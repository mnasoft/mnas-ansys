;;;; ./src/cfx/pre/method/name-old.lisp

(in-package :mnas-ansys/cfx/pre)

(defmethod name-old ((3d-region <3d-region>))
  "Возвращает имя 3d-региона при добавлении."
  (let ((mesh-name (<mesh>-name (<3d-region>-mesh 3d-region))))
    (format nil "D~A ~A" mesh-name mesh-name)))
