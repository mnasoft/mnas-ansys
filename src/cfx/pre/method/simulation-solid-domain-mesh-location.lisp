;;;; ./src/cfx/pre/method/simulation-solid-domain-mesh-location.lisp

(in-package :mnas-ansys/cfx/pre)

(defmethod simulation-solid-domain-mesh-location (mesh-name (simulation <simulation>))
  "@b(Описание:) метод @b(simulation-solid-domain-mesh-location) возвращает
строку, представляющую список 3d-регионов составляющих солидовый домен
с именем сети @b(mesh-name) симуляции @b(simulation).

 @b(Пример использования:)
@begin[lang=lisp](code)
  (simulation-solid-domain-mesh-location \"M1\" *simulation*)
@end(code)"
  (format nil "~{~A~^,~}"
          (select-3d-regions-name-by-mesh-name mesh-name simulation)))
