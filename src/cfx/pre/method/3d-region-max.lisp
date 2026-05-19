;;;; ./src/cfx/pre/method/3d-region-max.lisp

(in-package :mnas-ansys/cfx/pre)

(defmethod 3d-region-max (mesh-name (simulation <simulation>))
  "@b(Описание:) метод @b(3d-region-min) возвращает объект типа
@b(<3d-region>) с максимальным 3d-суффиксом по имени сетки
@b(mesh-name) из симуляции @b(simulation)."
  (first (sort (3d-region-mesh mesh-name simulation)
               #'>
               :key #'<3d-region>-3d-suffix)))
