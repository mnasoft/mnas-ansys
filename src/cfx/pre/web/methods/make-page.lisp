;;;; ./src/cfx/pre/web/methods/make-page.lisp

(in-package #:mnas-ansys/cfx/pre/web)

(defun make-hw-page ()
  (make-instance 'hw-page))



(defun make-simulation-meshes-page ()
  (make-instance 'simulation-meshes-page))
