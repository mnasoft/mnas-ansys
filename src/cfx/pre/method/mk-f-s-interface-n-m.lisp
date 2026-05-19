;;;; ./src/cfx/pre/method/mk-f-s-interface-n-m.lisp

(in-package :mnas-ansys/cfx/pre)

(defmethod mk-f-s-interface-n-m (fluid-domain-name solid-domain-name (simulation <simulation>))
  "Создает генеральный интерфейс типа флюд-солид по местам контакта
доменов флюидова @b(fluid-domain-name) и солидова
@b(solid-domain-name).

 @b(Пример использования:)
@begin[lang=lisp](code)
 (mk-f-s-interface-n-m \"D1\" \"M3\" *i*)
@end(code)
"
  (make-f-s-interface-general-connection
   fluid-domain-name
   solid-domain-name
   (fluid-2d-regions solid-domain-name simulation)
   (solid-2d-regions solid-domain-name simulation)))
