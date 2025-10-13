(in-package :mnas-ansys/cfx/pre/nodgui)

(defun demo-menu-check-buttons ()
  (nodgui:with-nodgui ()
    (let* ((mb (nodgui:make-menubar))
           (mfile (nodgui:make-menu mb "File" ))
           (ck-1 (make-instance 'nodgui:menucheckbutton
                                :master mfile
                                :text "Check 1"))
           (button (make-instance 'nodgui:button
                                  :text "get menu button value"
                                  :command
                                  (lambda ()
                                    (nodgui:message-box (format nil
                                                         "check-value ~a"
                                                         (nodgui:value ck-1))
                                                 "info"
                                                 nodgui:+message-box-type-ok+
                                                 nodgui:+message-box-icon-info+)))))
      (nodgui:pack button))))

(defun simulation ()
  (nodgui:with-nodgui ()
    (let* ((menubar (nodgui:make-menubar))
           (m-meshes (nodgui:make-menu menubar "Meshes"))
           (ck-2 (make-instance 'nodgui:menubutton
                                :master m-meshes :text "One-by-one"
                                :command
                                (lambda ()
                                  (meshes))))
           (ck-1 (make-instance 'nodgui:menucheckbutton 
                                :master m-meshes :text "By templates"))
           (m-3d-regions (nodgui:make-menu menubar "3D-Regions"))
           (ck-3 (make-instance 'nodgui:menubutton :master m-3d-regions :text "Сreate"))
           (button (make-instance 'nodgui:button :text "get menu button value"
                                  :command
                                  (lambda ()
                                    (nodgui:message-box (format nil
                                                         "check-value ~a"
                                                         (nodgui:value ck-1))
                                                 "info"
                                                 nodgui:+message-box-type-ok+
                                                 nodgui:+message-box-icon-info+)))))
      (nodgui:pack button))))

(simulation)
