;;;; ./src/cfx/pre/web/methods/defwidget.lisp

(in-package #:mnas-ansys/cfx/pre/web)

(reblocks/widget:defwidget hw-page ()
  ())
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defclass <mesh-id> ()
  ((id   :initarg :id
         :initform (error "Field ID is required")
         :type integer
         :reader <mesh-id>-id
         :documentation "id integer NO")
   (mesh :initarg :mesh
         :type mnas-ansys/cfx/pre:<mesh>
         :reader <mesh-id>-mesh)))

(defun make-<mesh-id> (id mesh)
  (make-instance '<mesh-id> :id id :mesh mesh))

(defun make-<mesh-item> (id mesh)
  (make-instance '<mesh-item> :mesh (make-<mesh-id> id mesh)))

(defparameter *mesh-g1*  
  (mnas-ansys/cfx/pre:mesh "G1"
                           (mnas-ansys/cfx/pre:<simulation>-meshes
                            mnas-ansys/cfx/pre::*simulation*)))

(make-<mesh-id>   0 *mesh-g1*)
(make-<mesh-item> 0 *mesh-g1*)

(defparameter *m-id*
  (make-instance '<mesh-id>
                 :id 0
                 :mesh ))

(reblocks/widget:defwidget <mesh-item> ()
  ((mesh 
    :initarg  :mesh
    :type     <mesh-id>
    :accessor <mesh-item>-mesh)))

(reblocks/widget:defwidget <mesh-page> ()
  ((mesh 
    :initarg  :mesh
    :type     <mesh-id>
    :accessor <mesh-page>-mesh)))

(defun make-<mesh-page> (id mesh)
  (make-instance '<mesh-page> :mesh (make-<mesh-id> id mesh)))

(make-<mesh-page> 0 *mesh-g1*)





;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(reblocks/widget:defwidget <mesh-list> ()
  ((items
    :initarg :items
    :type     (soft-list-of <mesh-item>)
    :accessor gost-list-items)))

(defun make-<mesh-list> (items)
  (make-instance '<mesh-list> :items items))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(reblocks/widget:defwidget simulation-page ()
  ((simulation
    :initarg :simulation
    :initform (error "Field simulation is required")
    :accessor <simulation-page>-simulation
    :type mnas-ansys/cfx/pre:<simulation>
    :documentation "id integer NO")
   (meshes
    :accessor <simulation-page>-meshes
    :type (soft-list-of <mesh-item>)
    :documentation "id integer NO")
   ))

(defun make-simulation-page ()
      (make-instance 'simulation-page :simulation mnas-ansys/cfx/pre::*simulation*))

(reblocks/widget:defwidget simulation-meshes-page ()
  ())

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

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
