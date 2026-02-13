;;;; ./src/mesh/msh/test.lisp

(in-package :mnas-ansys/mesh-msh)

(defparameter *ltn*
  (asdf:system-source-directory :mnas-ansys/mesh-msh)
  (when *compile-file-truename* *compile-file-truename*))

(defun default-sample-msh-path ()
  (when *load-truename*
    (merge-pathnames "../sample/A32_prj_15_DM3.msh"
                     (make-pathname :name nil :type nil :defaults *load-truename*))))

(defun run-msh-sample-test (&optional (path (default-sample-msh-path)))
  (unless (and path (probe-file path))
    (error "Sample .msh file not found: ~a" path))
  (let* ((mesh (parse-msh-file path))
         (total-volume (msh-mesh-total-volume mesh))
         (surface-areas (msh-mesh-surface-areas mesh))
         (total-area (msh-mesh-total-surface-area mesh)))
    (format t "Mesh: ~a~%" path)
    (format t "Total volume: ~,6f~%" total-volume)
    (format t "Surface areas:~%")
    (dolist (pair surface-areas)
      (format t "  ~a: ~,6f~%" (car pair) (cdr pair)))
    (format t "Total surface area: ~,6f~%" total-area)
    (values mesh total-volume surface-areas total-area)))

#+nil (run-msh-sample-test)
#+nil (default-sample-msh-path)
