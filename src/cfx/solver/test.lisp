;;;; ./src/cfx/solver/test.lisp

(in-package :mnas-ansys/cfx/solver)
                                         )
(ql:quickload :pathname-utils)

(pathname-utils:merge-pathnames*
 "src/cfx/solver/test/prj.out"
 (asdf:system-source-directory "mnas-ansys/cfx/solver"))

(defparameter *fn*
  (pathname-utils:merge-pathnames*
   "src/cfx/solver/test/prj.out"
   (asdf:system-source-directory "mnas-ansys/cfx/solver")))


(out-file-find-cel-start-end *fn*)
