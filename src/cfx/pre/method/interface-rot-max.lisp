;;;; ./src/cfx/pre/method/interface-rot-max.lisp

(in-package :mnas-ansys/cfx/pre)

#+nil
(defmethod interface-rot-max (mesh-name (simulation <simulation>))
  (remove-if-not
   #'2d-region-left-p
   (interfaces (3d-region-max mesh-name simulation))))

(defmethod interface-rot-max (mesh-name (simulation <simulation>))
  (remove-if-not
   #'interface-left-p
   (interfaces (3d-region-max mesh-name simulation))))
