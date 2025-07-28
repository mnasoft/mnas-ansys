;;;; ./src/cfx/pre/test.lisp

(in-package :mnas-ansys/cfx/pre)

(defparameter *simulation*
  (make-simulation "z:/ANSYS/CFX/a32/tin/DOM/*/A32_prj_06_*.tin"))

(map nil #'(lambda (el) (insert el *simulation*))
     '("G1" "G10" "G2" "G31" "G32" "G33" "G34" "G41" "G42" "G5" "G6" "G7" "G8" "G9" "M1" "M2" "M3"))

(progn ;; Возврат в исходное состояние
  (clrhash (<simulation>-domains  *simulation*))
  (clrhash (<simulation>-surfaces *simulation*)))

(<domain>-parent (domain "DG1 G1" *simulation*))
(meshes  *simulation*)

(and
 (check-equality *DG1-G1*   "DG1 G1")
 (check-equality *DG10-G10* "DG10 G10")
 (check-equality *DG2-G2*   "DG2 G2")
 (check-equality *DG31-G31* "DG31 G31")
 (check-equality *DG32-G32* "DG32 G32")
 (check-equality *DG33-G33* "DG33 G33")
 (check-equality *DG34-G34* "DG34 G34")
 (check-equality *DG41-G41* "DG41 G41")
 (check-equality *DG42-G42* "DG42 G42")
 (check-equality *DG5-G5*   "DG5 G5")
 (check-equality *DG6-G6*   "DG6 G6")
 (check-equality *DG7-G7*   "DG7 G7")

 (check-equality *DG8-G8*   "DG8 G8")
 (check-equality *DG9-G9*   "DG9 G9")

 (check-equality *DM1-M1*   "DM1 M1")
 (check-equality *DM2-M2*   "DM2 M2")
 (check-equality *DM3-M3*   "DM3 M3")
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; (check-equality *DG1-G1-2*   "DG1 G1 2")
;; (check-equality *DG2-G2-2*   "DG2 G2 2")
 )

;; <simulation>-icem-parts - исключить

(copy "DG1 G1" *simulation*)
(copy "DG2 G2" *simulation*)

'("DG1 G1"
  "DG2 G2"
  "DG31 G31"
  "DG32 G32"
  "DG33 G33"
  "DG34 G34"
  "DG41 G41"
  "DG42 G42"
  "DG5 G5"
  "DG9 G9"
  "DM1 M1"
  "DM2 M2"
  "DM3 M3")

*simulation*



(find-mesh-surface-by-domain-surface-name
 "DG1 M0 A_G1 SA 01 D_16.0"
 (domain "DG1 G1" *simulation*))



(let* ((ht (<domain>-surfaсes (domain "DG1 G1" *simulation*))))
  (loop :for i :in (alexandria:hash-table-keys ht)
        :collect
        (gethash i ht)
        ))





(surface-keys (domain "DG2 G2" *simulation*))

(mesh-name->domain-name "DG1/M0/KL/ST/OUT/01/D_1.0")


(alexandria:hash-table-keys  
 (<domain>-surfaсes (domain "DG1 G1" *simulation*)))




(meshes   (domain "DG1 G1" *simulation*))
"C/G1-G2/X_075.0/PPR_D_0.0"
  


(defmethod suffix (mesh-surface-name (simulation <simulation>))
  (loop :for d :in (domains simulation)
        :when (suffix mesh-surface-name (domain d simulation)) 
          :collect :it))

(suffix "C/G1-G2/X_075.0/PPR_D_0.0" *simulation*)
