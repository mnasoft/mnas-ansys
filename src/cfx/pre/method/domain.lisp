;;;; ./src/cfx/pre/method/domain.lisp

(in-package :mnas-ansys/cfx/pre)

(defmethod domain-names-fluid ((simulation <simulation>))
  "D1")

(defmethod domain-names-solid  ((simulation <simulation>))
  (sort 
   (remove-if-not
    #'(lambda (el)
        (uiop:string-prefix-p "M" el))
    (mesh-names simulation))
   #'string<))
