(in-package #:mnas-ansys)

;; (defparameter *tin-file* "~/quicklisp/local-projects/ANSYS/mnas-ansys/tin/a32_GT-13.tin")

(defparameter *tin-file*
  "D:/home/_namatv/CFX/a32/PR-02/tin/SM/pr-02-A32-SM_01.tin"
  )

(defparameter *tin* (open-tin-file *tin-file*))

(let ((tin (open-tin-file *tin-file*)))
  (<tin>-families tin))

(<curve>-surfaces (first (tin-curves *tin*)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defparameter *start-parts*
  '("START"))

(defparameter *stop-parts*
  '("STOP"
    ))

(let ((tin (open-tin-file *tin-file*)))
  (mnas-ansys/utils:surface-names-coeged-with-surface-in-family
   *start-parts*
   
   tin
   :times 1
   :families-excluded *stop-parts*))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(progn
  (defparameter *tin* (open-tin-file *tin-file*))
  (format t "~{~A~^ ~}" (curve-names-coeged-with-surface-in-family *parts* *tin*)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(sort 
'(
 "ASM.02"
 "ASM.03"
 "ASM.01"
 "D2/W/T/W_X027.4_D003.00_S00.81_T01"
 "D2/W/T/W_X027.4_D004.00_S01.08_T02"
 "D2/W/W_D176.00_S05.93_P00"
 "D2/C/C_2-4_N01_D029.00_S01.94"
 "D2/C/C_2-6_N01_D003.00_S01.15"
 "D2/C/C_2-5_N01_D060.00_S02.00"
 "D2/W/T/W_X049.5_D003.00_S00.81_T03"
 "D2/W/W_D004.00_S00.75_P01"
 "D2/W/W_D176.00_S05.93_P01"
 "D2/W/X/W_X049.5_D001.20_S00.46"
 "D2/W/T/W_X071.5_D003.00_S00.81_T04"
 "D2/W/W_D004.00_S00.75_P02"
 "D2/W/W_D176.00_S05.93_P02"
 "D2/C/X/C_1-2_X049.5_D001.20_S00.46"
 "D2/W/X/W_X071.5_D001.20_S00.46"
 "D2/W/W_D176.00_S05.93_P03"
 "D2/W/W_D004.00_S00.75_P03"
 "D2/W/T/W_X093.5_D003.00_S00.81_T05"
 "D2/C/X/C_1-2_X071.5_D001.20_S00.46"
 "D2/W/W_D176.00_S05.93_P15.3"
 "D2/W/W_D002.00_S00.40_P15.6"
 "D2/W/X/W_X076.5_D001.20_S00.46"
 "D2/W/X/W_X093.5_D001.20_S00.46"
 "D2/W/T/W_X115.5_D003.00_S00.81_T06"
 "D2/W/W_D004.00_S00.75_P04"
 "D2/W/W_D176.00_S05.93_P04"
 "D2/C/X/C_1-2_X093.5_D001.20_S00.46"
 "D2/W/X/W_X115.5_D001.20_S00.46"
 "D2/W/W_D004.00_S00.75_P05"
 "D2/W/W_D176.00_S05.93_P05"
 "D2/W/T/W_X137.5_D003.00_S00.81_T07"
 "D2/C/X/C_1-2_X115.5_D001.20_S00.46"
 "D2/W/W_D004.00_S00.75_P06"
 "D2/W/X/W_X137.5_D001.00_S00.38"
 "D2/W/W_D176.00_S05.93_P06"
 "D2/W/T/W_X159.5_D003.00_S00.81_T08"
 "D2/W/W_D004.00_S00.75_P07"
 "D2/W/X/W_X159.5_D001.00_S00.38"
 "D2/W/W_D176.00_S05.93_P07"
 "D2/W/T/W_X181.5_D003.00_S00.81_T09"
 "D2/C/X/C_1-2_X159.5_D001.00_S00.38"
 "D2/W/W_D004.00_S00.75_P08"
 "D2/W/X/W_X181.5_D001.00_S00.38"
 "D2/W/W_D176.00_S05.93_P08"
 "D2/W/T/W_X203.5_D003.00_S00.81_T10"
 "D2/C/X/C_1-2_X181.5_D001.00_S00.38"
 "D2/W/X/W_X203.5_D001.00_S00.38"
 "D2/W/T/W_X225.5_D003.00_S00.81_T12"
 "D2/W/W_D176.00_S05.93_P09"
 "D2/C/X/C_1-2_X203.5_D001.00_S00.38"
 "D2/C/X/C_1-2_X137.5_D001.00_S00.38"
 "D2/W/X/W_X225.5_D001.50_S00.58"
 "D2/W/W_D176.00_S05.93_P10"
 "D2/C/X/C_1-2_X225.5_D001.50_S00.58"
 "D2/W/X/W_X254.9_D001.60_S00.62"
 "D2/W/W_D005.00_S00.94_P11"
 "D2/W/X/W_X264.0_D011.50_S04.42"
 "D2/W/T/W_X254.9_D003.40_S00.92_T13"
 "D2/C/X/C_1-2_X254.9_D001.60_S00.62"
 "D2/C/X/C_1-2_X264.0_D011.50_S03.10"
 "D2/W/X/W_X302.9_D001.50_S00.58"
 "D2/W/W_D005.00_S00.94_P12"
 "D2/C/X/C_1-2_X350.9_D001.50_S00.58"
 "D2/C/X/C_1-2_X401.5_D001.20_S00.46"
 "D2/W/X/W_X401.5_D001.20_S00.46"
 "D2/W/T/W_X401.5_D003.40_S00.92_T16"
 "D2/W/W_D176.00_S05.93_P13"
 "D2/W/X/W_X456.0_D001.50_S00.58"
 "A.02/W_D176.00_S16.80_P14"
 "D2/C/X/C_1-2_X436.5_D001.50_S00.58"
 "A.02/POINT_CURVE"
 "D2/C/T_2-L_N01_D027.00_S05.00"
 "D2/C/T_2-R_N01_D027.00_S05.00"
 "D2/C/C_1-2_N01_D001.00_S00.38"
 "D2/B2"
 "GEOM"
 "D2/W/W_D004.00_S00.75_P09"
 "D2/W/W_D176.00_S05.93_P11"
 "D2/W/T/W_X302.9_D003.40_S00.92_T14"
 "D2/W/W_D176.00_S05.93_P12"
 "D2/W/X/W_X436.5_D001.50_S00.58"
 "D2/W/X/W_X436.5_D001.90_S00.73"
 "D2/C/X/C_1-2_X436.5_D001.90_S00.73"
 "D2/C/X/C_1-2_X302.9_D001.50_S00.58"
 "D2/W/X/W_X350.9_D001.50_S00.58"
 "D2/C"
 "D2/W/X/W_X401.2_D001.50_S00.58"
 "D2/C/X/C_1-2_X401.5_D001.50_S00.58"
 "D2/C/X/C_1-2_X456.0_D001.50_S00.58"
 "D2/W/T/W_X350.9_D003.40_S00.92_T15"
 "A.02/P14_ST"
 "D2/W/W_D005.00_S00.94_P14"
 "D2/W/W_D176.00_S05.93_P14.1"
 "D2/W/W_D005.00_S00.94_P13"
 "D2/C/X/C_1-2_X076.5_D001.20_S00.46"
 "D2/W/W_D002.50_S00.70_P15.1"
 "D2/W/W_D002.50_S00.70_P15.2"
 "D2/W/W_D027.00_S05.10_P15.5"
 "A.02"
 "D2/W/W_D008.30_S01.12_P16"
 "D2/P/CURVE_POINT"
 "D2/W"
 "D2/W/X"
 "D2/C/C_2-7_N01_D028.00_S03.00"
 "D2/C/X"
 "D2/W/T"
 "D2/W/T/W_X468.5_D003.60_S00.69_P16"
 "D2/W/W_D003.60_S00.69_P18"
 "D2/P"
 "D2"
 "SM/__32030107__________________________________1_1_2"
 "SM/H/X_466.5_D_001.5"
 "SM/H/X_452.0_D_001.5"
 "SM/CP"
 "SM/C/C_1-2_X_466.5_D_001.50"
 "SM/C/C_1-2_X_436.5_D_001.50"
 "SM/C/C_1-2_X_401.5_D_001.20"
 "SM/C/C_1-2_X_452.0_D_001.5"
 "SM/ZUB"
 "D2/W/T/W_X436.5_D003.40_S00.92_T17"
 "SM2/H_X_436.5"
 "SM2/PIN"
 "SM2"
 "HOLE"
 "C_1-2"
)
#'string<)
1 "D2/W/W_D176.00_S05.93_P12"
   D2/W/W_D176.00_S05.93_P12
2 "D2/W/W_D005.00_S00.94_P13"
   D2/W/W_D005.00_S00.94_P13
3 "D2/W/X/W_X401.5_D001.20_S00.46"
   D2/W/X/W_X401.5_D001.20_S00.46
4 "D2/C/X/C_1-2_X401.5_D001.20_S00.46"
   D2/W/X/W_X401.5_D001.20_S00.46
5 "D2/W/X/W_X401.2_D001.50_S00.58"
   D2/W/X/W_X401.2_D001.50_S00.58
6 "D2/C/X/C_1-2_X401.5_D001.50_S00.58"
   D2/C/X/C_1-2_X401.5_D001.50_S00.58
7 "D2/W/W_D176.00_S05.93_P13"
   D2/W/W_D176.00_S05.93_P13
8 "D2/W/W_D176.00_S05.93_P14.1"
   D2/W/W_D176.00_S05.93_P14.1
9 "D2/W/T/W_X436.5_D003.40_S00.92_T17"
   D2/W/T/W_X436.5_D003.40_S00.92_T17
10 "D2/W/T/W_X401.5_D003.40_S00.92_T16"
    D2/W/T/W_X401.5_D003.40_S00.92_T16
11 "D2/W/W_D005.00_S00.94_P14"
    D2/W/W_D005.00_S00.94_P14
12 "D2/W/W_D176.00_S05.93_P14.1"
    D2/W/W_D176.00_S05.93_P14.1
13 "D2/W/X/W_X466.5_D001.60_S00.43"
    D2/W/X/W_X466.5_D001.60_S00.43
14 "D2/C/X/C_1-2_X466.5_D001.50_S00.58"
    D2/C/X/C_1-2_X466.5_D001.50_S00.58
15 "D2/W/W_D008.30_S01.12_P17"
    D2/W/W_D008.30_S01.12_P17
16 "D2/W/T/W_X466.5_D003.60_S00.69_P16"


17 "D2/W/X/W_X436.5_D001.90_S00.73"
    D2/W/X/W_X436.5_D001.90_S00.73
18 "D2/C/X/C_1-2_X436.5_D001.90_S00.73"
    D2/C/X/C_1-2_X436.5_D001.90_S00.73
19 "D2/W/X/W_X436.5_D001.50_S00.58"
    D2/W/X/W_X436.5_D001.50_S00.58
20 "D2/C/X/C_1-2_X436.5_D001.50_S00.58"
    D2/C/X/C_1-2_X436.5_D001.50_S00.58

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun foo (y)
  (with-open-file (os "D:/home/_namatv/CFX/ugt5000_H2/V1/tin/DOMAINS/D1/123.rpl" :direction :output :if-exists :supersede)
    (format os "ic_undo_group_begin~%")
    (format os "ic_uns_subset_cut Selected set 1 1 {-92.750000000086757 ~A 0} {0 1 0} 0~%" y)
    (format os "ic_uns_subset_cut {added faces} set 1 1 {-92.750000000086757 ~A 0} {0 1 0} 0~%" y)
    (format os "ic_undo_group_end~%")
    (format os "ic_undo_group_begin~%")
    (format os "ic_rm D:/home/_namatv/CFX/ugt5000_H2/V1/tin/DOMAINS/D1/D1-Y_~A.ppm~%" y)
    (format os "ic_undo_group_end~%")
    (format os "sh {C:/ANSYS/v221/icemcfd/win64_amd/bin/cjpeg} -quality 75 D:/home/_namatv/CFX/ugt5000_H2/V1/tin/DOMAINS/D1/D1-Y_~A.ppm D:/home/_namatv/CFX/ugt5000_H2/V1/tin/DOMAINS/D1/D1-Y_~A.jpg~%"
            y y)))

(foo 500)

ic_undo_group_begin 
ic_rm ./plot_output.tmp
ic_rm D:/home/_namatv/CFX/ugt5000_H2/V1/tin/DOMAINS/D1/D1-Y_500.ppm
ic_undo_group_end 
(* 0.25 2.82) ; => 0.705 (70.5%)

(defparameter *lst-10* (list 1 5/4 8/5 2 5/2 16/5 4 5 63/10 8))
(defparameter *R-10*
  (apply #'append
         (loop :for j :from -3 :to 2
               :collect
               (loop :for i :in *lst-10* :collect
                                         (* i (expt 10 j))))))

(defun dia (d &optional (k 4))
  (loop :for i :in (reverse *R-10*)
        :when (<= i (/ d k)) :return i))

(dia 1.6)

(/ 12.5 4)

