;;;; ./src/cfx/solver/solver.lisp

(defpackage :mnas-ansys/cfx/solver
  (:use #:cl)
  (:nicknames "CFX-SOL")
  (:export time-per-iteration )
  (:export subseq-by-regexp
           subseq-by-regexp-file
           out-file-find-cel-start-end)
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

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun subseq-by-regexp (sequence regexp-start regexp-stop)
  (let* ((start (position-if #'(lambda (el) (ppcre:scan regexp-start el)) sequence :start 0))
         (stop  (position-if #'(lambda (el) (ppcre:scan regexp-stop el)) sequence :start start)))
    (values 
    (subseq sequence start stop)
    (list start stop))))

(defun subseq-by-regexp-file (file-name regexp-start regexp-stop)
  (subseq-by-regexp (uiop:read-file-lines file-name)
                    regexp-start
                    regexp-stop))

(defun out-file-find-cel-start-end (file-name)
  "@b(Описание:) функция @b(out-file-find-cel-start-end) возвраает
список, содержаший номера начальной (включительно) строки и конечной
строки (исключительно), в которых содержатся CEL-выражения. Для
out-фйла @b(file-name).

 @b(Пример использования:)
@begin[lang=lisp](code)
 (out-file-find-cel-start-end  #P\"z:/CFX/t71/cfx/T71030091_prj_01/DP=002/T71030091_prj_01_007.out\")
@end(code)"
  (mnas-ansys/ccl/parse:parse 
   (subseq-by-regexp (uiop:read-file-lines file-name)
                     ".*LIBRARY:.*"
                     "^ $")))
