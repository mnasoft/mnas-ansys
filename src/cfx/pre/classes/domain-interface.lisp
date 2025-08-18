(in-package :mnas-ansys/cfx/pre)

(defclass <mesh-connection> (mnas-ansys/ccl/core:<obj>)
  ((option                    :accessor <mesh-connection>-option
                         :initform "Automatic"
                         :initarg :option
                         :documentation "Option")))


(defclass <pitch-change> (mnas-ansys/ccl/core:<obj>)
  ((option                    :accessor <pitch-change>-option
                         :initform "None"
                         :initarg :option
                         :documentation "Option")))

(defclass <momentum-interface-model>
    ((option                  :accessor <momentum-interface-model>-option
                         :initform "None"
                         :initarg :option
                         :documentation "Option")))
     
(defclass <mass-and-momentum> (mnas-ansys/ccl/core:<obj>)
  ((option                    :accessor <mass-and-momentum>-option
                             :initform "Conservative Interface Flux"
                             :initarg :option
                             :documentation "Option")
   (momentum-interface-model :accessor <mass-and-momentum>-momentum-interface-model
                             :initform "None"
                             :initarg :momentum-interface-model
                             :documentation "MOMENTUM INTERFACE MODEL")))

(defclass <frame-change> (mnas-ansys/ccl/core:<obj>)
  ((option                    :accessor <frame-change>-option
                         :initform "None"
                         :initarg :option
                         :documentation "Option")))

