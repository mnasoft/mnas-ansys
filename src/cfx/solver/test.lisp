;;;; ./src/cfx/solver/test.lisp

(in-package :mnas-ansys/cfx/solver)

(ql:quickload :pathname-utils)
(ql:quickload :split-sequence)

(defparameter *fn*
  (pathname-utils:merge-pathnames*
   "src/cfx/solver/test/prj.out"
   (asdf:system-source-directory "mnas-ansys/cfx/solver")))


(defun subseq-by-predicate (sequence predicate-start predicate-stop &key (start 0))
  (let* ((s (position-if predicate-start sequence :start start))
         (e (position-if predicate-stop  sequence :start s)))
    (values 
     (subseq sequence s e)
     (list s e))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defparameter *out*
  (make-instance '<out> :file "Z:/CFX/n70/cfx/DP=007/N70_prj_36_001.out"))


(update *out*)
(<out>-lines *out*)
(cel  *out*)
(changes *out*)
(outer-loop-iteration *out*)
