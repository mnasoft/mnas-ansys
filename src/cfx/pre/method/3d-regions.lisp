;;;; ./src/cfx/pre/method/3d-regions.lisp

(in-package :mnas-ansys/cfx/pre)

(defmethod 3d-regions ((simulation <simulation>))
  " @b(Пример использования:)
@begin[lang=lisp](code)
 (domains *ds*)
@end(code)"
  (ht-keys-sort (<simulation>-3d-regions simulation)))
