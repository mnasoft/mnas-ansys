(in-package :mnas-ansys/cfx/pre)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; methods

(defmethod domains ((cfx-domains <cfx-domains>))
  " @b(Пример использования:)
@begin[lang=lisp](code)
 (all-domains *ds*)
@end(code)"
  (alexandria:hash-table-keys (<cfx-domains>-domains cfx-domains)))


(defmethod fluid-domains ((dom-sur <dom-sur>))
  " @b(Пример использования:)
@begin[lang=lisp](code)
 (fluid-domains  *ds*)
@end(code)"
  (remove-if #'(lambda (el)
                 (not
                  (uiop:string-prefix-p "DG" el)))
             (all-domains dom-sur)))

(defmethod solid-domains ((dom-sur <dom-sur>))
  " @b(Пример использования:)
@begin[lang=lisp](code)
 (solid-domains  *ds*)
@end(code)"
  (remove-if #'(lambda (el)
                 (not
                  (uiop:string-prefix-p "DM" el)))
             (all-domains dom-sur)))

(defmethod faces (dom (dom-sur <dom-sur>))
  (second (assoc dom (<dom-sur>-data dom-sur) :test #'equal)))

(defmethod interfaces (dom (dom-sur <dom-sur>))
  (sort 
   (remove-if #'(lambda (el)
                  (not
                   (uiop:string-prefix-p "C" el)))
              (faces dom dom-sur))
   #'string<))

(defmethod find-body (body-name (dom-sur <cfx-domains>))
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
           (all-domains dom-sur))
   #'string<))

(defmethod interfaces-dom (dom di-1 di-2 (dom-sur <dom-sur>))
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
                (interfaces dom dom-sur))
     #'string<)))

(defmethod mk-gen-interfaces-1-1 (dom-1 dom-2 di-1 di-2 (dom-sur <dom-sur>) &key (postfix ""))
  (loop :for i1 :in (interfaces-dom  dom-1 di-1 di-2 dom-sur)
        :for i2 :in (interfaces-dom dom-2 di-1 di-2 dom-sur)
        :collect
        (make-domain-interface-general-connection
         (mnas-string:common-prefix (list i1 i2)) i1 i2 :postfix postfix)))

(defmethod mk-gen-interfaces-n-m (g1 g2 (dom-sur <dom-sur>))
  (let* ((d1 (domains g1 dom-sur))
         (d2 (domains g2 dom-sur))
         (il1 (apply #'append
                     (mapcar #'(lambda (el) 
                                 (interfaces-dom el g1 g2 dom-sur))
                             d1)))
         (il2 (apply #'append
                     (mapcar #'(lambda (el) 
                                 (interfaces-dom el g1 g2 dom-sur))
                             d2))))
    (make-domain-interface-general-connection
     (mnas-string:common-prefix (append il1 il2)) il1 il2)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; Функции для создания вращательного интерфейса
;;;; Вращательная часть

(defmethod domain-min (g1 (dom-sur <dom-sur>))
  (let ((doms (domains g1 dom-sur)))
    (first (sort doms #'string<))))

(defmethod domain-max (g1 (dom-sur <dom-sur>))
  (let ((doms (domains g1 dom-sur)))
    (first (sort doms #'string>))))

(defmethod int-rot-max (g1 (dom-sur <dom-sur>))
  (let ((d-max (domain-max g1 dom-sur)))
    (sort 
     (loop :for i :in (interfaces-dom d-max g1 g1 dom-sur)
           :when (some #'(lambda (el) (string= "L" el))
                       (mnas-ansys/ccl:mk-split i))
             :collect i)
     #'string<)))


(defmethod int-rot-min (g1 (dom-sur <dom-sur>))
  (let ((d-max (domain-min g1 dom-sur)))
    (sort 
     (loop :for i :in (interfaces-dom d-max g1 g1 dom-sur)
           :when (some #'(lambda (el) (string= "R" el))
                       (mnas-ansys/ccl:mk-split i))
             :collect i)
     #'string<)))

(defmethod mk-rot-per-interfaces-n-m (g1 (dom-sur <dom-sur>) &key (postfix "ROT"))
  (let* ((i-min (int-rot-min g1 dom-sur))
         (i-max (int-rot-max g1 dom-sur)))
    (when (and i-min i-max)
      (make-domain-interface-rotational-periodicity 
       (mnas-string:common-prefix (append i-min i-max)) i-min i-max
       :postfix postfix))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; Функции для создания вращательного интерфейса
;;;; Генеральная часть

(defmethod domains-left (g1 (dom-sur <dom-sur>))
  (let ((doms (domains g1 dom-sur)))
   (cdr (reverse doms))))

(defmethod domains-right (g1 (dom-sur <dom-sur>))
  (let ((doms (domains g1 dom-sur)))
    (cdr doms)))

(defmethod int-rot-left (g1 (dom-sur <dom-sur>))
  (let ((d-left (domains-left g1 dom-sur)))
    (sort
     (apply #'append 
            (loop :for d :in d-left
                  :collect
                  (loop :for i :in (interfaces-dom d g1 g1 dom-sur)
                        :when (some #'(lambda (el) (string= "L" el))
                                    (mnas-ansys/ccl:mk-split i))
                          :collect i)))
     #'string<)))

(defmethod int-rot-right (g1 (dom-sur <dom-sur>))
  (let ((d-left (domains-right g1 dom-sur)))
    (sort
     (apply #'append 
            (loop :for d :in d-left
                  :collect
                  (loop :for i :in (interfaces-dom d g1 g1 dom-sur)
                        :when (some #'(lambda (el) (string= "R" el))
                                    (mnas-ansys/ccl:mk-split i))
                          :collect i)))
     #'string<)))
    
(defmethod mk-rot-gen-interfaces-n-m (g1 (dom-sur <dom-sur>) &key (postfix "ROT GEN"))
  (let* ((i-left  (int-rot-left g1 dom-sur))
         (i-right (int-rot-right g1 dom-sur)))
    (when (and i-left i-right)
      (make-domain-interface-general-connection
       (mnas-string:common-prefix (append i-left i-right)) i-left i-right
       :postfix postfix))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defmethod domains-surs (doms (dom-sur <dom-sur>))
  (apply #'append
         (mapcar
          #'(lambda (dom)
              (faces dom dom-sur))
          doms)))

(defmethod fluid-surs (s-body-name (dom-sur <dom-sur>))
  (let ((surs (domains-surs (fluid-domains dom-sur) dom-sur)))
    (sort 
    (remove-if
     #'(lambda (el)
         (or (not (uiop:string-prefix-p "DG" el))
         (string/= s-body-name (second (mnas-ansys/ccl:mk-split el)))))
     surs)
    #'string<)))

(defmethod solid-surs (s-body-name (dom-sur <dom-sur>))
  (let ((surs (domains-surs (solid-domains dom-sur) dom-sur)))
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

(defmethod mk-f-s-interface-n-m (fluid-dom solid-dom (dom-sur <dom-sur>))
  "
 @b(Пример использования:)
@begin[lang=lisp](code)
 (mk-f-s-interface-n-m \"D1\" \"M3\" *i*)
@end(code)
"
  (make-f-s-interface-general-connection
   fluid-dom
   solid-dom
   (fluid-surs solid-dom dom-sur)
   (solid-surs solid-dom dom-sur)))

(defmethod bodys ((dom-sur <dom-sur>))
  (remove-duplicates 
   (loop :for i :in (all-domains dom-sur)
         :collect
         (second (ppcre:split " " i)))
   :test #'equal))

(defmethod bodys-of-fluid ((dom-sur <dom-sur>))
    "
 @b(Пример использования:)
@begin[lang=lisp](code)
 (bodys-of-fluid *ds*)
 => (\"G1\" \"G2\" \"G31\" \"G32\" \"G33\" \"G34\" \"G41\" \"G42\" \"G5\" \"G6\" \"G7\" \"G8\" \"G9\" \"G10\")
@end(code)"
  (loop :for i :in (bodys dom-sur)
        :when (uiop:string-prefix-p "G" i)
          :collect i))

(defmethod bodys-of-solid ((dom-sur <dom-sur>))
  "
 @b(Пример использования:)
@begin[lang=lisp](code)
 (bodys-of-solid *ds*)  => (\"M1\" \"M2\" \"M3\")
@end(code)"
  (loop :for i :in (bodys dom-sur)
        :when (uiop:string-prefix-p "M" i)
          :collect i))

(defun rotate-around (named-points p-axis-start p-axis-end teta)
  "Функция вращает именованные точки повернутые вокруг оси, определяемой
точками p-axis-start p-axis-end на угол teta."
  (let ((rotate-teta (math/matr:rotate-around p-axis-start p-axis-end teta))) ;; Определяем матрицу поворота
    (loop :for (name p) :in named-points
          :collect (list name (math/matr:transform p rotate-teta)))))


(defun gt-metal-compare (tbl trd utime
                         monitor-tbl
                         res
                         &key
                           (header-lines 2)
                           (mon-convertor #'(lambda (el) el))
                           )
  "@b(Описание:) функция @b(gt-metal-compare)

 @b(Переменые:)
@begin(list)
 @item(tbl - 2d-list с заголовком длиной header-lines;)
 @item(trd - тренд;)
 @item(utime - универсальное время;)
 @item(header-lines - высота заголовка таблицы, там где нет имен сигналова;)
 @item(monitor-tbl - 2d-list с именами мониторов;)
 @item(res - CFX - res-файл.)
@end(list)
"
  (let ((tb-cdr tbl)
        (rez nil))
    (mnas-format:round-2d-list
     (append
      (loop :for l :in tbl
            :for i :from 0 :to (1- header-lines)
            :collect
            (progn (setf tb-cdr (cdr tb-cdr)) l))
      (progn 
        (loop :for l :in tb-cdr
              :for mon-line :in monitor-tbl
              :do
                 (push l rez)
                 (push (recoder/get:trd-analog-mid-by-utime
                        trd
                        utime
                        (recoder/slist:a-signals trd l))
                       rez)
                 (when (and monitor-tbl res)
                   (let ((mons (mnas-ansys/cfx/file:mon-select mon-line res)))
                     (push 
                      (mapcar
                       #'(lambda (mon)
                           (if mon
                               (mnas-ansys/cfx/file/mon:<mon>-name mon)
                               ""))
                       mons)
                      rez)
                     (push 
                      (mapcar
                       #'(lambda (mon)
                           (if mon
                               (funcall mon-convertor
                                        (math/stat:average-value
                                         (mnas-ansys/cfx/file/mon:<mon>-data mon)))
                               ""))
                       mons)
                      rez))))
        (reverse rez))))))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


