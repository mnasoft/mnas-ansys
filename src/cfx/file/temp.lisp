(in-package :mnas-ansys/cfx/file)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; Vars

(progn
  (defparameter *res-file*
    "D:/home/_namatv/CFX/n70/cfx/Ne_R=1.00/N70_prj_17/N70_prj_17mt_001_163.res"
    "Полный путь к res-файлу.")

  (defparameter *s-obj-file*
    "D:/home/_namatv/CFX/n70/cfx/Ne_R=1.00/N70_prj_17/N70_prj_17mt_001_163.s-obj"


    "Полный путь к файлу с сериализованными данными для объекта, класса
 foo.")

  (defparameter *n-iter* 500
    "Количество итераций")

;;; Создаем переменную, которая ссылается на res-файл.
  (defparameter *res*
    (make-instance '<res>
                   :res-pname *res-file*
                   :pathname  *s-obj-file*)))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; Tests

#+nil
(progn
  (mon-extract *res* *n-iter*) ; Извлекаем данные о мониторах из res-файла
  (ccl-extract *res*)          ; Извлекаем данные ccl
  (save        *res*)          ; Сохраняем объект в res-файл
  )

;;; Загружаем данные из файла
#+nil
(setf *res* (load-instance *res*))

(iterations      *res*) ; Количество итераций 
(iteration-start *res*) ; Начальная  итерация
(iteration-end   *res*) ; Конечная   итерация

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;

(res-to-s-obj "D:\home\_namatv\CFX\n70\cfx\Ne_R=1.00\N70_prj_16\N70_prj_16mt_002.res"
              :n-iter 100 :force-load t)

(dir-to-s-obj "D:/home/_namatv/CFX/n70/cfx/Ne_R=1.00/N70_prj_16/*.res"
              :n-iter 500 :force-load t)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; CCL

(ql:quickload :mnas-ansys/ccl)
(mnas-ansys/ccl:find-in-tree-in-deep
 '(("FLOW" "Flow Analysis 1") ("BOUNDARY" "INLET") "Mass Flow Rate")
 (<res>-ccl *res*) t)

(mnas-ansys/ccl:find-in-tree-in-deep 
 '(("FLOW" "Flow Analysis 1") ("BOUNDARY" "INLET") "Total Temperature")
 (<res>-ccl *res*) t)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; aver-temp max-temp



#+nil
(progn
  (vgplot:title  "Радиальная эпюра температур")
  (vgplot:xlabel "T, C")
  (vgplot:ylabel "h" )
  (vgplot:axis '(1100 1400 0 1))
  (vgplot:plot (mapcar #'second t-mid) (mapcar #'first t-mid)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; aver-teta max-teta

(teta *res*)

(max-temp *res*)
(max-teta *res*)
(aver-teta *res*)
(aver-temp *res*)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


(progn
  (defvar x)
  (defvar y)
  (setf x (vgplot:range 0.0 (* pi 2) 0.1))
  (setf y (map 'vector #'sin x))
;;  (vgplot:plot x y "or;H" x y "-k;")
  (vgplot:plot x y ";Чисто точки;with lp  dt 5 pt 11 ps 1.5 lc 'black'") ; lc 'red'
  (vgplot:plot x y ";Это точки;with linespoints pointtype 55 pointsize 1.2 linecolor '\#80ff00'") ; 
  (vgplot:text-show-label) )

(defun foo (res-file-name)
  (let* ((device    (pathname-device    res-file-name))
         (directory (pathname-directory res-file-name))
         (org-dir-tmpl
           (concatenate 'string 
                        (namestring
                         (make-pathname
                          :device    device
                          :directory directory))
                        "*.org")))
    (directory org-dir-tmpl)))

(defun move-to-ext-dir (pathname)
  (let* ((device    (pathname-device      pathname))
         (directory (pathname-directory   pathname))
         (name      (pathname-name        pathname))
         (type      (pathname-type        pathname))
         (subdir    (make-pathname
                     :device device
                     :directory (append directory (list type)))))
    (ensure-directories-exist subdir)
    (rename-file pathname
                 (make-pathname
                  :device device
                  :directory (append directory (list type))
                  :name name
                  :type type))))

(defun moves-to-ext-dir (res-file-name)
  (loop :for i :in (foo res-file-name)
        :do (move-to-ext-dir i)))