(defclass <interface-models> (mnas-ansys/ccl/core:<obj>)
  ((option                    :accessor <interface-models>-option
                              :initform "General Connection"
                              :initarg :option
                              :documentation "Option")
   (frame-change              :accessor <interface-models>-frame-change
                              :initform (make-instance '<frame-change>)
                              :initarg :frame-change
                              :documentation "Frame Change")
   (mass-and-momentum    :accessor <interface-models>-mass-and-momentum
                         :initform (make-instance '<mass-and-momentum>)
                         :initarg :mass-and-momentum
                         :documentation "MASS AND MOMENTUM")
   (pitch-change         :accessor <interface-models>-pitch-change
                         :initform (make-instance '<pitch-change>)
                         :initarg :pitch-change
                         :documentation "PITCH CHANGE")
   (mesh-connection      :accessor <interface-models>-mesh-connection
                         :initform (make-instance '<mesh-connection>)
                         :initarg :pitch-change
                         :documentation "MESH CONNECTION")))

(defclass <domain-interface> (mnas-ansys/ccl/core:<obj>)
  ((boundary-list1            :accessor <domain-interface>-boundary-list1
                              :initform "XXX Side 1"
                              :initarg :boundary-list1
                              :documentation "Boundary List1")
   (boundary-list2            :accessor <domain-interface>-boundary-list2
                              :initform "XXX Side 2"
                              :initarg :boundary-list2
                              :documentation "Boundary List2")
   (filter-domain-list1       :accessor <domain-interface>-filter-domain-list1
                              :initform "D1"
                              :initarg :filter-domain-list1
                              :documentation "Filter Domain List1")
   (filter-domain-list2       :accessor <domain-interface>-filter-domain-list2
                              :initform "D1"
                              :initarg :filter-domain-list2
                              :documentation "Filter Domain List2")
   (interface-region-list1    :accessor <domain-interface>-interface-region-list1
                              :initform "List 1"
                              :initarg :interface-region-list1
                              :documentation "Interface-Region-List1")
   (interface-region-list2    :accessor <domain-interface>-interface-region-list2
                              :initform "List 2"
                              :initarg :interface-region-list2
                              :documentation "Interface-Region-List2")
   (interface-type            :accessor <domain-interface>-interface-type
                              :initform "Fluid Fluid"
                              :initarg :interface-type
                              :documentation "Interface Type")
   (interface-models          :accessor interface-models
                              :initform (make-instance '<interface-models>)
                              :initarg :interface-models
                              :documentation "INTERFACE MODELS")))
  
(make-instance '<domain-interface>)

FLOW: Flow Analysis 1
  &replace DOMAIN INTERFACE: C G1 G2 X_
    Boundary List1 = C G1 G2 X_ Side 1
    Boundary List2 = C G1 G2 X_ Side 2
    Filter Domain List1 = D1
    Filter Domain List2 = D1
    Interface Region List1 = C G1 G2 X_049.5 D_1.0 1,C G1 G2 X_060.5 PP_D_0.0 1,C G1 G2 X_071.5 D_0.0 1,C G1 G2 X_075.0 PPL_D_0.0 1,C G1 G2 X_075.0 PPR_D_0.0 1,C G1 G2 X_093.5 D_0.0 1,C G1 G2 X_115.5 D_0.0 1,C G1 G2 X_137.5 D_0.0 1,C G1 G2 X_159.5 D_0.0 1,C G1 G2 X_181.5 D_0.0 1,C G1 G2 X_203.5 D_0.0 1,C G1 G2 X_225.5 D_0.0 1,C G1 G2 X_254.9 D_0.0 1,C G1 G2 X_261.5 D_14.5 1,C G1 G2 X_302.9 D_0.0 1,C G1 G2 X_350.9 D_0.0 1,C G1 G2 X_401.5 D_0.0 1,C G1 G2 X_436.5 D_0.0 1,C G1 G2 X_456.0 D_0.0 1,C G1 G2 X_466.5 D_0.0 1,C G1 G2 X_049.5 D_1.0 2,C G1 G2 X_060.5 PP_D_0.0 2,C G1 G2 X_071.5 D_0.0 2,C G1 G2 X_075.0 PPL_D_0.0 2,C G1 G2 X_075.0 PPR_D_0.0 2,C G1 G2 X_093.5 D_0.0 2,C G1 G2 X_115.5 D_0.0 2,C G1 G2 X_137.5 D_0.0 2,C G1 G2 X_159.5 D_0.0 2,C G1 G2 X_181.5 D_0.0 2,C G1 G2 X_203.5 D_0.0 2,C G1 G2 X_225.5 D_0.0 2,C G1 G2 X_254.9 D_0.0 2,C G1 G2 X_261.5 D_14.5 2,C G1 G2 X_302.9 D_0.0 2,C G1 G2 X_350.9 D_0.0 2,C G1 G2 X_401.5 D_0.0 2,C G1 G2 X_436.5 D_0.0 2,C G1 G2 X_456.0 D_0.0 2,C G1 G2 X_466.5 D_0.0 2
    Interface Region List2 = C G1 G2 X_049.5 D_1.0 4,C G1 G2 X_060.5 PP_D_0.0 4,C G1 G2 X_071.5 D_0.0 4,C G1 G2 X_075.0 PPL_D_0.0 4,C G1 G2 X_075.0 PPR_D_0.0 4,C G1 G2 X_093.5 D_0.0 4,C G1 G2 X_115.5 D_0.0 4,C G1 G2 X_137.5 D_0.0 4,C G1 G2 X_159.5 D_0.0 4,C G1 G2 X_181.5 D_0.0 4,C G1 G2 X_203.5 D_0.0 4,C G1 G2 X_225.5 D_0.0 4,C G1 G2 X_254.9 D_0.0 4,C G1 G2 X_261.5 D_14.5 4,C G1 G2 X_302.9 D_0.0 4,C G1 G2 X_350.9 D_0.0 4,C G1 G2 X_401.5 D_0.0 4,C G1 G2 X_436.5 D_0.0 4,C G1 G2 X_456.0 D_0.0 4,C G1 G2 X_466.5 D_0.0 4,C G1 G2 X_049.5 D_1.0 5,C G1 G2 X_060.5 PP_D_0.0 5,C G1 G2 X_071.5 D_0.0 5,C G1 G2 X_075.0 PPL_D_0.0 5,C G1 G2 X_075.0 PPR_D_0.0 5,C G1 G2 X_093.5 D_0.0 5,C G1 G2 X_115.5 D_0.0 5,C G1 G2 X_137.5 D_0.0 5,C G1 G2 X_159.5 D_0.0 5,C G1 G2 X_181.5 D_0.0 5,C G1 G2 X_203.5 D_0.0 5,C G1 G2 X_225.5 D_0.0 5,C G1 G2 X_254.9 D_0.0 5,C G1 G2 X_261.5 D_14.5 5,C G1 G2 X_302.9 D_0.0 5,C G1 G2 X_350.9 D_0.0 5,C G1 G2 X_401.5 D_0.0 5,C G1 G2 X_436.5 D_0.0 5,C G1 G2 X_456.0 D_0.0 5,C G1 G2 X_466.5 D_0.0 5
    Interface Type = Fluid Fluid
    INTERFACE MODELS: 
      Option = General Connection
      FRAME CHANGE: 
        Option = None
      END
      MASS AND MOMENTUM: 
        Option = Conservative Interface Flux
        MOMENTUM INTERFACE MODEL: 
          Option = None
        END
      END
      PITCH CHANGE: 
        Option = None
      END
    END
    MESH CONNECTION: 
      Option = Automatic
    END
  END
END

