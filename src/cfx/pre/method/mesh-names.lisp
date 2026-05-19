;;;; ./src/cfx/pre/method/mesh-names.lisp

(in-package :mnas-ansys/cfx/pre)

(defmethod mesh-names ((simulation <simulation>))
  " @b(Пример использования:)
@begin[lang=lisp](code)
 (mesh-names *simulation*)
@end(code)"
  (ht-keys (<simulation>-meshes simulation)))
