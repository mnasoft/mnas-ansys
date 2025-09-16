;;;; ./src/cfx/pre/class.lisp

(in-package :mnas-ansys/cfx/pre)

(defclass <mesh> ()
  ((mesh-3d-region-instance-number
    :accessor <mesh>-3d-region-instance-number
    :initarg  :3d-region-instance-number
    :initform 0
    :documentation "Количество 3d-регионов, которые ссылаются на эту сетку.")
   (mesh-tin-pathname
    :accessor <mesh>-tin-pathname
    :initarg  :tin-pathname
    :initform nil
    :documentation "Путь к в файловой системе tin-файлу геометрии.")
   (mesh-msh-pathname
    :accessor <mesh>-msh-pathname
    :initarg  :msh-pathname
    :initform nil
    :documentation "Путь в файловой системе к msh-файлу 3d-сетки.")
   (mesh-name
    :accessor <mesh>-name
    :initarg  :name
    :initform nil
    :documentation "Именя домена, например: \"G1\".")
   (2d-regions
    :accessor <mesh>-2d-regions ; <mesh>-surfaces <mesh>-2d-regions
    :initform (make-hash-table :test #'equal)
    :documentation "Хеш-таблица имен поверхностей, относящихся к домену по именному
соглашению ICEM."))
  (:documentation "Класс @b(<mesh>) представляет 3d-сетку системы ICEM."))

(defclass <3d-region> ()
  ((3d-region-mesh
    :accessor <3d-region>-mesh
    :initarg  :mesh
    :initform nil
    :documentation "Ссылка на объект типа <mesh>.")
   (3d-region-simulation
    :accessor <3d-region>-simulation
    :initarg  :simulation
    :initform nil
    :documentation "Ссылка на объект типа <simulation>.")
   (3d-region-3d-suffix
    :accessor <3d-region>-3d-suffix
    :initarg  :3d-suffix
    :initform nil
    :documentation "Суффикс 3d-региона. Например: 1, 2, 3.")
   (3d-region-2d-suffix
    :accessor <3d-region>-2d-suffix
    :initarg  :2d-suffix
    :initform nil
    :documentation "Суффикс для 2d-регионов. Например: 1, 2, 3.")))

(defclass <simulation> ()
  ((simulation-meshes
    :accessor <simulation>-meshes
    :initform (make-hash-table :test #'equal)
    :documentation "Представляет совокупность сеток загружаемых в симуляцию. Хеш-таблица
частей: ключ - имя; значение объект типа <mesh>.")
   (simulation-3d-regions
    :accessor <simulation>-3d-regions
    :initform (make-hash-table :test #'equal)
    :documentation
    "Хеш-таблица; ключ - объект типа <domain>; значение - объект типа
<domain>")
   (simulation-commands
    :accessor <simulation>-commands
    :initform '()
    :documentation
    "Список команд-объектов"))
  (:documentation "Симуляция CFX-Pre")
  )

(defclass <simulation-command> ()
  ((simulation-command-simulation
    :accessor <simulation-command>-simulation
    :initarg  :simulation
    :initform nil
    :type (or <simulation> null)
    :documentation "Ссылка на объект типа <simulation>."))
  (:documentation "Базовый класс для команд-объектов симуляции CFX-Pre"))

(defclass <simulation-mesh-transformation> (<simulation-command>)
  ((simulation-mesh-transformation
    :accessor <simulation>-mesh-transformation
    :initarg :mesh-transformation
    :type mnas-ansys/ccl/core:<mesh-transformation>))
  (:documentation "Базовый класс для команд-объектов симуляции CFX-Pre"))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defclass <simulation-interface-general> (<simulation-command>)
  ((mesh-name-1
    :accessor <simulation-interfaces-general>-mesh-name-1
    :initarg :mesh-name-1
    :type string
    :documentation "Имя первой сетки, сопрягаемой интефейсом")
   (mesh-name-2
    :accessor <simulation-interfaces-general>-mesh-name-2
    :initarg :mesh-name-2
    :type string
    :documentation "Имя второй сетки, сопрягаемой интефейсом."))
  (:documentation "Представляет Имя второй сетки, сопрягаемой интефейсом."))

(defclass <simulation-interface-rotational-periodicity> (<simulation-command>)
  ((mesh-name
    :accessor <simulation-interface-rotational-periodicity>-mesh-name
    :initarg :mesh-name
    :type string
    :documentation "Имя первой сетки."))
  (:documentation "Вращательный периодичный интерфейс."))

(defclass <simulation-interface-rotational-general> (<simulation-command>)
  ((mesh-name
    :accessor <simulation-interface-rotational-general>-mesh-name
    :initarg :mesh-name
    :type string
    :documentation "Имя первой сетки."))
  (:documentation "Вращательный генеральный интерфейс."))

(defclass <simulation-materials> (<simulation-command>)
  ()
  (:documentation "Добавляет материалы."))

(defclass <simulation-flow> (<simulation-command>)
  ((flow-name
    :accessor <simulation-flow>-flow-name
    :initarg :flow-name
    :initform "Flow Analysis 1"
    :type string
    :documentation "Имя симуляции.")
   (domain-fluid-name
    :accessor <simulation-flow>-domain-fluid-name
    :initarg :domain-fluid-name
    :initform "D1"
    :type string
    :documentation "Имя флюидового домена.")
   (domain-solid-names
    :accessor <simulation-flow>-domain-solid-names
    :initarg :domain-solid-names
    :initform '("M1" "M2" "M3")
    :type list
    :documentation "Имена солидовых доменов."))
  (:documentation "Команда для создания домена."))

(defclass <simulation-boundary-inlet> (<simulation-command>)
  ((name
    :accessor <simulation-boundary-inlet>-name
    :initarg :name
    :initform "INLET"
    :type string)
   (mass-flow-rate
    :accessor <simulation-boundary-inlet>-mass-flow-rate
    :initarg :mass-flow-rate
    :initform nil ; "10.0 [kg s^-1]"
    :type (or string null))
   (location
    :accessor <simulation-boundary-inlet>-location
    :initarg :location
    :initform "DG1 B AIR_IN D_32.0,DG1 B AIR_IN D_32.0 2"
    :type string)
   (static-temperature
    :accessor <simulation-boundary-inlet>-static-temperature
    :initarg :static-temperature
    :initform nil ;"20.0 [C]"
    :type (or string null))
   (total-temperature
    :accessor <simulation-boundary-inlet>-total-temperature
    :initarg :total-temperature
    :initform nil; "400.0 [C]"
    :type  (or string null))
   (components
    :accessor <simulation-boundary-inlet>-components
    :initarg :components
    :initform '(("CH4" 0.0)
                ("CO"  0.0)
                ("CO2" 0.0)
                ("H2O" 0.0)
                ("NO"  0.0)
                ("O2"  0.0)))))

(defclass <simulation-boundary-outlet> (<simulation-command>)
  ((name
    :accessor <simulation-boundary-outlet>-name 
    :initarg :name
    :initform "OUTLET"
    :type string)
   (mass-flow-rate
    :accessor <simulation-boundary-outlet>-mass-flow-rate
    :initarg :mass-flow-rate
    :initform nil ;"0.5 [kg s^-1]"
    :type (or string null))
   (location
    :accessor <simulation-boundary-outlet>-location
    :initarg :location
    :initform "DG1 B AIR_RL D_5.0,DG1 B AIR_RL D_5.0 2"
    :type string)
   (relative-pressure
    :accessor <simulation-boundary-outlet>-relative-pressure
    :initarg :relative-pressure
    :initform nil ; "-680 [kPa]"
    :type (or string null))))

(defclass <simulation-solver> (<simulation-command>)
  ((solution-units
    :accessor <simulation-solver>-solution-units
    :initarg :solution-units
    :initform (make-instance '<solution-units>)
    :type (or <solution-units> null))
   (solver-control
    :accessor <simulation-solver>-solver-control
    :initarg :solver-control
    :initform (make-instance '<solver-control>)
    :type (or <solver-control> null))))

(defclass <simulation-control> (<simulation-command>) ())

(defclass <simulation-monitor-point-region> (<simulation-command>)
  ((2d-regions-template
    :accessor <simulation-monitor-point-region>-2d-regions-template
    :initarg :2d-regions-template
    :initform nil)
   (prefix
    :accessor <simulation-monitor-point-region>-prefix
    :initarg :prefix
    :initform "MFR")
   (expression
    :accessor <simulation-monitor-point-region>-expression
    :initarg :expression
    :initform "massFlow()")))

(defclass <simulation-monitor-point> (<simulation-command>)
  ((prefix-expression
    :accessor <simulation-monitor-point>-prefix-expression
    :initarg :prefix-expression
    :initform nil ; MFR TT TP 
    )
   (locations
    :accessor <simulation-monitor-point>-locations
    :initarg :locations
    :initform nil #+nil '("INLET" "C G2 G6 Side 1")
    )))

(defclass <simulation-monitor-point-named-points> (<simulation-command>)
  ((prefix       
    :accessor <simulation-monitor-point-named-points>-prefix
    :initarg :prefix
    :initform "")
   (output-variables-list
    :accessor <simulation-monitor-point-named-points>-output-variables-list
    :initarg :output-variables-list
    :initform nil ;; '("Total Temperature" "Density" "Velocity u")
    )
   (domain-name
    :accessor <simulation-monitor-point-named-points>-domain-name
    :initarg :domain-name
    :initform nil ;; D1 M1 M2 M3
    )
   (named-points
    :accessor <simulation-monitor-point-named-points>-named-points
    :initarg :named-points
    :initform '(("100 100" (466.0 406.2809 75.29972)) ("100 101" (466.0 407.17053 70.33057))))))

