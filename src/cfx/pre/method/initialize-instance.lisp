;;;; ./src/cfx/pre/test.lisp

(in-package :mnas-ansys/cfx/pre)

#+nil
(defmethod initialize-instance :after ((cfx-domains <simulation>)
                                       &key icem-parts)
  (mapcar
   #'(lambda (el)
       (setf
        (gethash el
                 (<simulation>-icem-parts cfx-domains))
        el))
   icem-parts)
  cfx-domains)
