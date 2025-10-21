;;;; /src/cfx/pre/nodgui/simulation.lisp

(in-package :mnas-ansys/cfx/pre/nodgui)

(defun simulation ()
  (nodgui:with-nodgui ()
    (let* (
           (toplevel nodgui:*tk*)
           (top (make-instance 'nodgui:frame :master toplevel)) ;; :width 500 :height 300
           (txt (make-instance 'nodgui:scrolled-text :master top :warp nil))
;;;; Menu
           (menubar (nodgui:make-menubar toplevel))
           (m-meshes (nodgui:make-menu menubar "Meshes"))
           (mesh-single (make-instance 'nodgui:menubutton
                                       :master m-meshes :text "One-by-one"
                                       :command (lambda () (meshes))))
           (mesh-template (make-instance 'nodgui:menubutton
                                         :master m-meshes :text "By templates"
                                         :command (lambda () (meshes-template))))
           (m-3d-regions (nodgui:make-menu menubar "3D-Regions"))
           (3d-regions-create  (make-instance 'nodgui:menubutton
                                              :master m-3d-regions
                                              :text "Сreate"
                                              :command (lambda () (3d-regions)))))
      (block top
        (block top-items
          (nodgui:grid txt 0 0 :sticky :nswe))
        (nodgui:grid-columnconfigure top 1 :weight 1)
        (nodgui:grid-rowconfigure top 1 :weight 1)
        (nodgui:pack top :side :top :fill :x)
        )
      (setf (nodgui:text txt)
              (format nil "~A" *simulation*))
)))

#+nil (simulation)
