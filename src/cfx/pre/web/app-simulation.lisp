;;;; ./src/cfx/pre/web/app-simulation.lisp

(in-package #:mnas-ansys/cfx/pre/web)

(reblocks/app:defapp simulation
  :prefix "/apps1/simulation/"
  :routes ((page ("/" :name "simulation")
             (make-simulation-page))
           (page ("/meshes/" :name "simulation-meshes")
             (make-simulation-meshes-page))))

#+nil (restart-apps)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defclass mesh ()
  ((mesh :initarg :mesh
         :type mnas-ansys/cfx/pre:<mesh>
         :reader mesh-mesh)))

(defun make-mesh (mesh)
  (make-instance 'mesh :mesh mesh))

(defmethod reblocks/widget:render ((mesh mesh))
  (reblocks/html:with-html ()
    (:tr
     (:td (mnas-ansys/cfx/pre:<mesh>-name mesh))
     (:td (namestring
           (mnas-ansys/cfx/pre:<mesh>-tin-pathname mesh)))
     (:td (namestring
           (mnas-ansys/cfx/pre:<mesh>-msh-pathname mesh)))
     )))




   
#+nil (:p (:a :href "/apps/gosts/" "gosts"))

#+nil
mnas-ansys/cfx/pre::*simulation*

#+nil
(let ((simulation mnas-ansys/cfx/pre::*simulation*))
      (loop :for msh :in (mnas-ansys/cfx/pre:ht-keys-sort
                          (mnas-ansys/cfx/pre:<simulation>-meshes
                           simulation))
            :collect
            (list msh
                  (mnas-ansys/cfx/pre:<mesh>-3d-region-instance-number
                   (mnas-ansys/cfx/pre:mesh msh simulation)))))

#+nil
(mnas-ansys/cfx/pre:<mesh>-name msh)

#+nil
(let ((simulation mnas-ansys/cfx/pre::*simulation*))
  (namestring
   (mnas-ansys/cfx/pre:<mesh>-tin-pathname
   (mnas-ansys/cfx/pre:mesh "G1" simulation))))

#+nil
(mnas-ansys/cfx/pre:<mesh>-msh-pathname msh)
  
