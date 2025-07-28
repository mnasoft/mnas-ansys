;;;; ./src/cfx/pre/method/find.lisp

(in-package :mnas-ansys/cfx/pre)

(defmethod find-mesh-surface-name-by-domain-surface-name (domain-surface-name (domain <domain>))
  (find domain-surface-name
        (alexandria:hash-table-keys (<domain>-surfaсes domain))
        :test #'equal
        :key #'(lambda (el)
                 (gethash el (<domain>-surfaсes domain)))))

(defmethod suffix (domain-surface-name (domain <domain>))
