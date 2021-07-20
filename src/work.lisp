(in-package #:mnas-icem/utils)

(defparameter *tin-file* "/_gas/CFX/otd11/namatv/a32_base/PR-01/a32_KS_ALL.tin")

(defparameter *tin-file* "/_gas/CFX/otd11/namatv/a32_base/PR-01/GT_GU_KORP/a32_KORP_01.tin")
(defparameter *tin-file* "Z:/CFX/otd11/namatv/a32_base/PR-01/GT_GU_KORP/a32_KORP_01.tin")

(defparameter *tin* (open-tin-file *tin-file*))

(families (tin-surfaces *tin*))

(progn
  (defparameter *tin* (open-tin-file *tin-file*))
  (names 
   (exclude-by-families  
    (surfaces-coedged-with-curve-by-number 1 *tin*)
    '( "STOP" ))))


(progn
  (defparameter *tin* (open-tin-file *tin-file*))
  (surface-names-coeged-with-surfaces
   (exclude-by-families
    (surfaces-coedged-with-curve-by-number 1 *tin*) '("STOP"))
   *tin*
   :times 10
   :excluded (include-by-families (tin-surfaces *tin*) '("STOP"))))





(names (surfaces-coedged-with-curve-by-number 1 *tin*))
; F_249616 F_252756 F_249673 F_248994 F_249678 F_247109 F_250775 F_250643



(curves-by-coedges-number 1 *tin*)

(names 
 (surfaces-coedged-with-curve-by-number 1 *tin*))
 srf.22.5785 


(length (curves-by-coedges-number 4 *tin*))
(curve-names-by-coedges-number 2 *tin*)

(<tin>-file-name *tin*)
(file-timest)

(length (surfaces-coedged-with-curve-by-number 1 *tin*))
(surface-names-coedged-with-curve-by-number 4 *tin*)

(progn
  (defparameter *tin* (open-tin-file *tin-file*))
  (format t "~{~A~^ ~}"
          (surface-names-coeged-with-surface-in-family
           '(
             "GT_P12_INNER"
             )
           *tin*
           :families-excluded
           '(
             "GT_P12_TOREC_R"
             "GT_P12_TOREC_L"
             "GT_P12_STUB"
             "GT_P12_HOLES"
             ;; "GT_P12_OUTER"
             ) 
           :times 1)))

(surfaces-by-families
 '("GT_P11_STUB_1")
 *tin*)

(<tin>-families *tin*)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defparameter *parts* '("GT_P15_OUTER" "GT_P15_HOLES"))

(progn
  (defparameter *tin* (open-tin-file *tin-file*))
  (format t "~{~A~^ ~}" (curve-names-coeged-with-surface-in-family *parts* *tin*)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(progn
  (defparameter *tin* (open-tin-file *tin-file*))
  (format t "~{~A~^ ~}"
          (surface-names-coedged-with-curve-by-number
           3
           *tin*
           :families-excluded '(
                                "GT_P02_TOREC_H"
                                ))))
 F_557207 F_1070316 F_560695 F_557155 F_1070171 F_560713 F_556990.cut.0 F_1070304 F_557151 F_1070445 F_560709 F_560956.cut.0 F_1070287.cut.0 F_557898 F_557898.cut.0 F_1070628.cut.0 F_560435 F_560435.cut.0 

 F_1048378 F_1048379 F_1048930 F_1051683 F_1051660 F_1051628 F_1051596 F_1051564 F_1051532 F_1051500 F_1051468 F_1050509 F_1050526 F_1050581 F_1050709 F_1050740 F_1050772 F_1050804 F_1050836 F_1050820 F_1050788 F_1050756 F_1050724 F_1050604 F_1050553 F_1050659 F_1051452 F_1051484 F_1051516 F_1051548 F_1051580 F_1051612 F_1051644 F_1048734 F_1048696 F_1048407 F_1050852 F_1050868 F_1050884 F_1050900 F_1050916 F_1050932 F_1050948 F_1050964 F_1050980 F_1050996 F_1051012 F_1051028 F_1051044 F_1051060 F_1051076 F_1051092 F_1051108 F_1051124 F_1051140 F_1051156 F_1051172 F_1051188 F_1051204 F_1051220 F_1051236 F_1051252 F_1051268 F_1051284 F_1051300 F_1051316 F_1051332 F_1051348 F_1051364 F_1051380 F_1050388 F_1051396 srf.00 
 F_1050338 F_1056636 F_1048378 F_1048379 F_1050388 F_1056692 F_1050389 F_1053689 F_1048402 srf.00 
 ; => NIL
 ; => NIL
 F_1070628.cut.0 F_1070287.cut.0 F_1048759 F_1050852 F_1050884 F_1050916 F_1050948 F_1050980 F_1051012 F_1051044 F_1051076 F_1051108 F_1051140 F_1051172 F_1051204 F_1051236 F_1051268 F_1051300 F_1051332 F_1051364 F_1051380 F_1051348 F_1051316 F_1051284 F_1051252 F_1051220 F_1051188 F_1051156 F_1051124 F_1051092 F_1051060 F_1051028 F_1050996 F_1050964 F_1050932 F_1050900 F_1050868 F_1051396 F_1048930 F_1051683 F_1051660 F_1051628 F_1051596 F_1051564 F_1051532 F_1051500 F_1051468 F_1050509 F_1050526 F_1050581 F_1050709 F_1050740 F_1050772 F_1050804 F_1050836 F_1050820 F_1050788 F_1050756 F_1050724 F_1050604 F_1050553 F_1050659 F_1051452 F_1051484 F_1051516 F_1051548 F_1051580 F_1051612 F_1051644 F_1048734 F_1048696 F_1048407 F_1047326 F_1051741 F_1051746 F_1048758 F_1048754 F_1053597 F_1050404 F_1050323 F_1050309 => NIL



(<curve>-vertex1 (find-curve-by-name "E_1516615" *tin*))
(<curve>-vertex2 (find-curve-by-name "E_1516615" *tin*))





