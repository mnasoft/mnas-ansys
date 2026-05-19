;;;; ./src/cfx/pre/method/interface-rot-max.lisp

(in-package :mnas-ansys/cfx/pre)

(defmethod interface-rot-max (mesh-name (simulation <simulation>))
  (remove-if-not
   #'2d-region-left-p
   (interfaces (3d-region-max mesh-name simulation))))
