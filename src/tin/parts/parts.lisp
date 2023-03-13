;;;; ./src/parts/parts.lisp

(in-package :mnas-ansys)

(defun filter-c (surface-number-lst)
  (reduce
   #'(lambda (x y)
       (if (string= "C" (second (mnas-string:split "/" (first y))))
           (cons y x)
           x))
   surface-number-lst
   :initial-value nil))

(defun filter-domain-number (number surface-number-lst)
  (reduce
   #'(lambda (x y)
       (if (string= (format nil "D~36R" number) (first (mnas-string:split "/" (first y))))
           (cons y x)
           x))
   surface-number-lst
   :initial-value nil))

(defun filter-domain-not-number (number surface-number-lst)
  (reduce
   #'(lambda (x y)
       (if (string/= (format nil "D~36R" number) (first (mnas-string:split "/" (first y))))
           (cons y x)
           x))
   surface-number-lst
   :initial-value nil))

(defun find-bad-families (domain surface-number-lst)
  (set-difference (filter-domain-number domain surface-number-lst)
                  (filter-domain-not-number domain surface-number-lst)
                  :key #'(lambda (el) (subseq (first el) 3)) :test #'equal))

(defparameter *c*
  (apply #'append
         (loop :for i :in '("1" "2" "3" "4" "5" "6" "7" "8" "9" "A" "B")
               :collect
               (let ((f-name (format nil "D:/home/_namatv/CFX/a32_base/PR-01/tin/DOMAINS/D-~A/a32-D-~A.tin" i i )))
                 (filter-c (count-surface (open-tin-file f-name)))))))

(open-tin-file "D:/home/_namatv/CFX/test/02/DOMAINS/test-02-D1.tin")

(find-bad-families 1 *c*)

(("D1/C/T_1-R_N01_D070.0_S18.90" 1)
 ("D1/C/T_1-L_N01_D070.0_S18.90" 1)
 ("D1/C/B_1-O_N01_D010.00_S02.70" 5)
 ("D1/C/B_1-I_N01_D070.00_S18.91" 1))

(("D8/C/T_8-R_N01_D122.6_S10.00" 1)
 ("D8/C/T_8-L_N01_D122.6_S10.00" 1)
 ("D8/C/O_8-O_N01_D122.6_S10.00" 1))

*c*
(sort *c* #'string< :key #'(lambda (el)  (subseq (first el) 3)))

C_1 B_N01--D1 C C_1 B_N01_D070.00_S10.00,D1 C C_1 B_N01_D070.00_S10.00 2--DB C C_1 B_N01_D070.00_S10.00

"D1 C C_1 B_N01_D070.00_S10.00" "DB C C_1 B_N01_D070.00_S10.00"
"D1 C C_1 3_N01_D024.00_S01.61" "D3 C C_1 3_N01_D024.00_S01.61"
"D1 C C_1 4_N01_D032.00_S04.32" "D4 C C_1 4_N01_D032.00_S04.32"
"D1 C C_1 5_N01_D001.20_S00.23" "D5 C C_1 5_N01_D001.20_S00.23"
"D1 C C_1 5_N02_D015.80_S02.00" "D5 C C_1 5_N02_D015.80_S02.00"
"D1 C C_1 6_N01_D003.00_S00.81" "D6 C C_1 6_N01_D003.00_S00.81"
"D1 C C_1 A_N01_D034.10_S02.50"  "DA C C_1 A_N01_D034.10_S02.50"
"D2 C C_2 4_N01_D029.00_S01.94"  "D4 C C_2 4_N01_D029.00_S01.94"
"D2 C C_2 5_N01_D060.00_S02.00"  "D5 C C_2 5_N01_D060.00_S02.00"
"D2 C C_2 6_N01_D003.00_S01.15"  "D6 C C_2 6_N01_D003.00_S01.15"
"D2 C C_2 7_N01_D028.00_S03.00"  "D7 C C_2 7_N01_D028.00_S03.00"
"D3 C C_3 5_N01_D008.80_S01.20"  "D5 C C_3 5_N01_D008.80_S01.20"
"D7 C C_7 8_N01_D028.00_S03.00"  "D8 C C_7 8_N01_D028.00_S03.00"
"D9 C C_9 A_N01_D014.20_S02.50"  "DA C C_9 A_N01_D014.20_S02.50"

"D1 C X C_1 2_X049.5_D001.20_S00.46"   "D2 C X C_1 2_X049.5_D001.20_S00.46"
"D1 C X C_1 2_X071.5_D001.20_S00.46"   "D2 C X C_1 2_X071.5_D001.20_S00.46"
"D1 C X C_1 2_X076.5_D001.20_S00.46"   "D2 C X C_1 2_X076.5_D001.20_S00.46"
"D1 C X C_1 2_X093.5_D001.20_S00.46"   "D2 C X C_1 2_X093.5_D001.20_S00.46"
"D1 C X C_1 2_X115.5_D001.20_S00.46"   "D2 C X C_1 2_X115.5_D001.20_S00.46"
"D1 C X C_1 2_X137.5_D001.00_S00.38"   "D2 C X C_1 2_X137.5_D001.00_S00.38"
"D1 C X C_1 2_X159.5_D001.00_S00.38"   "D2 C X C_1 2_X159.5_D001.00_S00.38"
"D1 C X C_1 2_X181.5_D001.00_S00.38"   "D2 C X C_1 2_X181.5_D001.00_S00.38"
"D1 C X C_1 2_X203.5_D001.00_S00.38"   "D2 C X C_1 2_X203.5_D001.00_S00.38"
"D1 C X C_1 2_X225.5_D001.50_S00.58"   "D2 C X C_1 2_X225.5_D001.50_S00.58"
"D1 C X C_1 2_X254.9_D001.60_S00.62"   "D2 C X C_1 2_X254.9_D001.60_S00.62"
"D1 C X C_1 2_X264.0_D011.50_S03.10"   "D2 C X C_1 2_X264.0_D011.50_S03.10"
"D1 C X C_1 2_X302.9_D001.50_S00.58"   "D2 C X C_1 2_X302.9_D001.50_S00.58"
"D1 C X C_1 2_X350.9_D001.50_S00.58"   "D2 C X C_1 2_X350.9_D001.50_S00.58"
"D1 C X C_1 2_X401.5_D001.20_S00.46"   "D2 C X C_1 2_X401.5_D001.20_S00.46"
"D1 C X C_1 2_X401.5_D001.50_S00.58"   "D2 C X C_1 2_X401.5_D001.50_S00.58"
"D1 C X C_1 2_X436.5_D001.50_S00.58"   "D2 C X C_1 2_X436.5_D001.50_S00.58" 
"D1 C X C_1 2_X436.5_D001.90_S00.73"   "D2 C X C_1 2_X436.5_D001.90_S00.73"
"D1 C X C_1 2_X456.0_D001.50_S00.58"   "D2 C X C_1 2_X456.0_D001.50_S00.58"
"D1 C X C_1 2_X466.5_D001.50_S00.58"   "D2 C X C_1 2_X466.5_D001.50_S00.58"


"D1 C T_1 L_N01_D070.0_S18.90"   "D1 C T_1 R_N01_D070.0_S18.90" 
"D2 C T_2 L_N01_D027.00_S05.00"  "D2 C T_2 R_N01_D027.00_S05.00" 
"D7 C T_7 L_N01_D028.00_S03.00"  "D7 C T_7 R_N01_D028.00_S03.00" 
"D8 C T_8 L_N01_D122.6_S10.00"   "D8 C T_8 R_N01_D122.6_S10.00" 
"D9 C T_9 L_N01_D014.20_S02.50"  "D9 C T_9 R_N01_D014.20_S02.50" 
"DA C T_A L_N01_D034.10_S02.50"  "DA C T_A R_N01_D034.10_S02.50"

"D1 C C_1 2_N01_D001.00_S00.38"  "D2 C C_1 2_N01_D001.00_S00.38"

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
