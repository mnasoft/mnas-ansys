;;;; ./src/cfx/pre/method/3d-region.lisp

(in-package :mnas-ansys/cfx/pre)

(defmethod 3d-region (name (simulation <simulation>))
  "@b(Описание:) метод @b(domain) возвращает объект типа @b(<3d-region>) по
его имени из симуляции @b(simulation).

 @b(Пример использования:)
@begin[lang=lisp](code)
 (domain \"DG1 G1\" *simulation*)
@end(code)"
  (gethash name (<simulation>-3d-regions simulation)))
