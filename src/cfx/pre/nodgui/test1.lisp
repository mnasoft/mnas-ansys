(ql:quickload '(:sdl2 :cl-opengl))

(defpackage :sdl-3d-demo
  (:use :cl))

(in-package :sdl-3d-demo)

(defparameter *theta* 1.0)

(defun rdy ()
  (incf *theta* 0.01)
)
  
(defun rum-demo ()
  (sdl2:with-init (:everything)
    (sdl2:with-window (win :title "3d Points Demo"
                           :w 800 :h 600
                           :flags '(:opengl :shown))
    (sdl2:with-gl-context (gl win)
      (gl:viewport 0 0 800 600)
      (gl:matrix-mode :projection)
      (gl:load-identity)
      (gl:frustum -1 1 -1 1 0.1 100)
      (gl:matrix-mode :modelview)
      (let ((points '((0 0 -3) (1  1 5) (-1 -1 -4) (0.5 -0.5 -2))))
        (sdl2:with-event-loop (:method :poll)
          (:quit () t)
          (:idle ()
                 (gl:clear :color-buffer-bit :depth-buffer-bit)
                 (gl:load-identity)
                 (gl:rotate (rdy) 0 1 0)
                 ;;(mod (get-internal-real-time) 3600)
                 (gl:point-size 6.0)
                 (gl:begin :points)
                 (dolist (p points)
                   (destructuring-bind (x y z) p
                     (%gl:color-3f (/ (random 100) 100.0)
                                   (/ (random 100) 100.0)
                                   (/ (random 100) 100.0))
                     (%gl:vertex-3f x y z)))
                 (gl:end)
                 (sdl2:gl-swap-window win))))))))

(rum-demo)
