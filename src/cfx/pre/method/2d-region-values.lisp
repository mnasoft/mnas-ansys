;;;; ./src/cfx/pre/method/2d-region-values.lisp

(in-package :mnas-ansys/cfx/pre)

(defmethod 2d-region-values ((seq sequence))
  (apply #'append
         (loop :for i :across (coerce seq 'vector)
               :collect
               (2d-region-values i))))

(defmethod 2d-region-values ((mesh <mesh>))
  "@b(Описание:) метод @b(2d-region-values) возвращает список имен
2d-регионов...

 @b(Пример использования:)
@begin[lang=lisp](code)
 (surfaces (mesh \"G1\" *simulation*))
@end(code)"
  (ht-values-sort (<mesh>-2d-regions mesh)))

(defmethod 2d-region-values ((3d-region <3d-region>))
  (mapcar
   #'(lambda (el)
       (format nil "~A ~A" el (<3d-region>-2d-suffix 3d-region)))
   (ht-values-sort
    (<mesh>-2d-regions (<3d-region>-mesh 3d-region)))))

(defmethod 2d-region-values ((simulation <simulation>))
  (apply #'append
         (loop :for i :in (3d-regions simulation)
               :collect (2d-region-values (3d-region i simulation)))))
