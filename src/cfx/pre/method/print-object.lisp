;;;; ./src/cfx/pre/test.lisp

(in-package :mnas-ansys/cfx/pre)

(defmethod print-object ((obj <mesh>) s)
  (print-unreadable-object (obj s :type t)
    (format s "~S Instances: ~S~%tin-pathname: ~S~%msh-pathname: ~S~%2D-Regions:~%Keys~40TValues~%~{~{~40S~}~%~}"
            (<mesh>-name obj) ; Имя
            (<mesh>-3d-region-instance-number obj) ; Количество ссылок
            (<mesh>-tin-pathname obj) ; Путь к tin-файлу
            (<mesh>-msh-pathname obj) ; Путь к msh-файлу
            ;; Список 2d-регионов
            (loop :for 2d-region :in (ht-keys-sort (<mesh>-2d-regions obj))
                  :collect
                  (list 2d-region (2d-region 2d-region obj))))))

(defmethod print-object ((obj <3d-region>) s)
  (print-unreadable-object (obj s :type t)
    (format s "Mesh: ~5S 3D-Suffix: ~2S 2D-Suffix: ~2S Simulation: ~3S"
            (<mesh>-name (<3d-region>-mesh obj))
            (<3d-region>-3d-suffix obj)
            (<3d-region>-2d-suffix obj)
            (when (<3d-region>-simulation obj) T))))

(defmethod print-object ((simulation <simulation>) s)
  (print-unreadable-object (simulation s :type t)
    (format s "~%Meshes    : ~S~%3D-Regions: ~S~%Commands  : ~S"
            ;; Список 3d-сеток (имя - количество ссылок)
            (loop :for msh :in (ht-keys-sort (<simulation>-meshes simulation))
                  :collect
                  (list msh
                        (<mesh>-3d-region-instance-number
                         (mesh msh simulation))))
            ;; Список имен регионов
            (ht-keys-sort (<simulation>-3d-regions simulation))
            ;; Список команд (реверсированный в порядке их добавления)
            (reverse (<simulation>-commands simulation)))))

(defmethod print-object ((obj <simulation-mesh-transformation>) s)
  (print-unreadable-object (obj s :type t)
  (when (string= "Rotation"
                 (mnas-ansys/ccl/core:<mesh-transformation>-option
                  (<simulation>-mesh-transformation obj)))
    (format s "~S "
            (mnas-ansys/ccl/core:<mesh-transformation>-option
             (<simulation>-mesh-transformation obj)))
    (format s "~15S "
            (mnas-ansys/ccl/core:<mesh-transformation>-Target-Location
             (<simulation>-mesh-transformation obj)))
    (format s "~15S "
            (mnas-ansys/ccl/core:<mesh-transformation>-Rotation-Angle
             (<simulation>-mesh-transformation obj))))))

(defmethod print-object ((obj <simulation-interface-general>) s)
  (print-unreadable-object (obj s :type t)
    (format s "~S ~S ~S"
            (<simulation-interfaces-general>-mesh-name-1 obj)
            (<simulation-interfaces-general>-mesh-name-2 obj)
            (null (null (<simulation-command>-simulation obj)))
    )))


