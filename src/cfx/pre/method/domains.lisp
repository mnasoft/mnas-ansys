;;;; ./src/cfx/pre/test.lisp

(in-package :mnas-ansys/cfx/pre)

(defmethod domains ((simulation <simulation>))
  " @b(Пример использования:)
@begin[lang=lisp](code)
 (domains *ds*)
@end(code)"
  (ht-keys-sort (<simulation>-domains simulation)))

(defmethod meshes ((obj <meshes>))
  (ht-keys-sort (<meshes>-meshes obj)))


