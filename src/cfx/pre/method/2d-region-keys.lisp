;;;; ./src/cfx/pre/method/2d-region-keys.lisp

(in-package :mnas-ansys/cfx/pre)

(defmethod 2d-region-keys ((seq sequence))
  (apply #'append
         (loop :for i :across (coerce seq 'vector)
               :collect
               (2d-region-values i))))

(defmethod 2d-region-keys ((mesh <mesh>))
  (ht-keys-sort (<mesh>-2d-regions mesh)))

(defmethod 2d-region-keys ((3d-region <3d-region>))
  (ht-keys-sort
   (<mesh>-2d-regions
    (<3d-region>-mesh 3d-region))))
