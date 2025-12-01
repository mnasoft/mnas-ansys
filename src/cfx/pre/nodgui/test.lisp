;;;;


;;(mnas-ansys/cfx/pre:<simulation>-meshes *simulation*)

#+nil

(mnas-ansys/cfx/pre:add
 (make-instance 'mnas-ansys/cfx/pre:<3d-region>
                :mesh (mnas-ansys/cfx/pre:mesh "G1" *simulation*))
 *simulation*)

#+nil
(button (make-instance 'nodgui:button :text "get menu button value"
                                  :command
                                  (lambda ()
                                    (nodgui:message-box (format nil
                                                         "check-value ~a"
                                                         (nodgui:value ck-1))
                                                 "info"
                                                 nodgui:+message-box-type-ok+
                                                 nodgui:+message-box-icon-info+))))
(in-package :mnas-ansys/cfx/pre/nodgui)
(simulation)
"z:/ANSYS/CFX/a32/tin/DOM/*/A32_prj_05_D*.tin"  ;; Шаблон для задания имен tin-файлов
"z:/ANSYS/CFX/a32/msh/prj_05/A32_prj_05_D*.msh" ;; Шаблон для задания имен msh-файлов


(ql:quickload :mnas-ansys/cfx/pre/nodgui)

*simulation*
(mnas-ansys/cfx/pre:3d-region "DG1 G1 2" *simulation*)

(mnas-ansys/cfx/pre:<simulation>-3d-regions *simulation*)

(mnas-ansys/cfx/pre:3d-region "DG1 G1 2" *simulation*)
