;;;; ./src/read/read.lisp

(defpackage :mnas-ansys/tin/read
  (:use #:cl)
  (:export read-file-as-lines
           line-by-line
           by-key
	   int-by-key
	   x-by-key
	   y-by-key
	   z-by-key
           )
  (:documentation
   " Пакет @b(mnas-ansys/tin/read) предназначен для выполнения
 низкоуровевого разбора инструкций tin-файлов
 (представления геометрии) системы ANSYS ICEM."
   ))

(in-package :mnas-ansys/tin/read)

(defun read-file-as-lines (filename)
  "@b(Описание:) функция @b(read-file-as-lines) возвращает вектор
 строк, представляющий содержимое файла с именем @b(filename).
"
  (coerce (uiop:read-file-lines filename) 'vector))

(defgeneric line-by-line (container  &optional coerce-to)
  (:documentation
   "@b(Описание:) обобщенная_функция @b(line-by-line) возвращает
   построчное пердставление символьной информации находящейся в
   контейнере @b(container).
"))

(defmethod line-by-line ((string string) &optional (coerce-to 'list))
  (coerce 
    (let ((stream (make-string-input-stream string)))
      (loop :for line = (read-line stream nil)
            :while line :collect line))
    coerce-to))

(defmethod line-by-line ((pathname pathname) &optional (coerce-to 'list))
  "
 @b(Пример использования:)
@begin[lang=lisp](code)
 (line-by-line
  (probe-file \"~/quicklisp/local-projects/ANSYS/mnas-ansys/data/ccl/interfaces.ccl\"))
@end(code)"
  (coerce 
   (with-open-file (stream pathname)
     (loop :for line = (read-line stream nil)
           :while line :collect line))
   coerce-to))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; reader-help-func

(defun by-key (key place)
  "@b(Описание:) функция @b(by-key) возвращает строку, следующую
  за ключом @b(key) в списке @b(place).
 
 @b(Переменые:)
@begin(list)
 @item(key - строка;)
 @item(place - список строк;)
@end(list)

 @b(Пример использования:)
@begin[lang=lisp](code)
 (by-key \"key-1\" '(\"key-0\" \"value-0\" \"key-1\" \"value-1\" \"key-2\" \"value-2\")) 
 => \"value-1\"
@end(code)"
  (let ((pos (position key place :test #'string=)))
    (if pos (elt place (1+ pos)) "")))

(defun int-by-key (key place &key (default 0))
  " @b(Описание:) функция  @b(int-by-key) возвращает целое число,
  следующее за ключом @b(key) в списке строк @b(place).  В списке
  строк @b(place) число представлено в виде строки и парсится в целое.

 @b(Пример использования:)
@begin[lang=lisp](code)
 (int-by-key \"key-1\" '(\"key-0\" \"value-0\" \"key-1\" \"101325\" \"key-2\" \"value-2\"))  
 => 101325
@end(code)"
  (let ((rez (parse-integer (by-key key place) :junk-allowed t)))
    (if rez rez default)))

;;;;;;;;;;;;;;;;;;;;

(defun read-n-by-key (key place &key (n 1) (default 0.0))
  (let ((pos (position key place :test #'string=)))
    (if pos
        (read-from-string (elt place (+ n pos )))
        default)))

(defun x-by-key (key place &key (default 0.0))
    " @b(Описание:) функция  @b(int-by-key) возвращает вещественое число,
  следующее первым за ключом @b(key) в списке строк @b(place). В списке
  строк @b(place) число представлено в виде строки и парсится в вещественное.

 @b(Пример использования:)
@begin[lang=lisp](code)
  (x-by-key \"key-0\" '(\"key-0\" \"0.325\" \"key-1\" \"101.325\" \"201.325\" \"301.325\"))
  => 0.325, 5
  (x-by-key \"key-1\" '(\"key-0\" \"0.325\" \"key-1\" \"101.325\" \"201.325\" \"301.325\" ))
  => 101.325
  (x-by-key \"key-2\" '(\"key-0\" \"value-0\" \"key-1\" \"101.325\" \"201.325\" \"301.325\"))
  => 0.0
@end(code)"
  (read-n-by-key key place :n 1 :default default))

(defun y-by-key (key place &key (default 0.0))
  " @b(Описание:) функция  @b(int-by-key) возвращает вещественое число,
  следующее вторым за ключом @b(key) в списке строк @b(place). В списке
  строк @b(place) число представлено в виде строки и парсится в вещественное.

 @b(Пример использования:)
@begin[lang=lisp](code)
  (y-by-key \"key-1\" '(\"key-0\" \"value-0\" \"key-1\" \"101.325\" \"201.325\" \"301.325\" ))
   => 201.325
@end(code)"
  (read-n-by-key key place :n 2 :default default))

(defun z-by-key (key place &key (default 0.0))
  " @b(Описание:) функция  @b(int-by-key) возвращает вещественое число,
  следующее вторым за ключом @b(key) в списке строк @b(place). В списке
  строк @b(place) число представлено в виде строки и парсится в вещественное.

 @b(Пример использования:)
@begin[lang=lisp](code)
  (z-by-key \"key-1\" '(\"key-0\" \"value-0\" \"key-1\" \"101.325\" \"201.325\" \"301.325\" ))
   => 301.325
@end(code)"
  (read-n-by-key key place :n 3 :default default))

