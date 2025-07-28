;;;; ./src/cfx/pre/test.lisp

(in-package :mnas-ansys/cfx/pre)

(defmethod print-object ((domain <mesh>) s)
  (print-unreadable-object (domain s :type t)
    (format s "~S ~S"
            (<mesh>-name domain)
            (<mesh>-surfaces domain))))

(defmethod print-object ((meshes <meshes>) s)
  (print-unreadable-object (meshes s :type t)
    (format s "~S" (meshes meshes))))

(defmethod print-object ((domain <domain>) s)
  (print-unreadable-object (domain s :type t)
    (format s "~%~S~%~S"
            (<domain>-name domain)
            (ht-keys-sort (<domain>-surfaсes domain)))))

(defmethod print-object ((simulation <simulation>) s)
  (print-unreadable-object (simulation s :type t)
    (format s "~%Meshes  : ~S"
            (sort
             (alexandria:hash-table-keys
              (<meshes>-meshes simulation))
             #'string<))
    (format s "~%~S~%Surfaces: ~S"
            (sort 
             (alexandria:hash-table-values
              (<simulation>-domains simulation))
             #'string< :key #'<domain>-name)
            (<simulation>-surfaces simulation))))

