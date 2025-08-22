;;;; ./src/cfx/pre/not-used.lisp

(in-package :mnas-ansys/cfx/pre)



(defmethod icem-fluid-domains ((cfx-domains <simulation>))
  (let ((rez nil))
    (alexandria:maphash-keys
     #'(lambda (el)
         (push (first (ppcre:split "/" el)) rez))
     (<simulation>-icem-parts cfx-domains))
    (mapcar
     #'tail-of-string
     (sort
      (remove-duplicates
       (remove-if
        #'(lambda (el)
            (cond ((string= "C" el))
                  ((string= "DG0" el))))
        rez)
       :test #'equal)
      #'string<))))

(defmethod icem-solid-domains ((obj <simulation>))
  (let ((rez nil))
    (alexandria:maphash-keys
     #'(lambda (el)
         (push (second (ppcre:split "/" el)) rez))
     (<simulation>-icem-parts obj))
    (sort 
     (remove-duplicates 
      (remove-if
       #'(lambda (el)
           (or
            (funcall (complement #'is-starts-with-capital-m-p) el)
            (is-dash-string el)
            (string= "M0" el)))
       rez)
      :test #'equal)
     #'string<)))

(defmethod icem-domains ((obj <simulation>))
  (append
   (icem-fluid-domains obj)
   (icem-solid-domains obj)))

(defmethod icem-fluid-domain-p (domain-name (cfx-domains <simulation>))
  (not (null (member domain-name (icem-fluid-domains cfx-domains) :test #'equal))))

(defmethod icem-solid-domain-p (domain-name (cfx-domains <simulation>))
  (not (null (member domain-name (icem-solid-domains cfx-domains) :test #'equal))))

(defmethod find-icem-surfaces (domain-name (cfx-domains <simulation>))
  (let ((rez nil))
    (cond
      ((icem-fluid-domain-p domain-name cfx-domains)
       (alexandria:maphash-keys
        #'(lambda (key)
            (when
                (is-icem-fluid-surface key domain-name)
              (push key rez)))
        (<simulation>-icem-parts cfx-domains)))

      ((icem-solid-domain-p domain-name cfx-domains)
       rez))
    rez))

(defmethod fluid-domains ((cfx-domains <simulation>))
  " @b(Пример использования:)
@begin[lang=lisp](code)
 (fluid-domains  *ds*)
@end(code)"
  (remove-if #'(lambda (el)
                 (not
                  (uiop:string-prefix-p "DG" el)))
             (all-domains cfx-domains)))

(defmethod solid-domains ((cfx-domains <simulation>))
  " @b(Пример использования:)
@begin[lang=lisp](code)
 (solid-domains  *ds*)
@end(code)"
  (remove-if #'(lambda (el)
                 (not
                  (uiop:string-prefix-p "DM" el)))
             (all-domains cfx-domains)))

(defmethod faces (dom (cfx-domains <simulation>))
  (second (assoc dom (<simulation>-data cfx-domains) :test #'equal)))

(defmethod interfaces (dom (cfx-domains <simulation>))
  (sort 
   (remove-if #'(lambda (el)
                  (not
                   (uiop:string-prefix-p "C" el)))
              (faces dom cfx-domains))
   #'string<))

(defmethod find-body (body-name (cfx-domains <simulation>))
  "
 @b(Пример использования:)
@begin[lang=lisp](code)
 (domains \"G8\" *i*)
@end(code)
"
  (sort
   (remove-if #'(lambda (el)
               (not
                (uiop:string-prefix-p
                 (concatenate 'string "D" body-name " ")
                 el)))
           (all-domains cfx-domains))
   #'string<))

(defmethod interfaces-dom (dom di-1 di-2 (cfx-domains <simulation>))
  "
 @b(Пример использования:)
@begin[lang=lisp](code)
 (interfaces-dom \"DG1 G1 2\" \"G1\" \"G2\" *ds*)
@end(code)
"
  (labels ((mk-pred (name D1 D2 )
             (let ((splited-name (ppcre:split  " " name)))
               (and
                (string= (first splited-name) "C")
                (or
                 (and (string= (second splited-name) D1) (string= (third  splited-name) D2))
                 (and (string= (second splited-name) D2) (string= (third  splited-name) D1)))))))
    (sort 
     (remove-if #'(lambda (el)
                    (not
                     (mk-pred el di-1 di-2)))
                (interfaces dom cfx-domains))
     #'string<)))

(defmethod mk-gen-interfaces-1-1 (dom-1 dom-2 di-1 di-2 (cfx-domains <simulation>) &key (postfix ""))
  (loop :for i1 :in (interfaces-dom  dom-1 di-1 di-2 cfx-domains)
        :for i2 :in (interfaces-dom dom-2 di-1 di-2 cfx-domains)
        :collect
        (make-domain-interface-general-connection
         (mnas-string:common-prefix (list i1 i2)) i1 i2 :postfix postfix)))

(defmethod mk-gen-interfaces-n-m (g1 g2 (cfx-domains <simulation>))
  (let* ((d1 (domains g1 cfx-domains))
         (d2 (domains g2 cfx-domains))
         (il1 (apply #'append
                     (mapcar #'(lambda (el) 
                                 (interfaces-dom el g1 g2 cfx-domains))
                             d1)))
         (il2 (apply #'append
                     (mapcar #'(lambda (el) 
                                 (interfaces-dom el g1 g2 cfx-domains))
                             d2))))
    (make-domain-interface-general-connection
     (mnas-string:common-prefix (append il1 il2)) il1 il2)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; Функции для создания вращательного интерфейса
;;;; Вращательная часть

(defmethod domain-min (g1 (cfx-domains <simulation>))
  (let ((doms (domains g1 cfx-domains)))
    (first (sort doms #'string<))))

(defmethod domain-max (g1 (cfx-domains <simulation>))
  (let ((doms (domains g1 cfx-domains)))
    (first (sort doms #'string>))))

(defmethod int-rot-max (g1 (cfx-domains <simulation>))
  (let ((d-max (domain-max g1 cfx-domains)))
    (sort 
     (loop :for i :in (interfaces-dom d-max g1 g1 cfx-domains)
           :when (some #'(lambda (el) (string= "L" el))
                       (mnas-ansys/ccl:mk-split i))
             :collect i)
     #'string<)))


(defmethod int-rot-min (g1 (cfx-domains <simulation>))
  (let ((d-max (domain-min g1 cfx-domains)))
    (sort 
     (loop :for i :in (interfaces-dom d-max g1 g1 cfx-domains)
           :when (some #'(lambda (el) (string= "R" el))
                       (mnas-ansys/ccl:mk-split i))
             :collect i)
     #'string<)))



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; Функции для создания вращательного интерфейса
;;;; Генеральная часть

(defmethod domains-left (g1 (cfx-domains <simulation>))
  (let ((doms (domains g1 cfx-domains)))
   (cdr (reverse doms))))

(defmethod domains-right (g1 (cfx-domains <simulation>))
  (let ((doms (domains g1 cfx-domains)))
    (cdr doms)))

(defmethod int-rot-left (g1 (cfx-domains <simulation>))
  (let ((d-left (domains-left g1 cfx-domains)))
    (sort
     (apply #'append 
            (loop :for d :in d-left
                  :collect
                  (loop :for i :in (interfaces-dom d g1 g1 cfx-domains)
                        :when (some #'(lambda (el) (string= "L" el))
                                    (mnas-ansys/ccl:mk-split i))
                          :collect i)))
     #'string<)))

(defmethod int-rot-right (g1 (cfx-domains <simulation>))
  (let ((d-left (domains-right g1 cfx-domains)))
    (sort
     (apply #'append 
            (loop :for d :in d-left
                  :collect
                  (loop :for i :in (interfaces-dom d g1 g1 cfx-domains)
                        :when (some #'(lambda (el) (string= "R" el))
                                    (mnas-ansys/ccl:mk-split i))
                          :collect i)))
     #'string<)))
    
(defmethod mk-rot-gen-interfaces-n-m (g1 (cfx-domains <simulation>) &key (postfix "ROT GEN"))
  (let* ((i-left  (int-rot-left g1 cfx-domains))
         (i-right (int-rot-right g1 cfx-domains)))
    (when (and i-left i-right)
      (make-domain-interface-general-connection
       (mnas-string:common-prefix (append i-left i-right)) i-left i-right
       :postfix postfix))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defmethod domains-surs (doms (cfx-domains <simulation>))
  (apply #'append
         (mapcar
          #'(lambda (dom)
              (faces dom cfx-domains))
          doms)))

(defmethod fluid-surs (s-body-name (cfx-domains <simulation>))
  (let ((surs (domains-surs (fluid-domains cfx-domains) cfx-domains)))
    (sort 
    (remove-if
     #'(lambda (el)
         (or (not (uiop:string-prefix-p "DG" el))
         (string/= s-body-name (second (mnas-ansys/ccl:mk-split el)))))
     surs)
    #'string<)))

(defmethod solid-surs (s-body-name (cfx-domains <simulation>))
  (let ((surs (domains-surs (solid-domains cfx-domains) cfx-domains)))
    (sort 
     (remove-if
      #'(lambda (el)
          (or (uiop:string-prefix-p "DG0" el)
              (not (uiop:string-prefix-p "DG" el))
              (string/= s-body-name (second (mnas-ansys/ccl:mk-split el)))))
      surs)
     #'string<)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; Создание интерфесов типа флюид-солид

(defmethod mk-f-s-interface-n-m (fluid-dom solid-dom (cfx-domains <simulation>))
  "
 @b(Пример использования:)
@begin[lang=lisp](code)
 (mk-f-s-interface-n-m \"D1\" \"M3\" *i*)
@end(code)
"
  (make-f-s-interface-general-connection
   fluid-dom
   solid-dom
   (fluid-surs solid-dom cfx-domains)
   (solid-surs solid-dom cfx-domains)))

(defmethod bodys ((cfx-domains <simulation>))
  (remove-duplicates 
   (loop :for i :in (all-domains cfx-domains)
         :collect
         (second (ppcre:split " " i)))
   :test #'equal))


(defmethod bodys-of-fluid ((cfx-domains <simulation>))
    "
 @b(Пример использования:)
@begin[lang=lisp](code)
 (bodys-of-fluid *ds*)
 => (\"G1\" \"G2\" \"G31\" \"G32\" \"G33\" \"G34\" \"G41\" \"G42\" \"G5\" \"G6\" \"G7\" \"G8\" \"G9\" \"G10\")
@end(code)"
  (loop :for i :in (bodys cfx-domains)
        :when (uiop:string-prefix-p "G" i)
          :collect i))

(defmethod bodys-of-solid ((cfx-domains <simulation>))
  "
 @b(Пример использования:)
@begin[lang=lisp](code)
 (bodys-of-solid *ds*)  => (\"M1\" \"M2\" \"M3\")
@end(code)"
  (loop :for i :in (bodys cfx-domains)
        :when (uiop:string-prefix-p "M" i)
          :collect i))

(bodys-of-solid *simulation*)

(defun rotate-around (named-points p-axis-start p-axis-end teta)
  "Функция вращает именованные точки повернутые вокруг оси, определяемой
точками p-axis-start p-axis-end на угол teta."
  (let ((rotate-teta (math/matr:rotate-around p-axis-start p-axis-end teta))) ;; Определяем матрицу поворота
    (loop :for (name p) :in named-points
          :collect (list name (math/matr:transform p rotate-teta)))))

;;;; ./src/cfx/pre/test.lisp

(in-package :mnas-ansys/cfx/pre)

(defun foo (pathname directory)
  (namestring
   (make-pathname :directory directory
                  :name (pathname-name pathname)
                  :type (pathname-type pathname))))

(map
 nil
 #'(lambda (el)
     (uiop:copy-file el (foo el "//n000339/Users/namatv/pp")))
 (directory "z:/ANSYS/CFX/a32/tin/DOM/*/A32_prj_06_*.tin"))

(defun next-suffix (domain-suffix simulation-suffixes)
  (cond
    ((and (string= domain-suffix "")
          (equalp '("") simulation-suffixes))
     "2")
    ((and (string= domain-suffix "")
          (equalp '("" "2") simulation-suffixes))
     "3")
    ((and (string= domain-suffix "2")
          (equalp '("" "3" "2") simulation-suffixes))
     "3")
    ((and (string= domain-suffix "2")
          (equalp '("" "2") simulation-suffixes))
     "3")
    (t
     (break "~S ~S" domain-suffix simulation-suffixes
            ))))

(defun next-surface-by-suffix (name domain-suffix simulation-suffixes)
  (concatenate 'string name " " (next-suffix domain-suffix simulation-suffixes)))

(defmethod insert-to-domain-copy ((surface-key string)
                                  (domain <3d-region>)
                                  (domain-copy <3d-region>))
  (let* ((simulation  (<3d-region>-parent domain))
        (surface-value (next-surface-by-suffix (name-icem->cfx surface-key)
                          (suffix surface-key domain)
                          (suffix surface-key simulation))))
    ;; добавляем поверхность в домен
    (setf (gethash surface-key (<3d-region>-surfaсes domain-copy)) surface-value)
    ;; добавляем поверхность в перечень поверхностей
    (setf (gethash surface-value (<simulation>-surfaces simulation)) surface-value)
    domain-copy))

(defmethod copy ((domain-name string) (simulation <simulation>))
  (let* ((domain ;; Копируемый домен
           (domain domain-name simulation))
         (domain-copy ;; Новый домен
           (make-instance '<3d-region>
                          :name (next-domain-name
                                 (domain-name->mesh-name domain-name)
                                 simulation)
                          :parent (<3d-region>-parent domain))))
    (loop :for sur-key :in (surface-keys domain)
          :do
             (insert-to-domain-copy sur-key domain domain-copy))
    (add domain-copy simulation)))


(defmethod insert ((mesh-name string) (simulation <simulation>))
  "@b(Описание:) метод @b(insert) добавляет в симуляцию @(simulation)
домен по имени 3d-сетки ICEM."
  (let ((d-name (next-domain-name mesh-name simulation)))
    (when d-name
      (let ((domain (make-instance '<3d-region> :name d-name :parent simulation)))
        (loop :for sur :in (alexandria:hash-table-keys
                            (<mesh>-2d-regions
                             (gethash mesh-name
                                      (<meshes>-meshes simulation))))
              :do
                 (let ((cfx-sur (next-surface-name sur simulation)))
                   (unless (gethash cfx-sur (<simulation>-surfaces simulation))
                     (setf (gethash sur (<3d-region>-surfaсes domain)) ;; добавляем поверхность в домен
                           cfx-sur) 
                     (setf (gethash cfx-sur (<simulation>-surfaces simulation)) ;; добавляем поверхность в перечень поверхностей
                           cfx-sur)))) ;; loop
        (add domain simulation)
        simulation ;; возвращаем симуляцию
        ))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defmethod copy ((domain-name string) (simulation <simulation>))
  (let ((d-name-next (next-domain-name
                      (domain-name->mesh-name domain-name)
                      simulation)))
    (when d-name-next
      (let ((domain (make-instance '<3d-region> :name d-name-next)))
        (loop :for sur :in (simulation-doman-surfaces domain-name simulation)
              :do
                 (let ((cfx-sur (next-surface-name sur simulation)))
                   (unless (gethash cfx-sur (<simulation>-surfaces simulation))
                     (setf (gethash sur (<3d-region>-surfaсes domain)) ;; добавляем поверхность в домен
                           cfx-sur)
                     (setf ;; добавляем поверхность в перечень поверхностей
                      (gethash cfx-sur (<simulation>-surfaces simulation)) 
                           cfx-sur))))
        (add domain simulation)))
    simulation))
