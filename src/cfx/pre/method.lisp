;;;; ./src/cfx/pre/method.lisp

(in-package :mnas-ansys/cfx/pre)

(defun underscore-name-by-pathname (pathname)
  "@b(Описание:) функция @b(underscore-name-by-pathname) выделяет из пути
@b(pathname) последнюю часть имени перед которой стоит знак подчерка.

 @b(Пример использования:)
@begin[lang=lisp](code)
  (underscore-name-by-pathname #P\"z:/ANSYS/CFX/a32/tin/DOM/G5/A32_prj_06_DG10.tin\") => \"DG10\"
@end(code)"
  (first 
   (nreverse
    (ppcre:split "_" (pathname-name pathname)))))

(defun domain-name-by-pathname (pathname)
  "@b(Описание:) функция @b(domain-name-by-pathname) возвращает имя
домена основываясь на имени tin-файла.

 @b(Пример использования:)
@begin[lang=lisp](code)
 (domain-name-by-pathname #P\"z:/ANSYS/CFX/a32/tin/DOM/G5/A32_prj_06_DG10.tin\") => \"G10\"
@end(code)"
  (tail-of-string
   (underscore-name-by-pathname pathname)))

(defun make-mesh (pathname)
  (let* ((domain (make-instance '<mesh>))
        (tin (mnas-ansys/tin:open-tin-file pathname)))
    (setf (<mesh>-name domain)
          (domain-name-by-pathname pathname))
    (map 'nil
         #'(lambda (el)
             (setf
              (gethash el (<mesh>-surfaces domain))
              el))
         (remove-duplicates 
          (loop :for sur
                  :in (alexandria:hash-table-values
                       (mnas-ansys/tin:<tin>-surfaces tin))
                :collect 
                (mnas-ansys/tin:<ent>-family sur))
          :test #'equal))
    domain))

(defun ht-values-sort (ht &optional (func #'string<))
  (sort (alexandria:hash-table-values ht) func))

(defmethod surfaces ((icem-domain <mesh>))
  (ht-values-sort (<mesh>-surfaces icem-domain)))

(defmethod surfaces ((domain <domain>))
  (ht-values-sort (<domain>-surfaсes domain)))

(defmethod surfaces ((simulation <simulation>))
  (ht-values-sort (<simulation>-surfaces simulation)))

(defmethod surfaces ((d (eql nil)))
  d)

(defmethod add ((mesh <mesh>) (meshes <meshes>))
    "Добавляем сетку к коллекции сеток."
  (setf (gethash
         (<mesh>-name mesh)
         (<meshes>-domains meshes))
        mesh)
  meshes)

(defmethod add ((domain <domain>) (simulation <simulation>))
  "Добавляем домен в симуляцию"
  (setf (gethash (<domain>-name domain) 
                 (<simulation>-domains simulation))
        domain)
  simulation)

(defmethod domains ((obj <meshes>))
  (sort 
   (alexandria:hash-table-keys (<meshes>-domains obj))
   #'string<))

(defun make-meshes (directory-template)
  (let ((icem-domains (make-instance '<meshes>)))
    (loop :for d :in (directory directory-template)
          :do (add (make-mesh d) icem-domains))
    icem-domains))

(defun make-cfx-domains (directory-template)
  (let ((cfx-domains (make-instance '<simulation>)))
    (loop :for d :in (directory directory-template)
          :do (add (make-mesh d) cfx-domains))
    cfx-domains))

(defun mesh-name->domain-name (mesh-name)
  "@b(Описание:) функция @b(mesh-name->domain-name) возвращает имя домена
на основании имени сетки.
 
 @b(Пример использования:)
@begin[lang=lisp](code)
 (mesh-name->domain-name \"G1\") => \"DG1 G1\"
@end(code)"
  (concatenate 'string "D" mesh-name " " mesh-name))

(defun domain-name->mesh-name (domain-name)
  "@b(Описание:) функция @b(domain-name->mesh-name) возвращает имя сетки
на основании имени домена.
 
 @b(Пример использования:)
@begin[lang=lisp](code)
 (domain-name->mesh-name \"DG1 G1\") => \"G1\"
@end(code)"
  (second (ppcre:split " " domain-name)))

(defmethod next-domain-name ((mesh-name string) (cfx-domains <simulation>))
  "@b(Описание:) метод @b(next-domain-name) возвращает следующее
доступное имя для домена при вставке сетки в симуляцию CFX.
"
  (when (gethash mesh-name (<meshes>-domains cfx-domains))
    (let ((d-name (mesh-name->domain-name mesh-name)))
      (if (gethash d-name (<simulation>-domains cfx-domains))
          (loop :for i :from 2 
                :do
                   (unless (gethash (format nil "~A ~D" d-name i)
                                    (<simulation>-domains cfx-domains))
                     (return-from next-domain-name (format nil "~A ~D" d-name i))))
          d-name))))

(defun name-icem->cfx (name)
  (ppcre:regex-replace-all "[/-]" name " "))


(defmethod next-surface-name ((mesh-name string) (cfx-domains <simulation>))
  (let ((surface-name (name-icem->cfx mesh-name)))
    (if (gethash surface-name (<simulation>-surfaces cfx-domains))
          (loop :for i :from 2 
                :do
                   (unless (gethash (format nil "~A ~D" surface-name i)
                                    (<simulation>-surfaces cfx-domains))
                     (return-from next-surface-name (format nil "~A ~D" surface-name i))))
          surface-name)))

(defmethod simulation-doman-surfaces ((domain-name string) (simulation <simulation>))
  "
 @b(Пример использования:)
@begin[lang=lisp](code)
 (simulation-doman-surfaces \"DG1 G1\" *simulation*)
@end(code)
"
  ;; поверхности, которые входят в домен
  (surfaces
   (gethash domain-name
            (<simulation>-domains simulation))))

(defun check-equality (variable string)
  (equalp 
   (sort (ppcre:split "," variable) #'string<)
   (sort
    (alexandria:hash-table-keys
     (<domain>-surfaсes
      (gethash string
               (<simulation>-domains *simulation*))))
    #'string<)))

(defmethod insert ((mesh string) (simulation <simulation>))
  (let ((d-name (next-domain-name mesh simulation)))
    (when d-name
      (let ((domain (make-instance '<domain> :name d-name)))
        (loop :for sur :in (alexandria:hash-table-keys
                            (<mesh>-surfaces
                             (gethash mesh
                                      (<meshes>-domains simulation))))
              :do
                 (let ((cfx-suf (next-surface-name sur simulation)))
                   (unless (gethash cfx-suf (<simulation>-surfaces simulation))
                     (setf (gethash cfx-suf (<domain>-surfaсes domain)) ;; добавляем поверхность в домен
                           cfx-suf) 
                     (setf (gethash cfx-suf (<simulation>-surfaces simulation)) ;; добавляем поверхность в перечень поверхностей
                           cfx-suf)))) ;; loop
        (add domain simulation)
        simulation ;; возвращаем симуляцию
        ))))

(defmethod copy ((domain-name string) (simulation <simulation>))
  (let ((d-name-next (next-domain-name
                      (domain-name->mesh-name domain-name)
                      simulation)))
    (when d-name-next
      (let ((domain (make-instance '<domain> :name d-name-next)))
        (loop :for sur :in (simulation-doman-surfaces domain-name simulation)
              :do
                 (let ((cfx-suf (next-surface-name sur simulation)))
                   (unless (gethash cfx-suf (<simulation>-surfaces simulation))
                     (setf (gethash cfx-suf (<domain>-surfaсes domain)) ;; добавляем поверхность в домен
                           cfx-suf)
                     (setf ;; добавляем поверхность в перечень поверхностей
                      (gethash cfx-suf (<simulation>-surfaces simulation)) 
                           cfx-suf))))
        (add domain simulation)))
    simulation))

#+nil (progn domain d-name-next)
(defun make-corelation (domain-name result simulation)
  (let ((dom-result (ppcre:split "," result)))
    (loop :for i :in (simulation-doman-surfaces domain-name simulation)
          :collect
          (list i
                (extract-suffix i (first (filter-by-prefix i dom-result)))
                (mapcar
                 #'(lambda (el) (extract-suffix i el))
                 (filter-by-prefix i (surfaces simulation)))))))

(defun make-corelation-0 (domain-name result simulation)
  (let ((dom-result (ppcre:split "," result)))
    (loop :for i :in (simulation-doman-surfaces domain-name simulation)
          :collect
          (list i
                (first (filter-by-prefix i dom-result))
                (filter-by-prefix i (surfaces simulation))))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defmethod domains ((cfx-domains <simulation>))
  " @b(Пример использования:)
@begin[lang=lisp](code)
 (all-domains *ds*)
@end(code)"
  (alexandria:hash-table-keys (<simulation>-domains cfx-domains)))

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

(defmethod mk-rot-per-interfaces-n-m (g1 (cfx-domains <simulation>) &key (postfix "ROT"))
  (let* ((i-min (int-rot-min g1 cfx-domains))
         (i-max (int-rot-max g1 cfx-domains)))
    (when (and i-min i-max)
      (make-domain-interface-rotational-periodicity 
       (mnas-string:common-prefix (append i-min i-max)) i-min i-max
       :postfix postfix))))

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

(defun rotate-around (named-points p-axis-start p-axis-end teta)
  "Функция вращает именованные точки повернутые вокруг оси, определяемой
точками p-axis-start p-axis-end на угол teta."
  (let ((rotate-teta (math/matr:rotate-around p-axis-start p-axis-end teta))) ;; Определяем матрицу поворота
    (loop :for (name p) :in named-points
          :collect (list name (math/matr:transform p rotate-teta)))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
