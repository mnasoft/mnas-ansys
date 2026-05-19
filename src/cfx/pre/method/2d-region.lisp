;;;; ./src/cfx/pre/method/2d-region.lisp

(in-package :mnas-ansys/cfx/pre)

(defmethod 2d-region (key (mesh <mesh>))
  (gethash key (<mesh>-2d-regions mesh)))
