;;;; ./src/cfx/pre/method/interface-rot-left.lisp

(in-package :mnas-ansys/cfx/pre)

(defmethod interface-rot-left (mesh-name (simulation <simulation>))
  (apply #'append
         (loop :for 3d-region :in (3d-region-left mesh-name simulation)
               :collect
               (remove-if-not
                #'2d-region-left-p
                (interfaces-with 3d-region mesh-name)))))
