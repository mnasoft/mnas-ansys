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

#+nil
(setf *res* (load-instance *res*)) ; Загружаем данные из файла

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
;;;;


(math/stat:average-value
 (coerce 
  (mnas-ansys/cfx/file/mon:<mon>-data
   (gethash "GT OUT 109 100:Total Temperature" (<res>-mon *res*)))
  'list))

(defmethod aver-temp ((res <res>)
                      &key 
                        (h-i-from 100)
                        (h-i-to   109)
                        (w-i-from 100)
                        (w-i-to   134)
                        (h-rel
                            (loop :for h-i :from h-i-from :to h-i-to
                                  :for h-r :from 0.05 :by 0.1
                                  :collect h-r)
                                  )
                        )
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
    (vgplot:plot (mapcar #'second t-mid) (mapcar #'first t-mid))))

(defmethod max-temp ((res <res>)
                      &key 
                        (h-i-from 100)
                        (h-i-to   109)
                        (w-i-from 100)
                        (w-i-to   134)
                        (h-rel
                            (loop :for h-i :from h-i-from :to h-i-to
                                  :for h-r :from 0.05 :by 0.1
                                  :collect h-r)
                                  )
                        )
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
    (vgplot:plot (mapcar #'second t-max) (mapcar #'first t-max))))

(defmethod t-03-00 ((res <res>))
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
  (- (t-03-00 res) (t-02 res)))

(t-03-00 *res*)

(dt *res*)

(aver-temp *res*)

(max-temp *res*)

(progn
  (setf *res* (load-instance *res*)) ; Загружаем объект из s-obj-файла

  (<res>-data *res*)
  (mon-select ".*" *res*)




;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(<res>-mon *res*)

(<res>-ccl *res*)



(t-03-00 *res*)
