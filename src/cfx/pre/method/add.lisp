;;;; ./src/cfx/pre/method/add.lisp

(in-package :mnas-ansys/cfx/pre)

(defmethod add ((3d-region <3d-region>) (simulation <simulation>))
  "Добавляем домен в симуляцию"
  (setf (<3d-region>-3d-suffix 3d-region)
        (incf (<mesh>-3d-region-instance-number (<3d-region>-mesh 3d-region))))
  (setf (gethash (name 3d-region)
                 (<simulation>-3d-regions simulation))
        3d-region)
  (setf (<3d-region>-2d-suffix 3d-region)
        (hash-table-count (<simulation>-3d-regions simulation)))
  simulation)

(defmethod name ((3d-region <3d-region>))
  (let ((mesh-name (<mesh>-name (<3d-region>-mesh 3d-region))))
    (format nil "D~A ~A ~A" mesh-name mesh-name (<3d-region>-3d-suffix 3d-region))))

(defmethod name-old ((3d-region <3d-region>))
  "Возвращает имя 3d-региона при добавлении."
  (let ((mesh-name (<mesh>-name (<3d-region>-mesh 3d-region))))
    (format nil "D~A ~A" mesh-name mesh-name)))

(defmethod add ((mesh <mesh>) (simulation <simulation>))
  "Добавляем сетку к сиуляции."
  (setf (gethash (<mesh>-name mesh)
                 (<simulation>-meshes simulation))
        mesh)
  simulation)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defmethod add ((obj <simulation-mesh-transformation>) (simulation <simulation>))
  (push obj (<simulation>-commands simulation)))

(defmethod add ((obj <simulation-interface-general>) (simulation <simulation>))
  (push obj (<simulation>-commands simulation)))

(defmethod add ((obj <simulation-interface-rotational-periodicity>) (simulation <simulation>))
  (push obj (<simulation>-commands simulation)))

(defmethod add ((obj <simulation-interface-rotational-general>) (simulation <simulation>))
  (push obj (<simulation>-commands simulation)))

(defmethod add ((obj <simulation-materials>) (simulation <simulation>))
  (push obj (<simulation>-commands simulation)))

(defmethod add ((obj <simulation-flow>) (simulation <simulation>))
  (push obj (<simulation>-commands simulation)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

