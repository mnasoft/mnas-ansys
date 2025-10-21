;;;; ,/src/cfx/pre/nodgui/3d-regions.lisp
(in-package :mnas-ansys/cfx/pre/nodgui)

(defun 3d-regions ()
  (unless *simulation*
    (setf *simulation* (make-instance 'mnas-ansys/cfx/pre:<simulation>)))
  (nodgui:with-nodgui ()
    (nodgui:wm-title nodgui:*tk* "3D-Regions Creation")
    (let* ((toplevel nodgui:*tk*)
           (top           (make-instance 'nodgui:frame  :master toplevel))
           (msh-lb  (make-instance 'nodgui:scrolled-listbox :master top))
           (mid           (make-instance 'nodgui:frame  :master toplevel))
           (add-btn (make-instance 'nodgui:button :master mid :text "Create"))
           (del-btn (make-instance 'nodgui:button :master mid :text "Delete"))
           (bot           (make-instance 'nodgui:frame  :master toplevel))
           (3dr-lb (make-instance 'nodgui:scrolled-listbox :master bot))) 
      (labels ((refresh ()
                 (nodgui:listbox-delete msh-lb)
                 (nodgui:listbox-append msh-lb (meshes-to-strins-01))
                 (nodgui:listbox-delete 3dr-lb)
                 (nodgui:listbox-append 3dr-lb
                                        (mnas-ansys/cfx/pre:ht-keys-sort
                                         (mnas-ansys/cfx/pre:<simulation>-3d-regions *simulation*))))
               (create-click ()
                 (loop :for i :in (nodgui:listbox-get-selection-value msh-lb)
                       :do (mnas-ansys/cfx/pre:add
                            (make-instance 'mnas-ansys/cfx/pre:<3d-region>
                                           :mesh (mnas-ansys/cfx/pre:mesh i *simulation*))
                            *simulation*))
                 (refresh))
               (delete-click ()
                 (break "~A" (nodgui:listbox-get-selection-value 3dr-lb))
                 #+nil
                 (loop :for i :in (nodgui:listbox-get-selection-value 3dr-lb)
                       :do (remhash i (mnas-ansys/cfx/pre:<simulation>-meshes *simulation*)))
                 (refresh)))
        
        (block command-binding
          (setf (nodgui:command add-btn) #'create-click)
          (setf (nodgui:command del-btn) #'delete-click))

;;;; grid listbox
        (nodgui:grid msh-lb       0 0 :sticky :we)
        
        (nodgui:grid 3dr-lb  3 0 :sticky :we)

;;;; grid button
                
;;;; column/row-configure
        (loop :for w :in (list toplevel top mid)
              :do (nodgui:grid-columnconfigure w :all :weight 1)
                  (nodgui:grid-rowconfigure    w :all :weight 1))
        (block grid-pack
          (block top
            (block top-items
              (nodgui:grid msh-lb 0 0 :sticky :nswe))
            (nodgui:grid-columnconfigure top 0 :weight 1)          
            (nodgui:grid-rowconfigure    top 0 :weight 1)
            (nodgui:pack top :side :top :fill :both :expand t)
            #+nil
                    (nodgui:grid top 0 0 :padx 5 :pady 5 :sticky :we))
          (block mid
            (block mid-items
              (loop :for w :in (list add-btn del-btn)
              :for i :from 0
                    :do (nodgui:grid w 0 i :sticky :we)))
            (nodgui:pack mid :side :top :fill :x)
            #+nil (nodgui:grid mid          1 0 :padx 5 :pady 5 :sticky :we))
          (block bot
            (block bot-items
              (nodgui:grid 3dr-lb 0 0 :sticky :nswe))
            (nodgui:grid-columnconfigure bot 0 :weight 1)          
            (nodgui:grid-rowconfigure    bot 0 :weight 1)
            (nodgui:pack bot :side :top :fill :both :expand t)))
        (refresh)))))

;; (3d-regions)
