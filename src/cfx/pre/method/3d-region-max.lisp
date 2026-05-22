;;;; ./src/cfx/pre/method/3d-region-max.lisp

(in-package :mnas-ansys/cfx/pre)

(defmethod 3d-region-max (mesh-name (simulation <simulation>))
  " @b(Пример использования:)
@begin[lang=lisp](code)
 (3d-region-max \"G1\" *simulation*)
@end(code)"
  (first (sort (3d-region-mesh mesh-name simulation)
               #'>
               :key #'<3d-region>-3d-suffix)))
