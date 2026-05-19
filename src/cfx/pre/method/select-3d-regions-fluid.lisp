;;;; ./src/cfx/pre/method/select-3d-regions-fluid.lisp

(in-package :mnas-ansys/cfx/pre)

(defmethod select-3d-regions-fluid ((simulation <simulation>))
  "@b(Описание:) метод @b(select-3d-regions-fluid) возвращает
список флюидовых 3d-регионов симуляции @b(simulation).

 @b(Пример использования:)
@begin[lang=lisp](code)
  (select-3d-regions-fluid *simulation*)
@end(code)"
  (remove-if-not
   #'(lambda (el)
       (uiop:string-prefix-p "DG" (name el)))
   (ht-values (<simulation>-3d-regions simulation))))
