;;;; ./src/cfx/solver/test.lisp

(in-package :mnas-ansys/cfx/solver)

(ql:quickload :pathname-utils)
(ql:quickload :split-sequence)

(defparameter *fn*
  (pathname-utils:merge-pathnames*
   "src/cfx/solver/test/prj.out"
   (asdf:system-source-directory "mnas-ansys/cfx/solver")))

(defparameter *lst* (out-file-find-cel-start-end *fn*))

;; Пример использования:
(defparameter *lines*
  (let ((os (make-string-output-stream)))
    (mnas-ansys/ccl/parse:convert-to-ccl
     *lst*
     :stream os)
    (split-sequence:split-sequence
     #\newline
     (get-output-stream-string os)
     :remove-empty-subseqs t)))

(equalp (mnas-ansys/ccl/parse:parse *lines*) *lst*)

"Updating Command Language with the following changes:"
