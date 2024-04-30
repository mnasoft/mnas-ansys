(in-package :mnas-ansys/cfx/file)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; Vars

(progn
  (defparameter *res-file*
    "D:/home/_namatv/CFX/n70/cfx/Ne_R=1.00/N70_prj_17/N70_prj_17mt_001_83.res"
    "Полный путь к res-файлу.")

  (defparameter *s-obj-file*
    "D:/home/_namatv/CFX/n70/cfx/Ne_R=1.00/N70_prj_17/N70_prj_17mt_001_83.s-obj"

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
