;;; ./src/cfx/file/mon/core/temp.lisp

(in-package :mnas-ansys/cfx/file/mon/core)

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
    "D:/home/_namatv/CFX/n70/cfx/Ne_R=1.00/N70_prj_09/N70_prj_09mt_007.res"
    "Полный путь к res-файлу.")

  (defparameter *s-obj-file*
    "D:/home/_namatv/CFX/n70/cfx/Ne_R=1.00/N70_prj_09/N70_prj_09mt_007.s-obj"
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

(mnas-ansys/cfx/file/mon/core:mon-name *mon*)
(length (mnas-ansys/cfx/file/mon/core:mon-name-list *mon*))
(mnas-ansys/cfx/file/mon/core:mon-type *mon*)
(mnas-ansys/cfx/file/mon/core:mon-domen *mon*)
