;;;; ./src/cfx/pre/method/2d-region.lisp

(in-package :mnas-ansys/cfx/pre)

(defmethod 2d-region (key (mesh <mesh>))
  (gethash key (<mesh>-2d-regions mesh)))

(defmethod 2d-regions ((3d-region <3d-region>))
  "
 @b(Пример использования:)
@begin[lang=lisp](code)
 (2d-regions (second (select-3d-regions-by-mesh-name \"G2\" *simulation*)))
@end(code)
"
  (loop :for 2d-region
          :in (ht-values
               (<mesh>-2d-regions
                (<3d-region>-mesh 3d-region)))
        :collect (format nil "~A ~A"
                         2d-region
                         (<3d-region>-2d-suffix 3d-region))))

(defmethod 2d-regions ((seq sequence))
  (apply #'append
         (loop :for i :across (coerce seq 'vector)
               :collect
               (2d-regions i))))
