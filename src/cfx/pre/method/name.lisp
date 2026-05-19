;;;; ./src/cfx/pre/method/name.lisp

(in-package :mnas-ansys/cfx/pre)

(defmethod name ((3d-region <3d-region>))
  "@b(Описание:) метод @b(name) возвращает имя 3d-региона @b(3d-region).

 @b(Пример использования:)
@begin[lang=lisp](code)
 (name (3d-region \"DG1 G1 1\" *simulation*))
@end(code)"
  (let ((mesh-name (<mesh>-name (<3d-region>-mesh 3d-region))))
    (format nil "D~A ~A ~A" mesh-name mesh-name (<3d-region>-3d-suffix 3d-region))))

(defmethod name ((obj <simulation-boundary-inlet>))
  (<simulation-boundary-inlet>-name obj))

(defmethod name ((obj <simulation-boundary-outlet>))
  (<simulation-boundary-outlet>-name obj))
