;;;; ./src/cfx/pre/method/interface-pairs-solid.lisp

(in-package :mnas-ansys/cfx/pre)

(defmethod interface-pairs-solid ((simulation <simulation>))
  "@b(Описание:) метод @b(interface-pairs-solid) возвращает список пар
строк представляющих имена солидовых сеток для создания между ними
интерфейсов типа solid-solid.

 @b(Пример использования:)
@begin[lang=lisp](code)
 (interface-pairs-solid *simulation*)
@end(code)"
  (sort
   (remove-if-not
    #'(lambda (el)
        (and
         (uiop:string-prefix-p "M" (first el))
         (uiop:string-prefix-p "M" (second el))))
    (interface-pairs simulation))
   #'two-string-list<))
