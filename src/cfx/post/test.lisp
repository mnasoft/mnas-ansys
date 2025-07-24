;;;; ./src/cfx/post/test.lisp

(in-package :mnas-ansys/cfx/post)

;; GT-R.org - Сначала нужно загрузить его.
(progn
  (defparameter *res-fname*
    "Z:/ANSYS/CFX/a32/cfx/A32_prj_06/DP=001/A32_prj_06_002.res")

  (defparameter *res* (mnas-ansys/cfx/file:open-cfx-file *res-fname*))

  (defparameter *res-report* (make-instance '<res-report> :result *res*))

  (defparameter *gt-l*
    (make-instance '<mfr-gt>
                   :tracts *gt-l-air*
                   :name "Левая (четная) ЖТ)"
                   :result *res*))

  (defparameter *gt-r*
    (make-instance '<mfr-gt>
                   :tracts *gt-r-air*
                   :name "Правая (нечетная) ЖТ)"
                   :result *res*))

  (defparameter *gt-tf-l*
    (make-instance '<tf-gt> :name "Левая (четная) ЖТ)"
                            :result *res*
                            :mon-prefix "GT L OUT"
                            ))
  (defparameter *gt-tf-r*
    (make-instance '<tf-gt> :name "Правая (нечетная) ЖТ)"
                            :result *res*
                            :mon-prefix "GT R OUT"
                            ))
  )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(progn 
  (mfr-table *gt-l*) (mfr-table-group *gt-l*)
  (mfr-table *gt-r*) (mfr-table-group *gt-r*)
  (vgplot:close-plot)
  (let* ((data (cumulative-step (mfr-table-plot-data *gt-r*)))
         (x (mapcar #'first data))
         (y (mapcar #'second data)))
    (vgplot:plot x y)))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
#+nil
(mnas-ansys/cfx/file:mon-select ".*OUT.*" (<result>-result *gt-tf-l*))

(r-i 14.5 *gt-tf-l*)
(h *gt-tf-l*)
(h-i 14 *gt-tf-l*)
(+ 63.8 411.0)
(<tf-gt>-r-num *gt-tf-l*)
(h-delta *gt-tf-l*)
r-i-width
(r-i-width 14 *gt-tf-l*)  ; => 182.34871897256005d0

(area-i-j 1 0 *gt-tf-l*) ;




(1- (/ (mass-flow-rate *gt-tf-l*) (mass-flow-rate *gt-tf-r*)))

 ; => 







(let ((obj *gt-tf-r*))
  (Velocity-u-monitor-i-j 3 3 obj)
  (Total-Temperature-monitor-i-j 7 15 obj)
  (Density-monitor-i-j 0 15 obj)
  (ave-total-temperature obj)
  )
