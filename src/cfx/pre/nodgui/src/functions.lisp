;;;; ./src/cfx/pre/nodgui/functions.lisp

(in-package :mnas-ansys/cfx/pre/nodgui)

(defun meshes-to-strins ()
  (loop :for key :in (mnas-ansys/cfx/pre:ht-keys-sort
                       (mnas-ansys/cfx/pre:<simulation>-meshes *simulation*))
        :collect
        (let ((mesh (mnas-ansys/cfx/pre:mesh key *simulation*)))
          (format nil "~3A ~2A ~A ~A"
                         (mnas-ansys/cfx/pre:<mesh>-name mesh)
                         (mnas-ansys/cfx/pre:<mesh>-3d-region-instance-number mesh)
                         (mnas-ansys/cfx/pre:<mesh>-tin-pathname mesh)
                         (mnas-ansys/cfx/pre:<mesh>-msh-pathname mesh)))))

(defun meshes-to-strins-01 ()
  (mnas-ansys/cfx/pre:ht-keys-sort (mnas-ansys/cfx/pre:<simulation>-meshes *simulation*)))
