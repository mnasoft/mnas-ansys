;;;; ./src/cfx/file/file.lisp

(defpackage :mnas-ansys/cfx/file
  (:use #:cl)
  (:export <res>
           <res>-pathname ;; Аксессор к имени res-файла
           <res>-ccl      ;; Аксессор к списку ccl
           <res>-mon      ;; Хешированная таблица мониторов
           )
  (:export save          ;; Сохранение объекта
           load-instance ;; Загрузка объекта из файла
           )
  (:export ccl-extract ;; Извлечение данных связанных их файла.
           )
  (:export mon-extract ;; Извлечение данных о мониторах из res-файла
           mon-select  ;; Выборка из объекта по определенным мониторам
           mon-table   ;; Список номер пп, имя, данные по монитору
           mon-table-ave ;; ;; Список номер пп, имя, среднее значение по монитору СКО
           mon-to-org ; Вывод в файл с именем как у res-файла и расширением org
           mon-check ; Проверка монитора (списка мониторов) на корректность по имени (именам)
           )
  (:export iterations      ;; Количество итераций, по данным мониторов
           iteration-start ;; Номер начальной итерации
           iteration-end   ;; Номер конечной  итерации
           ) 
  (:export find-in-ccl ;; Поиск вглубину по данным ccl.
           )
  (:export *n-iter* ;; Количество итераций для мониторов, выгружаемое по умолчанию
           res-to-s-obj ;; Сохранение res-файла в формате s-obj
           dir-to-s-obj ;; Сохранение групы res-файлов в формате s-obj
           open-cfx-file ;; Открытие/сохранение res-файла в формате s-obj
           )
  (:export *mask-suffix* 
           res-to-org ;; Сохранение данных о мониторах res-файла в формате org
           dir-to-org ;; Сохранение данных о мониторах res-файлов в формате org
           )
  (:export slice ;; Укорачивает данные объекта от start до end
           slice-last ;; Укорачивает данные объекта оставляя последние number их число
           )
  (:export mk-fname-s-obj ;; Формирует имя s-obj файла на основании res-файла
           mk-fname-res ;; Формирует имя res   файла на основании res-файла
           )
  (:documentation
   "Пакет @(mnas-ansys/exchande) определяет функции, позволяющие извлечь
    информацию из файлов, которые экспортирует Ansys"))

(in-package :mnas-ansys/cfx/file)

(defparameter *n-iter* 500
  "@b(Описание:) параметр @b(*n-iter*) определяет максимальное количество
итераций, извлекаемое из res-файла.")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; defgeneric

(defgeneric iterations (res)
  (:documentation
   "@b(Описание:) обобщенная_функция @b(iterations) возвращает количество
итераций."))

(defgeneric iteration-start (res)
  (:documentation
   "@b(Описание:) обобщенная_функция @b(iteration-start) номер первой
итерации, которая имеется в мониторах."))

(defgeneric iteration-end (res)
  (:documentation
   "@b(Описание:) обобщенная_функция @b(iteration-end) номер последней
итерации, которая имеется в мониторах."))

(defgeneric mon-extract (res n-iter)
  (:documentation
   "@b(Описание:) метод @b(mon-extract) извлекает из res-файла"))

(defgeneric mon-select (regexp res)
  (:documentation
   "@b(Описание:) функция @b(mon-select) возвращает, список, каждый элемент которого
является 2d-списком, содержащим номер и заголовок колонки, удовлетворяющей @b(regexp)
для строки заголовков headered-tabel.

 @b(Переменые:)
@begin(list)
 @item(regexp - регулярное выражение;)
 @item(res - объект, содержащий мониторы.)
@end(list)
"))

(defgeneric mon-select (regexp res)
  (:documentation
"@b(Описание:) обобщенная_функция @b(mon-table) возващает 2d-list, в каждой
 строке которого содержится информация относящаяся к одному монитору:

@begin(list)
  @item(номер по порядку;)
  @item(имя монитора;)
  @item(данные монитору на соответствующем временном шаге;)
@end(list)

 В 2d-list попадают мониторы, имена которых удовлетвоняют регулярному
выражению @b(regexp) согласно правилам пакета cl-ppcre."))

(defgeneric slice (start end obj)
  (:documentation
   "@b(Описание:) обобщенная_функция @b(slice) возващает объект,
представляющий часть исходного @b(obj), оставляя данные начиная с
начального индекса @b(start) включительно и заканчивая конечным
@b(end) его не включая."))

(defgeneric slice-last (number obj)
  (:documentation
   "@b(Описание:) обобщенная_функция @b(slice) возващает объект,
представляющий часть исходного @(obj), оставляя последнее @b(number)
количество данных."))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; defclass

(defclass <res> (serializable-object:serializable-object)
  (
   (mon
    :accessor <res>-mon
    :initarg :mon
    :initform (make-hash-table :test #'equal)
    :documentation "Хешированная таблица мониторов.")
   (res-pname
    :accessor <res>-pathname
    :initarg :res-pname
    :initform nil
    :documentation "Полный путь к res-файлу ANSYS CFX.")
   (ccl
    :accessor <res>-ccl
    :initarg :res-ccl
    :initform nil
    :documentation "Полный путь к res-файлу ANSYS CFX.")
    )
  (:documentation
   "@b(Описание:) Класс @b(<res>) определяет интерфейсы для
 извлечения информации, находящейя в res-файлах системы ANSYS CFX."))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; defmethod

(defmethod print-object ((res <res>) stream)
  (format stream "Res-Pathname   = ~S~%" (<res>-pathname res))
  (format stream "S-Obj-Pathname = ~S~%" (slot-value res 'pathname))
  (when (/= 0 (hash-table-count (<res>-mon res)))
    (format stream "Start=~A; End=~A; Count=~A~%"
            (iteration-start res) (iteration-end res) (iterations res)))
  (when (<res>-ccl res)
    (format stream "~%========================================~%" )
    (format stream "CLL~%")
    (format stream "========================================~%" )
    (format stream "~S" (<res>-ccl res)))
  (when (/= 0 (hash-table-count (<res>-mon res)))
    (format stream "~2%========================================~%" )
    (format stream "Keys~%")
    (format stream "========================================~%" )
    (loop :for k :in (mnas-hash-table:keys (<res>-mon res))
          :for i :from 0
          :do
             (format stream "~5A: ~S~%" i k))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; defmethod

(defmethod mon-extract ((res <res>) (n-iter integer))
  (let* ((h-d (mnas-ansys/exchange:read-res-file
               (<res>-pathname res)
               :rec-number n-iter)) 
         (h (first h-d)) ;; Заголовок мониторов
         (d (cdr   h-d)) ;; Данные  мониторов
         )
    (when h
      (loop :for name :across h 
            :for j :from 0
            :do
               (let* ((mon (mnas-ansys/cfx/file/mon:mk-mon (list j name))))
                 (setf (mnas-ansys/cfx/file/mon:<mon>-data mon)
                       (apply #'vector 
                              (loop :for data :in d
                                    :collect (svref data j))))
                 (setf (gethash
                        (concatenate 'string
                                     (mnas-ansys/cfx/file/mon:<mon>-name mon)
                                     ":"
                                     (mnas-ansys/cfx/file/mon:<mon>-type mon))
                        (<res>-mon res))
                       mon))))))

(defmethod ccl-extract ((res <res>))
  "@b(Описание:) метод @b(ccl-extract) извлекает из res-файла данные на
языке ccl."
  (when (<res>-pathname res)
    (setf (<res>-ccl res)
          (mnas-ansys/exchange:res->ccl (<res>-pathname res)))))

(defmethod save ((res <res>))
  (serializable-object:save res :compression nil))

(defmethod load-instance ((res <res>))
  (setf res
        (serializable-object:load-instance (slot-value res 'pathname))))

(defmethod mon-select (regexp (res <res>))
  " @b(Пример использования:)
@begin[lang=lisp](code)
  (mon-select \"GT OUT.*:Total Temperature\" *res*)
=> (\"GT OUT 100 100:Total Temperature\"
    \"GT OUT 100 101:Total Temperature\"
    ... )
@end(code)
"
  (when (<res>-mon res)
    (let ((rgx (ppcre:create-scanner regexp)))
      (loop :for i :in (alexandria:hash-table-keys (<res>-mon res))
            :when (ppcre:scan rgx i)
              :collect (gethash i (<res>-mon res))))))

(defmethod mon-select ((strings cons) (res <res>))
  " @b(Пример использования:)
@begin[lang=lisp](code)
  (mon-select \"GT OUT.*:Total Temperature\" *res*)
=> (\"GT OUT 100 100:Total Temperature\"
    \"GT OUT 100 101:Total Temperature\"
    ... )
@end(code)
"
  (loop :for key :in strings
        :collect (gethash key (<res>-mon res))))

(defmethod iterations ((res <res>))
  " @b(Пример использования:)
@begin[lang=lisp](code)
 (iterations *res*) => 150
@end(code)"
  (if (and (<res>-mon res) (gethash ":" (<res>-mon res)))
      (length (mnas-ansys/cfx/file/mon:<mon>-data
               (gethash ":" (<res>-mon res))))))

(defmethod iteration-start ((res <res>))
  " @b(Пример использования:)
@begin[lang=lisp](code)
  (iteration-start *res*)
@end(code)"
  (let ((i nil) (v nil))
    (if (and (<res>-mon res)
             (setf i (gethash ":" (<res>-mon res)))
             (setf v (mnas-ansys/cfx/file/mon:<mon>-data i)))
        (svref v 0))))

(defmethod iteration-end ((res <res>))
    " @b(Пример использования:)
@begin[lang=lisp](code)
  (iteration-end   *res*)
@end(code)"
    (let ((i nil) (v nil))
    (if (and (<res>-mon res)
             (setf i (gethash ":" (<res>-mon res)))
             (setf v (mnas-ansys/cfx/file/mon:<mon>-data i)))
        (svref v (1- (length v))))))

(defmethod mon-table (regexp (res <res>))
  " @b(Пример использования:)
@begin[lang=lisp](code)
  (mon-table \".*MFR.*\" *res*)
@end(code)
"
  (when (<res>-mon res)
    (let ((selected (mon-select regexp res)))
      (loop :for name :in selected
            :for i :from 1
            :collect
            (append (list i name)
                    (coerce
                     (mnas-ansys/cfx/file/mon:<mon>-data
                      (gethash name
                               (<res>-mon res)))
                     'list))))))

(defmethod mon-table-ave (regexp (res <res>))
  " @b(Пример использования:)
@begin[lang=lisp](code)
  (mon-table \".*MFR.*\" *res*)
@end(code)
"
  (when (<res>-mon res)
    (let ((selected (mon-select regexp res)))
      (loop :for name :in selected
            :for i :from 1
            :collect
            (let ((data (mnas-ansys/cfx/file/mon:<mon>-data
                         (gethash name (<res>-mon res)))))
              (append (list i name)
                    (list (math/stat:average-value data)
                          (math/stat:standard-deviation (coerce data 'list))
                          (math/stat:variation-coefficient (coerce data 'list))
                          )))))))



(defmethod mon-to-org (regexp (res <res>) &key (suffix ""))
  "@b(Описание:) метод @b(mon-to-org) возвращает имя org-файла, в
который выводятся данные, связанные с мониторами объекта @b(res),
которые удовлетвоняют регулярному выражению @b(regexp) согласно
правилам пакета cl-ppcre.
"
  (let* ((rgx (ppcre:create-scanner ".*(?=[.][-|_|a-z|A-Z|0-9]+$)")) ; Извлечение из полного пути файла - полного пути без расширения
         (res-fname
           (ppcre:scan-to-strings rgx (<res>-pathname res)))
         (s-obj-fname
           (ppcre:scan-to-strings rgx  (slot-value res 'pathname)))
         )
    (cond
      (res-fname
       (with-open-file
           (stream
            (concatenate 'string res-fname suffix ".org")
            :direction :output
            :if-exists :supersede)
         (mnas-org-mode:table-to-org (mon-table regexp res) stream)
         (concatenate 'string res-fname suffix ".org")
         ))
      (s-obj-fname
       (with-open-file
           (stream
            (concatenate 'string s-obj-fname suffix ".org")
            :direction :output
            :if-exists :supersede)
         (mnas-org-mode:table-to-org (mon-table regexp res) stream)
         (concatenate 'string s-obj-fname suffix ".org"))))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun open-cfx-file (res-file-name &key (n-iter *n-iter*) (force-load nil))
  "@b(Описание:) функция @b(open-cfx-file) возвращает объект класса <res>."
  (res-to-s-obj res-file-name :n-iter n-iter :force-load force-load))
  
(defun res-to-s-obj (res-file-name &key (n-iter *n-iter*) (force-load nil))
  "@b(Описание:) функция @b(res-to-s-obj) возвращает объект класса <res>.

 @b(Переменые:)
@begin(list)
 @item(res-file-name - полное имя res-файла;)
 @item(n-iter - количество итераций по мониторам;)
 @item(force-load - признак принудительной выгрузки данных из
       res-файла.)
@end(list)
   Если данные объекта извлекаются:
@begin(list)
 @item(res-файла - если s-obj-файл не существует или force-load не
       равно nil;)
 @item(s-obj-файла - если s-obj-файл существует и force-load равен
      nil;)
@end(list)"
  (let* ((res-fn    (mk-fname-res   res-file-name))
         (s-obj-fn  (mk-fname-s-obj res-file-name))
         (res nil))
    (cond
;;;; Если есть res и s-obj и нет признака обязательного повторного разбора
      ((and (probe-file res-fn)
            (probe-file s-obj-fn)
            (null force-load))
       (setf res
             (make-instance 'mnas-ansys/cfx/file:<res>
                            :res-pname (namestring res-fn)
                            :pathname  (namestring s-obj-fn)))
       (setf res (mnas-ansys/cfx/file:load-instance res))
       res)
;;;; Если есть res и и нет s-obj
      ((and (probe-file res-fn)
            (null (probe-file s-obj-fn)))
       (setf res
             (make-instance 'mnas-ansys/cfx/file:<res>
                            :res-pname (namestring res-fn)
                            :pathname  (namestring s-obj-fn)))
       (mnas-ansys/cfx/file:ccl-extract res)
       (mnas-ansys/cfx/file:mon-extract res n-iter)
       (mnas-ansys/cfx/file:save        res)
       res)
;;;; Если есть res и s-obj и есть признак обязательного повторного разбора      
      ((and (probe-file res-fn)
            (probe-file s-obj-fn)
            force-load)
       (delete-file s-obj-fn)
       (setf res
             (make-instance 'mnas-ansys/cfx/file:<res>
                            :res-pname (namestring res-fn)
                            :pathname  (namestring s-obj-fn)))
       (mnas-ansys/cfx/file:ccl-extract res)
       (mnas-ansys/cfx/file:mon-extract res n-iter)
       (mnas-ansys/cfx/file:save        res)
       res)
      )))

(defun dir-to-s-obj (dir &key (n-iter *n-iter*) (force-load nil))
  "@b(Описание:) функция @b(dir-to-s-obj) создает для res-файлов,
удовлетворяющих шаблону @b(dir), скомпилированные файлы с расширением
 s-obj для обеспечения быстрой загрузки.

 @b(Пример использования:)
@begin[lang=lisp](code)
 (dir-to-s-obj \"D:/home/_namatv/CFX/n70/cfx/Ne_R=1.00/N70_prj_16/*.res\"
              :n-iter 500
              :force-load t)
@end(code)"
  (loop :for i :in (directory dir)
        :do
           (res-to-s-obj
             (namestring i)
             :n-iter n-iter
             :force-load force-load)))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defparameter *mask-suffix*
  '(("^.*$"                      "-ALL")
    ("^:$"                       "-A-TIME")
    ("^CH1 .*:Total Temperature" "-CH1-TT")))

(defun res-to-org (res &key (mask *mask-suffix*))
  "@b(Описание:) функция @b(res-to-org) выводит в сооветствующие
org-файлы данные мониторов для объекта res класса
'<res>.

  Перед выводом данные о мониторах загружаются из сериализованного
представления (из s-obj-файла).  Org-файлы сохраняются в каталог, где
располагаются res-файл и s-obj-файл.

 @b(Пример использования:)
@begin[lang=lisp](code)
 (res-to-org 
  (res-to-s-obj
   \"D:/home/_namatv/CFX/n70/cfx/Ne_R=1.00/N70_prj_07/N70_prj_07_001.res\"))
@end(code)
"
  (setf res (load-instance res)) ; Загружаем объект из s-obj-файла
  (loop :for (msk suf) :in mask
        :do
           (mon-to-org msk res :suffix suf)
        ))

(defun dir-to-org (dir &key (mask *mask-suffix*) (n-iter *n-iter*) (force-load nil))
  "@b(Описание:) функция @b(dir-to-org) выполняет сканирование каталога
@b(dir) на наличие res-файлов, удовлетворяющих маске поиска, и создает
для каждого из них набор org-файлов.

@b(Пример использования:)
@begin[lang=lisp](code)
  (dir-to-org \"D:/home/_namatv/CFX/n70/cfx/Ne_R=1.00/N70_prj_07/*.res\")
@end(code)
"
  (loop :for i :in (directory dir)
        :do
           (res-to-org 
            (res-to-s-obj (namestring i) :n-iter n-iter :force-load force-load)
            :mask mask )))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defmethod slice (start end (v simple-vector))
  (coerce
   (loop :for i :from (max 0 start) :below (min (length v) end)
         :collect
         (svref v i))
   'simple-vector))

(defmethod slice (start end (res <res>))
  (loop :for k :in (mnas-hash-table:keys (<res>-mon res))
        :collect
        (let ((v (mnas-ansys/cfx/file/mon:<mon>-data
                  (gethash k (<res>-mon res)))))
          (setf (mnas-ansys/cfx/file/mon:<mon>-data (gethash k (<res>-mon res)))
                (slice start end v)))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defmethod slice-last (number (v simple-vector))
  (coerce 
   (last 
    (coerce v 'list)
    (min (length v) number))
   'simple-vector))

(defmethod slice-last (number (res <res>))
  (loop :for k :in (mnas-hash-table:keys (<res>-mon res))
        :collect
        (let ((v (mnas-ansys/cfx/file/mon:<mon>-data
                  (gethash k (<res>-mon res)))))
          (setf (mnas-ansys/cfx/file/mon:<mon>-data (gethash k (<res>-mon res)))
                (slice-last number v))))
  res)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun mk-fname-s-obj (res-file-name)
  (let ((device    (pathname-device    res-file-name))
        (directory (pathname-directory res-file-name))
        (name      (pathname-name      res-file-name)))
    (make-pathname :device    device
                   :directory directory
                   :name      name
                   :type      "s-obj")))

(defun mk-fname-res (res-file-name)
  (let ((device    (pathname-device    res-file-name))
        (directory (pathname-directory res-file-name))
        (name      (pathname-name      res-file-name)))
    (make-pathname :device    device
                   :directory directory
                   :name      name
                   :type      "res")))

(defmethod mon-check (mon-name (res <res>))
  (let ((mon (gethash mon-name (mnas-ansys/cfx/file:<res>-mon  res))))
    (if mon
        (mnas-ansys/cfx/file/mon:<mon>-data mon)
        (format t "~S~%" mon-name))))

(defmethod mon-check ((mon-names cons) (res <res>))
  (loop :for i :in mon-names
        :do
           (mon-check i res)))
