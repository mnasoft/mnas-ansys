;;;; ./src/cfx/solver/solver.lisp

(defpackage :mnas-ansys/cfx/solver
  (:use #:cl)
  (:nicknames "CFX-SOL")
  (:export time-per-iteration )
  (:export subseq-by-regexp
           subseq-by-regexp-file
           out-file-find-cel-start-end
           )
  (:export positions-if
           slices-if
           slice-items-if
           )
  (:export
           mk-range-checker
           mk-regexp-checker
           )
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

(defun mk-range-checker (ranges &key (func #'<=))
  "@b(Описание:) функция @b(mk-range-checker) возвращает функцию,
возвращающую T, если ее аргумент попадает в хотя бы в один из
диапазонов задаваемых ranges.

 @b(Пример использования:)
@begin[lang=lisp](code)
 (funcall (mk-range-checker '((10 20)(30 40)(50 60))) 15) => T
 (funcall (mk-range-checker '((10 20)(30 40)(50 60))) 32) => T
@end(code)

"  
  #'(lambda (x)
      (some #'(lambda (range)
                (destructuring-bind (low hight) range
                  (funcall func low x hight)))
            ranges)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun mk-regexp-checker (regexp)
  #'(lambda (el) (ppcre:scan regexp el)))

(defun positions-if (predicate sequence)
  (loop :for s :in sequence
        :for i :from 0
        :when (funcall predicate s)
          :collect i))

(defun slices-if (start-predicate end-predicate sequence)
  "@b(Описание:) функция @b(slices-if) возвращает список диапазонов для
последовательности @b(sequence).

 @b(Переменые:)
@begin(list)
 @item(sequence - последоваельность;)
 @item(start-predicate - предикат для определения начала диапазона; )
 @item(end-predicate - предикат для определения конца диапазона.)
@end(list)

 @b(Пример использования:)
@begin[lang=lisp](code)
 (slices-if (mk-regexp-checker  *update-by-changes-start*)
            (mk-regexp-checker  *update-by-changes-end*)
            *seq*)
@end(code)"
  (loop :for i :in (positions-if start-predicate sequence)
        :collect (list i (position-if end-predicate sequence :start i))))

(defun slice-items-if (start-predicate end-predicate lines)
  (let ((predicate
          (mk-range-checker
           (slices-if start-predicate end-predicate lines))))
    (loop :for l :in lines
          :for i :from 0
          :when (funcall predicate i)
            :collect l)))

<out>
<out>-file
<out>-lines
update
cel
changes

(defclass <out> ()
  ((file
    :accessor <out>-file
    :initform nil
    :initarg :file
    :documentation "objects")
   (lines 
    :accessor <out>-lines 
    :initform nil
    :documentation "lines")))

(defmethod print-object ((out <out>) s)
  (print-unreadable-object (out s :type t)
    (format s "File: ~A" (<out>-file out))))

(defmethod update ((out <out>))
  (setf (<out>-lines  out)
        (uiop:read-file-lines (<out>-file out))))

(defmethod cel ((out <out>))
  (mnas-ansys/ccl/parse:parse 
   (subseq-by-regexp (<out>-lines out)
                     ".*LIBRARY:.*"
                     "^ $")))

(defmethod outer-loop-iteration ((out <out>))
  (let ((i
          (positions-if
           (mk-predicate-by-regexp "OUTER LOOP ITERATION")
           (<out>-lines out))))
    (list (length i) (nth (first (last i)) (<out>-lines out)))))
