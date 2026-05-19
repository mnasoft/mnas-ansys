;;;; ./src/cfx/pre/method/interface-rot-min.lisp

(in-package :mnas-ansys/cfx/pre)

(defmethod interface-rot-min (mesh-name (simulation <simulation>))
  (remove-if-not
   #'2d-region-right-p
   (interfaces (3d-region-min mesh-name simulation))))
