;;;; ./src/exchange/exchange.lisp

(defpackage :mnas-ansys/cfx/solver
  (:use #:cl)
  (:nicknames "CFX-SOL")
  (:export time-per-iteration )

  (:documentation
   "Пакет @(mnas-ansys/cfx/solver) определяет функции, позволяющие
 определять время, затрачиваемое CFX-SOLVER на одну итерацию."))

(in-package :mnas-ansys/cfx/solver)

(defun time-per-iteration (i-start t-start i-end t-end n-cores)
  "@b(Описание:) функция @b(time-per-iteration) Возвращает
время (выраженное в секундах), затрачиваемое CFX-SOLVER на одну
итерацию.

 @b(Переменые:)
@begin(list)
 @item(i-start - номер начальной итерации;)
 @item(i-end - номер конечной итерации;)
 @item(t-start - время CPU SECONDS для начальной итетации;)
 @item(t-end - время CPU SECONDS для конечной итетации;)
 @item(n-cores - количество процессоров.)
@end(list)


 @b(Пример использования:)
@begin[lang=lisp](code)
; OUTER LOOP ITERATION =    1                    CPU SECONDS = 8.578E+03
; OUTER LOOP ITERATION =   12                    CPU SECONDS = 7.206E+04
  (time-per-iteration 1  8.578E+03  12 7.206E+04 8)
@end(code)"
  (/ (- t-end t-start) (- i-end i-start) n-cores))
