;;;; ./src/cfx/pre/method/3d-region-mesh.lisp

(in-package :mnas-ansys/cfx/pre)

(defmethod 3d-region-mesh (mesh-name (simulation <simulation>))
  "@b(Описание:) метод @b(3d-region-mesh) возвращает список объектов типа
@b(<3d-region>) по имени сетки @b(mesh-name) из симуляции @b(simulation).

 @b(Пример использования:)
@begin[lang=lisp](code)
 (3d-region-mesh \"G1\" *simulation*)
@end(code)"
  (remove-if-not
   #'(lambda (el)
       (string=
        mesh-name
        (<mesh>-name (<3d-region>-mesh el))))
   (ht-values (<simulation>-3d-regions simulation))))
