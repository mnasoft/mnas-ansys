(in-package :mnas-ansys/cfx/file)

;; (monitor-to-org *res*)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; Vars

(defparameter *res-file*
  #+nil "D:/home/_namatv/CFX/n70/cfx/Ne_R=1.00/N70_prj_10/274_full.res"
  #+nil "D:/home/_namatv/CFX/n70/cfx/Ne_R=1.00/N70_prj_10/N70_prj_10mt_010.res"
  "D:/home/_namatv/CFX/n70/cfx/Ne_R=1.00/N70_prj_09/N70_prj_09mt_006.res"
  "Полный путь к res-файлу.")

(defparameter *s-obj-file*
  #+nil "D:/home/_namatv/CFX/n70/cfx/Ne_R=1.00/N70_prj_10/274_full.s-obj"
  #+nil "D:/home/_namatv/CFX/n70/cfx/Ne_R=1.00/N70_prj_10/N70_prj_10mt_010.s-obj"
  "D:/home/_namatv/CFX/n70/cfx/Ne_R=1.00/N70_prj_09/N70_prj_09mt_006.s-obj"
  "Полный путь к файлу с  сериализованными данными для объекта, класса
 foo.")

(defparameter *n-iter* 150
  "Количество итераций")

;;; Создаем переменную, которая ссылается на res-файл.
(defparameter *res*
  (make-instance '<res>
                 :res-pname *res-file*
                 :pathname  *s-obj-file*))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; Tests

#+nil
(progn
  (extract *res* *n-iter*) ; Извлекаем данные о мониторах из res-файла
  (save    *res*)          ; Сохраняем объект в res-файл
  )


(setf *res* (load-instance *res*)) ; Загружаем объект из s-obj-файла


(select ".*MFR.*" *res*)


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

(res->ccl res-file)

(extract "USER POINT,.*MFR.*" *res* )


(extract-average-value  "USER POINT,GT OUT.*Total Temperature.*" *res*)

(extract-average-value  "USER POINT,T03" *res*)

(setect-matches "USER POINT,T03" *res*)
