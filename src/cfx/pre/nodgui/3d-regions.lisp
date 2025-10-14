(in-package :mnas-ansys/cfx/pre/nodgui)

(defun 3d-regions ()
  (unless *simulation*
    (setf *simulation* (make-instance 'mnas-ansys/cfx/pre:<simulation>)))
  (nodgui:with-nodgui ()
    (nodgui:wm-title nodgui:*tk* "3D-Regions Creation")
    (let* ((toplevel nodgui:*tk*)
;;;; FRAME
           (frame1   (make-instance 'nodgui:frame :master toplevel))
           (frame2   (make-instance 'nodgui:frame :master frame1))
;;;; BUTTON
           (create-button  (make-instance 'nodgui:button :master frame2 :text "Create"))
           (delete-button  (make-instance 'nodgui:button :master frame2 :text "Delete"))
;;;; LISTBOX
           (mesh-listbox      (make-instance 'nodgui:scrolled-listbox :master frame1))
           (3d-region-listbox (make-instance 'nodgui:scrolled-listbox :master frame1 :heght 20))) 
      (labels ((refresh ()
                 (nodgui:listbox-delete mesh-listbox)
                 (nodgui:listbox-append mesh-listbox
                                        (mnas-ansys/cfx/pre:ht-keys-sort
                                         (mnas-ansys/cfx/pre:<simulation>-meshes *simulation*)))
                 (nodgui:listbox-delete 3d-region-listbox)
                 (nodgui:listbox-append 3d-region-listbox
                                        (mnas-ansys/cfx/pre:ht-keys-sort
                                         (mnas-ansys/cfx/pre:<simulation>-3d-regions *simulation*))))
               (create-click ()
                 (loop :for i :in (nodgui:listbox-get-selection-value mesh-listbox)
                       :do (mnas-ansys/cfx/pre:add
                            (make-instance 'mnas-ansys/cfx/pre:<3d-region>
                                           :mesh (mnas-ansys/cfx/pre:mesh "G1" *simulation*))
                            *simulation*))
                 (refresh))
               (delete-click ()
                 (break "~A" (nodgui:listbox-get-selection-value 3d-region-listbox))
                 #+nil
                 (loop :for i :in (nodgui:listbox-get-selection-value 3d-region-listbox)
                       :do (remhash i (mnas-ansys/cfx/pre:<simulation>-meshes *simulation*)))
                 (refresh)))
;;;; Button command binding
        (setf (nodgui:command create-button)      #'create-click)
        (setf (nodgui:command delete-button)    #'delete-click) 
;;;; grid
;;;; grid frames
        (nodgui:grid frame1 0 0 :padx 5 :pady 5 :sticky :we)
;;;; grid listbox
        (nodgui:grid mesh-listbox       0 0 :sticky :we)
        (nodgui:grid frame2             1 0 :padx 5 :pady 5 :sticky :we)
        (nodgui:grid 3d-region-listbox  3 0 :sticky :we)

;;;; grid button
        (loop :for w :in (list create-button delete-button)
              :for i :from 0
              :do (nodgui:grid w 0 i :sticky :we))        
;;;; column/row-configure
        (loop :for w :in (list toplevel frame1 frame2)
              :do (nodgui:grid-columnconfigure w :all :weight 1)
                  (nodgui:grid-rowconfigure    w :all :weight 1))
        (refresh)))))

;; (3d-regions)

;;(mnas-ansys/cfx/pre:<simulation>-meshes *simulation*)
"//n142013/home/_namatv/ANSYS/CFX/a32/tin/DOM/*/A32_prj_05_D*.tin"
"//n142013/home/_namatv/ANSYS/CFX/a32/msh/prj_05/A32_prj_05_D*.msh"

#+nil
(progn
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

  (tin-select-button-click ()
                           (nodgui:listbox-append tin-listbox
                                                  (directory (nodgui:text tin-fname-entry))))
  (msh-add-button-click ()
                        (nodgui:listbox-append msh-listbox
                                               (directory (nodgui:text msh-fname-entry))))

  (setf (nodgui:command clean-button)      #'clean-click)
  (setf (nodgui:command add-button)        #'add-click)

  (setf (nodgui:command msh-fname-button)  #'msh-fname-button-click)
  (setf (nodgui:command tin-fname-button)  #'tin-fname-button-click)
  (setf (nodgui:command tin-select-button) #'tin-select-button-click)
  (setf (nodgui:command msh-add-button)    #'msh-add-button-click)

  )


(mnas-ansys/cfx/pre:add
 (make-instance 'mnas-ansys/cfx/pre:<3d-region>
                :mesh (mnas-ansys/cfx/pre:mesh "G1" *simulation*))
 *simulation*)
