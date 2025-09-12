;;;; ./src/cfx/pre/classes/simulation-control.lisp

(in-package :mnas-ansys/cfx/pre)

(defclass <executable-selection> (mnas-ansys/ccl/core:<obj>)
  ((double-precision 
    :accessor <executable-selection>-double-precision 
    :initform "Off"
    :initarg :double-precision 
    :documentation "Double Precision")))

;;;;

(defclass <memory-control> (mnas-ansys/ccl/core:<obj>)
  ((catalogue-size-override
    :accessor <memory-control>-catalogue-size-override
    :initform "2.5x"
    :initarg :catalogue-size-override
    :documentation "Catalogue Size Override")
   (memory-allocation-factor
    :accessor <memory-control>-memory-allocation-factor
    :initform "1"
    :initarg :memory-allocation-factor
    :documentation "Memory Allocation Factor")
   ))

(defclass <interpolator-step-control> (mnas-ansys/ccl/core:<obj>)
  ((runtime-priority
    :accessor <interpolator-step-control>-runtime-priority
    :initform "1"
    :initarg :runtime-priority
    :documentation "Runtime Priority")
   (memory-control
    :accessor <interpolator-step-control>-memory-control
    :initform (make-instance '<memory-control>)
    :initarg :runtime-priority
    :documentation "MEMORY CONTROL")))
    


(make-instance '<execution-control>)

(defclass <parallel-host-library> (mnas-ansys/ccl/core:<obj>)
  )
  
(defclass <execution-control> (mnas-ansys/ccl/core:<obj>)
  ((executable-selection
    :accessor <execution-control>-executable-selection
    :initform (make-instance '<executable-selection>)
    :initarg :executable-selection
    :documentation "EXECUTABLE SELECTION")
   (interpolator-step-control
    :accessor <execution-control>-interpolator-step-control
    :initform (make-instance '<interpolator-step-control>)
    :initarg :interpolator-step-control
    :documentation "INTERPOLATOR STEP CONTROL")
   (parallel-host-library 
    :accessor <execution-control>-parallel-host-library 
    :initform (make-instance '<parallel-host-library>)
    :initarg :parallel-host-library 
    :documentation "PARALLEL HOST LIBRARY")
   ))

(make-instance '<execution-control>)
