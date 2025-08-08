;;;; ./src/cfx/pre/test.lisp

(in-package :mnas-ansys/cfx/pre)

(defmethod print-object ((obj <mesh>) s)
  (print-unreadable-object (obj s :type t)
    (format s "~S Instances: ~S~%tin-pathname: ~S~%msh-pathname: ~S~%2D-Regions:~%Keys~40TValues~%~{~{~40S~}~%~}"
            (<mesh>-name obj)
            (<mesh>-3d-region-instance-number obj)
            (<mesh>-tin-pathname obj)
            (<mesh>-msh-pathname obj)
            (loop :for 2d-region :in (ht-keys-sort (<mesh>-2d-regions obj))
                  :collect
                  (list 2d-region
                        (2d-region 2d-region obj)
                        )))))

#+nil 
(defmethod print-object ((meshes <meshes>) s)
  (print-unreadable-object (meshes s :type t)
    (format s "~S" (meshes meshes))))

(defmethod print-object ((obj <3d-region>) s)
  (print-unreadable-object (obj s :type t)
    (format s "| Mesh: ~S | 3D-Suffix: ~S | 2D-Suffix: ~S | Simulation: ~S |"
            (<mesh>-name (<3d-region>-mesh obj))
            (<3d-region>-3d-suffix obj)
            (<3d-region>-2d-suffix obj)
            (when (<3d-region>-simulation obj) T)
            )))

(defmethod print-object ((simulation <simulation>) s)
  (print-unreadable-object (simulation s :type t)
    (format s "~%Meshes    : ~S~%3D-Regions: ~S"
            (ht-keys-sort (<simulation>-meshes simulation))
            (ht-keys-sort (<simulation>-3d-regions simulation)))))


(format s "~%~S~%Surfaces: ~S"
        (sort 
         (alexandria:hash-table-values
          (<simulation>-domains simulation))
         #'string< :key #'<domain>-name)
        (<simulation>-surfaces simulation))


