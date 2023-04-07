;;;; ./src/ccl/parse/ccl-parse.lisp

(defpackage :mnas-ansys/ccl/parse
  (:use #:cl)

  (:intern header-p
           key-value-p
           end-p
           empty-p
           )
  (:export parse
           parse-file)
  (:documentation
   "@b(Описание:) пакет @b(mnas-ansys/ccl/parse) предназначен для
 парсинга (разбора) данных и файлов в формате ccl."))

(in-package :mnas-ansys/ccl/parse)

(defun header-p (string)
  "@b(Описание:) функция @b(header-p) возврашает T, если строка
  @b(string) является заголовком секции.
"
  (when #+nil (find #\: string)
        (search ":" string)
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
  #+nil(string= "END" string)
  (let ((rez (search "END" string)))
    (when (numberp rez) (floor rez 2))))

(defun parse (string)
  (let ((os (make-string-output-stream))
        (is (make-string-input-stream string)))
    (loop :for line = (read-line is nil)
          :while line
          :do
             (let ((s-tr (string-trim " " line)))
               (cond
                 ((key-value-p line)
                  (format os "~A~%"
                          (concatenate 'string "(\""
                                       (ppcre:regex-replace
                                        " *= *" s-tr "\" \"")
                                       "\")")))
                 ((header-p line)
                  (format os "~A~%"
                          (concatenate
                           'string "(\""
                           (ppcre:regex-replace ": *" s-tr "\" \"") "\"")))
                 ((end-p line)
                  (format os "~A~%"
                          (ppcre:regex-replace "END" s-tr ")"))))))
    (read-from-string
     (concatenate 'string "(" (get-output-stream-string os)")"))))

(defun read-file-as-lines-wo-back-slesh (file-name)
  (let ((os (make-string-output-stream))
        (str ""))
    (loop :for i :in (uiop:read-file-lines file-name)
          :do
             (if (eq (uiop:last-char i) #\\)
                 (setf str (concatenate 'string str (subseq i 0 (1- (length i)))))
                 (progn
                   (format os "~A~%" (concatenate 'string str i))
                           (setf str ""))))
    (get-output-stream-string os)))

(defun parse-file (file-name)
  (parse (read-file-as-lines-wo-back-slesh file-name)))
