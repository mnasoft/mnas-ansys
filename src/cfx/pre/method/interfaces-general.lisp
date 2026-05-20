;;;; ./src/cfx/pre/method/interfaces-general.lisp

(in-package :mnas-ansys/cfx/pre)

(defmethod interfaces-general ((mesh <mesh>))
  " @b(Пример использования:)
@begin[lang=lisp](code)
 (interfaces-general (mesh \"G1\" *simulation*))
@end(code)"
  (remove-if #'interface-rotational-p
             (interfaces mesh)))

(defmethod interfaces-general ((3d-region <3d-region>))
  ;;;; ToDo
  "@b(Описание:) метод @b(interfaces) возвращает список имен 2d-регионов,
являющихся интерфейсами для 3d-региона @b(3d-region).

 @b(Пример использования:)
@begin[lang=lisp](code)
 (interfaces-general (3d-region \"DG1 G1 1\" *simulation*))
@end(code)"
  (remove-if #'interface-rotational-p
             (interfaces 3d-region)))

