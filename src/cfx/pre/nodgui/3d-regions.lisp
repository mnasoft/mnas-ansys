;;;; ,/src/cfx/pre/nodgui/3d-regions.lisp
(in-package :mnas-ansys/cfx/pre/nodgui)

(defun 3d-regions ()
  (unless *simulation*
    (setf *simulation* (make-instance 'mnas-ansys/cfx/pre:<simulation>)))
  (nodgui:with-nodgui ()
    (nodgui:wm-title nodgui:*tk* "3D-Regions Creation")
    (let* ((toplevel nodgui:*tk*)
;;;; FRAME
           (top   (make-instance 'nodgui:frame :master toplevel))
           (frame2   (make-instance 'nodgui:frame :master top))
;;;; BUTTON
           (create-button  (make-instance 'nodgui:button :master frame2 :text "Create"))
           (delete-button  (make-instance 'nodgui:button :master frame2 :text "Delete"))
;;;; LISTBOX
           (mesh-listbox      (make-instance 'nodgui:scrolled-listbox :master top  ))
           (3d-region-listbox (make-instance 'nodgui:scrolled-listbox :master top :heght 20))) 
      (labels ((refresh ()
                 (nodgui:listbox-delete mesh-listbox)
                 (nodgui:listbox-append mesh-listbox (meshes-to-strins-01))
                 (nodgui:listbox-delete 3d-region-listbox)
                 (nodgui:listbox-append 3d-region-listbox
                                        (mnas-ansys/cfx/pre:ht-keys-sort
                                         (mnas-ansys/cfx/pre:<simulation>-3d-regions *simulation*))))
               (create-click ()
                 (loop :for i :in (nodgui:listbox-get-selection-value mesh-listbox)
                       :do (mnas-ansys/cfx/pre:add
                            (make-instance 'mnas-ansys/cfx/pre:<3d-region>
                                           :mesh (mnas-ansys/cfx/pre:mesh i *simulation*))
                            *simulation*))
                 (refresh))
               (delete-click ()
                 (break "~A" (nodgui:listbox-get-selection-value 3d-region-listbox))
                 #+nil
                 (loop :for i :in (nodgui:listbox-get-selection-value 3d-region-listbox)
                       :do (remhash i (mnas-ansys/cfx/pre:<simulation>-meshes *simulation*)))
                 (refresh)))
;;;; Button command binding
        (setf (nodgui:command create-button) #'create-click)
        (setf (nodgui:command delete-button) #'delete-click) 
;;;; grid
;;;; grid frames
        (nodgui:grid top 0 0 :padx 5 :pady 5 :sticky :we)
;;;; grid listbox
        (nodgui:grid mesh-listbox       0 0 :sticky :we)
        (nodgui:grid frame2             1 0 :padx 5 :pady 5 :sticky :we)
        (nodgui:grid 3d-region-listbox  3 0 :sticky :we)

;;;; grid button
        (loop :for w :in (list create-button delete-button)
              :for i :from 0
              :do (nodgui:grid w 0 i :sticky :we))        
;;;; column/row-configure
        (loop :for w :in (list toplevel top frame2)
              :do (nodgui:grid-columnconfigure w :all :weight 1)
                  (nodgui:grid-rowconfigure    w :all :weight 1))
        (refresh)))))

;; (3d-regions)

