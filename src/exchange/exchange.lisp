;;;; ./src/exchange/exchange.lisp

(defpackage :mnas-ansys/exchange
  (:use #:cl)
  (:nicknames "EXCH")
  (:export read-dat-file
           average-value-from-dat-file
           )
  (:export select-first-n
           select-last-n)
  (:export read-res-file
           setect-matches
           setect-matches-vector
           average-value-from-headered-tabel
           average-values-from-headered-tabel
           average-value-from-headered-tabel-by-col-name
           average-value-from-headered-tabel-by-col-names
           ave-average-value-from-headered-tabel-by-col-names
           max-average-value-from-headered-tabel-by-col-names
           ave-max-average-value-from-headered-tabel-by-col-names
           )
  (:export convert-coord)
  (:export res->ccl)
  (:documentation
   "Пакет @(mnas-ansys/exchande) определяет функции, позволяющие извлечь
    информацию из файлов, которые экспортирует Ansys"))

(in-package :mnas-ansys/exchange)

(defparameter *cfx5mondata* "C:/ANSYS/v145/CFX/bin/cfx5mondata.exe")

(uiop:getenv "ANSYS231_DIR")  ; => "C:\\Program Files\\ANSYS Inc\\v231\\ANSYS"

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




(defun read-res-file (res-file
                      &key
                        (rec-number 500)
                        (program *cfx5mondata*)
                        (file-name
                         (namestring
                          (fad:with-output-to-temporary-file (stream))
                          ))
                        (varrule  "CATEGORY = USER POINT")
                      &aux
                        (regex-0-1 (ppcre:create-scanner "\",\""))
                        (regex-0-2 (ppcre:create-scanner "\"\""))
                        (regex-n-1 (ppcre:create-scanner ",(?=,)|,$"))
                        (regex-n-1 (ppcre:create-scanner ",(?=,)|,$"))
                        (regex-n-2 (ppcre:create-scanner ","))
                        )
  "@b(Описание:) функция @b(read-res-file) возвращает список,
   состоящий из векторов, основанный на данных, содержащихся в
   res-файле.  Первый вектор содержит имена параметров, второй и
   последующие векторы содержат значения для указанных параметров.

   (read-res-file \"D:/home/_namatv/CFX/n70/cfx/Ne_R=1.00/N70_prj_10/274_full.res\" :rec-number 1)
   => 
   (#(\"ACCUMULATED TIMESTEP\"
      \"USER POINT,CH1 m16i0 p321i2 m1i2,D1,\"x=-1.60E-02,y= 3.21E-01,z=-1.21E-03\",CH4.Mass Fraction\"
      ...)
    #(274 0.04226463 ...))
"
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
                    (let* ((str-01 (ppcre:regex-replace-all regex-0-1 i  "\" \""))
                           (str-02 (ppcre:regex-replace-all regex-0-2 str-01  "\\\"")))
                      (format os "~A" (concatenate 'string "#(" str-02 ")"))))
                  (when (> j (max 1 (- is-length 1 rec-number)))
                    (let* ((str-01
                             (ppcre:regex-replace-all
                              regex-n-2 (ppcre:regex-replace-all regex-n-1 i ",nil")
                              " ")))
                      (format os "~A" (concatenate 'string "#(" str-01 ")")))))
         (delete-file file-name)
         (read-from-string
          (concatenate 'string "(" (get-output-stream-string os) ")"))))
    (sb-ext:run-program program 
                        (list res-file
                              "-out" file-name
                              "-varrule" varrule))
    (scan-res-file file-name)))

(defun setect-matches (regex headered-tabel)
  "@b(Описание:) функция @b(setect-matches) возвращает, список, каждый элемент которого
является 2d-списком, содержащим номер и заголовок колонки, удовлетворяющей @b(regex)
для строки заголовков headered-tabel.

 @b(Пример использования:)
@begin[lang=lisp](code)
 (setect-matches \"GT1\" *h-d*)
=> ((1124 \"USER POINT,Temperature GT1 F T01 p46i5 p415i5 p0i0,D1,\"x= 4.65E-02,y= 4.16E-01,z= 0.00E+00\",Temperature\")
    (1125 \"USER POINT,Temperature GT1 F T02 p46i5 p335i0 p80i5,D1,\"x= 4.65E-02,y= 3.35E-01,z= 8.05E-02\",Temperature\")
    ...
   )
@end(code)
"
  (let ((rgx (ppcre:create-scanner regex)))
    (loop :for i :across (first headered-tabel)
          :for j :from 0
          :when (ppcre:scan rgx i)
            :collect `(,j ,i))))

(defun setect-matches-vector (regex headered-tabel)
  "@b(Описание:) функция @b(setect-matches) возвращает, список, каждый элемент которого
является 2d-списком, содержащим номер и заголовок колонки, удовлетворяющей @b(regex)
для строки заголовков headered-tabel.

 @b(Пример использования:)
@begin[lang=lisp](code)
 (setect-matches \"GT1\" *h-d*)
=> ((1124 \"USER POINT,Temperature GT1 F T01 p46i5 p415i5 p0i0,D1,\"x= 4.65E-02,y= 4.16E-01,z= 0.00E+00\",Temperature\")
    (1125 \"USER POINT,Temperature GT1 F T02 p46i5 p335i0 p80i5,D1,\"x= 4.65E-02,y= 3.35E-01,z= 8.05E-02\",Temperature\")
    ...
   )
@end(code)
"
  (let ((rgx (ppcre:create-scanner regex)))
    (loop :for i :across (svref headered-tabel 0)
          :for j :from 0
          :when (ppcre:scan rgx i)
            :collect `(,j ,i))))

(defun average-value-from-headered-tabel
    (regex headered-tabel
     &aux
       (mathed (setect-matches regex headered-tabel))
       (col (first (first mathed)))
       (col-name (second (first mathed)))
       (tabel (cdr headered-tabel)))
  (let ((data (mapcar #'(lambda (el)
                          #+nil(nth col el)
                          (svref el col))
                      tabel)))
    (list col-name
     (math/stat:average-not-nil-value data)
     (math/stat:standard-deviation-not-nil data))))

(defun average-values-from-headered-tabel (regexes headered-tabel)
  (mapcar #'(lambda (regex)
              (average-value-from-headered-tabel regex headered-tabel))
          regexes))

(defun average-value-from-headered-tabel-by-col-name
    (col-name headered-tabel
     &aux
       (col (first col-name))
       (col-name (second col-name))
       (tabel (cdr headered-tabel)))
  (let ((data (mapcar #'(lambda (el)
                          #+nil(nth col el)
                          (svref el col))
                      tabel)))
    (list col-name
          (math/stat:average-not-nil-value data)
          (math/stat:standard-deviation-not-nil data))))

(defun average-value-from-headered-tabel-by-col-names
    (col-names headered-tabel)
  (mapcar
   #'(lambda (col-name)
       (average-value-from-headered-tabel-by-col-name col-name headered-tabel))
   col-names))

(defun ave-average-value-from-headered-tabel-by-col-names
    (number col-names headered-tabel)
  (list
   number
   (math/stat:average-value
    (mapcar #'second
            (average-value-from-headered-tabel-by-col-names col-names headered-tabel)))))

(defun max-average-value-from-headered-tabel-by-col-names
    (number col-names headered-tabel)
  (list
   number
   (math/stat:max-value
    (mapcar #'second
            (average-value-from-headered-tabel-by-col-names col-names headered-tabel)))))

(defun ave-max-average-value-from-headered-tabel-by-col-names
    (number col-names headered-tabel
     &aux
       (rez (mapcar #'second
                    (average-value-from-headered-tabel-by-col-names
                     col-names
                     headered-tabel))))
      (list
     number
     (math/stat:average-value rez)
     (math/stat:max-value rez)))

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


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun res->ccl (res-file
                 &key
                   (program "C:/ANSYS/v145/CFX/bin/cfx5cmds.exe")
                   (file-name
                    (namestring
                     (fad:with-output-to-temporary-file (stream))))
                   (file-name-ccl (concatenate 'string file-name ".ccl")))
  "@b(Описание:) функция @b(res->ccl) возвращает списковое представление
   ccl, извлекаемое из @b(res-file).

 @b(Пример использования:)
@begin[lang=lisp](code)
  (res->ccl \"//n133905/home/_namatv/CFX/n70/cfx/N70_prj_03/hot/prj_03_Tair_15_G1_12_GTD_good/res-bak/5980_full.bak\")
=>((\"LIBRARY\" \"\"
   (\"CEL\" \"\"
    (\"EXPRESSIONS\" \"\"
     (\"Expression 1\"
      \"massFlowAve(Total Pressure )@REGION:B AIR_IN D_16.000+massFlow()@REGION:C C_1_4 C_1_4_1 D_16.000\")
    ...
   ))))
@end(code)
"
  (delete-file file-name)  
  (sb-ext:run-program program 
                      (list "-read"
                            "-def"
                            res-file
                            "-text"
                            file-name-ccl))
  (let ((rez (mnas-ansys/ccl/parse:parse-file file-name-ccl)))
    (delete-file file-name-ccl)
    rez))
