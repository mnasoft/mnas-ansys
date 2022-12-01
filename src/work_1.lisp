(in-package #:mnas-ansys/tin/utils)

(defparameter *tin-file* "Z:/_namatv/CFX/n70/tin/SEP/GU/cfx_N70_prj_01_GU-01.tin")
(defparameter *tin-file* "D:/home/_namatv/CFX/a32/a32_2d_ch_opt/tin/02/a32_2d_ch_opt_02.tin")
(defparameter *tin-file* "Z:/_namatv/CFX/n70/tin/SEP/ALL/GU/cfx_N70_prj_02_GU_02.tin")
(defparameter *tin-file* "D:/home/_namatv/CFX/n70/tin/SEP/ALL/GU/cfx_N70_prj_01_GU-03.tin")
(defparameter *tin-file* "D:/home/_namatv/CFX/n70/tin/SEP/ALL/GU/cfx_N70_prj_02_GU_02.tin")

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

"
(define_family GU/GU_GT/D_08.000 prism 0 tetra_size 0.0 height  0.0 hratio 0.0 nlay 0 ratio 0.0 width 0.0 min 0.0 dev 0.0 color 14262323

 define_family GU/ZAV_1/OUT/WALL/D_00.500 prism 0 tetra_size 0.0 height  0.0 hratio 0.0 nlay 0 ratio 0.0 width 0.0 min 0.0 dev 0.0 color 6697976

 define_family GU/GU_KMP/OUT prism 0 tetra_size 0.0 height  0.0 hratio 0.0 nlay 0 ratio 0.0 width 0.0 min 0.0 dev 0.0 color 13644716

 define_family POINT_CURVE prism 0 tetra_size 0.0 height  0.0 hratio 0.0 nlay 0 ratio 0.0 width 0.0 min 0.0 dev 0.0 color 15304499

 define_family GU/G2/HOLES/CH_2 prism 0 tetra_size 0.0 height  0.0 hratio 0.0 nlay 0 ratio 0.0 width 0.0 min 0.0 dev 0.0 color 15283079

 define_family GU/G1/WALL/D_02.000 prism 0 tetra_size 0.0 height  0.0 hratio 0.0 nlay 0 ratio 0.0 width 0.0 min 0.0 dev 0.0 color 5125117

 define_family GU/G1/HOLES/D_01.600 prism 0 tetra_size 0.0 height  0.0 hratio 0.0 nlay 0 ratio 0.0 width 0.0 min 0.0 dev 0.0 color 15283079

 define_family GU/G1/HOLES/D_00.520 prism 0 tetra_size 0.0 height  0.0 hratio 0.0 nlay 0 ratio 0.0 width 0.0 min 0.0 dev 0.0 color 3388617

 define_family GU/G1 prism 0 tetra_size 0.0 height  0.0 hratio 0.0 nlay 0 ratio 0.0 width 0.0 min 0.0 dev 0.0 color 0

 define_family GU/G2/HOLES/D_07.500 prism 0 tetra_size 0.0 height  0.0 hratio 0.0 nlay 0 ratio 0.0 width 0.0 min 0.0 dev 0.0 color 16537139

 define_family P2 prism 0 tetra_size 0.0 height  0.0 hratio 0.0 nlay 0 ratio 0.0 width 0.0 min 0.0 dev 0.0 color 3393972

 define_family GU/G2/HOLES/D_02.000 prism 0 tetra_size 0.0 height  0.0 hratio 0.0 nlay 0 ratio 0.0 width 0.0 min 0.0 dev 0.0 color 3363581

 define_family GU/G2/HOLES/D_00.600 prism 0 tetra_size 0.0 height  0.0 hratio 0.0 nlay 0 ratio 0.0 width 0.0 min 0.0 dev 0.0 color 8383795

 define_family P3 prism 0 tetra_size 0.0 height  0.0 hratio 0.0 nlay 0 ratio 0.0 width 0.0 min 0.0 dev 0.0 color 3931716

 define_family GU/G2 prism 0 tetra_size 0.0 height  0.0 hratio 0.0 nlay 0 ratio 0.0 width 0.0 min 0.0 dev 0.0 color 0

 define_family GU/ZAV_1/POINT_CURVE prism 0 tetra_size 0.0 height  0.0 hratio 0.0 nlay 0 ratio 0.0 width 0.0 min 0.0 dev 0.0 color 13023027

 define_family GU/G1/GEOM prism 0 tetra_size 0.0 height  0.0 hratio 0.0 nlay 0 ratio 0.0 width 0.0 min 0.0 dev 0.0 color 3388617

 define_family GU/COOL_2/OUT/START prism 0 tetra_size 0.0 height  0.0 hratio 0.0 nlay 0 ratio 0.0 width 0.0 min 0.0 dev 0.0 color 9974751

 define_family GU/COOL_1/WALL/IN/D_02.000 prism 0 tetra_size 0.0 height  0.0 hratio 0.0 nlay 0 ratio 0.0 width 0.0 min 0.0 dev 0.0 color 3400848

 define_family GU/COOL_1/P5 prism 0 tetra_size 0.0 height  0.0 hratio 0.0 nlay 0 ratio 0.0 width 0.0 min 0.0 dev 0.0 color 3393972

 define_family GU/COOL_1/HOLES/H_COOL prism 0 tetra_size 0.0 height  0.0 hratio 0.0 nlay 0 ratio 0.0 width 0.0 min 0.0 dev 0.0 color 5176627

 define_family GU/COOL_1/WALL/OUT/D_04.000 prism 0 tetra_size 0.0 height  0.0 hratio 0.0 nlay 0 ratio 0.0 width 0.0 min 0.0 dev 0.0 color 3369718

 define_family GU/COOL_1/HOLES/D_06.000 prism 0 tetra_size 0.0 height  0.0 hratio 0.0 nlay 0 ratio 0.0 width 0.0 min 0.0 dev 0.0 color 16343603

 define_family GU/COOL_2/OUT/HOLES/D_04.000 prism 0 tetra_size 0.0 height  0.0 hratio 0.0 nlay 0 ratio 0.0 width 0.0 min 0.0 dev 0.0 color 16727871

 define_family GU/HOLES prism 0 tetra_size 0.0 height  0.0 hratio 0.0 nlay 0 ratio 0.0 width 0.0 min 0.0 dev 0.0 color 0

 define_family GU/COOL_2/OUT/WALL/D_04.000 prism 0 tetra_size 0.0 height  0.0 hratio 0.0 nlay 0 ratio 0.0 width 0.0 min 0.0 dev 0.0 color 3379428

 define_family GU/ZAV_1/ZAV_1_IN prism 0 tetra_size 0.0 height  0.0 hratio 0.0 nlay 0 ratio 0.0 width 0.0 min 0.0 dev 0.0 color 3379428

 define_family GU/ZAV_1/IN/WALL/D_04.000 prism 0 tetra_size 0.0 height  0.0 hratio 0.0 nlay 0 ratio 0.0 width 0.0 min 0.0 dev 0.0 color 3406430

 define_family GU/ZAV_1/OUT/ZAV_1_OUT prism 0 tetra_size 0.0 height  0.0 hratio 0.0 nlay 0 ratio 0.0 width 0.0 min 0.0 dev 0.0 color 9122791

 define_family GU/ZAV_1 prism 0 tetra_size 0.0 height  0.0 hratio 0.0 nlay 0 ratio 0.0 width 0.0 min 0.0 dev 0.0 color 0

 define_family B/GAS_1/D_04.000 prism 0 tetra_size 0.0 height  0.0 hratio 0.0 nlay 0 ratio 0.0 width 0.0 min 0.0 dev 0.0 color 8336365

 define_family GU/G2/G2_IN prism 0 tetra_size 0.0 height  0.0 hratio 0.0 nlay 0 ratio 0.0 width 0.0 min 0.0 dev 0.0 color 5125117

 define_family P7 prism 0 tetra_size 0.0 height  0.0 hratio 0.0 nlay 0 ratio 0.0 width 0.0 min 0.0 dev 0.0 color 3383258

 define_family GU prism 0 tetra_size 0.0 height  0.0 hratio 0.0 nlay 0 ratio 0.0 width 0.0 min 0.0 dev 0.0 color 16019763

 define_family GU/ZAV_2/ZAV_2_IN prism 0 tetra_size 0.0 height  0.0 hratio 0.0 nlay 0 ratio 0.0 width 0.0 min 0.0 dev 0.0 color 3390657

 define_family GU/ZAV_2/OUT/WALL/D_08.000 prism 0 tetra_size 0.0 height  0.0 hratio 0.0 nlay 0 ratio 0.0 width 0.0 min 0.0 dev 0.0 color 16528214

 define_family GU/ZAV_2 prism 0 tetra_size 0.0 height  0.0 hratio 0.0 nlay 0 ratio 0.0 width 0.0 min 0.0 dev 0.0 color 0

 define_family GU/ZAV_2/LOP/R/D_04.000 prism 0 tetra_size 0.0 height  0.0 hratio 0.0 nlay 0 ratio 0.0 width 0.0 min 0.0 dev 0.0 color 3366650

 define_family GU/ZAV_2/LOP/SUCT/D_08.000 prism 0 tetra_size 0.0 height  0.0 hratio 0.0 nlay 0 ratio 0.0 width 0.0 min 0.0 dev 0.0 color 16665141

 define_family GU/ZAV_2/LOP/T/D_04.000 prism 0 tetra_size 0.0 height  0.0 hratio 0.0 nlay 0 ratio 0.0 width 0.0 min 0.0 dev 0.0 color 10761174

 define_family GU/ZAV_2/LOP/R prism 0 tetra_size 0.0 height  0.0 hratio 0.0 nlay 0 ratio 0.0 width 0.0 min 0.0 dev 0.0 color 0

 define_family GU/ZAV_2/L2_B prism 0 tetra_size 0.0 height  0.0 hratio 0.0 nlay 0 ratio 0.0 width 0.0 min 0.0 dev 0.0 color 0

 define_family GU/ZAV_2/LOP/T prism 0 tetra_size 0.0 height  0.0 hratio 0.0 nlay 0 ratio 0.0 width 0.0 min 0.0 dev 0.0 color 0

 define_family GU/ZAV_2/LOP/T/D_00.500 prism 0 tetra_size 0.0 height  0.0 hratio 0.0 nlay 0 ratio 0.0 width 0.0 min 0.0 dev 0.0 color 3404151

 define_family GU/ZAV_2/IN/WALL/D_08.000 prism 0 tetra_size 0.0 height  0.0 hratio 0.0 nlay 0 ratio 0.0 width 0.0 min 0.0 dev 0.0 color 3398812

 define_family GU/ZAV_2/IN prism 0 tetra_size 0.0 height  0.0 hratio 0.0 nlay 0 ratio 0.0 width 0.0 min 0.0 dev 0.0 color 0

 define_family GU/ZAV_2/OUT prism 0 tetra_size 0.0 height  0.0 hratio 0.0 nlay 0 ratio 0.0 width 0.0 min 0.0 dev 0.0 color 0

 define_family GU/ZAV_2/OUT/WALL/D_16.000 prism 0 tetra_size 0.0 height  0.0 hratio 0.0 nlay 0 ratio 0.0 width 0.0 min 0.0 dev 0.0 color 3407186

 define_family GU/ZAV_2/IN/WALL/D_16.000 prism 0 tetra_size 0.0 height  0.0 hratio 0.0 nlay 0 ratio 0.0 width 0.0 min 0.0 dev 0.0 color 12989367

 define_family GU/ZAV_1/LOP/R_IN/D_04.00 prism 0 tetra_size 0.0 height  0.0 hratio 0.0 nlay 0 ratio 0.0 width 0.0 min 0.0 dev 0.0 color 3382492

 define_family GU/ZAV_1/LOP/SUCT/D_04.000 prism 0 tetra_size 0.0 height  0.0 hratio 0.0 nlay 0 ratio 0.0 width 0.0 min 0.0 dev 0.0 color 16069486

 define_family GU/ZAV_1/T/D_0.630 prism 0 tetra_size 0.0 height  0.0 hratio 0.0 nlay 0 ratio 0.0 width 0.0 min 0.0 dev 0.0 color 6748211

 define_family GU/ZAV_1/IN/WALL/D_08.000 prism 0 tetra_size 0.0 height  0.0 hratio 0.0 nlay 0 ratio 0.0 width 0.0 min 0.0 dev 0.0 color 9122791

 define_family GU/ZAV_1/OUT/WALL/D_04.000 prism 0 tetra_size 0.0 height  0.0 hratio 0.0 nlay 0 ratio 0.0 width 0.0 min 0.0 dev 0.0 color 3391423

 define_family GU/ZAV_1/OUT/R/D_16.000 prism 0 tetra_size 0.0 height  0.0 hratio 0.0 nlay 0 ratio 0.0 width 0.0 min 0.0 dev 0.0 color 3406430

 define_family GU/ZAV_1/OUT/WALL/D_0.630 prism 0 tetra_size 0.0 height  0.0 hratio 0.0 nlay 0 ratio 0.0 width 0.0 min 0.0 dev 0.0 color 4455996

 define_family GU/ZAV_1/T/D_02.000 prism 0 tetra_size 0.0 height  0.0 hratio 0.0 nlay 0 ratio 0.0 width 0.0 min 0.0 dev 0.0 color 4406526

 define_family GU/ZAV_1/OUT/WALL/D_02.000 prism 0 tetra_size 0.0 height  0.0 hratio 0.0 nlay 0 ratio 0.0 width 0.0 min 0.0 dev 0.0 color 14849075

 define_family GU/ZAV_1/OUT/WALL/D_16.000 prism 0 tetra_size 0.0 height  0.0 hratio 0.0 nlay 0 ratio 0.0 width 0.0 min 0.0 dev 0.0 color 14824340

 define_family GU/COOL_2 prism 0 tetra_size 0.0 height  0.0 hratio 0.0 nlay 0 ratio 0.0 width 0.0 min 0.0 dev 0.0 color 0

 define_family GU/COOL_1 prism 0 tetra_size 0.0 height  0.0 hratio 0.0 nlay 0 ratio 0.0 width 0.0 min 0.0 dev 0.0 color 0

 define_family GU/COOL_2/OUT prism 0 tetra_size 0.0 height  0.0 hratio 0.0 nlay 0 ratio 0.0 width 0.0 min 0.0 dev 0.0 color 7091190

 define_family GU/COOL_2/OUT/HOLES/D_01.500 prism 0 tetra_size 0.0 height  0.0 hratio 0.0 nlay 0 ratio 0.0 width 0.0 min 0.0 dev 0.0 color 3405418

 define_family GU/COOL_2/OUT/HOLES prism 0 tetra_size 0.0 height  0.0 hratio 0.0 nlay 0 ratio 0.0 width 0.0 min 0.0 dev 0.0 color 0

 define_family GU/COOL_2/OUT/WALL prism 0 tetra_size 0.0 height  0.0 hratio 0.0 nlay 0 ratio 0.0 width 0.0 min 0.0 dev 0.0 color 0

 define_family GU/COOL_2/OUT/WALL/D_02.000 prism 0 tetra_size 0.0 height  0.0 hratio 0.0 nlay 0 ratio 0.0 width 0.0 min 0.0 dev 0.0 color 12304947

 define_family GU/COOL_2/OUT/WALL/D_16.000 prism 0 tetra_size 0.0 height  0.0 hratio 0.0 nlay 0 ratio 0.0 width 0.0 min 0.0 dev 0.0 color 16331618

 define_family C/C_2_3/C_2_3_1/D_16.000 prism 0 tetra_size 0.0 height  0.0 hratio 0.0 nlay 0 ratio 0.0 width 0.0 min 0.0 dev 0.0 color 15304499

 define_family GU/G2/WALL/D_08.000 prism 0 tetra_size 0.0 height  0.0 hratio 0.0 nlay 0 ratio 0.0 width 0.0 min 0.0 dev 0.0 color 3373041

 define_family C/C_1_5/C_1_5_1/D_04.000 prism 0 tetra_size 0.0 height  0.0 hratio 0.0 nlay 0 ratio 0.0 width 0.0 min 0.0 dev 0.0 color 5911547

 define_family C/C_1_4/C_1_4_2/D_16.000 prism 0 tetra_size 0.0 height  0.0 hratio 0.0 nlay 0 ratio 0.0 width 0.0 min 0.0 dev 0.0 color 5176627

 define_family C prism 0 tetra_size 0.0 height  0.0 hratio 0.0 nlay 0 ratio 0.0 width 0.0 min 0.0 dev 0.0 color 8336365

 define_family C/C_1_5 prism 0 tetra_size 0.0 height  0.0 hratio 0.0 nlay 0 ratio 0.0 width 0.0 min 0.0 dev 0.0 color 3364348

 define_family C/C_1_4/C_1_4_1/D_06.000 prism 0 tetra_size 0.0 height  0.0 hratio 0.0 nlay 0 ratio 0.0 width 0.0 min 0.0 dev 0.0 color 15676283

 define_family C/C_2_5/C_2_5_1/D_04.000 prism 0 tetra_size 0.0 height  0.0 hratio 0.0 nlay 0 ratio 0.0 width 0.0 min 0.0 dev 0.0 color 14234528

 define_family GU/GU_KMP/WALL/D_16.000 prism 0 tetra_size 0.0 height  0.0 hratio 0.0 nlay 0 ratio 0.0 width 0.0 min 0.0 dev 0.0 color 5911547

 define_family GU/GU_KMP/WALL/D_02.000 prism 0 tetra_size 0.0 height  0.0 hratio 0.0 nlay 0 ratio 0.0 width 0.0 min 0.0 dev 0.0 color 3385555

 define_family GU/GU_KMP/WALL/D_04.000 prism 0 tetra_size 0.0 height  0.0 hratio 0.0 nlay 0 ratio 0.0 width 0.0 min 0.0 dev 0.0 color 15676283

 define_family GU/GU_KMP/WALL/D_08.000 prism 0 tetra_size 0.0 height  0.0 hratio 0.0 nlay 0 ratio 0.0 width 0.0 min 0.0 dev 0.0 color 5176627

 define_family C/C_1_4/C_1_4_1 prism 0 tetra_size 0.0 height  0.0 hratio 0.0 nlay 0 ratio 0.0 width 0.0 min 0.0 dev 0.0 color 0

 define_family C/C_1_4/C_1_4_2 prism 0 tetra_size 0.0 height  0.0 hratio 0.0 nlay 0 ratio 0.0 width 0.0 min 0.0 dev 0.0 color 0

 define_family C/C_1_5/C_1_5_1 prism 0 tetra_size 0.0 height  0.0 hratio 0.0 nlay 0 ratio 0.0 width 0.0 min 0.0 dev 0.0 color 0

 define_family C/C_2_5/C_2_5_1 prism 0 tetra_size 0.0 height  0.0 hratio 0.0 nlay 0 ratio 0.0 width 0.0 min 0.0 dev 0.0 color 0

 define_family GU/GU_GT prism 0 tetra_size 0.0 height  0.0 hratio 0.0 nlay 0 ratio 0.0 width 0.0 min 0.0 dev 0.0 color 0

 define_family GU/GU_GT/D_02.000 prism 0 tetra_size 0.0 height  0.0 hratio 0.0 nlay 0 ratio 0.0 width 0.0 min 0.0 dev 0.0 color 3735111

 define_family GU/GU_GT/D_04.000 prism 0 tetra_size 0.0 height  0.0 hratio 0.0 nlay 0 ratio 0.0 width 0.0 min 0.0 dev 0.0 color 7549939

 define_family GU/ZAV_2/OUT/WALL/D_04.000 prism 0 tetra_size 0.0 height  0.0 hratio 0.0 nlay 0 ratio 0.0 width 0.0 min 0.0 dev 0.0 color 3376107

 define_family C/C_2_4/C_2_4_1/D_16.000 prism 0 tetra_size 0.0 height  0.0 hratio 0.0 nlay 0 ratio 0.0 width 0.0 min 0.0 dev 0.0 color 3393972

 define_family C/C_2_4 prism 0 tetra_size 0.0 height  0.0 hratio 0.0 nlay 0 ratio 0.0 width 0.0 min 0.0 dev 0.0 color 0

 define_family C/C_2_4/C_2_4_1 prism 0 tetra_size 0.0 height  0.0 hratio 0.0 nlay 0 ratio 0.0 width 0.0 min 0.0 dev 0.0 color 0

 define_family C/C_2_3 prism 0 tetra_size 0.0 height  0.0 hratio 0.0 nlay 0 ratio 0.0 width 0.0 min 0.0 dev 0.0 color 9430323

 define_family C/C_2_3/C_2_3_1/C_2_3_1 prism 0 tetra_size 0.0 height  0.0 hratio 0.0 nlay 0 ratio 0.0 width 0.0 min 0.0 dev 0.0 color 3884286

 define_family C/C_2_3/C_2_3_1 prism 0 tetra_size 0.0 height  0.0 hratio 0.0 nlay 0 ratio 0.0 width 0.0 min 0.0 dev 0.0 color 0

 define_family B/GAS_2/D_08.000 prism 0 tetra_size 0.0 height  0.0 hratio 0.0 nlay 0 ratio 0.0 width 0.0 min 0.0 dev 0.0 color 13675571

 define_family B prism 0 tetra_size 0.0 height  0.0 hratio 0.0 nlay 0 ratio 0.0 width 0.0 min 0.0 dev 0.0 color 0

 define_family B/GAS_2 prism 0 tetra_size 0.0 height  0.0 hratio 0.0 nlay 0 ratio 0.0 width 0.0 min 0.0 dev 0.0 color 0

 define_family B/GAS_1 prism 0 tetra_size 0.0 height  0.0 hratio 0.0 nlay 0 ratio 0.0 width 0.0 min 0.0 dev 0.0 color 0

 define_family GU/GU_KMP/WALL/D_00.500 prism 0 tetra_size 0.0 height  0.0 hratio 0.0 nlay 0 ratio 0.0 width 0.0 min 0.0 dev 0.0 color 8336365

 define_family GU/G1/HOLES prism 0 tetra_size 0.0 height  0.0 hratio 0.0 nlay 0 ratio 0.0 width 0.0 min 0.0 dev 0.0 color 0

 define_family GU/G1/HOLES/D_07.000 prism 0 tetra_size 0.0 height  0.0 hratio 0.0 nlay 0 ratio 0.0 width 0.0 min 0.0 dev 0.0 color 5962547

 define_family GU/G1/WALL prism 0 tetra_size 0.0 height  0.0 hratio 0.0 nlay 0 ratio 0.0 width 0.0 min 0.0 dev 0.0 color 9122791

 define_family GU/G1/WALL/D_16.000 prism 0 tetra_size 0.0 height  0.0 hratio 0.0 nlay 0 ratio 0.0 width 0.0 min 0.0 dev 0.0 color 13644716

 define_family GU/G1/WALL/D_04.000 prism 0 tetra_size 0.0 height  0.0 hratio 0.0 nlay 0 ratio 0.0 width 0.0 min 0.0 dev 0.0 color 15694643

 define_family GU/G1/WALL/D_08.000 prism 0 tetra_size 0.0 height  0.0 hratio 0.0 nlay 0 ratio 0.0 width 0.0 min 0.0 dev 0.0 color 3396520

 define_family GU/G2/HOLES prism 0 tetra_size 0.0 height  0.0 hratio 0.0 nlay 0 ratio 0.0 width 0.0 min 0.0 dev 0.0 color 4652601

 define_family GU/G2/HOLES/D_15.000 prism 0 tetra_size 0.0 height  0.0 hratio 0.0 nlay 0 ratio 0.0 width 0.0 min 0.0 dev 0.0 color 3402627

 define_family GU/G2/WALL/D_01.000 prism 0 tetra_size 0.0 height  0.0 hratio 0.0 nlay 0 ratio 0.0 width 0.0 min 0.0 dev 0.0 color 11547597

 define_family GU/G2/WALL prism 0 tetra_size 0.0 height  0.0 hratio 0.0 nlay 0 ratio 0.0 width 0.0 min 0.0 dev 0.0 color 0

 define_family GU/G2/WALL/D_16.000 prism 0 tetra_size 0.0 height  0.0 hratio 0.0 nlay 0 ratio 0.0 width 0.0 min 0.0 dev 0.0 color 16659786

 define_family D_07.500 prism 0 tetra_size 0.0 height  0.0 hratio 0.0 nlay 0 ratio 0.0 width 0.0 min 0.0 dev 0.0 color 4980276

 define_family GU/G2/WALL/D_02.000 prism 0 tetra_size 0.0 height  0.0 hratio 0.0 nlay 0 ratio 0.0 width 0.0 min 0.0 dev 0.0 color 10802739

 define_family GU/ZAV_1/LOP prism 0 tetra_size 0.0 height  0.0 hratio 0.0 nlay 0 ratio 0.0 width 0.0 min 0.0 dev 0.0 color 0

 define_family GU/ZAV_1/LOP/R_IN prism 0 tetra_size 0.0 height  0.0 hratio 0.0 nlay 0 ratio 0.0 width 0.0 min 0.0 dev 0.0 color 0

 define_family GU/ZAV_1/IN/WALL prism 0 tetra_size 0.0 height  0.0 hratio 0.0 nlay 0 ratio 0.0 width 0.0 min 0.0 dev 0.0 color 0

 define_family GU/ZAV_1/LOP/PRES/D_04.000 prism 0 tetra_size 0.0 height  0.0 hratio 0.0 nlay 0 ratio 0.0 width 0.0 min 0.0 dev 0.0 color 13023027

 define_family GU/ZAV_1/LOP/PRES prism 0 tetra_size 0.0 height  0.0 hratio 0.0 nlay 0 ratio 0.0 width 0.0 min 0.0 dev 0.0 color 0

 define_family GU/ZAV_1/T prism 0 tetra_size 0.0 height  0.0 hratio 0.0 nlay 0 ratio 0.0 width 0.0 min 0.0 dev 0.0 color 0

 define_family GU/ZAV_2/LOP prism 0 tetra_size 0.0 height  0.0 hratio 0.0 nlay 0 ratio 0.0 width 0.0 min 0.0 dev 0.0 color 0

 define_family GU/ZAV_2/LOP/SUCT prism 0 tetra_size 0.0 height  0.0 hratio 0.0 nlay 0 ratio 0.0 width 0.0 min 0.0 dev 0.0 color 0

 define_family GU/ZAV_2/LOP/PRES/D_08.000 prism 0 tetra_size 0.0 height  0.0 hratio 0.0 nlay 0 ratio 0.0 width 0.0 min 0.0 dev 0.0 color 9168691

 define_family GU/ZAV_2/LOP/PRES prism 0 tetra_size 0.0 height  0.0 hratio 0.0 nlay 0 ratio 0.0 width 0.0 min 0.0 dev 0.0 color 0

 define_family GU/GU_KMP/WALL/D_01.000 prism 0 tetra_size 0.0 height  0.0 hratio 0.0 nlay 0 ratio 0.0 width 0.0 min 0.0 dev 0.0 color 13675571

 define_family GU/ZAV_2/IN/WALL/D_04.000 prism 0 tetra_size 0.0 height  0.0 hratio 0.0 nlay 0 ratio 0.0 width 0.0 min 0.0 dev 0.0 color 16084531

 define_family GU/GU_KMP/WALL prism 0 tetra_size 0.0 height  0.0 hratio 0.0 nlay 0 ratio 0.0 width 0.0 min 0.0 dev 0.0 color 0

 define_family D_02.00 prism 0 tetra_size 0.0 height  0.0 hratio 0.0 nlay 0 ratio 0.0 width 0.0 min 0.0 dev 0.0 color 9822515

 define_family GU/ZAV_2/OUT/WALL/D_02.000 prism 0 tetra_size 0.0 height  0.0 hratio 0.0 nlay 0 ratio 0.0 width 0.0 min 0.0 dev 0.0 color 11586867

 define_family GU/ZAV_2/IN/WALL prism 0 tetra_size 0.0 height  0.0 hratio 0.0 nlay 0 ratio 0.0 width 0.0 min 0.0 dev 0.0 color 0

 define_family GU/ZAV_2/OUT/WALL prism 0 tetra_size 0.0 height  0.0 hratio 0.0 nlay 0 ratio 0.0 width 0.0 min 0.0 dev 0.0 color 0

 define_family C/C_1_3/C_1_3_1/D_04.000 prism 0 tetra_size 0.0 height  0.0 hratio 0.0 nlay 0 ratio 0.0 width 0.0 min 0.0 dev 0.0 color 3385555

 define_family C/C_1_3 prism 0 tetra_size 0.0 height  0.0 hratio 0.0 nlay 0 ratio 0.0 width 0.0 min 0.0 dev 0.0 color 0

 define_family C/C_1_3/C_1_3_1 prism 0 tetra_size 0.0 height  0.0 hratio 0.0 nlay 0 ratio 0.0 width 0.0 min 0.0 dev 0.0 color 0

 define_family GU/COOL_1/HOLES prism 0 tetra_size 0.0 height  0.0 hratio 0.0 nlay 0 ratio 0.0 width 0.0 min 0.0 dev 0.0 color 0

 define_family GU/COOL_1/HOLES/D_01.200 prism 0 tetra_size 0.0 height  0.0 hratio 0.0 nlay 0 ratio 0.0 width 0.0 min 0.0 dev 0.0 color 7598899

 define_family GU/COOL_1/HOLES/D_01.500 prism 0 tetra_size 0.0 height  0.0 hratio 0.0 nlay 0 ratio 0.0 width 0.0 min 0.0 dev 0.0 color 3688446

 define_family GU/COOL_1/WALL prism 0 tetra_size 0.0 height  0.0 hratio 0.0 nlay 0 ratio 0.0 width 0.0 min 0.0 dev 0.0 color 0

 define_family GU/COOL_1/WALL/OUT prism 0 tetra_size 0.0 height  0.0 hratio 0.0 nlay 0 ratio 0.0 width 0.0 min 0.0 dev 0.0 color 0

 define_family GU/COOL_1/WALL/IN/D_04.000 prism 0 tetra_size 0.0 height  0.0 hratio 0.0 nlay 0 ratio 0.0 width 0.0 min 0.0 dev 0.0 color 12268482

 define_family GU/COOL_1/WALL/IN prism 0 tetra_size 0.0 height  0.0 hratio 0.0 nlay 0 ratio 0.0 width 0.0 min 0.0 dev 0.0 color 0

 define_family GU/COOL_1/WALL/OUT/D_02.000 prism 0 tetra_size 0.0 height  0.0 hratio 0.0 nlay 0 ratio 0.0 width 0.0 min 0.0 dev 0.0 color 10018611

 define_family GU/COOL_2/IN/WALL/D_04.000 prism 0 tetra_size 0.0 height  0.0 hratio 0.0 nlay 0 ratio 0.0 width 0.0 min 0.0 dev 0.0 color 3373808

 define_family GU/COOL_2/IN/WALL/D_16.000 prism 0 tetra_size 0.0 height  0.0 hratio 0.0 nlay 0 ratio 0.0 width 0.0 min 0.0 dev 0.0 color 9384933

 define_family GU/COOL_2/IN/WALL/D_02.000 prism 0 tetra_size 0.0 height  0.0 hratio 0.0 nlay 0 ratio 0.0 width 0.0 min 0.0 dev 0.0 color 8383795

 define_family GEOM prism 0 tetra_size 0.0 height  0.0 hratio 0.0 nlay 0 ratio 0.0 width 0.0 min 0.0 dev 0.0 color 16663866
)"
