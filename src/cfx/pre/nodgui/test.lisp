(ql:quickload :nodgui)

(defpackage :three-frames-demo
  (:use :cl))
(in-package :three-frames-demo)

(defun make-form ()
  (nodgui:with-nodgui ()
    (nodgui:wm-title nodgui:*tk* "Three-frame form")
    ;; --- Первый фрейм (выбор файлов) ---
    (let* ((top (make-instance 'nodgui:frame :master nodgui:*tk*))
           (tin-var (make-instance 'nodgui:entry :master top))
           (msh-var (make-instance 'nodgui:entry :master top)))
      ;; *.tin
      (nodgui:grid (make-instance 'nodgui:button :master top
                                                 :text "Choose .tin" :width 12
                                                 :command (lambda ()
                                                            (let ((f (nodgui:get-open-file
                                                                      :file-types '(("TIN files" "*.tin")
                                                                                    ("All files" "*.*")))))
                                                              (when f
                                                                (setf (nodgui:text tin-var) f)))))
                   0 0 :padx 6 :pady 4 :sticky :w)
      (nodgui:grid (make-instance 'nodgui:entry :master top :textvariable tin-var :width 40)
                   0 1 :padx 6 :pady 4 :sticky :ew)

      ;; *.msh
      (nodgui:grid (make-instance 'nodgui:button :master top :text "Choose .msh" :width 12
                                                 :command (lambda ()
                                                            (let ((f (nodgui:get-open-file
                                                                      :file-types '(("MSH files" "*.msh")
                                                                                    ("All files" "*.*")))))
                                                              (when f
                                                                (setf (nodgui:text msh-var) f)))))
                   1 0 :padx 6 :pady 4 :sticky :w)
      (nodgui:grid (make-instance 'nodgui:entry :master top :textvariable msh-var :width 40)
                   1 1 :padx 6 :pady 4 :sticky :ew)


      ;; строки без веса → высота фиксирована
      (nodgui:pack top :side :top :fill :x)
      ;; второй столбец растягивается
      (nodgui:grid-columnconfigure top 1 :weight 1))

    ;; --- Второй фрейм (Add/Delete/Clean) ---
    (let ((mid (make-instance 'nodgui:frame :master nodgui:*tk*)))
      (nodgui:grid (make-instance 'nodgui:button
                                  :master mid :text "Add"
                                  :command (lambda () (format t "Add pressed~%")))
                   0 0 :sticky :ew :padx 4 :pady 4)
      (nodgui:grid (make-instance 'nodgui:button
                                  :master mid :text "Delete"
                                  :command (lambda () (format t "Delete pressed~%")))
                   0 1 :sticky :ew :padx 4 :pady 4)
      (nodgui:grid (make-instance 'nodgui:button
                                  :master mid :text "Clean"
                                  :command (lambda () (format t "Clean pressed~%")))
                   0 2 :sticky :ew :padx 4 :pady 4)
      ;; все три столбца растягиваются
      (dotimes (i 3) (nodgui:grid-columnconfigure mid i :weight 1))
      ;; строка без веса → высота фиксирована
      (nodgui:pack mid :side :top :fill :x))

    ;; --- Третий фрейм (листбокс + скроллбар) ---
    (let* ((bot (make-instance 'nodgui:frame :master nodgui:*tk*))
           (lb (make-instance 'nodgui:scrolled-listbox :master bot))) 
      (nodgui:grid lb 0 0 :sticky :nsew)
      ;; растягиваемость
      (nodgui:grid-rowconfigure bot 0 :weight 1)
      (nodgui:grid-columnconfigure bot 0 :weight 1)

      (nodgui:pack bot :side :top :fill :both :expand t))))

;; Запуск
(make-form)
