;;;; /src/cfx/pre/classes/boundary.lisp

(in-package :mnas-ansys/cfx/pre)



(defclass <flow-regime> (mnas-ansys/ccl/core:<obj>)
  ((option                    :accessor <flow-regime>-option
                              :initform "Subsonic"
                              :initarg :option
                              :documentation "Option")))

(defclass <turbulence> (mnas-ansys/ccl/core:<obj>)
  ((option                    :accessor <turbulence>-option
                              :initform "Medium Intensity and Eddy Viscosity Ratio" ;; Static Temperature
                              :initarg :option
                              :documentation "Option")))

(defclass <heat-transfer> (mnas-ansys/ccl/core:<obj>)
  ((option                    :accessor <heat-transfer>-option
                              :initform "Total Temperature" ;; Static Temperature
                              :initarg :option
                              :documentation "Option")
   (total-temperature         :accessor <heat-transfer>-total-temperature
                              :initform "455.6 [C]"
                              :initarg :total-temperature
                              :documentation "Total Temperature")
   (static-temperature        :accessor <heat-transfer>-static-temperature
                              :initform "18.1 [C]"
                              :initarg :static-temperature
                              :documentation "Static Temperature")))

(defclass <flow-direction> (mnas-ansys/ccl/core:<obj>)
  ((option                    :accessor <flow-direction>-option
                              :initform "Normal to Boundary Condition"
                              :initarg :option
                              :documentation "Option")))

(defclass <boundary-conditions> (mnas-ansys/ccl/core:<obj>)
  ((components                :accessor <boundary-conditions>-components
                              :initform (make-instance '<component-list>
                                                       :components
                                                       `(,(make-instance '<component> :name "CH4" :option "Mass Fraction" :mass-fraction 0.0)
                                                         ,(make-instance '<component> :name "CO"  :option "Mass Fraction" :mass-fraction 0.0)
                                                         ,(make-instance '<component> :name "CO2" :option "Mass Fraction" :mass-fraction 0.0)
                                                         ,(make-instance '<component> :name "H2O" :option "Mass Fraction" :mass-fraction 0.0)
                                                         ,(make-instance '<component> :name "NO"  :option "Mass Fraction" :mass-fraction 0.0)
                                                         ,(make-instance '<component> :name "O2"  :option "Mass Fraction" :mass-fraction 0.0))) ; 0.232
                              :initarg :components
                              :documentation "components")
   (flow-direction            :accessor <boundary-conditions>-flow-direction
                              :initform (make-instance '<flow-direction>)
                              :initarg :flow-direction
                              :documentation "FLOW DIRECTION")
   (flow-regime               :accessor <boundary-conditions>-flow-regime
                              :initform (make-instance '<flow-regime>)
                              :initarg :flow-regime
                              :documentation "FLOW REGIME")
   (heat-transfer             :accessor <boundary-conditions>-heat-transfer
                              :initform (make-instance '<heat-transfer>)
                              :initarg :heat-transfer
                              :documentation "HEAT TRANSFER")
   (mass-and-momentum         :accessor <boundary-conditions>-mass-and-momentum
                              :initform (make-instance '<mass-and-momentum>)
                              :initarg :mass-and-momentum
                              :documentation "MASS AND MOMENTUM")
   (turbulence                :accessor <boundary-conditions>-turbulence
                              :initform (make-instance '<turbulence>)
                              :initarg :turbulence
                              :documentation "TURBULENCE")))

(defclass <boundary> (mnas-ansys/ccl/core:<obj>)
  ((boundary-type             :accessor <boundary>-boundary-type
                              :initform "OUTLET"
                              :initarg :boundary-type
                              :documentation "Boundary Type")
   (Location                  :accessor <boundary>-location
                              :initform "2d-region"
                              :initarg :location
                              :documentation "Location")
   (boundary-conditions       :accessor <boundary>-boundary-сonditions
                              :initform (make-instance '<boundary-conditions>
                                                       :mass-and-momentum
                                                       (make-instance  '<mass-and-momentum>
                                                                       :momentum-interface-model nil
                                                                       :Relative-Pressure "-680 [kPa]"))
                              :initarg :boundary-conditions
                              :documentation "BOUNDARY CONDITIONS")))
