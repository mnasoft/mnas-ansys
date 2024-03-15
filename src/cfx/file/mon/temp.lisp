;;; ./src/cfx/file/mon/temp.lisp

(in-package :mnas-ansys/cfx/file/mon)

(progn 
  (mk-mon *mon*)
  *mon*
  (mon-coords  *mon*)
  (mon-name-list *mon*)
  (mon-fam *mon*)
  (mon-location *mon*)
  )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; Tests

(progn
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
    (make-instance 'mnas-ansys/cfx/file:<res>
                   :res-pname *res-file*
                   :pathname  *s-obj-file*)))

(setf *res* (mnas-ansys/cfx/file:load-instance *res*)) ; Загружаем объект из s-obj-файла

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; Tests

(defparameter *mon*  (first (mnas-ansys/cfx/file:mon-select ".*CONE11.*" *res*)))

(defparameter *mon*  (first (mnas-ansys/cfx/file:mon-select ".*MFR.*" *res*)))

(mon-name *mon*)
(length (mon-name-list *mon*))
(mon-type *mon*)
(mon-domen *mon*)
