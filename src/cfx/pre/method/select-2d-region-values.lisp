;;;; ./src/cfx/pre/method/select-2d-region-values.lisp

(in-package :mnas-ansys/cfx/pre)

(defmethod select-2d-region-values (regexp (obj null)) nil)

(defmethod select-2d-region-values (regexp (3d-region <3d-region>))
  "@b(Описание:) метод @b(select-2d-regions) возвращает список значений
2d-регионов для 3d-региона @b(3d-region), соответствующих регулярном
выражению @b(regexp).

 @b(Пример использования:)
@begin[lang=lisp](code)
 ;; Пример для поиска всех флюидовых 2d-регионов, используемых как
 ;; интерфейс.
 (select-2d-regions \"C G1 G2.*\" (3d-region \"DG1 G1 1\" *simulation*))
@end(code)"
  (remove-if-not
   #'(lambda (el)
       (ppcre:scan regexp el))
   (2d-region-values 3d-region)))

(defmethod select-2d-region-values (regexp (simulation <simulation>))
  "@b(Описание:) метод @b(select-2d-region-values) возвращает список
2d-регионов для симуляции @b(simulation), соответствующих регулярном
выражению @b(regexp).

 @b(Пример использования:)
@begin[lang=lisp](code)
 ;; Пример для поиска всех флюидовых 2d-регионов используемых для
 ;; задания граничных условий
 (select-2d-region-values \"DG[0-9]* B[0-9]* .*\" *simulation*)
 ;; Пример для поиска флюидовых 2d-регионов используемых для
 ;; задания конкретного граничного условия
 (select-2d-region-values \"DG[0-9]* B[0-9]* AIR_IN .*\" *simulation*)
@end(code)"
  (remove-if-not
   #'(lambda (el)
       (ppcre:scan regexp el))
   (2d-region-values simulation)))
