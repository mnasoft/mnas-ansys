;;;; ./src/cfx/pre/method/interface-pairs.lisp

(in-package :mnas-ansys/cfx/pre)

(defmethod interface-pairs ((mesh <mesh>))
  (remove-duplicates 
   (loop :for i :in (interfaces mesh)
         :collect
         (sort 
          (ppcre:split "-" (between-first-two-slashes i))
          #'string<))
   :test #'equal))

(defmethod interface-pairs ((simulation <simulation>))
  (remove-duplicates 
   (apply #'append
          (loop :for mesh :in (ht-values (<simulation>-meshes simulation))
                :collect
                (interface-pairs mesh)))
   :test #'equal))
