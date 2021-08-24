;;;; ./src/clim/clim.lisp

(defpackage #:mnas-ansys/clim
  (:use #:clim-lisp #:alexandria))

(in-package #:mnas-ansys/clim)

(clim:define-application-frame app ()
  ((a :initform 100 :accessor a)
   (b :initform 200 :accessor b))
  (:panes (app :application :display-function #'display)
          (int :interactor))
  (:layouts (default (clim:vertically ()
                       (2/3 app)
                       (1/3 int))))
  (:geometry :width 800 :height 400))



(defgeneric display (frame pane)
  (:method ((frame app) pane)
    (clim:draw-rectangle* pane
                          (a frame)
                          (b frame)
                          (+ 100 (a frame))
                          (+ 100 (b frame)))))

(defun run ()
  (let ((frame (clim:make-application-frame 'app)))
    (clim:run-frame-top-level frame)))
