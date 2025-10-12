(in-package :mnas-ansys/cfx/pre/nodgui)

(defun meshes ()
  (unless *simulation*
    (setf *simulation* (make-instance 'mnas-ansys/cfx/pre:<simulation>)))
  (nodgui:with-nodgui ()
    (nodgui:wm-title nodgui:*tk* "frame-example.lisp")
    (let* ((toplevel (make-instance 'nodgui:toplevel :title "Mesh Dialog"
                                                     :name "toplevel"
                                                     :master nil))
           (frame1 (make-instance 'nodgui:frame :master toplevel))
           (frame2 (make-instance 'nodgui:frame :master toplevel))
           (frame3 (make-instance 'nodgui:frame :master toplevel))
;;;; TIN
           (tin-fname-button (make-instance 'nodgui:button :master frame1
                                                           :text "TIN-file ..."
                                                           :width 15
                                                           :name "tin-fname-button"))
           (tin-fname-entry (make-instance 'nodgui:entry :master frame1
                                                         :width 80
                                                         :name "tin-fname-entry"))
;;;; MSH
           (msh-fname-button
             (make-instance 'nodgui:button :master frame1
                                           :width 15
                                           :text " MSH-file ..."
                                           :name "msh-fname-button"))
           (msh-fname-entry (make-instance 'nodgui:entry
                                           :master frame1
                                           :width 80
                                           :name "msh-fname-entry"))           
;;;; LISTBOX
           (mesh-listbox (make-instance 'nodgui:scrolled-listbox :master frame3))
;;;; BUTTON
           (clean-button (make-instance 'nodgui:button :master frame2
                                        ;:width 20
                                        :text "Clean"
                                        :name "clean-button"))           
           (delete-button (make-instance 'nodgui:button :master frame2
                                        ;:width 20
                                         :text "Delete"
                                         :name "delete-button"))
           (add-button (make-instance 'nodgui:button :master frame2
                                        ;:width 20
                                      :text "Add"
                                      :name "add-button")))
      (labels ((refresh  ()
                 (nodgui:listbox-delete mesh-listbox)
                 (nodgui:listbox-append mesh-listbox
                                        (mnas-ansys/cfx/pre:ht-keys-sort
                                         (mnas-ansys/cfx/pre:<simulation>-meshes *simulation*))))
               (add-click ()
                 (let ((tin-pathname (probe-file (nodgui:text tin-fname-entry)))
                       (msh-pathname (probe-file (nodgui:text msh-fname-entry))))
                   (when (and
                          (not (string= "" (nodgui:text tin-fname-entry)))
                          (not (string= "" (nodgui:text msh-fname-entry)))
                          tin-pathname
                          msh-pathname)
                     (mnas-ansys/cfx/pre:add
                      (make-instance 'mnas-ansys/cfx/pre:<mesh>
                                     :tin-pathname tin-pathname
                                     :msh-pathname msh-pathname)
                      *simulation*)
                     (refresh))))
               (delete-click ()
                 (loop :for i :in (nodgui:listbox-get-selection-value mesh-listbox)
                       :do (remhash i (mnas-ansys/cfx/pre:<simulation>-meshes *simulation*)))
                 (refresh))
               (clean-click ()
                 (clrhash (mnas-ansys/cfx/pre:<simulation>-meshes *simulation*))
                 (refresh))
               (msh-fname-button-click ()
                 (let ((fname (nodgui:get-open-file )))
                   (when fname
                     (setf (nodgui:text msh-fname-entry) fname))))
               (tin-fname-button-click ()
                 (let ((fname (nodgui:get-open-file )))
                   (when fname
                     (setf (nodgui:text tin-fname-entry) fname)))))
;;;; Button command binding 
        (setf (nodgui:command clean-button)     #'clean-click)
        (setf (nodgui:command add-button)       #'add-click)
        (setf (nodgui:command delete-button)    #'delete-click)        
        (setf (nodgui:command msh-fname-button) #'msh-fname-button-click)
        (setf (nodgui:command tin-fname-button) #'tin-fname-button-click)
;;;; grid
;;;; grid frames
        (nodgui:grid frame1 0 0 :padx 5 :pady 5 :sticky :we)
        (nodgui:grid frame2 1 0 :padx 5 :pady 5 :sticky :we)
        (nodgui:grid frame3 2 0 :padx 5 :pady 5 :sticky :we)
;;;; grid button entry
        (nodgui:grid tin-fname-button 0 0 :sticky :we)
        (nodgui:grid tin-fname-entry  0 1 :sticky :we)    
        (nodgui:grid msh-fname-button 1 0 :sticky :we)
        (nodgui:grid msh-fname-entry  1 1 :sticky :we)
;;;; grid button
        (loop :for w :in (list add-button delete-button clean-button)
              :for i :from 0
              :do (nodgui:grid w 0 i :sticky :we))
;;;; grid listbox
        (nodgui:grid mesh-listbox 0 0 :sticky :we)
;;;; column/row-configure
        (loop :for w :in (list toplevel frame1 frame2 frame3)
              :do (nodgui:grid-columnconfigure w :all :weight 1)
                  (nodgui:grid-rowconfigure    w :all :weight 1))
        
        (nodgui:grid-columnconfigure frame1 0 :weight 0)
        
        (refresh)))))

;; (meshes)

(mnas-ansys/cfx/pre:<simulation>-meshes *simulation*)
