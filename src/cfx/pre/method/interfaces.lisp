;;;; ./src/cfx/pre/method/interfaces.lisp

(in-package :mnas-ansys/cfx/pre)

(defmethod interfaces ((mesh <mesh>))
  " @b(Пример использования:)
@begin[lang=lisp](code)
 (interfaces (mesh \"G1\" *simulation*))
@end(code)"
  (sort
   (remove-if (complement #'interface-p)
              (ht-keys (<mesh>-2d-regions mesh)))
   #'string<))

(defmethod interfaces ((3d-region <3d-region>))
  " @b(Пример использования:)
@begin[lang=lisp](code)
 (interfaces (3d-region \"DG1 G1 1\" *simulation*))
@end(code)"
  (sort
   (remove-if (complement #'interface-p)
              (2d-region-values 3d-region))
   #'string<))
