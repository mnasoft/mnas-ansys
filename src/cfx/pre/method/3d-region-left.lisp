;;;; ./src/cfx/pre/method/3d-region-left.lisp

(in-package :mnas-ansys/cfx/pre)

(defmethod 3d-region-left (mesh-name (simulation <simulation>))
  "@b(Описание:) метод @b(3d-region-min) возвращает список объектов типа
@b(<3d-region>) с минимальными 3d-суффиксами по имени сетки
@b(mesh-name) из симуляции @b(simulation)."
  (let ((3d-regions (3d-region-mesh mesh-name simulation)))
    (butlast
     (sort 3d-regions
           #'<
           :key #'<3d-region>-3d-suffix))))
