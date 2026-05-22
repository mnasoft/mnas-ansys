;;;; ./src/cfx/pre/method/interfaces-with.lisp

(in-package :mnas-ansys/cfx/pre)

(defmethod interfaces-with ((3d-region <3d-region>) mesh-name-2)
  "@b(Описание:) метод @b(interfaces-with) возвращает список имен
2d-регионов для 3d-региона @b(3d-region) сопряженных с 3d-регионом с
именем сетки @b(mesh-name-2).

 @b(Пример использования:)
@begin[lang=lisp](code)
 (interfaces-with (3d-region \"DG1 G1 1\" *simulation*) \"G2\")
@end(code)"
  (labels ((foo (str)
             (let ((lst (ppcre:split " " str)))
               (list (second lst) (third lst)))))
    (let ((mesh-name-1 (<mesh>-name (<3d-region>-mesh 3d-region))))
      (remove-if-not
       #'(lambda (el)
           (let ((lst (foo el)))
             (equalp
              (sort lst #'string<)
              (sort (list mesh-name-1 mesh-name-2) #'string<))))
       (interfaces 3d-region)))))


(defmethod interfaces-general-with ((3d-region <3d-region>) mesh-name-2)
  "@b(Описание:) метод @b(interfaces-with) возвращает список имен
2d-регионов для 3d-региона @b(3d-region) сопряженных с 3d-регионом с
именем сетки @b(mesh-name-2).

 @b(Пример использования:)
@begin[lang=lisp](code)
 (interfaces-general-with (3d-region \"DG1 G1 1\" *simulation*) \"G2\")
@end(code)"
  (labels ((foo (str)
             (let ((lst (ppcre:split " " str)))
               (list (second lst) (third lst)))))
    (let ((mesh-name-1 (<mesh>-name (<3d-region>-mesh 3d-region))))
      (remove-if-not
       #'(lambda (el)
           (let ((lst (foo el)))
             (equalp
              (sort lst #'string<)
              (sort (list mesh-name-1 mesh-name-2) #'string<))))
       (interfaces-general 3d-region)))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defmethod interfaces-general-with-01 ((3d-region <3d-region>) mesh-name-2)
  "@b(Описание:) метод @b(interfaces-with) возвращает список имен
2d-регионов для 3d-региона @b(3d-region) сопряженных с 3d-регионом с
именем сетки @b(mesh-name-2).

 @b(Пример использования:)
@begin[lang=lisp](code)
 (interfaces-general-with (3d-region \"DG1 G1 1\" *simulation*) \"G2\")
@end(code)"
  (labels ((foo (str)
             (let ((lst (ppcre:split " " str)))
               (list (second lst) (third lst)))))
    (let ((mesh-name-1 (<mesh>-name (<3d-region>-mesh 3d-region))))
      (remove-if-not
       #'(lambda (el)
           (let ((lst (foo el)))
             (equalp
              (sort lst #'string<)
              (sort (list mesh-name-1 mesh-name-2) #'string<))))
       (interface-ff-diff-general 3d-region)))))

