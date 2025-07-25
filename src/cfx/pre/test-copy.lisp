;;;; ./src/cfx/pre/test.lisp

(in-package :mnas-ansys/cfx/pre)

(defun foo (pathname directory)
  (namestring
   (make-pathname :directory directory
                  :name (pathname-name pathname)
                  :type (pathname-type pathname))))

(map
 nil
 #'(lambda (el)
     (uiop:copy-file el (foo el "//n000339/Users/namatv/pp")))
 (directory "z:/ANSYS/CFX/a32/tin/DOM/*/A32_prj_06_*.tin"))
