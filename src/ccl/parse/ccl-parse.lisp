;;;; ./src/ccl/parse/ccl-parse.lisp

(defpackage #:mnas-ansys/ccl-parse
  (:use #:cl)
  (:intern start-char
           string-depth
           section-header-p
           key-value-p
           end-p
           empty-p
           separate
           read-key-value
           read-section-header
           deep-reverse
           nthcar
           nth-cons-subst
           ccl-line
           ccl-line-slow
           parse-slow)
  (:export parse
           parse-file)
  (:documentation
   "@b(Описание:) пакет @b(mnas-ansys/ccl-parse) предназначен для
 парсинга (разбора) данных и файлов в формате ccl."))

(in-package #:mnas-ansys/ccl-parse)
 
(defun start-char (char string)
  "@b(Описание:) функция @b(start-chars) возвращает количество
  символов @b(char), с которых начинается строка @b(string).

 @b(Пример использования:)
@begin[lang=lisp](code)
 (start-char #\space \"    Boundary List1 = C T_1 G Side 1\") => 4
 (start-char #\space \"\") => 0
@end(code)
"
  (let ((rez 0))
    (loop :for i :from 0 :below (length string) :do
      (if (eq char (char string i))
          (incf rez)
          (return rez)))
    rez))

(defun string-depth (string)
  "@b(Описание:) функция @b(string-depth) возвращает глубину
 вложенности списка для формата ccl комплекса CFX.

 @b(Пример использования:) @begin[lang=lisp](code)
 (string-depth \"    Boundary List1 = C T_1 G Side 1\")
@end(code)
"
  (floor (start-char #\space string) 2))

(defun section-header-p (string)
  "@b(Описание:) функция @b(section-header-p) возврашает T, если строка
  @b(string) является заголовком секции.
"
  (when #+nil (find #\: string)
        (search ": " string)
        t))

(defun key-value-p (string)
  "@b(Описание:) функция @b(key-value-p) возврашает T, если строка
  @b(string) является парой ключ-значение.

 @b(Пример использования:)
@begin[lang=lisp](code)
 (key-value-p \"    Boundary List1 = C T_1 G Side 1\") => T
@end(code)"
  (when #+nil (find #\= string)
        (search " = " string) t))

(defun end-p (string)
  "@b(Описание:) функция @b(end-p) возвращает:
@begin(list)
 @item(- глубну вложенности, закрывающегося списка; )
 @item(- nil, если передаваемая строка не содержит признака закрытия
 списка.)
@end(list)"
  (let ((rez (search "END" string)))
    (when (numberp rez) (floor rez 2))))

(defun empty-p (string)
  "@b(Описание:) функция @b(empty-p) возвращает T, если строка
 является пустой."
  (string= "" string))

(defun separate (delimiter string)
  (let ((n (search delimiter string )))
    (list (subseq string 0 n)
          (subseq string (+ n (length delimiter))))))

(defun read-key-value (string)
  "
 @b(Пример использования:)
@begin[lang=lisp](code)
 (read-key-value \"    Filter Domain List1 = D1L\")
@end(code)
"
  (let ((rez (separate " = " string)))
    (setf (first rez) (string-left-trim " " (first rez)))
    (nreverse rez)))

(defun read-section-header (string)
  "
 @b(Пример использования:)
@begin[lang=lisp](code)
 (read-section-header \"        MOMENTUM INTERFACE MODEL: \")
@end(code)
"
  (let ((rez (separate ": " string)))
    (setf (first rez) (string-left-trim " " (first rez)))
    (nreverse rez)))

(defun deep-reverse (l)
  "@b(Описание:) функция @b(deep-reverse) выполняет рекурсивное
 реверсирование списка @b(l).

 @b(Пример использования:)
@begin[lang=lisp](code)
 (deep-reverse '(1 (2 3 (4 5 6) 7) 8 9))
 => (9 8 (7 (6 5 4) 3 2) 1)
@end(code)
"
  (cond ((null l) nil)
        ((listp (car l))
         (append (deep-reverse (cdr l))
                 (list (deep-reverse (car l)))))
        (t (append (deep-reverse (cdr l))
                   (list (car l))))))

(defun nthcar (n lst)
  "@b(Описание:) функция @b(nthcar) возвращает результат применения к
  списку @b(lst)  функции @b(car) @b(n) раз."
  (let ((rez lst))
        (dotimes (i n rez)
          (setf rez (car rez)))))

(defun nth-cons-subst (n new-list list)
  "@b(Описание:) функция @b(nth-cons-subst) 

 @b(Пример использования:)
@begin[lang=lisp](code)
 (nth-cons-subst 0 '(1 2) '(((((1) 2) 3) 4) 5)) => ((1 2) ((((1) 2) 3) 4) 5)
 (nth-cons-subst 1 '(1 2) '(((((1) 2) 3) 4) 5)) => (((1 2) (((1) 2) 3) 4) 5)
 (nth-cons-subst 3 '(1 2) '(((((1) 2) 3) 4) 5)) => (((((1 2) (1) 2) 3) 4) 5)
@end(code)"
  (setf list
        (subst
         (cons new-list (nthcar n list))
         (nthcar n list)
         list)))

(defun ccl-line (v-strings i)
  "@b(Описание:) функция @b(ccl-line) возвращает список из двух элементов или NIL.
 
  Список из двух элементов возвращается в случае если @b(i)-товый
  элемент вектора строк @b(v-strings) является:

@begin(list)
 @item(заголовком секции;)
 @item(парой ключ-значение.)
@end(list)
"
  (let ((string (svref v-strings i)))
    (let ((empty-p          (empty-p string))
          (key-value-p      (key-value-p string))
          (section-header-p (section-header-p string))
          (end-p            (end-p string))
          (string-depth     (string-depth string)))
      (cond
        (section-header-p
         (list (read-section-header string)
               (list string-depth section-header-p key-value-p empty-p end-p)))
        #+nil
        (progn (push  rez)
               (ccl-line (first rez) v-strings (1+ i) end level))
        (key-value-p
         (list (read-key-value string)
               (list string-depth section-header-p key-value-p empty-p end-p)))
        (end-p (list nil
                     (list string-depth section-header-p key-value-p empty-p end-p)))))))

(defun ccl-line-slow (v-strings i)
  "@b(Описание:) функция @b(ccl-line) возвращает список из двух элементов или NIL.
 
  Список из двух элементов возвращается в случае если @b(i)-товый
  элемент вектора строк @b(v-strings) является:

@begin(list)
 @item(заголовком секции;)
 @item(парой ключ-значение.)
@end(list)
"
  (let ((string (svref v-strings i)))
    (let ((empty-p          (empty-p string))
          (key-value-p      (key-value-p string))
          (section-header-p (section-header-p string))
          (end-p            (end-p string))
          (string-depth     (string-depth string)))
      (cond
        (section-header-p
         (list (read-section-header string)
               (list string-depth section-header-p key-value-p empty-p end-p)))
        (key-value-p
         (list (read-key-value string)
               (list string-depth section-header-p key-value-p empty-p end-p)))
        (t nil)))))

(defun parse-slow (v-strings)
  "@b(Описание:) функция @b(parse) возвращает список как результат
  парсинга вектора строк @b(v-strings) формата CCL ANSYS CFX.

 При парсинге учитывается количество двойных отступов.

 При парсинге признаки окончания раздела игнорируются.

 @b(Пример использования:)
@begin[lang=lisp](code)
 (parse *lines*)
@end(code)
"
    (let ((rez nil)
          (a   nil))
      (loop :for i :from 0 :below (length v-strings) :do
        (progn
          #+nil
          (format t "~A~%" i)
          (setf a (ccl-line-slow v-strings i))
          (cond
            ((null a))
            ((numberp (first (second a)))
             (setf rez (nth-cons-subst (first (second a))
                                       (first a)
                                       rez))))))
      (deep-reverse rez)))

(defun parse (v-strings)
  "@b(Описание:) функция @b(parse) возвращает список как результат
  парсинга вектора строк @b(v-strings) формата CCL ANSYS CFX.

 При парсинге учитывается количество двойных отступов.

 При парсинге признаки окончания раздела игнорируются.

 @b(Пример использования:)
@begin[lang=lisp](code)
 (parse *lines*)
@end(code)"
  (let ((a nil)
        (of (make-string-output-stream)))
    (format of "(~%")
    (loop :for i :from 0 :below (length v-strings) :do
      (progn
        (setf a (ccl-line v-strings i))
        (cond
          ;; section-header-p
          ((second (second a)) (format of "(~{~S ~}~%" (nreverse (first a))))
          ;; key-value-p
          ((third (second a))
           (format of "~S~%" (nreverse (first a))))
          ;; end-p
          ((fifth (second a))
           (format of ")~%")))))
    (format of ")~%")
    (read-from-string
     (get-output-stream-string of))))

(defun parse-file (file-name)
  "@b(Описание:) функция @b(parse-file) возвращает список как результат
  парсинга файла @b(file-name) формата CCL ANSYS CFX.

 @b(Пример использования:)
@begin[lang=lisp](code)
 (parse-file \"~/quicklisp/local-projects/ANSYS/mnas-ansys/data/ccl/interfaces.ccl\")
@end(code)
"
  (parse (mnas-ansys/read:read-file-as-lines file-name)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

#+nil
(progn
  (sb-profile:profile start-char
                      string-depth
                      section-header-p
                      key-value-p
                      end-p
                      empty-p
                      separate
                      read-key-value
                      read-section-header
                      deep-reverse
                      nthcar
                      nth-cons-subst
                      ccl-line
                      parse
                      parse-file)
  (parse-file "~/quicklisp/local-projects/ZM/cfx/a32-base/temp.ccl")
  (sb-profile:report)
  (sb-profile:reset)
  (sb-profile:unprofile))
