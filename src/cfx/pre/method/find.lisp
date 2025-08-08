;;;; ./src/cfx/pre/method/find.lisp

(in-package :mnas-ansys/cfx/pre)

#+nil
(defmethod find-mesh-surface-name-by-domain-surface-name (domain-surface-name (domain <3d-region>))
  (find domain-surface-name
        (alexandria:hash-table-keys (<3d-region>-2d____  domain))
        :test #'equal
        :key #'(lambda (el)
                 (gethash el (<domain>-surfaсes domain)))))

