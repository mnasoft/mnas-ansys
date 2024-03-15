;;;; ./src/cfx/file/mon/mon.lisp

(defpackage :mnas-ansys/cfx/file/mon/core
  (:use #:cl)
  (:export mon-number
           mon-name
           mon-name-list
           mon-fam
           mon-domen
           mon-type
           mon-coords
           )
  (:documentation
   "Пакет @(mnas-ansys/cfx/file/mon/core) определяет функции,
позволяющие сформировать монитор (см. пакет :mnas-ansys/cfx/file/mon)."))

(in-package :mnas-ansys/cfx/file/mon/core)

(defun mon-number (mon)
  (first mon))

(defun mon-name (mon)
  (second mon))

(defun mon-name-list (mon)
  (let* ((name (mon-name mon))
         (n-lst(mnas-string:split "\"" name)))
    (cond
      ((and (consp n-lst) (= 3 (length n-lst)))
       (append
        (mnas-string:split "," (first n-lst))
        (list (second n-lst))
        (mnas-string:split "," (third n-lst))))
      ((and (consp n-lst) (= 1 (length n-lst)))
       (mnas-string:split "," (first n-lst))))))

(defun mon-fam (mon)
  (nth 0 (mon-name-list mon)))

(defun mon-domen (mon)
  (nth 2 (mon-name-list mon)))

(defun mon-type (mon)
  (nth 4 (mon-name-list mon)))

(defun mon-coords (mon)
  (let ((n-lst (mon-name-list mon)))
    (when (and (consp n-lst) (= 5 (length n-lst)))
      (nreverse
       (loop :for i :in (nreverse (mnas-string:split " " (second n-lst)))
             :for j :from 1 :to 3
             :collect (mnas-ansys/exchange:convert-coord i))))))

(defun mon-location (mon)
  (loop :for s
          :in 
          (mnas-string:split "\", xyz=" (nth 3 (mon-name-list mon)))
        :collect (read-from-string s)))
