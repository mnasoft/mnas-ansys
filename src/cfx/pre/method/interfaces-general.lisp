;;;; ./src/cfx/pre/method/interface.lisp

(in-package :mnas-ansys/cfx/pre)

(defmethod interfaces-general ((mesh <mesh>))
  "@b(Описание:) метод @b(interfaces) возвращает список ключей 2d-регионов,
являющихся интерфейсами для сети @b(mesh).

 @b(Пример использования:)
@begin[lang=lisp](code)
 (interfaces (3d-region \"DG1 G1 1\" *simulation*))
@end(code)"
  (remove-if #'interface-rotational-p
             (interfaces mesh)))

(defmethod interfaces-general ((3d-region <3d-region>))
  ;;;; ToDo
  "@b(Описание:) метод @b(interfaces) возвращает список имен 2d-регионов,
являющихся интерфейсами для 3d-региона @b(3d-region).

 @b(Пример использования:)
@begin[lang=lisp](code)
 (interfaces (3d-region \"DG1 G1 1\" *simulation*))
@end(code)"
  (sort 
   (remove-if #'(lambda (el)
                  (not
                   (uiop:string-prefix-p "C" el)))
              (2d-region-values 3d-region))
   #'string<))

