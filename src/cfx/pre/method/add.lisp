;;;; ./src/cfx/pre/method/add.lisp

(in-package :mnas-ansys/cfx/pre)

(defmethod add ((3d-region <3d-region>) (simulation <simulation>))
  "@b(Описание:) метод @b(add) добавляет 3d-region @b(3d-region) в
симуляцию @b(simulation).

 @b(Пример использования:)
@begin[lang=lisp](code)
 (add (make-instance '<3d-region>
                     :mesh (mesh \"G1\" *simulation*) :simulation *simulation*)
      *simulation*)
@end(code)"
  (setf (<3d-region>-3d-suffix 3d-region)
        (incf (<mesh>-3d-region-instance-number (<3d-region>-mesh 3d-region))))
  (setf (gethash (name 3d-region)
                 (<simulation>-3d-regions simulation))
        3d-region)
  (setf (<3d-region>-2d-suffix 3d-region)
        (hash-table-count (<simulation>-3d-regions simulation)))
  simulation)


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
