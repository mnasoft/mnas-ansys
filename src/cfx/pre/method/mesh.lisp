;;;; ./src/cfx/pre/test.lisp

(in-package :mnas-ansys/cfx/pre)

(defmethod mesh (name (simulation <simulation>))
  " @b(Пример использования:)
@begin[lang=lisp](code)
 (mesh   \"G2\"     *simulation*)
@end(code)"
  (gethash name (<simulation>-meshes simulation)))

(defmethod mesh (name (ht hash-table))
  " @b(Пример использования:)
@begin[lang=lisp](code)
 (mesh \"G1\" (<simulation>-meshes *simulation*))
@end(code)"
  (gethash name ht))
