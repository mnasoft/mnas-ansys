;;;; ./src/cfx/pre/method/mk-rot-gen-interfaces-n-m.lisp

(in-package :mnas-ansys/cfx/pre)

(defmethod mk-rot-gen-interfaces-n-m (mesh-name (simulation <simulation>) &key (postfix "ROT GEN"))
  (let* ((i-left (interface-rot-left mesh-name simulation))
         (i-right (interface-rot-right mesh-name simulation)))
    (when (and i-left i-right)
      (make-domain-interface-general-connection
       (mnas-string:common-prefix (append i-left i-right)) i-left i-right
       :postfix postfix))))
