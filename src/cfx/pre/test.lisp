;;;; ./src/cfx/pre/test.lisp

(in-package :mnas-ansys/cfx/pre)

(progn 
  (defparameter *simulation*
    (make-instance '<simulation>))

  (defparameter *msh-num*
    '(("G1"  2)
      ("G10" 1)
      ("G2"  2)
      ("G31" 2)
      ("G32" 2)
      ("G33" 2)
      ("G34" 2)
      ("G41" 2)
      ("G42" 2)
      ("G5"  2)
      ("G6"  1)
      ("G7"  1)
      ("G8"  1)
      ("G9"  2)
      ("M1"  2)
      ("M2"  2)
      ("M3"  2)))

  (map nil
     #'(lambda (tin msh)
         (add (make-instance '<mesh>
                             :tin-pathname tin 
                             :msh-pathname msh)
              *simulation*))
     (directory "z:/ANSYS/CFX/a32/tin/DOM/*/A32_prj_07_D*.tin")
     (directory "z:/ANSYS/CFX/a32/msh/prj_07/A32_prj_07_D*.msh")))

(map nil
     #'(lambda (msh-num)
         (loop :for i :from 0 :below (second msh-num)
               :do
                  (add
                   (make-instance '<3d-region>
                                  :mesh (mesh (first msh-num) *simulation*))
                   *simulation*)))
     *msh-num*)

(map nil
     #'(lambda (msh-num)
         (mk-mesh-rotation "DG31 G31 2" "-22.5 [degree]" *simulation*))
     *msh-num*)

(format nil "~A" msh)

  (mk-mesh-rotation "DG31 G31 2" "-22.5 [degree]" *simulation*)
  (mk-mesh-rotation "DG32 G32 2" "-22.5 [degree]" *simulation*)
  (mk-mesh-rotation "DG33 G33 2" "-22.5 [degree]" *simulation*)
  (mk-mesh-rotation "DG32 G34 2" "-22.5 [degree]" *simulation*)

  (mk-mesh-rotation "DG41 G41 2" "-22.5 [degree]" *simulation*)
  (mk-mesh-rotation "DG42 G42 2" "-22.5 [degree]" *simulation*)  
  
  (mk-mesh-rotation "DG9 G9 2" "-22.5 [degree]" *simulation*)
  
;;;;
  (create-script *simulation* t))




(defmacro mk-mesh-rotation (Target-Location Rotation-Angle simulation)
  `(add (make-instance '<simulation-mesh-transformation>
                      :mesh-transformation (make-instance 'mnas-ansys/ccl/core:<mesh-transformation>
                                                          :Target-Location ,Target-Location
                                                          :Use-Multiple-Copy "Off"
                                                          :Delete-Original nil
                                                          :Glue-Copied "On"
                                                          :Glue-Reflected "On"
                                                          :Number-of-Copies nil
                                                          :Rotation-Angle ,Rotation-Angle))
        ,simulation))



