;;;; ./src/cfx/pre/test.lisp

(in-package :mnas-ansys/cfx/pre)

(defmethod select-3d-regions-by-mesh-name (mesh-name (simulation <simulation>))
  (sort
   (remove-if
    (complement (predicate-msh-name mesh-name))
    (ht-values (<simulation>-3d-regions simulation)))
    #'<
   :key #'<3d-region>-3d-suffix))

(defmethod select-3d-regions-name-by-mesh-name (mesh-name (simulation <simulation>))
  (mapcar #'name
          (select-3d-regions-by-mesh-name mesh-name simulation)))
