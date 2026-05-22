;;;; ./src/cfx/pre/predicat.lisp

(in-package :mnas-ansys/cfx/pre)

(defun 3d-region-with-mesh-name (mesh-name)
  "@b(Описание:) функция @b(3d-region-with-mesh-name) возвращает
функцию-предикат, которая возвратит T для объекта 3d-region класса
<3d-region> если его сеть имеет имя mesh-name.

 @b(Пример использования:)
@begin[lang=lisp](code)
 (remove-if
  (complement (predicate-msh-name \"G1\"))
  (ht-values (<simulation>-3d-regions *simulation*)))
@end(code)"
  #'(lambda (3d-region)
      (string= mesh-name (<mesh>-name (<3d-region>-mesh 3d-region)))))


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

(defun two-string-list< (a b)
  "Истинно, если двухэлементный список A лексикографически меньше списка B.
   Сравнивает сначала первые элементы, при равенстве — вторые."
  (or (string< (first a) (first b))
      (and (string= (first a) (first b))
           (string< (second a) (second b)))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; Не предикаты

(defun is-icem-fluid-surface (surface-name domain-name)
  (let* ((path (ppcre:split "/" surface-name)))
    (or
     (string= (first path) (concatenate 'string "D" domain-name))
     (and (string= (first path) "C")
          (member domain-name (ppcre:split "-" (second path)) :test #'equal)))))

(defun filter-by-prefix (prefix strings)
  "Возвращает список строк, начало которых имеет префикс @b(prefix).

 @b(Пример использования:)
@begin[lang=lisp](code)
 (filter-by-prefix \"AaB\" '(\"AaB 123\" \"AaB123\" \"Aw\" \"Aa\"))
@end(code)
"
  (remove-if-not
   #'(lambda (s)
       (uiop:string-prefix-p prefix s))
   strings))

(defun extract-suffix (prefix string)
  "@b(Описание:) функция @b(extract-suffix) возвращает суффикс."
  (when (uiop:string-prefix-p prefix string)
    (string-trim " " (subseq string (length prefix)))))


(defun 2d-region-right-p (2d-region-name)
  (some #'(lambda (el) (string= "R" el))
        (mnas-ansys/ccl:mk-split 2d-region-name)))

(defun 2d-region-left-p (2d-region-name)
  (some #'(lambda (el) (string= "L" el))
            (mnas-ansys/ccl:mk-split 2d-region-name)))

(defun between-first-two-slashes (s)
  "Возвращает подстроку между первым и вторым '/' в строке S. Если
второго '/' нет — возвращает NIL. Пустая строка допустима (например,
\"a//b\")."
  (ppcre:register-groups-bind (between)
      ("^[^/]*/([^/]*)/" s)
    between))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun interface-p (2d-region-name)
  (let ((items (mnas-ansys/ccl:mk-split 2d-region-name)))
    (string= "C" (first items))))

(defun interface-ff-p (2d-region-name)
  "@b(Описание:) функция @b(interface-ff-p) возвращает T, если это
интерфейс типа флюид-флюид.

 @b(Пример использования:)
@begin[lang=lisp](code)
  (interface-ff-p \"C G1 G2 X_022.0 D_0.0 1\")
@end(code)
"
  (let ((items (mnas-ansys/ccl:mk-split 2d-region-name)))
    (and (interface-p 2d-region-name)
         (eq #\G (char (second items) 0))
         (eq #\G (char (third  items) 0)))))

(defun interface-ss-p (2d-region-name)
  "@b(Описание:) функция @b(interface-ff-p) возвращает T, если это
интерфейс типа солид-солид.

 @b(Пример использования:)
@begin[lang=lisp](code)
  (interface-ff-p \"C M1 M2 GT GU D_0.0 26\")
@end(code)"
  (let ((items (mnas-ansys/ccl:mk-split 2d-region-name)))
    (and (interface-p 2d-region-name)
         (eq #\M (char (second items) 0))
         (eq #\M (char (third  items) 0)))))

(defun interface-same-mesh-p (2d-region-name)
  "@b(Описание:) функция @b(interface-diff-mesh-p) возвращает T, если
@b(2d-region-name) соединяет 3д-регионы с разноименными сетками.

  "
  (let ((items (mnas-ansys/ccl:mk-split 2d-region-name)))
    (and (interface-p 2d-region-name)
         (string= (second items) (third items)))))

(defun interface-diff-mesh-p (2d-region-name)
  "@b(Описание:) функция @b(interface-diff-mesh-p) возвращает T, если
@b(2d-region-name) соединяет 3д-регионы с разноименными сетками.

 @b(Пример использования:)
@begin[lang=lisp](code)
  (interface-diff-mesh-p \"C G1 G2 X_022.0 D_0.0 1\")
@end(code)"
  (let ((items (mnas-ansys/ccl:mk-split 2d-region-name)))
    (and (interface-p 2d-region-name)
         (string/= (second items)
                   (third items)))))

(defun interface-rotational-p (2d-region-name)
  (and (interface-same-mesh-p 2d-region-name)
       (or (2d-region-left-p 2d-region-name)
           (2d-region-right-p 2d-region-name))))

(defun interface-same-mesh-rotational-p (2d-region-name)
  (and (interface-same-mesh-p 2d-region-name)
       (or (2d-region-left-p 2d-region-name)
           (2d-region-right-p 2d-region-name))))

(defun interface-diff-mesh-rotational-p (2d-region-name)
  (and (interface-diff-mesh-p 2d-region-name)
       (or (2d-region-left-p 2d-region-name)
           (2d-region-right-p 2d-region-name))))


(defun interface-right-p (2d-region-name)
  (and (interface-same-mesh-p 2d-region-name)
       (2d-region-right-p 2d-region-name)))

(defun interface-left-p (2d-region-name)
  (and (interface-same-mesh-p 2d-region-name)
       (2d-region-left-p 2d-region-name)))

(defun interface-ff-diff-general-p (2d-region-name)
  "Генеральный "
    (and (interface-diff-mesh-p 2d-region-name)
         (interface-ff-p 2d-region-name)
         (not (interface-diff-mesh-rotational-p 2d-region-name))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun interface-diff-mesh-right-p (2d-region-name)
  (let ((items (mnas-ansys/ccl:mk-split 2d-region-name)))
    (and (interface-p 2d-region-name)
         (string/= (second items)
                   (third items))
         (some #'2d-region-right-p (cdddr items)))))

(defun interface-diff-mesh-left-p (2d-region-name)
  (let ((items (mnas-ansys/ccl:mk-split 2d-region-name)))
    (and (interface-p 2d-region-name)
         (string/= (second items)
                   (third items))
         (some #'2d-region-left-p (cdddr items)))))
