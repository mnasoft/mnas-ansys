;;;; ./src/cfx/pre/method/3d-region-not-min.lisp

(in-package :mnas-ansys/cfx/pre)

(defmethod 3d-region-not-min (mesh-name (simulation <simulation>))
  "@b(Описание:) метод @b(3d-region-min) возвращает объекты типа
@b(<3d-region>) с не минимальным 3d-суффиксом по имени сетки
@b(mesh-name) из симуляции @b(simulation)."
  (cdr (sort (3d-region-mesh mesh-name simulation)
               #'<
               :key #'<3d-region>-3d-suffix)))
