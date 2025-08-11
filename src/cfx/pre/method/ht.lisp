;;;; ./src/cfx/pre/predicat.lisp

(in-package :mnas-ansys/cfx/pre)

(defun ht-keys (ht) (alexandria:hash-table-keys ht))

(defun ht-values (ht) (alexandria:hash-table-values ht))

(defun ht-keys-sort (ht &optional (func #'string<))
  (sort (alexandria:hash-table-keys ht) func))

(defun ht-values-sort (ht &optional (func #'string<))
  (sort (alexandria:hash-table-values ht) func))


