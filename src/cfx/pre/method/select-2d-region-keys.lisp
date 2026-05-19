;;;; ./src/cfx/pre/method/select-2d-region-keys.lisp

(in-package :mnas-ansys/cfx/pre)

(defmethod select-2d-region-keys (regexp (obj null)) nil)

(defmethod select-2d-region-keys (regexp (3d-region <3d-region>))
  "@b(Описание:) метод @b(select-2d-region-keys) возвращает список ключей
2d-регионов для 3d-региона @b(3d-region), соответствующих регулярном
выражению @b(regexp).

 @b(Пример использования:)
@begin[lang=lisp](code)
 ;; Пример для поиска всех флюидовых 2d-регионов, используемых как
 ;; интерфейс.
 (select-2d-region-keys \"C/G1-G2.*\" (3d-region \"DG1 G1 1\" *simulation*))
@end(code)"
  (remove-if-not
   #'(lambda (el)
       (ppcre:scan regexp el))
   (2d-region-keys 3d-region)))
