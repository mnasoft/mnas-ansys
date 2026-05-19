;;;; ./src/cfx/pre/method/interface-rot-right.lisp

(in-package :mnas-ansys/cfx/pre)

(defmethod interface-rot-right (mesh-name (simulation <simulation>))
  (apply #'append
         (loop :for 3d-region :in (3d-region-right mesh-name simulation)
               :collect
               (remove-if-not
                #'2d-region-right-p
                (interfaces-with 3d-region mesh-name)))))
