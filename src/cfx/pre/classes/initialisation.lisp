;;;; ./src/cfx/pre/classes/initialisation.lisp

(in-package :mnas-ansys/cfx/pre)

  
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defclass <TEMPERATURE> (mnas-ansys/ccl/core:<obj>)
  ((Option 
    :accessor <TEMPERATURE>-Option
    :initform "Automatic with Value"
    :initarg :Option
    :documentation "Option")
   (Temperature 
    :accessor <TEMPERATURE>-Temperature 
    :initform "480 [C]"
    :initarg :Temperature 
    :documentation "Temperature")))

(defclass <CARTESIAN-VELOCITY-COMPONENTS> (mnas-ansys/ccl/core:<obj>)
  ((Option
    :accessor <CARTESIAN-VELOCITY-COMPONENTS>-Option
    :initform "Automatic"
    :initarg :Option
    :documentation "Option")))


(defclass <TURBULENCE-INITIAL-CONDITIONS> (mnas-ansys/ccl/core:<obj>) 
  ((Option 
    :accessor <TURBULENCE-INITIAL-CONDITIONS>-Option 
    :initform "Medium Intensity and Eddy Viscosity Ratio"
    :initarg :Option
    :documentation "Option")))

(defclass <STATIC-PRESSURE> (mnas-ansys/ccl/core:<obj>)
  ((Option 
    :accessor <STATIC-PRESSURE>-Option 
    :initform "Automatic with Value"
    :initarg :Option
    :documentation "Option")
   (Relative-Pressure
    :accessor <STATIC-PRESSURE>-Relative-Pressure
    :initform "-100 [kPa]"
    :initarg :Relative-Pressure
    :documentation "Relative Pressure")))

(defclass <INITIAL-CONDITIONS> (mnas-ansys/ccl/core:<obj>)
  ((Velocity-Type
    :accessor <INITIAL-CONDITIONS>-Velocity-Type
    :initform "Cartesian"
    :initarg :Velocity-Type
    :documentation "Velocity-Type")
   (CARTESIAN-VELOCITY-COMPONENTS
    :accessor <INITIAL-CONDITIONS>-CARTESIAN-VELOCITY-COMPONENTS
    :initform (make-instance '<CARTESIAN-VELOCITY-COMPONENTS>)
    :initarg :CARTESIAN-VELOCITY-COMPONENTS
    :documentation "CARTESIAN VELOCITY COMPONENTS")
   (<component-list>
    :accessor <INITIAL-CONDITIONS>-component-list
    :initform (make-instance '<component-list>)
    :initarg :Velocity-Type
    :documentation "component-list")
  
   (STATIC-PRESSURE
    :accessor <INITIAL-CONDITIONS>-STATIC-PRESSURE
    :initform (make-instance '<STATIC-PRESSURE>)
    :initarg :STATIC-PRESSURE
    :documentation "STATIC PRESSURE")
   
   (TEMPERATURE
    :accessor <INITIAL-CONDITIONS>-TEMPERATURE
    :initform (make-instance '<TEMPERATURE>)
    :initarg :TEMPERATURE
    :documentation "TEMPERATURE")
   (TURBULENCE-INITIAL-CONDITIONS
    :accessor <INITIAL-CONDITIONS>-TURBULENCE-INITIAL-CONDITIONS
    :initform (make-instance '<TURBULENCE-INITIAL-CONDITIONS>)
    :initarg :TURBULENCE-INITIAL-CONDITIONS
    :documentation "TURBULENCE INITIAL CONDITIONS")
   ))

(defclass <INITIALISATION> (mnas-ansys/ccl/core:<obj>)
  ((Option 
    :accessor <INITIALISATION>-Option 
    :initform "Automatic"
    :initarg :Option
    :documentation "Option")
   (INITIAL-CONDITIONS 
    :accessor <INITIALISATION>-INITIAL-CONDITIONS 
    :initform (make-instance '<INITIAL-CONDITIONS>)
    :initarg :INITIAL-CONDITIONS 
    :documentation "INITIAL CONDITIONS")
   ))

(make-instance '<INITIALISATION>) 

(make-instance '<component-list>
               :components
               `(,(make-instance '<component>  :name "CH4" :option "Automatic")
                  ,(make-instance '<component> :name "CO"  :option "Automatic")
                  ,(make-instance '<component> :name "CO2" :option "Automatic")
                  ,(make-instance '<component> :name "H2O" :option "Automatic")
                  ,(make-instance '<component> :name "NO" :option "Automatic")
                  ,(make-instance '<component> :name "O2"
                                               :option "Automatic with Value"
                                               :mass-fraction "0.232")))
