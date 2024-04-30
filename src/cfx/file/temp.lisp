(in-package :mnas-ansys/cfx/file)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; Vars

(directory "D:/home/_namatv/CFX/n70/cfx/Ne_R=1.00/N70_prj_16/*.res")

(progn
  (defparameter *res-file*
    "D:/home/_namatv/CFX/n70/cfx/Ne_R=1.00/N70_prj_16/N70_prj_16mt_001_411.res"
    "Полный путь к res-файлу.")

  (defparameter *s-obj-file*
    "D:/home/_namatv/CFX/n70/cfx/Ne_R=1.00/N70_prj_16/N70_prj_16mt_001_411.s-obj"

    "Полный путь к файлу с сериализованными данными для объекта, класса
 foo.")

  (defparameter *n-iter* 150
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

(iterations *res*) ; Количество итераций 
(iteration-start *res*) ; Начальная итерация
(iteration-end   *res*) ; Конечная  итерация

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
;;;; t-03 t-02 dt

(defmethod t-03 ((res <res>))
  (- (math/stat:average-value
      (coerce 
       (mnas-ansys/cfx/file/mon:<mon>-data
        (gethash "T03:" (<res>-mon res)))
       'list))
     273.15))

(defmethod t-02 ((res <res>))
  (mnas-ansys/ccl:find-in-tree-in-deep 
   '(("FLOW" "Flow Analysis 1") ("BOUNDARY" "INLET") "Total Temperature")
   (<res>-ccl *res*) t))

(defmethod dt ((res <res>))
  (- (t-03 res) (t-02 res)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; aver-temp max-temp

(defmethod aver-temp ((res <res>)
                      &key 
                        (h-i-from 100)
                        (h-i-to   109)
                        (w-i-from 100)
                        (w-i-to   134)
                        (h-rel (loop :for h-i :from h-i-from :to h-i-to
                                     :for h-r :from 0.05 :by 0.1 :collect h-r)))
  (let ((t-mid
          (loop :for h :from h-i-from :to h-i-to
                :for h-r :in h-rel
                :collect
                (list
                 h-r
                 (- 
                  (math/stat:average-value
                   (loop :for w :from w-i-from :to w-i-to
                         :collect
                         (math/stat:average-value
                          (coerce 
                           (mnas-ansys/cfx/file/mon:<mon>-data
                            (gethash
                             (format nil "GT OUT ~A ~A:Total Temperature" h w)
                             (<res>-mon res)))
                           'list))))
                  273.15)))))
    t-mid))

#+nil
(progn
  (vgplot:title  "Радиальная эпюра температур")
  (vgplot:xlabel "T, C")
  (vgplot:ylabel "h" )
  (vgplot:axis '(1100 1400 0 1))
  (vgplot:plot (mapcar #'second t-mid) (mapcar #'first t-mid)))

(defmethod max-temp ((res <res>)
                     &key 
                       (h-i-from 100)
                       (h-i-to   109)
                       (w-i-from 100)
                       (w-i-to   134)
                       (h-rel (loop :for h-i :from h-i-from :to h-i-to
                                    :for h-r :from 0.05 :by 0.1 :collect h-r)))
  (let ((t-max
          (loop :for h :from h-i-from :to h-i-to
                :for h-r :in h-rel
                :collect
                (list
                 h-r
                 (- 
                  (math/stat:max-value
                   (loop :for w :from w-i-from :to w-i-to
                         :collect
                         (math/stat:average-value
                          (coerce 
                           (mnas-ansys/cfx/file/mon:<mon>-data
                            (gethash
                             (format nil "GT OUT ~A ~A:Total Temperature" h w)
                             (<res>-mon res)))
                           'list))))
                  273.15)))))
    t-max ))



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; aver-teta max-teta

(defmethod aver-teta ((res <res>)
                      &key 
                        (h-i-from 100)
                        (h-i-to   109)
                        (w-i-from 100)
                        (w-i-to   134)
                        (h-rel (loop :for h-i :from h-i-from :to h-i-to
                                     :for h-r :from 0.05 :by 0.1 :collect h-r)))
  (let* ((t-mid
           (aver-temp res :h-i-from h-i-from
                          :h-i-to h-i-to
                          :w-i-from w-i-from
                          :w-i-to w-i-to
                          :h-rel h-rel ))
         (t-02 (t-02 res))
         (dt   (dt res))
         (teta-mid (mapcar #'(lambda (x)
                               (list (first x)  (/ (- (second x) t-02) dt)))
                           t-mid)))
    teta-mid))

(defmethod max-teta ((res <res>)
                     &key 
                       (h-i-from 100)
                       (h-i-to   109)
                       (w-i-from 100)
                       (w-i-to   134)
                       (h-rel (loop :for h-i :from h-i-from :to h-i-to
                                    :for h-r :from 0.05 :by 0.1 :collect h-r)))
  (let* ((t-max
           (max-temp res :h-i-from h-i-from
                         :h-i-to h-i-to
                         :w-i-from w-i-from
                         :w-i-to w-i-to
                         :h-rel h-rel ))
         (t-02 (t-02 res))
         (dt   (dt res))
         (teta-max (mapcar #'(lambda (x)
                               (list (first x)  (/ (- (second x) t-02) dt)))
                           t-max)))
    teta-max))

(defmethod teta ((res <res>)
                 &key 
                   (h-i-from 100)
                   (h-i-to   109)
                   (w-i-from 100)
                   (w-i-to   134)
                   (h-rel (loop :for h-i :from h-i-from :to h-i-to
                                :for h-r :from 0.05 :by 0.1 :collect h-r)))
  (let ((aver-teta
          (aver-teta res :h-i-from h-i-from
                         :h-i-to h-i-to
                         :w-i-from w-i-from
                         :w-i-to w-i-to
                         :h-rel h-rel ))
        (max-teta
          (max-teta res :h-i-from h-i-from
                        :h-i-to h-i-to
                        :w-i-from w-i-from
                        :w-i-to w-i-to
                        :h-rel h-rel )))
    (let ((name
            (format nil "~A[~A]"
                    (ppcre:regex-replace-all "_"  (pathname-name (<res>-pathname res)) "-")
                    (iterations *res*)
                    )))
      (progn
        (vgplot:title  "Радиальная эпюра относительных температур")
    
        (vgplot:xlabel "T, C")
        (vgplot:ylabel "h" )
        (vgplot:axis '(0.8 1.3 0 1))
        (vgplot:plot (mapcar #'second max-teta) (mapcar #'first max-teta)
                     (concatenate 'string name ":" "U_{ max}")
                     (mapcar #'second aver-teta) (mapcar #'first aver-teta)
                     (concatenate 'string name ":" "U_{ mid}"))
        (vgplot:text-show-label)))))
    
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
