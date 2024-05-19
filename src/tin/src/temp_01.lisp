
(in-package :mnas-ansys/tin)

(defparameter *tin*
  (mnas-ansys/tin:open-tin-file "D:/cfx/project3.tin"))

(defparameter *lines* 
  (read-file-as-lines "D:/cfx/project3.tin"))

(svref *lines* 27)

(let ((lines *lines*)
      (n 27))
  
      (position-if #'(lambda (el) (find el '("bspline") :test #'string=))
		   lines
		   :start (1+ n)
		   :key (lambda (el) (first (mnas-string:split " " el)))))



(let ((lines *lines*)
      (n 28))
  (read-object *lines* n (make-instance '<bspline>)))

    (values curve (- (position-if #'(lambda (el) (find el *defines* :test #'string=))
				  lines
				  :start (1+ n)
				  :key (lambda (el) (first (mnas-string:split " " el))))
		     n))

