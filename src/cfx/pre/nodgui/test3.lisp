(ql:quickload '(:sdl2 :cl-opengl :cl-glut :cl-glu ))

(defun run-demo ()
  (sdl2:with-init (:everything)
    (sdl2:with-window (win :title "SDL2 + GLUT Teapot"
                           :w 800 :h 600
                           :flags '(:opengl :shown))
      (sdl2:with-gl-context (gl win)
        ;; Настройка OpenGL
        (gl:viewport 0 0 800 600)
        (gl:matrix-mode :projection)
        (gl:load-identity)
        (glu:perspective 45.0 (/ 800.0 600.0) 1.0 100.0)
        (gl:matrix-mode :modelview)
        (glut:init) 

        ;; Цикл событий
        (sdl2:with-event-loop (:method :poll)
          (:quit () t)
          (:idle ()
                 (gl:clear :color-buffer-bit :depth-buffer-bit)
                 (gl:load-identity)
                 
                 (gl:light :light0 :position '(0 1 1 0))
                 (gl:light :light0 :diffuse '(1.0 0.0 1.0 0))

                 (gl:material :front :ambient  '(0.2 0.2 0.2 1.0))
                 (gl:material :front :diffuse  '(0.2 0.6 1.0 1.0))
                 (gl:material :front :specular '(1.0 1.0 1.0 1.0))
                 (gl:material :front :shininess 80.0)

                 (gl:enable :depth-test)
                 (gl:enable :lighting)
                 (gl:enable :light0)

                 (gl:color 1.0 0.2 0.2)                 
                 
                 (gl:load-identity)

                 (gl:translate 0.0 0.0 -5.0)
                 ;(glut:solid-sphere 0.2 50 50)
            
                 (gl:rotate (mod (* (get-internal-real-time) (/ (* 1/10 360.0) internal-time-units-per-second)) 360.0) 0 1 0)

                 (glut:solid-teapot 0.2)

                 (gl:load-identity)

                 ;; Рисуем чайник GLUT
                 ;;(glut:solid-teapot 1.2)

                 (gl:translate 0.0 0.0 -5.0)
                 (gl:rotate (mod (* (get-internal-real-time) (/ (* 1/10 360.0) internal-time-units-per-second)) 360.0) 1 1 0)


                 (gl:material :front :ambient  '(0.2 0.2 0.2 1.0))
                 (gl:material :front :diffuse  '(0.6 1.0 0.20 1.0))
                 (gl:material :front :specular '(1.0 1.0 1.0 1.0))
                 (gl:material :front :shininess 80.0)
                 
                 
                                        ;(glut:solid-sphere 0.1 50 50)
                 (gl:translate 2.0 0.0 0.0)
                 (glut:solid-teapot 0.1)

                 (sdl2:gl-swap-window win)))))))

(run-demo)
