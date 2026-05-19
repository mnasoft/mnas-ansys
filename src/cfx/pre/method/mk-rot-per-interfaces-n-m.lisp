;;;; ./src/cfx/pre/method/mk-rot-per-interfaces-n-m.lisp

(in-package :mnas-ansys/cfx/pre)

(defmethod mk-rot-per-interfaces-n-m (mesh-name
                                      (simulation <simulation>)
                                      &key (postfix "ROT"))
  (let* ((i-min (interface-rot-min mesh-name simulation))
         (i-max (interface-rot-max mesh-name simulation)))
    (when (and i-min i-max)
      (make-domain-interface-rotational-periodicity
       (mnas-string:common-prefix (append i-min i-max)) i-min i-max
       :postfix postfix))))
