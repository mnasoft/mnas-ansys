;;;; ./src/exchange/exchange.lisp

(defpackage :mnas-ansys/exchange
  (:use #:cl)
  (:nicknames "EXCH")
  (:export read-dat-file
           average-value-from-dat-file)
  (:export select-first-n
           select-last-n)
  (:documentation
   "Пакет @(mnas-ansys/exchande) определяет функции, позволяющие извлечь
    информацию из файлов которые экспортирует Ansys"))

(in-package :mnas-ansys/exchange)

(defun read-dat-file (dat-file)
  "@b(Описание:) функция @b(read-dat-file) возвращает 2 значения:
@begin(list)
 @item(первое - 2d-list, содержащий данные из файла в формате дат;)
 @item(второе - 1d-list, содержащий заголовки столбцов.)
@end(list)

 @b(Переменые:)
@begin(list)
 @item(dat-file - имя dat-файла;)
@end(list)

 @b(Пример использования:)
@begin[lang=lisp](code)
   (read-dat-file \"Y:/_namatv/CFX/n70/cfx/N70_prj_04/hot/prj_04_Tair_15_G1_12_GTD_good/t03.dat\")
@end(code)"
  (let ((data
          (with-open-file (stream dat-file)
            (loop :for i :from 0
                  :for line = (read-line stream nil nil)
                  :while line
                  :collect
                  (mapcar #'read-from-string (mnas-string:split "," line))))))
    (values (cdr data) (car data))))

(defun select-first-n (data &optional (n 500))
  " @b(Пример использования:)
@begin[lang=lisp](code)
(select-last-n
  (read-dat-file
    \"Y:/_namatv/CFX/n70/cfx/N70_prj_04/hot/prj_04_Tair_15_G1_12_GTD_good/t03.dat\")
   500)
@end(code)
"
  (loop :for i :in data
        :for j :from 1 :to n
        :collect i))

(defun select-last-n (data &optional (n 500))
  " @b(Пример использования:)
@begin[lang=lisp](code)
(select-last-n
  (read-dat-file
    \"Y:/_namatv/CFX/n70/cfx/N70_prj_04/hot/prj_04_Tair_15_G1_12_GTD_good/t03.dat\")
   500)
@end(code)
"
  (loop :for i :in (reverse data) 
        :for j :from 1 :to n
        :collect i))

(defun average-value-from-dat-file (col dat-file 
                                    &key
                                      (last 500)
                                    &aux (data (read-dat-file dat-file)))
  "@b(Описание:) функция @b(mid-value-from-dat-file) возвращает среднее значение
   переменной, находящейся в колонке @b(col).

 @b(Переменые:)
@begin(list)
 @item(col - номер колонки, первая колонка имеет номер 0;)
 @item(dat-file - имя файла.)
@end(list)

 @b(Пример использования:)
@begin[lang=lisp](code)
 (average-value-from-dat-file 1
  \"Y:/_namatv/CFX/n70/cfx/N70_prj_04/hot/prj_04_Tair_15_G1_12_GTD_good/t03.dat\")
@end(code)"
  (math/stat:average-value
   (if last
       (math/matr:col col (select-last-n data last))
       (math/matr:col col data))))


