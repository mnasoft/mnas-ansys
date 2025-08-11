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
     (directory "~/work/tin/A32_prj_06_D*.tin"
                #+nil
                "z:/ANSYS/CFX/a32/tin/DOM/*/A32_prj_07_D*.tin")
     (directory "~/work/tin/A32_prj_06_D*.tin"
                #+nil "z:/ANSYS/CFX/a32/msh/prj_07/A32_prj_07_D*.msh")))

(progn
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
           (let ((msh (first msh-num))
                 (num (second msh-num)))
             (when (= num 2)
               (mk-mesh-rotation (format nil "D~A ~A 2" msh msh)
                                 "-22.5 [degree]"
                                 *simulation*))))
       *msh-num*))

*simulation*
(reset *simulation*)



;;;;
  (create-script *simulation* t)

(clrhash (<simulation>-3d-regions *simulation*))
(setf (<simulation>-commands *simulation*) nil)






