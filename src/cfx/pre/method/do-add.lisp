;;;; ./src/cfx/pre/method/do-add.lisp

(in-package :mnas-ansys/cfx/pre)

(defmethod do-add ((3d-region string) (simulation <simulation>))
  (gtmImport (namestring (<mesh>-msh-pathname
                          (<3d-region>-mesh
                           (3d-region 3d-region simulation))))
             :genopt "-n")
  (gtmAction-rename-Region
   (name-old (3d-region 3d-region simulation))
   (name (3d-region 3d-region simulation)))
  (loop :for key :in (ht-keys-sort
                      (<mesh>-2d-regions
                       (<3d-region>-mesh
                        (3d-region 3d-region simulation))))
        :do (let ((val (gethash key (<mesh>-2d-regions
                                     (<3d-region>-mesh
                                      (3d-region 3d-region simulation))))))
              (gtmAction-rename-Region
               val
               (format nil "~A ~A" val
                       (<3d-region>-2d-suffix (3d-region 3d-region simulation)))))))
