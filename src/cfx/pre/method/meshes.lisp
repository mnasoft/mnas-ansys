;;;; ./src/cfx/pre/test.lisp

(in-package :mnas-ansys/cfx/pre)

(defmethod meshes ((obj <meshes>))
  (sort 
   (alexandria:hash-table-keys (<meshes>-meshes obj))
   #'string<))


