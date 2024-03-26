;;;; ./src/cfx/file/mon/mon.lisp

mon-full-name mon-des

(defpackage :mnas-ansys/cfx/file/mon/core
  (:use #:cl)
  (:export mon-number ;; Номер монитора
           mon-des    ;; Обозначение монитора
           )
  (:export mon-fam      ;; Семейство (USER POINT|ACC TIME STAMP)
           mon-name     ;; 
           mon-domen    ;;
           mon-type     ;;
           mon-coords   ;;
           mon-location ;;
           )
  (:export convert-coord)
  (:intern mon-name-list)
  (:documentation
   "Пакет @(mnas-ansys/cfx/file/mon/core) определяет функции,
позволяющие сформировать монитор (см. пакет :mnas-ansys/cfx/file/mon)."))

(in-package :mnas-ansys/cfx/file/mon/core)

(defun convert-coord (x)
  "Преобразует строковое представление значения в число.

 @b(Пример использования:)
@begin[lang=lisp](code)
 (convert-coord \"p179i5\")
 (convert-coord \"m258i3\") 
@end(code)
"
  (read-from-string
   (ppcre:regex-replace-all
    "m"
    (ppcre:regex-replace-all
     "p"
     (ppcre:regex-replace-all "i" x ".") "+")
    "-")))

(defun mon-number (mon)
  (first mon))

(defun mon-des (mon) 
  (second mon))

(defun mon-des (mon)
  (second mon))

(defun mon-name-list (mon)
  (let* ((name (mon-des mon))
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

(defun mon-name (mon)
  (nth 1 (mon-name-list mon)))

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
             :collect (convert-coord i))))))

(defun mon-location (mon)
  "@b(Описание:) функция @b(mon-location) возвращает список координат
расположения монитора или nil, если монитор не относится к точке."
  (let ((name-list (mon-name-list mon)))
    (when (<= 4 (length name-list))
      (loop :for s
              :in 
              (mnas-string:split "\", xyz=" (nth 3 name-list))
            :collect (read-from-string s)))))
