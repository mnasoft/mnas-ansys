(in-package :mnas-ansys/exchange)

(ql:quickload :serializable-object)

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
  "Количество итераций"
  )

(defclass foo (serializable-object:serializable-object)
  ((data :accessor foo-data)))

(defparameter *foo* (make-instance 'foo :pathname *s-obj-file*))

(setf (foo-data *foo*)
      (read-res-file *res-file* :rec-number *n-iter*))

(serializable-object:save *foo* :compression nil)

(defparameter *foo*
  (serializable-object:load-instance
   *s-obj-file*))


(setect-matches "USER POINT," (foo-data *foo*))

(setect-matches "USER POINT,GT OUT.*Velocity.*"          (foo-data *foo*))
(setect-matches "USER POINT,GT OUT.*Density.*"           (foo-data *foo*))
(setect-matches "USER POINT,GT OUT.*Total Temperature.*" (foo-data *foo*))

(setect-matches "USER POINT,.*MFR.*"          (foo-data *foo*))


(average-value-from-headered-tabel
 (mapcar #'second (setect-matches "USER POINT,.*MFR.*" (foo-data *foo*)))
 (foo-data *foo*))

(loop :for i :across (first (foo-data *foo*)) :do
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
  (average-value-h-d \"USER POINT,.*MFR.*\" (foo-data *foo*) )
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

(extract "USER POINT,.*MFR.*" (foo-data *foo*) )


(extract-average-value  "USER POINT,GT OUT.*Total Temperature.*" (foo-data *foo*))

(extract-average-value  "USER POINT,T03" (foo-data *foo*))

(setect-matches "USER POINT,T03" (foo-data *foo*))
