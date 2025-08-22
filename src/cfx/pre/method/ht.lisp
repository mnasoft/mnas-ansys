;;;; ./src/cfx/pre/predicat.lisp

(in-package :mnas-ansys/cfx/pre)

(defun ht-keys (ht)
  "Возвращает список ключей хеш-таблицы @b(ht)."
  (alexandria:hash-table-keys ht))

(defun ht-values (ht)
  "Возвращает список значений хеш-таблицы @b(ht)."
  (alexandria:hash-table-values ht))

(defun ht-keys-sort (ht &optional (func #'string<))
    "Возвращает сортированный по предикату @b(func) список ключей
хеш-таблицы @b(ht)."
  (sort (alexandria:hash-table-keys ht) func))

(defun ht-values-sort (ht &optional (func #'string<))
    "Возвращает сортированный по предикату @b(func) список значений
хеш-таблицы @b(ht)."  
  (sort (alexandria:hash-table-values ht) func))


