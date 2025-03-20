;;;; /src/ccl/parse/test-01.lisp

(in-package :mnas-ansys/ccl/parse)

(defun parse (string)
  (labels ((out-key-val (lst os)
             (cond ((= (length lst) 1) (format os "(~{~S~} ~S " lst ""))
                   ((= (length lst) 2) (format os "(~{~S~^ ~})" lst)))))
    (let ((os (make-string-output-stream))
          (is (make-string-input-stream string)))
      (format os "(")
      (loop :for line = (read-line is nil)
            :while line
            :do
               (let ((s-tr (string-trim " " line)))
                 (cond
                   ((key-value-p line)
                    (out-key-val (ppcre:split " *= *" s-tr ) os))
                   ((header-p line)
                    (out-key-val (ppcre:split ": *" s-tr ) os))
                   ((end-p line)
                    (format os ")")))))
      (format os ")")
      (read-from-string (get-output-stream-string os)))))
 
(defparameter *fn* 
  "/home/mna/quicklisp/local-projects/ANSYS/mnas-ansys/src/ccl/parse/test-02.out")

(parse-file *fn*)
