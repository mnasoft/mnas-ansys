;;;; ./src/cfx/pre/web/start-stop.lisp

(in-package #:mnas-ansys/cfx/pre/web)

(defun start-apps (&key (port 8081))
  (reblocks/server:start :port port
                         :apps '(hw simulation)))

(defun stop-apps ()
  (reblocks/server:stop)
  )

(defun restart-apps ()
  (progn (stop-apps) (start-apps)))

#+nil (start-apps)
#+nil (stop-apps)
#+nil (restart-apps)
