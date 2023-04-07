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


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defparameter *res-fname*
  "//n133905/home/_namatv/CFX/n70/cfx/N70_prj_01/hot/prj_01_Tair_0_G1_17/rez-bak/N70_prj_01_Ne_10_Tair_0_D_FaS_Mesh_good_GTD_bad_CMB_FRCaED_002.res")


(defun read-res-file (res-file
                      &key
                        (rec-number 500)
                        (program "D:/ANSYS/v145/CFX/bin/cfx5mondata.exe")
                        (file-name
                         (namestring
                          (fad:with-output-to-temporary-file (stream))
                          ))
                        (varrule  "CATEGORY = USER POINT"))
  (labels
      ((scan-res-file (file-name                                   
                       &aux
                         (os (make-string-output-stream ))
                         (is (uiop:read-file-lines file-name))
                         (is-length (length is)))
         (loop :for i :in is
               :for j :from 0 :below is-length
               :do
                  (when (= j 0)
                    (let* ((str-01 (ppcre:regex-replace-all "\",\""  i  "\" \""))
                           (str-02 (ppcre:regex-replace-all "\"\"" str-01  "\\\"")))
                      (format os "~A" (concatenate 'string "(" str-02 ")"))))
                  (when (> j (max 1 (- is-length 1 rec-number)))
                    (let* ((str-01 (ppcre:regex-replace-all ","  i  " ")))
                      (format os "~A" (concatenate 'string "(" str-01 ")")))))
         (delete-file file-name)
         (read-from-string
          (concatenate 'string "(" (get-output-stream-string os) ")"))))
    (sb-ext:run-program program 
                        (list res-file
                              "-out" file-name
                              "-varrule" varrule))
    (scan-res-file file-name)))

(defparameter *h-d*
  (read-res-file *res-fname*))

(defun setect-mathed (regex headered-tabel)
  (let ((rgx (ppcre:create-scanner regex)))
    
  (loop :for i :in (first headered-tabel)
        :for j :from 0
        :when (ppcre:scan rgx i)
          :collect `(,j ,i))))

(setect-mathed "USER POINT,T03" *h-d*)
(setect-mathed "USER POINT,P02" *h-d*) 
(setect-mathed "USER POINT,P03" *h-d*) 


(defun average-value-from-headered-tabel
    (regex headered-tabel
     &aux
       (col (first
             (first
              (setect-mathed regex headered-tabel))))
       (col-name (second
                  (first
                   (setect-mathed regex headered-tabel))))
       (tabel (cdr headered-tabel)))
  (let ((data (mapcar #'(lambda (el) (nth col el)) tabel)))
    (list col-name
     (math/stat:average-value data)
     (math/stat:variation-coefficient data))))

(defun average-values-from-headered-tabel (regexes headered-tabel)
  (mapcar #'(lambda (regex)
              (average-value-from-headered-tabel regex headered-tabel))
          regexes))

(average-values-from-headered-tabel
 '("USER POINT,T03" "USER POINT,P02" "USER POINT,P03")
 *h-d*)

(with-open-file (str "~/h-d.lisp" :direction :output :if-exists :supersede)
  (format str "~S" *h-d*))

