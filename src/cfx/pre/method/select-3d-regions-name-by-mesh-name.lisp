;;;; ./src/cfx/pre/method/select-3d-regions-name-by-mesh-name.lisp

(in-package :mnas-ansys/cfx/pre)

(defmethod select-3d-regions-name-by-mesh-name (mesh-name (simulation <simulation>))
  "@b(Описание:) метод @b(select-3d-regions-by-mesh-name) возвращает
список имен 3d-регионов по имени сетки.

 @b(Пример использования:)
@begin[lang=lisp](code)
  (select-3d-regions-name-by-mesh-name \"G1\" *simulation*)
@end(code)"
  (mapcar #'name
          (select-3d-regions-by-mesh-name mesh-name simulation)))
