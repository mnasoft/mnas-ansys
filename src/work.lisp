(in-package #:mnas-ansys/utils)

(defparameter *tin-file* "/_gas/CFX/otd11/namatv/a32_base/PR-01/a32_KS_ALL.tin")

(defparameter *tin-file* "/_gas/CFX/otd11/namatv/a32_base/PR-01/GT_GU_KORP/a32_KORP_01.tin")
(defparameter *tin-file* "Z:/CFX/otd11/namatv/a32_base/PR-01/GT_GU_KORP/a32_KORP_01.tin")

(defparameter *tin-file* "D:/home/_namatv/CFX/ugt5000_H2/V1/tin/GT/CONES/ugt5000_H2_V001_CONES.tin")

(defparameter *tin-file* "D:/home/_namatv/CFX/ugt5000_H2/V1/tin/SM/SM-2/ugt5000_H2_V001_SM_05.tin")

(defparameter *tin-file* "D:/home/_namatv/CFX/ugt5000_H2/V1/tin/GU//ugt5000_H2_V001_GU_03.tin")

(progn
  (defparameter *tin* (open-tin-file *tin-file*))
  (format t "~{~A ~}"
          (curve-names-coeged-with-surface-in-family
           '(
             "SM/OUT/P_OUT"
             ;;"SM/OUT/OUT"
             )
           *tin*
           )))

(progn
  (defparameter *tin* (open-tin-file *tin-file*))
  (surface-names-coeged-with-surface-in-family
   '(
     ;;"GU/OUT/P_OUT"
     "KOLL"
    #+nil

     "START"
     #+nil
     "SM/IN/P_IN"
     #+nil
     "SM/OUT/OUT"
     )
   *tin*
   :times 1
   :families-excluded '(
                        "GU/A/A2"
                        "GU/H/H1"
                        "GU/H/H2"
                        "GU/H/H3"
                        "GU/H/H4"
                        "GU/H/H5"
                        "GU/T"
                        "GU/OUT/P_OUT"
                        "GU/D3/D_004.00"
                        "GU/D3/D_000.80"
                        )))


(progn
  (defparameter *tin* (open-tin-file *tin-file*))
  (surface-names-coeged-with-surface-in-family
   '("START"
     #+nil "START"
     )
   *tin*
   :times 1
   :families-excluded '("GT/IN/T" "GT/OUT/T" "STOP" )
   ))

(progn
  (defparameter *tin* (open-tin-file *tin-file*))
  (surface-names-coeged-with-surface-in-family
   '("C_IN") *tin*
   :times 3
   :families-excluded '(
                        "GT/IN/T"
                        "GT/OUT/T"
;;;;                        
                        "GT/OUT/C_OUT" 
                        "GT/OUT/C_OUT/T"
                        "GT/OUT/C_OUT/D_002.60"
;;;;                        
                        "GT/IN/D_002.00"
;;;;                        
                        "GT/H/H_01"
                        "GT/H/H_02"
                        "GT/H/H_02.1"
                        "GT/H/H_03"
                        "GT/H/H_04"
                        "GT/H/H_05"
                        "GT/H/H_06"
                        "GT/H/H_07"
                        "GT/H/H_08"
                        "GT/H/H_09"
                        "GT/H/H_10"
                        "GT/H/H_11"
                        "GT/H/H_12"
                        "GT/H/H_BIG")))
