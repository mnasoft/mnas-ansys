(in-package #:mnas-ansys/tin/utils)

(defparameter *tin-file* "Z:/_namatv/CFX/n70/tin/SEP/GU/cfx_N70_prj_01_GU-01.tin")
(defparameter *tin-file* "D:/home/_namatv/CFX/a32/a32_2d_ch_opt/tin/02/a32_2d_ch_opt_02.tin")
(defparameter *tin-file* "Z:/_namatv/CFX/n70/tin/SEP/ALL/GU/cfx_N70_prj_02_GU_02.tin")

(probe-file *tin-file*)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defparameter *tin* (open-tin-file *tin-file*))
(<tin>-families *tin*)

(progn
  (defparameter *tin* (open-tin-file *tin-file*))
  (surface-names-coeged-with-surface-in-family
   '( "START"
     )
   *tin*
   :times 20
   :families-excluded
   '(
     "STOP"
     "GAS_2")
   ))
