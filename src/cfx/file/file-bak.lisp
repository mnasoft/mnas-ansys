;;;; ./src/cfx/file/file.lisp

(defpackage :mnas-ansys/cfx/file-bak
  (:use #:cl)
  (:export <res>
           <res>-head     ;; Аксессор заголовока таблицы
           <res>-pathname ;; Аксессор к имени res-файла
           <res>-data     ;; Аксессор данных таблицы
           <res>-ccl      ;; Аксессор к списку ccl
           )
  (:export save          ;; Сохранение объекта
           load-instance ;; Загрузка объекта из файла
           )
  (:export ccl-extract ;; Извлечение данных связанных их файла.
           )
  (:export mon-extract ;; Извлечение данных о мониторах из res-файла
           mon-select  ;; Выборка из объекта по определенным мониторам
           mon-table   ;; Список номер пп, имя, данные по монитору
           mon-to-org  ;; Вывод в файл с именем как у res-файла и расширением org
           )
  (:export find-in-ccl ;; Поиск вглубину по данным ccl.
           )
  (:export convert-coord)
  (:export res->ccl)
  (:documentation
   "Пакет @(mnas-ansys/exchande) определяет функции, позволяющие извлечь
    информацию из файлов, которые экспортирует Ansys"))

(in-package :mnas-ansys/cfx/file-bak)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; defclass

(defclass <res> (serializable-object:serializable-object)
  ((head
    :accessor <res>-head
    :initarg :head
    :initform nil
    :documentation "Строка заголовков.")
   (data
    :accessor <res>-data
    :initarg :data
    :initform nil
    :documentation "Данные.")
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

(defmethod print-object ((res <res>) stream)
  (format stream "Res-Pathname   = ~S~%" (<res>-pathname res))
  (format stream "S-Obj-Pathname = ~S~%" (slot-value res 'pathname))
  (when (<res>-data res)
    (format stream "Data Length = ~S~%" (length (<res>-data res))))
  (when (<res>-ccl res)
    (format stream "~%========================================~%" )
    (format stream "CLL~%")
    (format stream "========================================~%" )
    (format stream "~S" (<res>-ccl res)))
  (when (<res>-head res)
    (format stream "Key Length = ~S~%" (length (<res>-head res)))
    (format stream "~%========================================~%" )
    (format stream "Keys~%")
    (format stream "========================================~%" )
    (loop :for k :across (<res>-head res)
          :for i :from 0
          :do
             (format stream "~5A: ~A~%" i k))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; defmethod

(defmethod mon-extract ((res <res>) (n-iter integer))
  "@b(Описание:) метод @b(mon-extract) извлекает из res-файла 
"
  (let ((h-d (mnas-ansys/exchange:read-res-file (<res>-pathname res) :rec-number n-iter)))
    (setf (<res>-head res) (first h-d))
    (setf (<res>-data res) (cdr   h-d))
    res))

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
  "@b(Описание:) функция @b(mon-select) возвращает, список, каждый элемент которого
является 2d-списком, содержащим номер и заголовок колонки, удовлетворяющей @b(regexp)
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
  (when (<res>-head res)
  (let ((rgx (ppcre:create-scanner regexp)))
    (loop :for i :across (<res>-head res)
          :for j :from 0
          :when (ppcre:scan rgx i)
            :collect `(,j ,i)))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defmethod mon-table (regexp (res <res>))
  "@b(Описание:) метод @b(mon-table) возващает 2d-list, в каждой
 строке которого содержится информация относящаяся к одному монитору:

@begin(list)
  @item(номер по порядку;)
  @item(имя монитора;)
  @item(данные монитору на соответствующем временном шаге;)
@end(list)

 В 2d-list попадают мониторы, имена которых удовлетвоняют регулярному
выражению @b(regexp) согласно правилам пакета cl-ppcre.

 @b(Пример использования:)
@begin[lang=lisp](code)
  (mon-table \".*MFR.*\" *res*)
@end(code)
"
  (when (<res>-head res))
  (let ((selected (mon-select regexp res)))
    (loop :for (i name) :in selected
          :collect
          (append (list i name) (loop :for val :in (<res>-data res) :collect (svref val i))))))

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
         (concatenate 'string s-obj-fname suffix ".org")
         )))))
