;;;; ./src/cfx/pre/method/interface-pairs-fluid.lisp

(in-package :mnas-ansys/cfx/pre)

(defmethod interface-pairs-fluid ((simulation <simulation>))
  (remove-if-not
   #'(lambda (el)
       (and
        (uiop:string-prefix-p "G" (first el))
        (uiop:string-prefix-p "G" (second el))))
   (interface-pairs simulation)))
