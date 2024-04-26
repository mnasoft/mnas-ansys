(in-package :mnas-ansys/exchange)

(defparameter *res-fname*
  "//n133905/home/_namatv/CFX/n70/cfx/N70_prj_01/hot/prj_01_Tair_0_G1_17/rez-bak/N70_prj_01_Ne_10_Tair_0_D_FaS_Mesh_good_GTD_bad_CMB_FRCaED_002.res")

(read-res-file *res-fname*)

(defparameter *h-d* (read-res-file *res-fname*))

(setect-matches "USER POINT,T03" *h-d*)
(setect-matches "USER POINT,P02" *h-d*) 
(setect-matches "USER POINT,P03" *h-d*)

(length (setect-matches "GT1 M" *h-d*))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(setect-matches "GT[4] M T[0-9]*" *h-d*)
(setect-matches "GT[14] M T29" *h-d*)

(append
        (setect-matches "GT[14] M T[0-9]* p47i5"  *h-d*) ;; 47.5
        (setect-matches "GT[14] M T[0-9]* p69i5"  *h-d*) ;; 69.5
        (setect-matches "GT[14] M T[0-9]* p91i5"  *h-d*) ;; 91.5
        (setect-matches "GT[14] M T[0-9]* p113i5" *h-d*) ;; 113.5
        (setect-matches "GT[14] M T[0-9]* p135i5" *h-d*) ;; 135.5
        (setect-matches "GT[14] M T[0-9]* p157i5" *h-d*) ;; 157.5
        (setect-matches "GT[14] M T[0-9]* p179i5" *h-d*) ;; 179.5
        (setect-matches "GT[14] M T[0-9]* p201i5" *h-d*) ;; 201.5
        (setect-matches "GT[14] M T[0-9]* p225i5" *h-d*) ;; 225.5
        (setect-matches "GT[14] M T[0-9]* p249i5" *h-d*) ;; 249.5
        (setect-matches "GT[14] M T[0-9]* p273i5" *h-d*) ;; 273.5
        (append
               (setect-matches "GT1 M T4[5-9]" *h-d*)
               (setect-matches "GT1 M T5[0-2]" *h-d*)) ;; 330.0
        (append
               (setect-matches "GT4 M T4[1-8]" *h-d*)) ;; 359.5
        (append
               (setect-matches "GT1 M T5[3-9]" *h-d*)
               (setect-matches "GT1 M T60" *h-d*)
               (setect-matches "GT4 M T49" *h-d*)
               (setect-matches "GT4 M T5[0-6]" *h-d*))) ;; 426.0

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(average-value-from-headered-tabel "GT[14] M T[0-9]* p47i5" *h-d*)
 
(average-value-from-headered-tabel-by-col-names 
 (setect-matches "GT[14] M T[0-9]* p47i5" *h-d*) *h-d*)

(ave-max-average-value-from-headered-tabel-by-col-names
 330.0         (append
               (setect-matches "GT1 M T4[5-9]" *h-d*)
               (setect-matches "GT1 M T5[0-2]" *h-d*))
 *h-d*)

(average-value-from-headered-tabel-by-col-names
 (append
  (setect-matches "GT1 M T4[5-9]" *h-d*)
  (setect-matches "GT1 M T5[0-2]" *h-d*))
 *h-d*)

(average-values-from-headered-tabel
 '("USER POINT,T03" "USER POINT,P02" "USER POINT,P03")
 *h-d*)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

