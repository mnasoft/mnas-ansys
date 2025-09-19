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


(defmethod print-object ((obj <simulation-interface-rotational-periodicity>) s)
  (print-unreadable-object (obj s :type t)
    (format s "~S ~S"
            (<simulation-interface-rotational-periodicity>-mesh-name obj)
            (null (null (<simulation-command>-simulation obj))))))

(defmethod print-object ((obj <simulation-interface-rotational-general>) s)
  (print-unreadable-object (obj s :type t)
    (format s "~S ~S"
            (<simulation-interface-rotational-general>-mesh-name obj)
            (null (null (<simulation-command>-simulation obj))))))

(defmethod print-object ((obj <simulation-flow>) s)
  (print-unreadable-object (obj s :type t)
    (format s "~S ~S ~{~S~^,~} ~S ~S"
            (<simulation-flow>-flow-name obj)
            (<simulation-flow>-domain-fluid-name obj)
            (<simulation-flow>-domain-solid-names obj)
            (<simulation-flow>-reference-pressure obj)
            (null (null (<simulation-command>-simulation obj))))))

(defmethod print-object ((obj <simulation-boundary-inlet>) s)
  (print-unreadable-object (obj s :type t)
    (format s "~S " (<simulation-boundary-inlet>-name obj))
    (format s "~S " (<simulation-boundary-inlet>-mass-flow-rate obj))
    (when (<simulation-boundary-inlet>-static-temperature obj)
      (format s "~S " (<simulation-boundary-inlet>-static-temperature obj)))
    (when (<simulation-boundary-inlet>-total-temperature obj)
      (format s "~S " (<simulation-boundary-inlet>-total-temperature obj))
      (format s "~S " (null (null (<simulation-command>-simulation obj))))
      (format s "~S " (<simulation-boundary-inlet>-Location obj)))))

(defmethod print-object ((obj <simulation-boundary-outlet>) s)
  (print-unreadable-object (obj s :type t)
    (format s "~S " (<simulation-boundary-outlet>-name obj))
    (when (<simulation-boundary-outlet>-mass-flow-rate obj)
      (format s "~S " (<simulation-boundary-outlet>-mass-flow-rate obj)))
    (when (<simulation-boundary-outlet>-relative-pressure obj)
      (format s "~S " (<simulation-boundary-outlet>-relative-pressure obj)))
    (format s "~S " (null (null (<simulation-command>-simulation obj))))
    (format s "~S" (<simulation-boundary-outlet>-location obj))))

(defmethod print-object ((obj <simulation-solver>) s)
  (print-unreadable-object (obj s :type t)))

(defmethod print-object ((obj <simulation-control>) s)
  (print-unreadable-object (obj s :type t)))

(defmethod print-object ((obj <simulation-monitor-point-region>) s)
  (print-unreadable-object (obj s :type t)
    (format s "~S " (<simulation-monitor-point-region>-prefix obj))
    (format s "~S " (<simulation-monitor-point-region>-expression obj))
    (format s "~{~S~^,~}" (<simulation-monitor-point-region>-2d-regions-template obj))))

(defmethod print-object ((obj <simulation-monitor-point-named-points>) s)
  (print-unreadable-object (obj s :type t)
    (format s "~S " (<simulation-monitor-point-named-points>-prefix obj))
    (format s "~S " (<simulation-monitor-point-named-points>-domain-name obj))
    (format s "~S " (length (<simulation-monitor-point-named-points>-named-points obj)))
    (format s "~{~S~^,~}" (<simulation-monitor-point-named-points>-output-variables-list obj))
    ))

(defmethod print-object ((obj <simulation-monitor-point>) s)
  (print-unreadable-object (obj s :type t)
    (format s "~S " (null (null (<simulation-command>-simulation obj))))
    (format s "~{~S~^,~} " (<simulation-monitor-point>-locations obj))
    (format s "~{~{~S~^-~}~^,~} " (<simulation-monitor-point>-prefix-expression obj))))

