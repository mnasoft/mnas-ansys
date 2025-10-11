(defpackage #:mnas-ansys/cfx/pre/nodgui
  (:use #:cl)
  )

(in-package :mnas-ansys/cfx/pre/nodgui)

(defparameter *simulation* nil
  #+nil (make-instance '<simulation>)
  "Ссылка на объект смуляции.")

(defun main ()
  (unless *simulation*
    (setf *simulation* (make-instance 'mnas-ansys/cfx/pre:<simulation>)))
  (nodgui:with-nodgui ()
    (nodgui:wm-title nodgui:*tk* "frame-example.lisp")
    (let* ((toplevel
             (make-instance 'nodgui:toplevel
                            :width 200
                            :height 150
                            :title "Mesh Dialog"
                            :name "toplevel"
                            :master nil
                            ))
           (frame1 (make-instance 'nodgui:frame :master toplevel))
           (frame2 (make-instance 'nodgui:frame :master toplevel))
           (frame3 (make-instance 'nodgui:frame :master toplevel))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;           
           (tin-fname-entry (make-instance 'nodgui:entry
                                           :master frame1
                                           :width 40
                                           :name "tin-fname-entry"))
           (tin-fname-button
             (make-instance 'nodgui:button 
                            :master frame1
                            :text "Open TIN-file ..."
                            :width 20
                            :name "tin-fname-button"))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;                  
           (msh-fname-entry (make-instance 'nodgui:entry
                                           :master frame1
                                           :width 40
                                           :name "msh-fname-entry"))
           (msh-fname-button
             (make-instance 'nodgui:button 
                            :master frame1
                            :width 20
                            :text "Open MSH-file ..."
                            :name "msh-fname-button"))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
           (mesh-listbox (make-instance 'nodgui:scrolled-listbox
                                        :master frame3
                                        :width 160))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;           
           (ok-button (make-instance 'nodgui:button 
                                     :master frame2
                                     :width 20
                                     :text "Add"
                                     :name "ok-button"))
           (clean-button (make-instance 'nodgui:button 
                                        :master frame2
                                        :width 20
                                        :text "Clean"
                                        :name "clean-button")))
      (labels ((refresh  ()
                 (nodgui:listbox-delete mesh-listbox)
                 (nodgui:listbox-append mesh-listbox
                                        (mnas-ansys/cfx/pre:ht-keys-sort
                                         (mnas-ansys/cfx/pre:<simulation>-meshes *simulation*)))
                 )
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

        (setf (nodgui:command clean-button)     #'clean-click)
        (setf (nodgui:command ok-button)        #'add-click)
        (setf (nodgui:command msh-fname-button) #'msh-fname-button-click)
        (setf (nodgui:command tin-fname-button) #'tin-fname-button-click)
        
        (nodgui:grid frame1 0 0 :padx 5 :pady 5)
        (nodgui:grid frame2 1 0 :padx 5 :pady 5)
        (nodgui:grid frame3 2 0 :padx 5 :pady 5)
        
        (nodgui:grid tin-fname-button 0 0) (nodgui:grid tin-fname-entry  0 1)    
        (nodgui:grid msh-fname-button 1 0) (nodgui:grid msh-fname-entry  1 1)
        (nodgui:grid mesh-listbox 4 1)
        (nodgui:grid ok-button 5 1 :sticky :e)
        (nodgui:grid clean-button 5 0 :sticky :e)
        
        (refresh)

        ))))


;; (main)

    ;; Загружаем сетки 
;;    (mesh-add *simulation* tin-pathnames msh-pathnames))

#+nil
(progn
  (nodgui:name  tin-fname-entry)
  (nodgui:widget-path  toplevel)

  (parent (getf (nodgui:widget-path widget) :parent))


  :command

  #'(lambda ()
      (let ((tin-pathname (probe-file (nodgui:text tin-fname-entry)))
            (msh-pathname (probe-file (nodgui:text msh-fname-entry))))
        (when (and tin-pathname
                   msh-pathname)
          (mnas-ansys/cfx/pre:add
           (make-instance 'mnas-ansys/cfx/pre:<mesh>
                          :tin-pathname tin-pathname
                          :msh-pathname msh-pathname)
           *simulation*)
          (nodgui:listbox-delete  mesh-listbox)
          (nodgui:listbox-append mesh-listbox
                                 (mnas-ansys/cfx/pre:ht-keys-sort
                                  (mnas-ansys/cfx/pre:<simulation>-meshes *simulation*)))
          (format t "~A" *simulation*))))


  (mesh-add *simulation* tin-pathnames msh-pathnames)

  (nodgui:destroy toplevel)
  (nodgui:destroy nodgui:*tk*)


  (instanes-angle-label (make-instance 'nodgui:label
                                       :master frame1
                                       :width 20
                                       :text "Instanes Angle"
                                       :name "instanes-angle-label"))

  (instanes-angle-entry (make-instance 'nodgui:combobox
                                       :values '(36.0 -36.0 22.5 -22.5 18.0 -18.0) 
                                       :master frame1
                                       :text "-22.5"
                                       :width 10
                                       :name "instanes-angle-entry"))

  (nodgui:grid instanes-angle-label 3 0)
  (nodgui:grid instanes-angle-entry 3 1 :sticky :w)

  (instanes-number-label (make-instance 'nodgui:label
                                        :master frame1
                                        :width 20
                                        :text "Instanes Number"
                                        :name "instanes-number-label"))
  (instanes-number-entry (make-instance 'nodgui:spinbox
                                        :master frame1
                                        :from 1 :to 40
                                        :text "1"
                                        :width 10
                                        :name "instanes-number-entry"))
  (nodgui:grid instanes-number-label 2 0)
  (nodgui:grid instanes-number-entry 2 1 :sticky :w)
  )
