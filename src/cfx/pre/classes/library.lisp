(in-package :mnas-ansys/cfx/pre)

(defclass <material> (mnas-ansys/ccl/core:<obj>)
  ((Material-Group
    :accessor <material>-Material-Group
    :initform "User"
    :initarg :Material-Group
    :documentation "Material Group")
   (Option
    :accessor <material>-Option
    :initform "Reacting Mixture"
    :initarg :Option
    :documentation "Option")
   (Reactions-List
    :accessor <material>-Reactions-List
    :initform "Methane Air WD2 NO PDF"
    :initarg :Reactions-List
    :documentation "Reactions List")))



(defclass <LIBRARY> (mnas-ansys/ccl/core:<obj>)
  ((objects
    :accessor <LIBRARY>-objects
    :initform nil
    :initarg :objects
    :documentation "objects")
   ))
(in-package :mnas-ansys/cfx/pre)

(defclass <interpolation-data> (mnas-ansys/ccl/core:<obj>)
  ((Data-Pairs
    :accessor <INTERPOLATION-DATA>-Data-Pairs
    :initform "25 , 9.64 , 100 , 10.5 , 200 , 11.7 , 300 , 13.8 , 400 , 16.4 , 500 , 18.9 , 600 , 21.4 , 700 , 23.5 , 800 , 25.6 , 900 , 28.1"
    :initarg :Data-Pairs
    :documentation "Data Pairs")
   (Extend-Max
    :accessor <INTERPOLATION-DATA>-Extend-Max
    :initform "On"
    :initarg :Extend-Max
    :documentation "Extend Max")
   (Extend-Min
    :accessor <INTERPOLATION-DATA>-Extend-Min
    :initform "On"
    :initarg :Extend-Min
    :documentation "Extend Min")
   (Option
    :accessor <INTERPOLATION-DATA>-Option
    :initform "One Dimensional"
    :initarg :Option
    :documentation "Option")
))

(defclass <function> (mnas-ansys/ccl/core:<obj>)
  ((argument-units
    :accessor <function>-argument-units
    :initform "C"
    :initarg :objects
    :documentation "Argument Units")
   (option
    :accessor <function>-option
    :initform "Interpolation"
    :initarg :option
    :documentation "Option")
   (result-units
    :accessor <function>-result-units
    :initform "W / (m K)"
    :initarg :result-units
    :documentation "Result Units")
   (interpolation-data
    :accessor <function>-interpolation-data
    :initform (make-instance '<interpolation-data>)
    :initarg :INTERPOLATION-DATA
    :documentation "INTERPOLATION DATA")
   ))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(make-instance '<material> :name "GAS")
(make-instance '<FUNCTION>)
