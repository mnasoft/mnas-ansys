;;;;

"z:/ANSYS/CFX/a32/tin/DOM/*/A32_prj_05_D*.tin"
"z:/ANSYS/CFX/a32/msh/prj_05/A32_prj_05_D*.msh"

;;(mnas-ansys/cfx/pre:<simulation>-meshes *simulation*)

#+nil

(mnas-ansys/cfx/pre:add
 (make-instance 'mnas-ansys/cfx/pre:<3d-region>
                :mesh (mnas-ansys/cfx/pre:mesh "G1" *simulation*))
 *simulation*)
