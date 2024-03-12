;;;; ./src/cfx/file/mon.lisp

(in-package :mnas-ansys/cfx/file)

(defun mon-number (mon)
  (first mon)
  )

(defun mon-name (mon)
  (second mon)  
  )

(defun mon-name-list (mon)
  (let* ((name (mon-name mon))
         (n-lst(mnas-string:split "\"" name)))
    (cond
      ((and (consp n-lst) (= 3 (length n-lst)))
       (append
        (mnas-string:split "," (first n-lst))
        (list (second n-lst))
        (mnas-string:split "," (third n-lst))))
      ((and (consp n-lst) (= 1 (length n-lst)))
       (mnas-string:split "," (first n-lst))))))

(defun mon-domain (mon)
  (nth 2 (mon-name-list mon)))

(defun mon-type (mon)
  (nth 4 (mon-name-list mon)))

(defun mon-coords (mon)
  )

(defparameter *mon*  (first (mon-select ".*CONE11.*" *res*)))

(defparameter *mon*  (first (mon-select ".*MFR.*" *res*)))

(mon-name *mon*)
