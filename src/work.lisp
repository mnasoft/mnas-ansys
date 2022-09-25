(in-package #:mnas-ansys/utils)

(defparameter *tin-file* "Z:/_namatv/CFX/n70/tin/SEP/GU/cfx_N70_prj_01_GU-01.tin")
(defparameter *tin-file* "D:/home/_namatv/CFX/a32/a32_2d_ch_opt/tin/02/a32_2d_ch_opt_02.tin")

(defparameter *tin-file* "Z:/_namatv/CFX/n70/tin/DOMAINS/D-1/cfx_N70_prj_01_D-1.tin")
(defparameter *tin-file* "D:/PRG/msys64/home/mnaso/CFX/cfx_N70_prj_01_D-1.tin")

(defparameter *d-names*
    (loop :for i :in (names (mnas-ansys:<tin>-families *tin*))
      :if (let ((str (first (last (mnas-string:split "/" i)))))
            (and (eq #\D (char str 0))
                 (eq #\_ (char str 1))))
        :collect i :into d-rez
          :finally (return d-rez)))
(progn
  (format t "~A~%" "ic_undo_group_begin")
  (loop :for i :in *d-names*
        :do
           (let ((d-size
                   (read-from-string
                    (first
                     (last
                      (mnas-string:split
                       "_"
                       (first (last (mnas-string:split "/" i)))))))))
             d-size
             (format t "ic_geo_set_family_params ~A no_crv_inf prism 0 emax ~A ehgt 0.0 hrat 0 nlay 0 erat ~A ewid 0 emin 0.0 edev 0.0 split_wall 0 internal_wall 0~%"
                     i (/ d-size 4) 0)))
  (format t "~A~2%" "ic_undo_group_end"))

(let ((str
        (first (last (mnas-string:split "/" (nth 6 (names (mnas-ansys:<tin>-families *tin*))))))))
  (and (eq #\D (char str 0))
       (eq #\_ (char str 1))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defparameter *tin* (open-tin-file *tin-file*))

(svref (mnas-ansys/read:read-file-as-lines *tin-file*) 25)

(<obj>-name (first (mnas-ansys:<tin>-families *tin*)))
(<family>-prism (first (mnas-ansys:<tin>-families *tin*)))

(sort (mnas-ansys:<tin>-families *tin*) #'string< :key #'<obj>-name)

(names (mnas-ansys:<tin>-families *tin*))

(<obj>-name
 (first 
  (coedged
   (first 
    (secect-surfaces-by-families
     '(
       "ZAV_1/L1"
       "ZAV_1/ZAV_1_IN"
       "ZAV_1/ZAV_1_IN_ML"
       "ZAV_1/ZAV_1_OUT"
       "ZAV_1/ZAV_1_OUT_ML"
       )
     *tin*))
   *tin*)))
 
(progn
  (defparameter *tin* (open-tin-file *tin-file*))
  (format t "~{~A ~}"
          (curve-names-coeged-with-surface-in-family
           '(
 "ZAV_1/L1"
 "ZAV_1/ZAV_1_IN"
 "ZAV_1/ZAV_1_IN_ML"
 "ZAV_1/ZAV_1_OUT"
 "ZAV_1/ZAV_1_OUT_ML"

             )
           *tin*
           )))

("CFX___70038107_1_10"
 "G1"
 "G1/CH_1"
 "G1/CH_1_H"
 "G1/CH_1_SH"
 "G2"
 "G2/CH_2"
 "G2/CH_2_K"
 "G2/H2"
 "G2/H2_S"
 "GEOM"
 "HOLES"
 "HOLES/H_COOL"
 "HOLES/H_COOL_1"
 "HOLES/H_COOL_2"
 "KOLL"
 "OUT"
 "P2"
 "P3"
 "P4"
 "P5"
 "P6"
 "POINT_CURVE"
 "START"
 "STOP"
 "ZAV_1"
 "ZAV_1/L1"
 "ZAV_1/ZAV_1_IN"
 "ZAV_1/ZAV_1_IN_ML"
 "ZAV_1/ZAV_1_OUT"
 "ZAV_1/ZAV_1_OUT_ML")

(progn
  (defparameter *tin* (open-tin-file *tin-file*))
  (surface-names-coeged-with-surface-in-family
   '("START")
   *tin*
   :times 1
   :families-excluded
   '(#+nil "CFX___70038107_1_10"
     "H_COOL"
)
   ))

(progn
  (defparameter *tin* (open-tin-file *tin-file*))
  (surface-names-coeged-with-surface-in-family
   '("KOLL"
     #+nil "START"
     )
   *tin*
   :times 4
   :families-excluded
   '(#+nil
     "CFX___70038107_1_10" "G1" "G1/CH_1" "G1/CH_1_H" "G1/CH_1_SH" "G2" "G2/CH_2"
     "G2/CH_2_K" "G2/H2" "G2/H2_S" "GEOM" "HOLES" "HOLES/H_COOL" "HOLES/H_COOL_1"
     "HOLES/H_COOL_2" "KOLL" "L1" "OUT" "P2" "P3" "P4" "P5" "P6" "POINT_CURVE"
     "START" "STOP")
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

(curve-names-coeged-with-surfaces-in-families
     '(
       "ZAV_1/L1"
       "ZAV_1/ZAV_1_IN"
       "ZAV_1/ZAV_1_IN_ML"
       "ZAV_1/ZAV_1_OUT"
       "ZAV_1/ZAV_1_OUT_ML"
       )
     *tin*)
