;;;; ./src/read/read.lisp

(defpackage #:mnas-ansys/read
  (:use #:cl)
  (:export read-file-as-lines
           read-by-key
	   read-int-by-key
	   read-x-by-key
	   read-y-by-key
	   read-z-by-key
           )
  (:documentation
   " Пакет @b(mnas-ansys/read) предназначен для выполнения
 низкоуровевого разбора инструкций tin-файлов
 (представления геометрии) системы ANSYS ICEM."
   ))

(in-package :mnas-ansys/read)

(defun read-file-as-lines (filename)
  "@b(Описание:) функция @b(read-file-as-lines) возвращает вектор
 строк, представляющий содержимое файла с именем @b(filename).
"
  (coerce (uiop:read-file-lines filename) 'vector))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; reader-help-func

(defun read-by-key (key place)
  "@b(Описание:) функция @b(read-by-key) возвращает строку, следующую
  за ключом @b(key) в списке @b(place).
 
 @b(Переменые:)
@begin(list)
 @item(key - строка;)
 @item(place - список строк;)
@end(list)

 @b(Пример использования:)
@begin[lang=lisp](code)
 (read-by-key \"key-1\" '(\"key-0\" \"value-0\" \"key-1\" \"value-1\" \"key-2\" \"value-2\")) 
 => \"value-1\"
@end(code)"
  (let ((pos (position key place :test #'string=)))
    (if pos (elt place (1+ pos)) "")))

(defun read-int-by-key (key place &key (default 0))
  " @b(Описание:) функция  @b(read-int-by-key) возвращает целое число,
  следующее за ключом @b(key) в списке строк @b(place).  В списке
  строк @b(place) число представлено в виде строки и парсится в целое.

 @b(Пример использования:)
@begin[lang=lisp](code)
 (read-int-by-key \"key-1\" '(\"key-0\" \"value-0\" \"key-1\" \"101325\" \"key-2\" \"value-2\"))  
 => 101325
@end(code)"
  (let ((rez (parse-integer (read-by-key key place) :junk-allowed t)))
    (if rez rez default)))

;;;;;;;;;;;;;;;;;;;;

(defun read-n-by-key (key place &key (n 1) (default 0.0))
  (let ((pos (position key place :test #'string=)))
    (if pos
        (read-from-string (elt place (+ n pos )))
        default)))

(defun read-x-by-key (key place &key (default 0.0))
    " @b(Описание:) функция  @b(read-int-by-key) возвращает вещественое число,
  следующее первым за ключом @b(key) в списке строк @b(place). В списке
  строк @b(place) число представлено в виде строки и парсится в вещественное.

 @b(Пример использования:)
@begin[lang=lisp](code)
  (read-x-by-key \"key-0\" '(\"key-0\" \"0.325\" \"key-1\" \"101.325\" \"201.325\" \"301.325\"))
  => 0.325, 5
  (read-x-by-key \"key-1\" '(\"key-0\" \"0.325\" \"key-1\" \"101.325\" \"201.325\" \"301.325\" ))
  => 101.325
  (read-x-by-key \"key-2\" '(\"key-0\" \"value-0\" \"key-1\" \"101.325\" \"201.325\" \"301.325\"))
  => 0.0
@end(code)"
  (read-n-by-key key place :n 1 :default default))

(defun read-y-by-key (key place &key (default 0.0))
  " @b(Описание:) функция  @b(read-int-by-key) возвращает вещественое число,
  следующее вторым за ключом @b(key) в списке строк @b(place). В списке
  строк @b(place) число представлено в виде строки и парсится в вещественное.

 @b(Пример использования:)
@begin[lang=lisp](code)
  (read-y-by-key \"key-1\" '(\"key-0\" \"value-0\" \"key-1\" \"101.325\" \"201.325\" \"301.325\" ))
   => 201.325
@end(code)"
  (read-n-by-key key place :n 2 :default default))

(defun read-z-by-key (key place &key (default 0.0))
  " @b(Описание:) функция  @b(read-int-by-key) возвращает вещественое число,
  следующее вторым за ключом @b(key) в списке строк @b(place). В списке
  строк @b(place) число представлено в виде строки и парсится в вещественное.

 @b(Пример использования:)
@begin[lang=lisp](code)
  (read-z-by-key \"key-1\" '(\"key-0\" \"value-0\" \"key-1\" \"101.325\" \"201.325\" \"301.325\" ))
   => 301.325
@end(code)"
  (read-n-by-key key place :n 3 :default default))

