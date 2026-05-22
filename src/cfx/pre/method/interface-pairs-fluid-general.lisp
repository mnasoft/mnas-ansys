;;;; ./src/cfx/pre/method/interface-pairs-fluid-general.lisp

(in-package :mnas-ansys/cfx/pre)

(defmethod interface-pairs-fluid-general ((simulation <simulation>))
  " @b(Пример использования:)
@begin[lang=lisp](code)
 (interface-pairs-fluid-general *simulation*)
@end(code) "
  (sort
   (remove-if-not
    #'(lambda (el)
        (string/= (first el) (second el)))
    (interface-pairs-fluid simulation))
   #'two-string-list<))
