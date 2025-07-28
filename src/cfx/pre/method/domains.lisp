;;;; ./src/cfx/pre/test.lisp

(in-package :mnas-ansys/cfx/pre)

(defmethod domains ((simulation <simulation>))
  " @b(Пример использования:)
@begin[lang=lisp](code)
 (domains *ds*)
@end(code)"
  (ht-keys-sort (<simulation>-domains simulation)))

(defmethod domain (name (simulation <simulation>))
  "@b(Описание:) метод @b(domain) возвращает объект типа @b(<domain>) по
его имени из симуляции @b(simulation).

 @b(Пример использования:)
@begin[lang=lisp](code)
 (domain \"DG1 G1\" *simulation*)
@end(code)"
  (gethash name (<simulation>-domains simulation)))





