(in-package :mnas-ansys/cfx/pre)

(require :nodgui)


(defun Feet-to-Metres ()
  (nodgui:with-nodgui ()
    (nodgui:wm-title nodgui:*tk* "Feet to Metres")                           
    (let ((content (make-instance 'nodgui:frame)))                    
      (nodgui:configure content :padding "3 3 12 12")                
      (nodgui:grid content 0 0 :sticky "nsew")
      (nodgui:grid-columnconfigure nodgui:*tk* 0 :weight 1)
      (nodgui:grid-rowconfigure nodgui:*tk* 0 :weight 1)

      (let* ((feet-entry (make-instance   'nodgui:entry   :master content :width 7))    
             (metres-label (make-instance 'nodgui:label :master content :text ""))
             (label-feet (make-instance   'nodgui:label   :master content :text "feet"))
             (label-eq-to (make-instance  'nodgui:label  :master content :text "is equivalent to"))
             (label-metres (make-instance 'nodgui:label :master content :text "metres")))
        (flet ((calculate ()                                                 
                 (let ((feet (read-from-string (nodgui:text feet-entry))))
                   (setf (nodgui:text metres-label)
                         (if (numberp feet)
                             (/ (round (* 0.3048 feet 10000.0)) 10000.0)
                             "")))))
          
          (nodgui:grid feet-entry   1 2 :sticky "we" :padx 5 :pady 5)                 
          (nodgui:grid label-feet   1 3 :sticky "w"  :padx 5 :pady 5)
          (nodgui:grid label-eq-to  2 1 :sticky "e"  :padx 5 :pady 5)
          (nodgui:grid metres-label 2 2 :sticky "we" :padx 5 :pady 5)
          (nodgui:grid label-metres 2 3 :sticky "w"  :padx 5 :pady 5)
          (nodgui:grid (make-instance  'nodgui:button :master content :text "Calculate" :command #'calculate)
                       3 3 :sticky "w"  :padx 5 :pady 5)
          (nodgui:focus feet-entry)                                                 
          (nodgui:bind nodgui:*tk* "<Return>" (lambda (evt) (calculate))))))
    ))

(defun Mesh-Edit ()
  (nodgui:with-nodgui ()
    (nodgui:wm-title nodgui:*tk* "Feet to Metres") 
    (let ((content (make-instance 'nodgui:frame))) 
      (nodgui:configure content :padding "3 3 12 12") 
      (nodgui:grid content 0 0 :sticky "nsew") 
      (nodgui:grid-columnconfigure nodgui:*tk* 0 :weight 1) 
      (nodgui:grid-rowconfigure nodgui:*tk* 0    :weight 1) 
      (let* ((entry-msh  (make-instance 'nodgui:entry  :master content :width 40)) 
             (button-msh (make-instance 'nodgui:button :master content :text "MSH"))
             (entry-tin  (make-instance 'nodgui:entry  :master content :width 40))
             (button-tin (make-instance 'nodgui:button :master content :text "TIN"))
             (entry-num  (make-instance 'nodgui:entry  :master content :width 10)) 
             (label-num  (make-instance 'nodgui:label  :master content :text "Number"))
             (entry-ang  (make-instance 'nodgui:entry  :master content :width 10)) 
             (label-ang  (make-instance 'nodgui:label  :master content :text "Angle"))
             (combo-num  (make-instance 'nodgui:combobox
                                        :master content
                                        :values '("Вариант 1" "Вариант 2" "Вариант 3")
                                        :width 20))
             )
        (flet ((calculate ()                                                 
                 (let ((txt (nodgui:text combo-num)))
                   (setf (nodgui:text entry-num) txt))))
          
          (nodgui:grid entry-msh    1 1 :sticky "we" :padx 5 :pady 5)                 
          (nodgui:grid button-msh   1 2 :sticky "w"  :padx 5 :pady 5)
          (nodgui:grid entry-tin    2 1 :sticky "e"  :padx 5 :pady 5)
          (nodgui:grid button-tin   2 2 :sticky "we" :padx 5 :pady 5)
          (nodgui:grid entry-num    3 1 :sticky "w"  :padx 5 :pady 5)
          (nodgui:grid label-num    3 2 :sticky "we" :padx 5 :pady 5)
          (nodgui:grid entry-ang    4 1 :sticky "w"  :padx 5 :pady 5)
          (nodgui:grid label-ang    4 2 :sticky "we" :padx 5 :pady 5)
          (nodgui:grid combo-num    5 1 :sticky "we" :padx 5 :pady 5)

          (nodgui:grid (make-instance  'nodgui:button :master content :text "Calculate" :command #'calculate)
                       5 3 :sticky "w"  :padx 5 :pady 5)

          (nodgui:configure button-msh
                            :command (lambda ()
                                       (let ((fname (nodgui:get-open-file
                                                     :title "Выберите файл"
                                                     :file-types '(("All Files" "*")
                                                                   ("MSH Files" "*.msh")))))
                                         (when fname (setf (nodgui:text entry-msh) fname)))))
          (nodgui:configure button-tin
                            :command (lambda ()
                                       (let ((fname (nodgui:get-open-file
                                                     :title "Выберите файл"
                                                     :file-types '(("All Files" "*")
                                                                   ("TIN Files" "*.tin")))))
                                         (when fname (setf (nodgui:text entry-tin) fname)))))
          
          (nodgui:focus entry-msh) 
          (nodgui:bind nodgui:*tk* "<Return>" (lambda (evt) (calculate))))))
    ))

(Mesh-Edit)
