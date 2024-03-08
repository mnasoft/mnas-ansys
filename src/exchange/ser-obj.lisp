(in-package :mnas-ansys/exchange)

(ql:quickload :serializable-object)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; defclass

(defclass <htable> (serializable-object:serializable-object)
  ((head
    :accessor <htable>-head
    :initarg :head
    :initform nil
    :documentation "Строка заголовков.")
   (data
    :accessor <htable>-data
    :initarg :data
    :initform nil
    :documentation "Данные."))
  (:documentation
   "@b(Описание:) Класс @b(<htable>) определяет интерфейсы для
 извлечения информации, находящейя в res-файлах системы ANSYS CFX."))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defclass <res> (<htable>)
  ((res-pname
    :accessor <res>-res-pname
    :initarg :res-pname
    :initform nil
    :documentation "Полный путь к res-файлу ANSYS CFX."))
  (:documentation
   "@b(Описание:) Класс @b(<htable>) определяет интерфейсы для
 извлечения информации, находящейя в res-файлах системы ANSYS CFX."))

(defmethod print-object ((res <res>) stream)
  (format stream "Res-Pathname   = ~S~%" (<res>-res-pname res))
  (format stream "S-Obj-Pathname = ~S~%" (slot-value res 'pathname))
  (when (<htable>-data res)
    (format stream "Data Length = ~S~%" (length (<htable>-data res))))
  (when (<htable>-head res)
    (format stream "Key Length = ~S~%" (length (<htable>-head res)))
    (format stream "========================================~%" )
    (format stream "Keys~%")
    (format stream "========================================~%" )
    (loop :for k :across (<htable>-head res)
          :for i :from 0
          :do
      (format stream "~5A: ~A~%" i k))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; defmethod

(defmethod extract ((res <res>) (n-iter integer))
  "@b(Описание:) метод @b(extract) извлекает из res-файла 
"
  (let ((h-d (read-res-file (<res>-res-pname res) :rec-number n-iter)))
    (setf (<htable>-head res) (first h-d))
    (setf (<htable>-data res) (cdr   h-d))))

(defmethod save ((res <res>))
  (serializable-object:save res :compression nil))

(defmethod load-instance ((res <res>))
  (setf res
        (serializable-object:load-instance (slot-value res 'pathname) )))

(defmethod select (regexp (res <res>))
  "@b(Описание:) функция @b(select) возвращает, список, каждый элемент которого
является 2d-списком, содержащим номер и заголовок колонки, удовлетворяющей @b(regexp)
для строки заголовков headered-tabel.

 @b(Пример использования:)
@begin[lang=lisp](code)
 (setect-matches \"GT1\" *h-d*)
=> ((1124 \"USER POINT,Temperature GT1 F T01 p46i5 p415i5 p0i0,D1,\"x= 4.65E-02,y= 4.16E-01,z= 0.00E+00\",Temperature\")
    (1125 \"USER POINT,Temperature GT1 F T02 p46i5 p335i0 p80i5,D1,\"x= 4.65E-02,y= 3.35E-01,z= 8.05E-02\",Temperature\")
    ...
   )
@end(code)
"
  (when (<htable>-head res)
  (let ((rgx (ppcre:create-scanner regexp)))
    (loop :for i :across (<htable>-head res)
          :for j :from 0
          :when (ppcre:scan rgx i)
            :collect `(,j ,i)))))

(defmethod to-org-00 ((res <res>) &key (stream t) (from) (to) (regexp ".*MFR.*") (average nil))
  (when (<htable>-head res))
  (let ((selected (select regexp res)))
    (format stream "|~{ ~A~^ |~}|~%" 
    (loop :for (i name) :in selected :collect i)
      
    )))

(to-org-00 *res* )

#+nil (list name
      (math/stat:average-value
       (loop :for val :in d :collect (svref val i))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; Vars

(defparameter *res-file*
  #+nil "D:/home/_namatv/CFX/n70/cfx/Ne_R=1.00/N70_prj_10/274_full.res"
  "D:/home/_namatv/CFX/n70/cfx/Ne_R=1.00/N70_prj_10/N70_prj_10mt_010.res"
  "Полный путь к res-файлу.")

(defparameter *s-obj-file*
  #+nil "D:/home/_namatv/CFX/n70/cfx/Ne_R=1.00/N70_prj_10/274_full.s-obj"
  "D:/home/_namatv/CFX/n70/cfx/Ne_R=1.00/N70_prj_10/N70_prj_10mt_010.s-obj"
  "Полный путь к файлу с  сериализованными данными для объекта, класса
 foo.")

(defparameter *n-iter* 150
  "Количество итераций")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; Tests

;;; Создаем переменную, которая ссылается на res-файл.
(defparameter *res*
  (make-instance '<res>
         ;       :res-pname *res-file*
                 :pathname  *s-obj-file*))

(setf *res* (load-instance *res*))

(select ".*MFR.*" *res*)

(extract-01 *res* 150)
(length (<htable>-data *res*))


(read-res-file (<res>-res-pname *res*) :rec-number *n-iter*)

(select "USER POINT," *res*)

(setect-matches "USER POINT,GT OUT.*Velocity.*"          *res*)
(setect-matches "USER POINT,GT OUT.*Density.*"           *res*)
(setect-matches "USER POINT,GT OUT.*Total Temperature.*" *res*)

(setect-matches "USER POINT,.*MFR.*"          *res*)


(average-value-from-headered-tabel
 (mapcar #'second (setect-matches "USER POINT,.*MFR.*" *res*))
 *res*)

(loop :for i :across (first *res*) :do
      (format t "~A~%" i) )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun average-value-h-d (regexp h-d)
  "@b(Описание:) функция @b(average-value-h-d) возвращает 2d-list, каждым
элементом которого является список у которого:
@begin(list)
 @item(первым элементом является заголовок;)
 @item(вторым элементом является среднее значение;)
@end(list)

 @b(Пример использования:)
@begin[lang=lisp](code)
  (average-value-h-d \"USER POINT,.*MFR.*\" *res* )
  =>
  ((\"USER POINT,MFR G1 G1 LR Side 1\" 1.0441316)
   (\"USER POINT,MFR G1 G2 X_049i5 Side 1\" -0.022962399)
   (\"USER POINT,MFR G1 G2 X_067i8 Side 1\" -0.042467475))
@end(code)
"
  (let ((d (cdr h-d)))
    (loop :for (i name) :in (setect-matches regexp h-d)
          :collect
          (list name
                (math/stat:average-value
                 (loop :for val :in d :collect (svref val i)))))))

(defun extract-average-value (regexp h-d)
  "@b(Описание:) функция @b(extract-average-value) выводит по столбцам в
org-формате таблицу, содержащую заголовки и средние значения. Таблица
имеет две строки и несколько столбцов.
"
  (let ((rez (average-value-h-d regexp h-d)))
    (format t "~{| ~{ ~A~^ | ~}~%~} " (math/matr:transpose rez))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(extract "USER POINT,.*MFR.*" *res* )


(extract-average-value  "USER POINT,GT OUT.*Total Temperature.*" *res*)

(extract-average-value  "USER POINT,T03" *res*)

(setect-matches "USER POINT,T03" *res*)
