;;;; ./src/cfx/pre/test.lisp

(in-package :mnas-ansys/cfx/pre)

(defmethod select-3d-regions-by-mesh-name (mesh-name (simulation <simulation>))
  (sort
   (remove-if
    (complement (3d-region-with-mesh-name mesh-name))
    (ht-values (<simulation>-3d-regions simulation)))
    #'<
   :key #'<3d-region>-3d-suffix))

(defmethod select-3d-regions-name-by-mesh-name (mesh-name (simulation <simulation>))
  (mapcar #'name
          (select-3d-regions-by-mesh-name mesh-name simulation)))

(defmethod select-3d-regions-fluid ((simulation <simulation>))
  (remove-if-not
   #'(lambda (el)
       (uiop:string-prefix-p "DG" (name el)))
   (ht-values (<simulation>-3d-regions simulation))))

(defmethod simulation-fluid-domain-location ((simulation <simulation>))
  (format nil "~{~A~^,~}"
          (sort (mapcar #'name (select-3d-regions-fluid simulation))
                #'string<)))

(defmethod select-3d-regions-solid ((simulation <simulation>))
  (remove-if-not
   #'(lambda (el)
       (uiop:string-prefix-p "DM" (name el)))
   (ht-values (<simulation>-3d-regions simulation))))


(defmethod simulation-solid-domain-mesh-location (mesh-name (simulation <simulation>))
  (format nil "~{~A~^,~}"
          (select-3d-regions-name-by-mesh-name mesh-name simulation)))
