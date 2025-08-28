(in-package :mnas-ansys/cfx/pre)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; Fluid
(defclass <buoyancy-model> (mnas-ansys/ccl/core:<obj>)
  ((option
    :accessor <buoyancy-model>-option
    :initform "Non Buoyant"
    :initarg :option
    :documentation "Option")))

(defclass <domain-motion> (mnas-ansys/ccl/core:<obj>)
  ((option
    :accessor <domain-motion>-Option
    :initform "Stationary"
    :initarg :option
    :documentation "Option")))

(defclass <mesh-deformation> (mnas-ansys/ccl/core:<obj>)
  ((option
    :accessor <mesh-deformation>-option
    :initform "None"
    :initarg :option
    :documentation "Option")))

(defclass <reference-pressure> (mnas-ansys/ccl/core:<obj>)
  ((reference-pressure
    :accessor <reference-pressure>-reference-pressure
    :initform "1.943 [MPa]"
    :initarg :reference-pressure
    :documentation "Reference Pressure")))

(defclass <domain-models> (mnas-ansys/ccl/core:<obj>)
  ((buoyancy-model
    :accessor <domain-models>-buoyancy-model
    :initform (make-instance '<buoyancy-model>)
    :initarg :buoyancy-model
    :documentation "BUOYANCY MODEL")
   (domain-motion
    :accessor <domain-models>-domain-motion
    :initform (make-instance '<domain-motion>)
    :initarg :domain-motion
    :documentation "DOMAIN MOTION")
   (mesh-deformation
    :accessor <domain-models>-mesh-deformation
    :initform (make-instance '<mesh-deformation>)
    :initarg :mesh-deformation
    :documentation "MESH DEFORMATION")
   (reference-pressure
    :accessor <domain-models>-reference-pressure
    :initform (make-instance '<reference-pressure>)
    :initarg :reference-pressure
    :documentation "REFERENCE PRESSURE")))

(defclass <morphology> (mnas-ansys/ccl/core:<obj>)
  ((option
    :accessor <morphology>-option
    :initform "Continuous Fluid" ;; "Continuous Solid"
    :initarg :option
    :documentation "Option")))

(defclass <fluid-definition> (mnas-ansys/ccl/core:<obj>)
  ((Material
    :accessor <fluid-definition>-Material
    :initform "GAS"
    :initarg :material
    :documentation "Material")
   (Option
    :accessor <fluid-definition>-Option
    :initform "Material Library"
    :initarg :material
    :documentation "Option")
   (morphology
    :accessor <fluid-definition>-morphology
    :initform (make-instance '<morphology>)
    :initarg :morphology
    :documentation "Option")))

(defclass <combustion-model> (mnas-ansys/ccl/core:<obj>)
  ((Option
    :accessor <combustion-model>-Option
    :initform "Finite Rate Chemistry and Eddy Dissipation"
    :initarg :Option
    :documentation "Option")))

(defclass <component> (mnas-ansys/ccl/core:<obj>)
  ((Mass-Fraction
    :accessor <component>-Mass-Fraction
    :initform nil
    :initarg :Mass-Fraction
    :documentation "Mass-Fraction 0.232")
   (Option
    :accessor <component>-Option
    :initform "Transport Equation"
    :initarg :Option
    :documentation "Option")))

(defclass <component-list> ()
  ((components
    :accessor <component-list>-components
    :initform `(,(make-instance '<component> :name "CH4")
                ,(make-instance '<component> :name "CO")
                ,(make-instance '<component> :name "CO2")
                ,(make-instance '<component> :name "H2O")
                ,(make-instance '<component> :name "NO")
                ,(make-instance '<component> :name "O2")
                ,(make-instance '<component> :name "N2"
                                             :option "Constraint"))
    :initarg :components
    :documentation "Components")))

(defmethod print-object ((obj <component-list>) s)
  (loop :for i :in (<component-list>-components obj)
        :do (print-object i s)))

(defclass <heat-transfer-model> (mnas-ansys/ccl/core:<obj>)
  ((Option
    :accessor <heat-transfer-model>-Option
    :initform "Total Energy"
    :initarg :Option
    :documentation "Option")))

(defclass <thermal-radiation-model> (mnas-ansys/ccl/core:<obj>)
  ((Option
    :accessor <thermal-radiation-model>-Option
    :initform "None"
    :initarg :Option
    :documentation "Option")))

(defclass <turbulence-model> (mnas-ansys/ccl/core:<obj>)
  ((Option
    :accessor <turbulence-model>-Option
    :initform "SST"
    :initarg :Option
    :documentation "Option")))

(defclass <turbulent-wall-functions> (mnas-ansys/ccl/core:<obj>)
  ((high-speed-model
    :accessor <turbulent-wall-functions>-High-Speed-Model
    :initform "Off"
    :initarg :High-Speed-Model
    :documentation "High Speed Model")
   (Option
    :accessor <turbulent-wall-functions>-Option
    :initform "Automatic"
    :initarg :Option
    :documentation "Option")))

(defclass <fluid-models> (mnas-ansys/ccl/core:<obj>)
  ((combustion-model          :accessor <fluid-models>-combustion-model
                              :initform (make-instance '<combustion-model>)
                              :initarg :combustion-model
                              :documentation "COMBUSTION MODEL")
   (components                :accessor <fluid-models>-components
                              :initform (make-instance '<component-list>)
                              :initarg :components
                              :documentation "COMBUSTION MODEL")
   (heat-transfer-model       :accessor <fluid-models>-heat-transfer-model
                              :initform (make-instance '<heat-transfer-model>
                                                       :option "Total Energy")
                              :initarg :heat-transfer-model
                              :documentation "HEAT TRANSFER MODEL")
   (thermal-radiation-model   :accessor <fluid-models>-thermal-radiation-model
                              :initform (make-instance '<thermal-radiation-model>)
                              :initarg :thermal-radiation-model
                              :documentation "THERMAL RADIATION MODEL")
   (turbulence-model          :accessor <fluid-models>-turbulence-model
                              :initform (make-instance '<turbulence-model>)
                              :initarg :turbulence-model
                              :documentation "TURBULENCE MODEL")
   (turbulent-wall-functions  :accessor <fluid-models>-turbulent-wall-functions
                              :initform (make-instance '<turbulent-wall-functions>)
                              :initarg :turbulent-wall-functions
                              :documentation "TURBULENT WALL FUNCTIONS")))

(defclass <domain> (mnas-ansys/ccl/core:<obj>)
  ((coord-frame               :accessor <domain>-coord-frame
                              :initform "Coord 0"
                              :initarg :coord-frame
                              :documentation "Coord Frame")
   (domain-type               :accessor <domain>-Domain-Type
                              :initform "Fluid"
                              :initarg :Domain-Type
                              :documentation "Domain Type")
   (Location                  :accessor <domain>-location
                              :initform ""
                              :initarg :Location
                              :documentation "Location")
   (domain-models             :accessor <domain>-domain-models
                              :initform (make-instance '<domain-models>)
                              :initarg :domain-models
                              :documentation "DOMAIN MODELS")
   (fluid-definition          :accessor <domain>-FLUID-DEFINITION
                              :initform (make-instance '<fluid-definition>
                                                       :morphology
                                                       (make-instance '<morphology>
                                                                      :option
                                                                      "Continuous Fluid"))
                              :initarg :fluid-definition
                              :documentation "FLUID DEFINITION")
   (fluid-models              :accessor <domain>-FLUID-MODELS
                              :initform (make-instance '<FLUID-MODELS>)
                              :initarg :fluid-models
                              :documentation "FLUID-MODELS")
   (solid-definition          :accessor <domain>-solid-definition
                              :initform (make-instance '<solid-definition>)
                              :initarg :solid-definition
                              :documentation "SOLID DEFINITION")
   (solid-models              :accessor <domain>-solid-models
                              :initform (make-instance '<solid-models>)
                              :initarg :solid-models
                              :documentation "SOLID MODELS")))
;;;; Fluid
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; Solid

(defclass <solid-definition> (mnas-ansys/ccl/core:<obj>)
  ((material                  :accessor <solid-definition>-Material
                              :initform "HN60VT"
                              :initarg :material
                              :documentation "Material")
   (option                    :accessor <solid-definition>-Option
                              :initform "Material Library"
                              :initarg :Option
                              :documentation "Option")
   (morphology                :accessor <solid-definition>-morphology
                              :initform (make-instance '<morphology>
                                                       :option "Continuous Solid")
                              :initarg :morphology
                              :documentation "MORPHOLOGY")))

(defclass <solid-models> (mnas-ansys/ccl/core:<obj>)
  ((heat-transfer-model       :accessor <solid-models>-heat-transfer-model
                              :initform (make-instance '<heat-transfer-model>
                                                       :option "Thermal Energy")
                              :initarg :heat-transfer-model
                              :documentation "HEAT TRANSFER MODEL")
   (thermal-radiation-model   :accessor <solid-models>-thermal-radiation-model
                              :initform (make-instance '<thermal-radiation-model>)
                              :initarg :thermal-radiation-model
                              :documentation "THERMAL RADIATION MODEL")))

(defclass <domains-list> ()
  ((domains                   :accessor <domains-list>-domains
                              :initform ()
                              :initarg :domains
                              :documentation "domains")))

(defmethod print-object ((obj <domains-list>) s)
  (loop :for i :in (<domains-list>-domains obj)
        :do (print-object i s)))

(defclass <flow> (mnas-ansys/ccl/core:<obj>)
  ((domains                   :accessor <flow>-domains
                              :initform (make-instance '<domains-list>)
                              :initarg :domains
                              :documentation "domains")))


