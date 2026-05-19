;;;; ./src/cfx/pre/method/select-3d-regions-by-mesh-name.lisp

(in-package :mnas-ansys/cfx/pre)

(defmethod select-3d-regions-by-mesh-name (mesh-name (simulation <simulation>))
  "@b(Описание:) метод @b(select-3d-regions-by-mesh-name) возвращает
список 3d-регионов по имени сетки.

 @b(Пример использования:)
@begin[lang=lisp](code)
  (select-3d-regions-by-mesh-name \"G1\" *simulation*)
@end(code)"
  (sort
   (remove-if
    (complement (3d-region-with-mesh-name mesh-name))
    (ht-values (<simulation>-3d-regions simulation)))
   #'<
   :key #'<3d-region>-3d-suffix))
