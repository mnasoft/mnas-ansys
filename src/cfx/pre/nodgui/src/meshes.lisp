;;;; ./src/cfx/pre/nodgui/meshes.lisp

(in-package :mnas-ansys/cfx/pre/nodgui)

(defun meshes ()
  (unless *simulation*
    (setf *simulation* (make-instance 'mnas-ansys/cfx/pre:<simulation>)))
  (nodgui:with-nodgui ()
    (nodgui:wm-title nodgui:*tk* "Mesh Dialog")
    (let* ((toplevel nodgui:*tk*)
           (top     (make-instance 'nodgui:frame :master toplevel))
           (mid     (make-instance 'nodgui:frame :master toplevel))
           (bot     (make-instance 'nodgui:frame :master toplevel))
           (tin-btn (make-instance 'nodgui:button :master top :text "TIN-file ..." :width 15))
           (msh-btn (make-instance 'nodgui:button :master top :text " MSH-file ..." :width 15))
           (tin-ent (make-instance 'nodgui:entry  :master top :width 80))           
           (msh-ent (make-instance 'nodgui:entry  :master top :width 80))           
           (msh-lbx (make-instance 'nodgui:scrolled-listbox :master bot))
           (clr-btn (make-instance 'nodgui:button :master mid :text "Clean"))
           (del-btn (make-instance 'nodgui:button :master mid :text "Delete"))
           (add-btn (make-instance 'nodgui:button :master mid :text "Add")))
      (labels ((refresh ()
                 (nodgui:listbox-delete msh-lbx)
                 (nodgui:listbox-append msh-lbx (meshes-to-strins)))
               (add-btn-click ()
                 (let ((tin-pathname (probe-file (nodgui:text tin-ent)))
                       (msh-pathname (probe-file (nodgui:text msh-ent))))
                   (when (and (not (string= "" (nodgui:text tin-ent)))
                              (not (string= "" (nodgui:text msh-ent))) tin-pathname msh-pathname)
                     (mnas-ansys/cfx/pre:add
                      (make-instance 'mnas-ansys/cfx/pre:<mesh> :tin-pathname tin-pathname :msh-pathname msh-pathname)
                      *simulation*)
                     (refresh))))
               (del-btn-click ()
                 (loop :for i :in (nodgui:listbox-get-selection-value msh-lbx)
                       :do (remhash i (mnas-ansys/cfx/pre:<simulation>-meshes *simulation*)))
                 (refresh))
               (clr-btn-click ()
                 (clrhash (mnas-ansys/cfx/pre:<simulation>-meshes *simulation*))
                 (refresh))
               (msh-btn-click ()
                 (let ((fname (nodgui:get-open-file
                               :file-types
                               '(("MSH Files" "*.msh") ("All Files" "*")))))
                   (when fname
                     (setf (nodgui:text msh-ent) fname))))
               (tin-btn-click ()
                 (let ((fname (nodgui:get-open-file
                               :file-types
                               '(("TIN Files" "*.tin") ("All Files" "*") ))))
                   (when fname
                     (setf (nodgui:text tin-ent) fname)))))
        (block command
          (setf (nodgui:command clr-btn) #'clr-btn-click)
          (setf (nodgui:command add-btn) #'add-btn-click)
          (setf (nodgui:command del-btn) #'del-btn-click)        
          (setf (nodgui:command msh-btn) #'msh-btn-click)
          (setf (nodgui:command tin-btn) #'tin-btn-click))
        (block top
          (nodgui:grid tin-btn 0 0 :sticky :w)
          (nodgui:grid msh-btn 1 0 :sticky :w)        
          (nodgui:grid tin-ent 0 1 :sticky :ew)    
          (nodgui:grid msh-ent 1 1 :sticky :ew)
          (nodgui:grid-columnconfigure top 1 :weight 1)
          (nodgui:pack top :side :top :fill :x))
        (block mid
          (loop :for w :in (list add-btn del-btn clr-btn)
                :for i :from 0
                :do (nodgui:grid w 0 i :sticky :ew)
                    (nodgui:grid-columnconfigure mid i :weight 1))
          (nodgui:pack mid :side :top :fill :x))
        (block bot
          (nodgui:grid msh-lbx 0 0 :sticky :nsew)
          (nodgui:grid-rowconfigure bot 0 :weight 1)
          (nodgui:grid-columnconfigure bot 0 :weight 1)
          (nodgui:pack bot :side :top :fill :both :expand t))
        (refresh)))))

;; (meshes)
