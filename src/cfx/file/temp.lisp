(in-package :mnas-ansys/cfx/file)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; Vars

(progn
  (defparameter *res-file*
    "D:/home/_namatv/PRG/msys64/home/namatv/work/A32_prj_17_000_0966.res"
    "Полный путь к res-файлу.")

  (defparameter *n-iter* 500
    "Количество итераций")

;;; Создаем переменную, которая ссылается на res-файл.
  (defparameter *res*
    (make-instance '<res>
                   :res-pname *res-file*)))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(probe-file *res-file*)
(probe-file *s-obj-file*)

(open-cfx-file "D:/home/_namatv/PRG/msys64/home/namatv/work/A32_prj_17_000_0966.res" :force-load t)
