;;;; ./src/cfx/pre/predicat.lisp

(in-package :mnas-ansys/cfx/pre)

(defun is-dash-string (s)
  "Возвращает T, если строка содержит #\\-, иначе NIL.

 @b(Пример использования:)
@begin[lang=lisp](code)
 (is-dash-string \"is-dash-string\") => T
  (is-dash-string \"is_dash_string\") => NIL
@end(code)
"
  (not (null (search "-" s))))

(defun is-starts-with-capital-m-p (s)
  "Возвращает T, если строка начинается с символа #\\M, иначе NIL."
  (and (stringp s)
       (> (length s) 0)
       (char= (char s 0) #\M)))

(defun tail-of-string (s)
  "Возвращает подстроку строки S без первого символа."
  (subseq s 1))

(defun is-icem-fluid-surface (surface-name domain-name)
  (let* ((path (ppcre:split "/" surface-name)))
    (or
     (string= (first path) (concatenate 'string "D" domain-name))
     (and (string= (first path) "C")
          (member domain-name (ppcre:split "-" (second path)) :test #'equal)))))
