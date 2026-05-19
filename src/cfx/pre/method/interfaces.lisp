;;;; ./src/cfx/pre/method/interfaces.lisp

(in-package :mnas-ansys/cfx/pre)

(defmethod interfaces ((mesh <mesh>))
  "@b(Описание:) метод @b(interfaces) возвращает список ключей 2d-регионов,
являющихся интерфейсами для сети @b(mesh).

 @b(Пример использования:)
@begin[lang=lisp](code)
 (interfaces (3d-region \"DG1 G1 1\" *simulation*))
@end(code)"
  (sort
   (remove-if #'(lambda (el)
                  (not
                   (uiop:string-prefix-p "C" el)))
              (ht-keys (<mesh>-2d-regions mesh)))
   #'string<))

(defmethod interfaces ((3d-region <3d-region>))
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
