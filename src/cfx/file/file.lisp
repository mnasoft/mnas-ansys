;;;; ./src/cfx/file/file.lisp

(defpackage :mnas-ansys/cfx/file
  (:use #:cl)
  (:export <htable>       ;; Класс таблицы
           <htable>-head  ;; Аксессор заголовока таблицы
           <htable>-data  ;; Аксессор данных таблицы
           )
  (:export <res>
           <res>-res-pname
           )
  (:export extract        ;; Извлечение данных о мониторах из res-файла
           save           ;; Сохранение объекта
           load-instance  ;; Загрузка объекта из файла
           select         ;; Выборка из объекта по определенным мониторам
           monitor-table  ;; Список номер пп, имя, данные по монитору
           monitor-to-org ;; Вывод в файл с именем как у res-файла и расширением org
           )
  (:export convert-coord)
  (:export res->ccl)
  (:documentation
   "Пакет @(mnas-ansys/exchande) определяет функции, позволяющие извлечь
    информацию из файлов, которые экспортирует Ansys"))

(in-package :mnas-ansys/cfx/file)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; defclass

(defclass <htable> (serializable-object:serializable-object)
  ((head
    :accessor <htable>-head
    :initarg :head
    :initform nil
    :documentation "Строка заголовков.")
   (data
    :accessor <htable>-data
    :initarg :data
    :initform nil
    :documentation "Данные."))
  (:documentation
   "@b(Описание:) Класс @b(<htable>) определяет интерфейсы для
 извлечения информации, находящейя в res-файлах системы ANSYS CFX."))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defclass <res> (<htable>)
  ((res-pname
    :accessor <res>-res-pname
    :initarg :res-pname
    :initform nil
    :documentation "Полный путь к res-файлу ANSYS CFX."))
  (:documentation
   "@b(Описание:) Класс @b(<htable>) определяет интерфейсы для
 извлечения информации, находящейя в res-файлах системы ANSYS CFX."))

(defmethod print-object ((res <res>) stream)
  (format stream "Res-Pathname   = ~S~%" (<res>-res-pname res))
  (format stream "S-Obj-Pathname = ~S~%" (slot-value res 'pathname))
  (when (<htable>-data res)
    (format stream "Data Length = ~S~%" (length (<htable>-data res))))
  (when (<htable>-head res)
    (format stream "Key Length = ~S~%" (length (<htable>-head res)))
    (format stream "========================================~%" )
    (format stream "Keys~%")
    (format stream "========================================~%" )
    (loop :for k :across (<htable>-head res)
          :for i :from 0
          :do
      (format stream "~5A: ~A~%" i k))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; defmethod

(defmethod extract ((res <res>) (n-iter integer))
  "@b(Описание:) метод @b(extract) извлекает из res-файла 
"
  (let ((h-d (mnas-ansys/exchange:read-res-file (<res>-res-pname res) :rec-number n-iter)))
    (setf (<htable>-head res) (first h-d))
    (setf (<htable>-data res) (cdr   h-d))))

(defmethod save ((res <res>))
  (serializable-object:save res :compression nil))

(defmethod load-instance ((res <res>))
  (setf res
        (serializable-object:load-instance (slot-value res 'pathname))))

(defmethod select (regexp (res <res>))
  "@b(Описание:) функция @b(select) возвращает, список, каждый элемент которого
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
  (when (<htable>-head res)
  (let ((rgx (ppcre:create-scanner regexp)))
    (loop :for i :across (<htable>-head res)
          :for j :from 0
          :when (ppcre:scan rgx i)
            :collect `(,j ,i)))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defmethod monitor-table ((res <res>) &key (regexp ".*MFR.*"))
  (when (<htable>-head res))
  (let ((selected (select regexp res)))
    (loop :for (i name) :in selected
          :collect
          (append (list i name) (loop :for val :in (<htable>-data res) :collect (svref val i))))))

(defmethod monitor-to-org ((res <res>) &key (regexp ".*MFR.*"))
  (let* ((rgx (ppcre:create-scanner ".*(?=[.][-|_|a-z|A-Z|0-9]+$)")) ; Извлечение из полного пути файла - полного пути без расширения
         (res-fname
           (ppcre:scan-to-strings rgx (<res>-res-pname res)))
         (s-obj-fname
           (ppcre:scan-to-strings rgx  (slot-value res 'pathname)))
         )
    (cond
      (res-fname
       (with-open-file
           (stream
            (concatenate 'string res-fname ".org")
            :direction :output
            :if-exists :supersede)
         (mnas-org-mode:table-to-org (monitor-table res :regexp regexp) stream)
         (concatenate 'string res-fname ".org")
         ))
      (s-obj-fname
       (with-open-file
           (stream
            (concatenate 'string s-obj-fname ".org")
            :direction :output
            :if-exists :supersede)
         (mnas-org-mode:table-to-org (monitor-table res :regexp regexp) stream)
         (concatenate 'string s-obj-fname ".org")
         )))))

