;;;; /src/cfx/pre/nodgui/simulation.lisp

(in-package :mnas-ansys/cfx/pre/nodgui)

(defun simulation ()
  (nodgui:with-nodgui ()
    (let* ((menubar (nodgui:make-menubar))
           (m-meshes (nodgui:make-menu menubar "Meshes"))
           (mesh-single (make-instance 'nodgui:menubutton
                                :master m-meshes :text "One-by-one"
                                :command (lambda () (meshes))))
           (mesh-template (make-instance 'nodgui:menubutton
                                :master m-meshes :text "By templates"
                                :command (lambda () (meshes-template))))
           (m-3d-regions (nodgui:make-menu menubar "3D-Regions"))
           (ck-3 (make-instance 'nodgui:menubutton
                                :master m-3d-regions
                                :text "Сreate"
                                :command (lambda () (3d-regions)))))
      #+nil
      (nodgui:pack button))))

#+nil (simulation)


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




