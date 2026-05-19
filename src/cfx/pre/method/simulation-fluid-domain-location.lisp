;;;; ./src/cfx/pre/method/simulation-fluid-domain-location.lisp

(in-package :mnas-ansys/cfx/pre)

(defmethod simulation-fluid-domain-location ((simulation <simulation>))
  "@b(Описание:) метод @b(simulation-fluid-domain-location) возвращает
строку, представляющую список 3d-регионов составляющих флюидовый домен
симуляции @b(simulation).

 @b(Пример использования:)
@begin[lang=lisp](code)
  (simulation-fluid-domain-location *simulation*)
@end(code)"
  (format nil "~{~A~^,~}"
          (sort (mapcar #'name (select-3d-regions-fluid simulation))
                #'string<)))
