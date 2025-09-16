;;;; ./src/cfx/pre/classes/solver.lisp

(in-package :mnas-ansys/cfx/pre)

(defclass <solution-units> (mnas-ansys/ccl/core:<obj>)
  ((angle-units  
    :accessor <solution-units>-angle-units
    :initform "[rad]"
    :initarg :angle-units  
    :documentation "Angle Units")
   (length-units
    :accessor <solution-units>-length-units
    :initform "[m]"
    :initarg :length-units
    :documentation "Length Units")
   (mass-units
    :accessor <solution-units>-mass-units
    :initform "[kg]"
    :initarg :mass-units
    :documentation "Mass Units")
   (solid-angle-units
    :accessor <solution-units>-solid-angle-units
    :initform "[sr]"
    :initarg :solid-angle-units
    :documentation "Solid Angle Units")
   (temperature-units
    :accessor <solution-units>-temperature-units
    :initform "[K]"
    :initarg :temperature-units
    :documentation "Temperature Units")
   (time-units
    :accessor <solution-units>-time-units
    :initform "[s]"
    :initarg :time-units
    :documentation "Time Units")))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defclass <advection-scheme> (mnas-ansys/ccl/core:<obj>)
  ((option
    :accessor <advection-scheme>-option
    :initform "High Resolution"
    :initarg :option
    :documentation "Option")))

(defclass <convergence-control> (mnas-ansys/ccl/core:<obj>)
  ((maximum-number-of-iterations
    :accessor <convergence-control>-maximum-number-of-iterations
    :initform "20000"
    :initarg :maximum-number-of-iterations
    :documentation "Maximum Number of Iterations")
   (minimum-number-of-iterations
    :accessor <convergence-control>-minimum-number-of-iterations
    :initform "1"
    :initarg :maximum-number-of-iterations
    :documentation "Minimum Number of Iterations")
   (physical-timescale
    :accessor <convergence-control>-physical-timescale
    :initform "0.0002 [s]"
    :initarg :physical-timescale
    :documentation "Physical Timescale")
   (solid-timescale
    :accessor <convergence-control>-solid-timescale
    :initform "0.01 [s]"
    :initarg :solid-timescale
    :documentation "Solid Timescale")
   (solid-timescale-control
    :accessor <convergence-control>-solid-timescale-control
    :initform "Physical Timescale"
    :initarg :solid-timescale-control
    :documentation "Solid Timescale Control")
   (timescale-control
    :accessor <convergence-control>-timescale-control
    :initform "Physical Timescale"
    :initarg :timescale-control
    :documentation "timescale control")
   ))

(defclass <convergence-criteria> (mnas-ansys/ccl/core:<obj>)
  ((residual-target
    :accessor <convergence-criteria>-residual-target
    :initform "1.E-4"
    :initarg :maximum-number-of-iterations
    :documentation "Residual Target")
   (residual-type
    :accessor <convergence-criteria>-residual-type
    :initform "RMS"
    :initarg :maximum-number-of-iterations
    :documentation "Residual Type")))

(defclass <dynamic-model-control> (mnas-ansys/ccl/core:<obj>)
  ((global-dynamic-model-control
    :accessor <dynamic-model-control>-global-dynamic-model-control
    :initform "On"
    :initarg :global-dynamic-model-control
    :documentation "Global Dynamic Model Control")))

(defclass <solver-control> (mnas-ansys/ccl/core:<obj>)
  ((turbulence-numerics
    :accessor <solver-control>-turbulence-numerics
    :initform "First Order"
    :initarg :turbulence-numerics
    :documentation "Turbulence Numerics")
   (advection-scheme
    :accessor <solver-control>-advection-scheme
    :initform (make-instance '<advection-scheme>)
    :initarg :advection-scheme
    :documentation "ADVECTION SCHEME")
   (convergence-control
    :accessor <solver-control>-convergence-control
    :initform (make-instance '<convergence-control>)
    :initarg :convergence-control
    :documentation "CONVERGENCE CONTROL")
   (convergence-criteria
    :accessor <solver-control>-convergence-criteria
    :initform (make-instance '<convergence-criteria>)
    :initarg :convergence-criteria
    :documentation "CONVERGENCE CRITERIA")
   (dynamic-model-control
    :accessor <solver-control>-dynamic-model-control
    :initform (make-instance '<dynamic-model-control>)
    :initarg :dynamic-model-control
    :documentation "DYNAMIC MODEL CONTROL")
   ))

(make-instance '<solver-control>)

"
SIMULATION CONTROL: 
  &replace EXECUTION CONTROL: 
    EXECUTABLE SELECTION: 
      Double Precision = Off
    END
    INTERPOLATOR STEP CONTROL: 
      Runtime Priority = Standard
      MEMORY CONTROL: 
        Catalogue Size Override = 2.5x
        Memory Allocation Factor = 1
      END
    END
    PARALLEL HOST LIBRARY: 
      HOST DEFINITION: n133905
        Host Architecture String = winnt-amd64
        Installation Root = C:\ANSYS\v%v\CFX
        Number of Processors = 1
        Relative Speed = 9.2
      END
      HOST DEFINITION: n133906
        Host Architecture String = winnt-amd64
        Installation Root = C:\ANSYS\v%v\CFX
        Number of Processors = 1
        Relative Speed = 9.2
      END
      HOST DEFINITION: n142012
        Host Architecture String = winnt-amd64
        Installation Root = C:\ANSYS\v%v\CFX
        Number of Processors = 1
        Relative Speed = 11.15
      END
      HOST DEFINITION: n142013
        Host Architecture String = winnt-amd64
        Installation Root = C:\ANSYS\v%v\CFX
        Relative Speed = 11.15
      END
    END
    PARTITIONER STEP CONTROL: 
      Multidomain Option = Independent Partitioning
      Runtime Priority = Standard
      EXECUTABLE SELECTION: 
        Use Large Problem Partitioner = On
      END
      MEMORY CONTROL: 
        Character Memory Override = 2.5x
        Memory Allocation Factor = 1.1
      END
      PARTITIONING TYPE: 
        Option = Optimized Recursive Coordinate Bisection
        Partition Size Rule = Automatic
        Partition Weight Factors = 0.03424, 0.03424, 0.03424, 0.03424, 0.03424, 0.03424, 0.03424, 0.03424, 0.03424, 0.03424, 0.03424, 0.03424, 0.03424, 0.03424, 0.03424, 0.03424, 0.02826, 0.02826, 0.02826, 0.02826, 0.02826, 0.02826, 0.02826, 0.02826, 0.02826, 0.02826, 0.02826, 0.02826, 0.02826, 0.02826, 0.02826, 0.02826
      END
    END
    RUN DEFINITION: 
      Run Mode = Full
      Solver Input File = D:\home\_namatv\ANSYS\CFX\a32\cfx\A32_prj_07\DP=003\A32_prj_07.def
      INITIAL VALUES SPECIFICATION: 
        INITIAL VALUES CONTROL: 
          Use Mesh From = Solver Input File
        END
        INITIAL VALUES: Initial Values 1
          File Name = D:\home\_namatv\ANSYS\CFX\a32\cfx\A32_prj_06\DP=002\A32_prj_06_002.res
          Option = Results File
        END
      END
    END
    SOLVER STEP CONTROL: 
      Runtime Priority = Standard
      MEMORY CONTROL: 
        Character Memory Override = 2.5x
        Memory Allocation Factor = 1.1
      END
      PARALLEL ENVIRONMENT: 
        Parallel Host List = n142013*8,n142012*8,n133906*8,n133905*8
        Start Method = Platform MPI Distributed Parallel
      END
    END
  END
END
"
