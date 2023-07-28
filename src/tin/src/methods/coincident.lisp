(in-package :mnas-ansys/tin)

(defmethod coincident ((curve <curve>) (tin <tin>))
  " @b(Пример использования:)
@begin[lang=lisp](code)
  (let* ((tin (open-tin-file
              (concatenate 'string
                           (namestring
                            (asdf:system-source-directory :mnas-ansys))
                          \"data/tin/DG7.tin\")))
         (curve (find-curve-by-name \"E_1322573.1\" tin)))
    (coincident curve tin))
@end(code)"
  (list
   (find-point-by-name (<curve>-vertex1 curve) tin)
   (find-point-by-name (<curve>-vertex2 curve) tin)))

(defmethod coincident ((point <point>) (tin <tin>))
  "  @b(Пример использования:)
@begin[lang=lisp](code)
  (let* ((tin (open-tin-file
              (concatenate 'string
                           (namestring
                            (asdf:system-source-directory :mnas-ansys))
                          \"data/tin/DG7.tin\")))
         (point (find-point-by-name \"GEOM.60\" tin)))
    (coincident point tin))
@end(code)"
  (loop :for curve :in (tin-curves tin)
        :when (some #'(lambda (pnt) (eq pnt point))
                    (coincident curve tin))
          :collect curve))
