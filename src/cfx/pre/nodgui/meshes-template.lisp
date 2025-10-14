(in-package :mnas-ansys/cfx/pre/nodgui)

(defun meshes-template ()
  (unless *simulation*
    (setf *simulation* (make-instance 'mnas-ansys/cfx/pre:<simulation>)))
  (nodgui:with-nodgui ()
    (nodgui:wm-title nodgui:*tk* "frame-example.lisp")
    (let* ((toplevel (make-instance 'nodgui:toplevel :master nil :title "Mesh Select"))
;;;; FRAME
           (frame1   (make-instance 'nodgui:frame :master toplevel))
           (frame1-l (make-instance 'nodgui:frame :master frame1))
           (frame1-r (make-instance 'nodgui:frame :master frame1))
           (frame2   (make-instance 'nodgui:frame :master toplevel))
           (frame3   (make-instance 'nodgui:frame :master toplevel))
;;;; TIN
           (tin-fname-entry  (make-instance 'nodgui:entry  :master frame1-l :width 80))
           (tin-fname-button (make-instance 'nodgui:button :master frame1-l :text "TIN-file ..." :width 15))
           (tin-select-button   (make-instance 'nodgui:button :master frame1-l :text "Select"    :width 15))
           (tin-listbox (make-instance 'nodgui:scrolled-listbox :master frame1-l))
;;;; MSH
           (msh-fname-entry  (make-instance 'nodgui:entry  :master frame1-r :width 80))
           (msh-fname-button (make-instance 'nodgui:button :master frame1-r :text "MSH-file ..." :width 15))
           (msh-add-button   (make-instance 'nodgui:button :master frame1-r :text "Select"       :width 15))
           (msh-listbox      (make-instance 'nodgui:scrolled-listbox :master frame1-r)) 
;;;; BUTTON
           (clean-button  (make-instance 'nodgui:button :master frame2 :text "Clean"))
           (delete-button (make-instance 'nodgui:button :master frame2 :text "Delete"))
           (add-button    (make-instance 'nodgui:button :master frame2 :text "Add"))
;;;; LISTBOX
           (mesh-listbox (make-instance 'nodgui:scrolled-listbox :master frame3))
           (progressbar  (make-instance 'nodgui:progressbar :master frame3))
           )      
      (labels ((refresh ()
                 (nodgui:listbox-delete mesh-listbox)
                 (nodgui:listbox-append mesh-listbox
                                        (mnas-ansys/cfx/pre:ht-keys-sort
                                         (mnas-ansys/cfx/pre:<simulation>-meshes *simulation*))))
               (add-click ()
                 (let ((tin (nodgui:listbox-all-values tin-listbox))
                       (msh (nodgui:listbox-all-values msh-listbox)))
                   (when (= (length tin) (length msh))
                     (loop :for tin-fname :in tin
                           :for msh-fname :in msh
                           :for i :from 1
                           :do
                              (let ((tin-pathname (probe-file tin-fname))
                                    (msh-pathname (probe-file msh-fname)))
                                (setf (nodgui:value progressbar)
                                      (floor (* i (/ 100 (length tin)))))
                                (when (and tin-pathname msh-pathname)
                                  (mnas-ansys/cfx/pre:add 
                                   (make-instance 'mnas-ansys/cfx/pre:<mesh>
                                                  :tin-pathname tin-pathname
                                                  :msh-pathname msh-pathname)
                                   *simulation*)
                                  (refresh)))))))
               (delete-click ()
                 (loop :for i :in (nodgui:listbox-get-selection-value mesh-listbox)
                       :do (remhash i (mnas-ansys/cfx/pre:<simulation>-meshes *simulation*)))
                 (refresh))
               (clean-click ()
                 (clrhash (mnas-ansys/cfx/pre:<simulation>-meshes *simulation*))
                 (refresh))
               (msh-fname-button-click ()
                 (let ((fname (nodgui:get-open-file
                               :file-types '(("MSH Files" "*.msh") ("All Files" "*")))))
                   (when fname
                     (setf (nodgui:text msh-fname-entry) fname))))
               (tin-fname-button-click ()
                 (let ((fname (nodgui:get-open-file
                               :file-types '(("MSH Files" "*.msh") ("All Files" "*")))))
                   (when fname
                     (setf (nodgui:text tin-fname-entry) fname))))
               (tin-select-button-click ()
                 (nodgui:listbox-append tin-listbox
                                        (directory (nodgui:text tin-fname-entry))))
               (msh-add-button-click ()
                 (nodgui:listbox-append msh-listbox
                                        (directory (nodgui:text msh-fname-entry)))))
;;;; Button command binding 
        (setf (nodgui:command clean-button)      #'clean-click)
        (setf (nodgui:command add-button)        #'add-click)
        (setf (nodgui:command delete-button)     #'delete-click)        
        (setf (nodgui:command msh-fname-button)  #'msh-fname-button-click)
        (setf (nodgui:command tin-fname-button)  #'tin-fname-button-click)
        (setf (nodgui:command tin-select-button) #'tin-select-button-click)
        (setf (nodgui:command msh-add-button)    #'msh-add-button-click)
;;;; grid
;;;; grid frames
        (nodgui:grid frame1 0 0 :padx 5 :pady 5 :sticky :we)
        (nodgui:grid frame2 1 0 :padx 5 :pady 5 :sticky :we)
        (nodgui:grid frame3 2 0 :padx 5 :pady 5 :sticky :we)

        (nodgui:grid frame1-l 0 0 :padx 5 :pady 5 :sticky :we)
        (nodgui:grid frame1-r 0 1 :padx 5 :pady 5 :sticky :we)        
;;;; frame1-l
        (nodgui:grid tin-fname-button 0 0 :sticky :we)
        (nodgui:grid tin-fname-entry  1 0 :sticky :we)
        (nodgui:grid tin-select-button 2 0 :sticky :we)
        (nodgui:grid tin-listbox      3 0 :sticky :we)
;;;; frame1-r
        (nodgui:grid msh-fname-button 0 0 :sticky :we)
        (nodgui:grid msh-fname-entry  1 0 :sticky :we)
        (nodgui:grid msh-add-button   2 0 :sticky :we)
        (nodgui:grid msh-listbox      3 0 :sticky :we)
;;;; grid button
        (loop :for w :in (list add-button delete-button clean-button)
              :for i :from 0
              :do (nodgui:grid w 0 i :sticky :we))
;;;; grid listbox
        (nodgui:grid mesh-listbox 0 0 :sticky :we)
        (nodgui:grid progressbar  1 0 :sticky :we)
;;;; column/row-configure
        (loop :for w :in (list toplevel frame1 frame1-l frame1-r frame2 frame3)
              :do (nodgui:grid-columnconfigure w :all :weight 1)
                  (nodgui:grid-rowconfigure    w :all :weight 1))
        
;;        (nodgui:grid-columnconfigure frame1 0 :weight 0)
        
        (refresh)))))

;; (meshes-template)

;;(mnas-ansys/cfx/pre:<simulation>-meshes *simulation*)
"//n142013/home/_namatv/ANSYS/CFX/a32/tin/DOM/*/A32_prj_05_D*.tin"
"//n142013/home/_namatv/ANSYS/CFX/a32/msh/prj_05/A32_prj_05_D*.msh"

#+nil
(progn

  )
