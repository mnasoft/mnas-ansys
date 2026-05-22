;;;; ./src/cfx/pre/method/interface-pairs-fluid-rotational.lisp

(in-package :mnas-ansys/cfx/pre)

(defmethod interface-pairs-fluid-rotational ((simulation <simulation>))
  " @b(Пример использования:)
@begin[lang=lisp](code)
 (interface-pairs-fluid-rotational *simulation*)
@end(code)"
  (mapcar #'first
          (sort
           (remove-if-not
            #'(lambda (el)
                (string= (first el) (second el)))
            (interface-pairs-fluid simulation))
           #'two-string-list<)))

