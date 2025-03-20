(in-package :mnas-ansys/ccl/parse)

(defun parse (lines)
  (labels ((out-key-val (lst os)
             (cond ((= (length lst) 1) (format os "(~{~S~} ~S " lst ""))
                   ((= (length lst) 2) (format os "(~{~S~^ ~})" lst)))))
    (let ((os (make-string-output-stream))
          (is (make-string-input-stream (remove-back-slesh lines)
               #+nil 
               (ppcre:regex-replace-all
                "[ ]+"
                (remove-back-slesh lines)
                " ")))
          )
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

;;; bak
(defun parse (strings)
  (labels ((out-key-val (lst os)
             (cond ((= (length lst) 1) (format os "(~{~S~} ~S " lst ""))
                   ((= (length lst) 2) (format os "(~{~S~^ ~})" lst)))))
    (let ((os (make-string-output-stream))
          (is (make-string-input-stream strings)))
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
