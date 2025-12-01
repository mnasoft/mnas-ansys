;;;; ./src/cfx/pre/nodgui/meshes-template.lisp

(in-package :mnas-ansys/cfx/pre/nodgui)

(defun meshes-template ()
  (unless *simulation*
    (setf *simulation* (make-instance 'mnas-ansys/cfx/pre:<simulation>)))
  (nodgui:with-nodgui ()
    (nodgui:wm-title nodgui:*tk* "Msh by Template")
    (let* ((toplevel nodgui:*tk*)
           (top (make-instance 'nodgui:frame :master toplevel))
           (t-l (make-instance 'nodgui:frame :master top))
           (tlu (make-instance 'nodgui:frame :master t-l))
           (tlb (make-instance 'nodgui:frame :master t-l))
           (t-r (make-instance 'nodgui:frame :master top))
           (tru (make-instance 'nodgui:frame :master t-r))
           (trb (make-instance 'nodgui:frame :master t-r))
           (mid (make-instance 'nodgui:frame :master toplevel))
           (bot (make-instance 'nodgui:frame :master toplevel))
;;;; TIN
           (tin-fnm-btn (make-instance 'nodgui:button :master tlu :text "TIN-file ..." :width 15))
           (tin-sel-btn (make-instance 'nodgui:button :master tlu :text "Select"       :width 15))
           (tin-cln-btn (make-instance 'nodgui:button :master tlu :text "Clean"        :width 15))
           (tin-fnm-ent (make-instance 'nodgui:entry  :master tlb :width 80))
           (tin-listbox (make-instance 'nodgui:scrolled-listbox :master tlb))
;;;; MSH
           (msh-fnm-btn (make-instance 'nodgui:button :master tru :text "MSH-file ..." :width 15))
           (msh-sel-btn (make-instance 'nodgui:button :master tru :text "Select"       :width 15))
           (msh-cln-btn (make-instance 'nodgui:button :master tru :text "Clean"        :width 15))
           (msh-fnm-ent (make-instance 'nodgui:entry  :master trb :width 80))
           (msh-listbox (make-instance 'nodgui:scrolled-listbox :master trb)) 
;;;; BUTTON
           (cln-button (make-instance 'nodgui:button :master mid :text "Clean"))
           (del-button (make-instance 'nodgui:button :master mid :text "Delete"))
           (add-button (make-instance 'nodgui:button :master mid :text "Add"))
;;;; LISTBOX
           (mesh-listbox (make-instance 'nodgui:scrolled-listbox :master bot))
           (progressbar  (make-instance 'nodgui:progressbar      :master bot))
           (statusbar    (make-instance 'nodgui:label            :master bot :text "Do some thing"))
           ) 
      (labels ((refresh ()
                 (nodgui:listbox-delete mesh-listbox)
                 (nodgui:listbox-append mesh-listbox (meshes-to-strins)))
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
                                (setf (nodgui:text statusbar) (format nil "Loading ~A ..." tin-fname))

                                (when (and tin-pathname msh-pathname)
                                  (mnas-ansys/cfx/pre:add 
                                   (make-instance 'mnas-ansys/cfx/pre:<mesh>
                                                  :tin-pathname tin-pathname
                                                  :msh-pathname msh-pathname)
                                   *simulation*)
                                  (refresh)))))
                     (setf (nodgui:text statusbar) "Meshes Loaded")
                     ))
               (delete-click ()
                 (loop :for i :in (nodgui:listbox-get-selection-value mesh-listbox)
                       :do (remhash i (mnas-ansys/cfx/pre:<simulation>-meshes *simulation*)))
                 (refresh))
               (clean-click ()
                 (clrhash (mnas-ansys/cfx/pre:<simulation>-meshes *simulation*))
                 (refresh))
               (msh-fnm-click ()
                 (let ((fname (nodgui:get-open-file
                               :file-types '(("MSH Files" "*.msh") ("All Files" "*")))))
                   (when fname
                     (setf (nodgui:text msh-fnm-ent) fname))))
               (tin-fnm-click ()
                 (let ((fname (nodgui:get-open-file
                               :file-types '(("MSH Files" "*.msh") ("All Files" "*")))))
                   (when fname
                     (setf (nodgui:text tin-fnm-ent) fname))))
               (tin-sel-click () (nodgui:listbox-append tin-listbox (directory (nodgui:text tin-fnm-ent))))
               (msh-sel-click () (nodgui:listbox-append msh-listbox (directory (nodgui:text msh-fnm-ent))))
               (msh-cln-click () (nodgui:listbox-delete msh-listbox))
               (tin-cln-click () (nodgui:listbox-delete tin-listbox)))
        (block command
          (setf (nodgui:command cln-button)  #'clean-click)
          (setf (nodgui:command add-button)  #'add-click)
          (setf (nodgui:command del-button)  #'delete-click)        
          (setf (nodgui:command msh-fnm-btn) #'msh-fnm-click)
          (setf (nodgui:command tin-fnm-btn) #'tin-fnm-click)
          (setf (nodgui:command tin-sel-btn) #'tin-sel-click)
          (setf (nodgui:command tin-cln-btn) #'tin-cln-click)
          (setf (nodgui:command msh-sel-btn) #'msh-sel-click)
          (setf (nodgui:command msh-cln-btn) #'msh-cln-click))
        (block grid-pack
          (block top
            (block t-l
              (block tlu
                (block tlu-items
                  (nodgui:grid tin-fnm-btn 0 0 :sticky :we)
                  (nodgui:grid tin-sel-btn 0 1 :sticky :we)
                  (nodgui:grid tin-cln-btn 0 2 :sticky :we))
                (nodgui:grid-columnconfigure tlu :all :weight 1)
                (nodgui:grid tlu 0 0 :padx 5 :pady 5 :sticky :we))
              (block tlb
                (block tlb-items
                  (nodgui:grid tin-fnm-ent 0 0 :sticky :we)
                  (nodgui:grid tin-listbox 1 0 :sticky :we))
                (nodgui:grid-columnconfigure tlb :all :weight 1)
                (nodgui:grid tlb 1 0 :padx 5 :pady 5 :sticky :we))
              (nodgui:grid-columnconfigure t-l :all :weight 1)
              (nodgui:grid t-l 0 0 :padx 5 :pady 5 :sticky :we))
            (block t-r
              (block tru
                (block tru-items
                  (nodgui:grid msh-fnm-btn 0 0 :sticky :we)
                  (nodgui:grid msh-sel-btn 0 1 :sticky :we)
                  (nodgui:grid msh-cln-btn 0 2 :sticky :we))
                (nodgui:grid-columnconfigure tru :all :weight 1)
                (nodgui:grid tru 0 0 :padx 5 :pady 5 :sticky :we))
              (block trb
                (block trb-items
                  (nodgui:grid msh-fnm-ent  0 0 :sticky :we)
                  (nodgui:grid msh-listbox  1 0 :sticky :we))
                (nodgui:grid-columnconfigure trb :all :weight 1)
                (nodgui:grid trb 1 0 :padx 5 :pady 5 :sticky :we))
              (nodgui:grid-columnconfigure t-r :all :weight 1)
              (nodgui:grid t-r 0 1 :padx 5 :pady 5 :sticky :we))
            (nodgui:grid-columnconfigure top :all :weight 1)
            (nodgui:pack top :side :top :fill :x))
          (block mid
            (block mid-items
              (loop :for w :in (list add-button del-button cln-button)
                    :for i :from 0
                    :do (nodgui:grid w 0 i :sticky :we)))
            (nodgui:grid-columnconfigure mid :all :weight 1)
            (nodgui:pack mid :side :top :fill :x))
          (block bot
            (block bot-items
              (nodgui:grid mesh-listbox 0 0 :sticky :nswe)
              (nodgui:grid progressbar  1 0 :sticky :we)
              (nodgui:grid statusbar    2 0 :sticky :we)
              )
            (nodgui:grid-columnconfigure bot 0 :weight 1)          
            (nodgui:grid-rowconfigure    bot 0 :weight 1)
            (nodgui:pack bot :side :top :fill :both :expand t)))
        (refresh)))))

;; (meshes-template)

