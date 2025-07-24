;;;; ./src/cfx/post/method-tf-gt.lisp

(in-package :mnas-ansys/cfx/post)

(defmethod print-object ((obj <tf-gt>) s)
  (print-unreadable-object (obj s :type t)
    (format s "~S"
            (<tf-gt>-name obj))))

(defmethod h ((obj <tf-gt>))
  "Высота"
  (- (<tf-gt>-r-max obj)
     (<tf-gt>-r-min obj)))

(defmethod h-i-relative (i (obj <tf-gt>))
  "Относительная высота i-того пояса"
  (/ (1+ (* 2 i)) 2 (<tf-gt>-r-num obj)))

(defmethod h-i (i (obj <tf-gt>))
  "Высота i-того пояса"
  (* (h obj)
     (h-i-relative i obj)))

(defmethod r-i (i (obj <tf-gt>))
  "Радиус i-того пояса"
  (+ (<tf-gt>-r-min obj)
     (* (h obj)
        (h-i-relative i obj))))

(defmethod a-delta ((obj <tf-gt>))
  "Угол ячейки"
  (/ (<tf-gt>-a obj)
     (/ (1- (<tf-gt>-a-num obj)) 2)))

(defmethod h-delta ((obj <tf-gt>))
  "Высота ячейки"
  (/ (h obj) (<tf-gt>-r-num obj)))

(defmethod a-j (j (obj <tf-gt>))
  "Угол расположения j-товой ячейки, отсчитываемый от вертикальной оси;
при взгляде на обойму против хода газа; против часовой стрелки."
  (- (<tf-gt>-a obj)
     (* (a-delta obj) j)))

(defmethod r-i-width (i (obj <tf-gt>))
  (- (/ (* 2 pi (r-i i obj))
        (<tf-gt>-n-tube obj))
     (* 2 (<tf-gt>-delta obj))))

(defmethod area-i-j (i j (obj <tf-gt>))
  "Площадь элемента сечения ЖТ, mm^2"
  (cond
    ((or (= j 0) (= j (1- (<tf-gt>-a-num obj))))
     (let ((area 
             (* (h-delta obj)
                (/ (- (r-i-width i obj)
                      (* (r-i i obj)
                         (/ pi 180)
                         (a-delta obj)
                         (- (<tf-gt>-a-num obj) 2)))
                   2))))
       (when (or (= i 0) (= i (1- (<tf-gt>-r-num obj))))
         (decf area (* 0.25
                       (- 4 pi)
                       (expt (<tf-gt>-r-small obj) 2))))
       area))
    (t
     (* (h-delta obj) (r-i i obj) (* (/ pi 180)(a-delta obj))))))


(defmethod monitor-i-j (i j name (obj <tf-gt>))
  (let ((key (format nil "~A ~A ~A:~A"
                     (<tf-gt>-mon-prefix obj)
                     (+ i (<tf-gt>-r-start-index obj))
                     (+ j (<tf-gt>-a-start-index obj))
                     name))
        (ht (mnas-ansys/cfx/file:<res>-mon
             (<result>-result obj))))
    (math/stat:average-value
     (mnas-ansys/cfx/file/mon:<mon>-data
      (gethash key ht)))))

(defmethod Velocity-u-monitor-i-j (i j (obj <tf-gt>))
  "Проекция скорости в направлении (u) оси X в точке (i,j), m/s"
  (monitor-i-j i j "Velocity u" obj))

(defmethod Total-Temperature-monitor-i-j (i j (obj <tf-gt>))
  "Полная температура в точке (i,j), K"  
  (monitor-i-j i j "Total Temperature" obj))

(defmethod Density-monitor-i-j (i j (obj <tf-gt>))
  "Плотность в точке (i,j)"
  (monitor-i-j i j "Density" obj))

(defmethod mass-flow-rate ((obj <tf-gt>))
  "Массовый расход на выхде из ЖТ, kg/s"
  (loop :for i :from 0 :below (<tf-gt>-r-num obj)
        :summing
        (loop :for j :from 0 :below (<tf-gt>-a-num obj)
              :summing
              (* 1e-3 ; mm -> m
                 1e-3 ; mm -> m
               (area-i-j               i j obj)
                 (velocity-u-monitor-i-j i j obj)
                 (density-monitor-i-j    i j obj)))))

(defmethod ave-total-temperature ((obj <tf-gt>))
  "Среднемассовая температура на выхде из ЖТ, K"
  (let ((mfr (mass-flow-rate obj)))
    (loop :for i :from 0 :below (<tf-gt>-r-num obj)
          :summing
          (loop :for j :from 0 :below (<tf-gt>-a-num obj)
                :summing
                (/
                 (* 1e-3                ; mm -> m
                    1e-3                ; mm -> m
                    (area-i-j                         i j obj)
                    (velocity-u-monitor-i-j           i j obj)
                    (density-monitor-i-j              i j obj)
                    (total-temperature-monitor-i-j    i j obj))
                 mfr)))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defmethod monitor-coord (r-i a-i (obj <tf-gt>))
  
  )


