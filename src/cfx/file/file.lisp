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
           mon-to-org  ;; Вывод в файл с именем как у res-файла и расширением org
           )
  (:export iterations  ;; Количество итераций, по данным мониторов
           iteration-start ;; Номер начальной итерации
           iterations-end) ;; Номер конечной  итерации
  (:export find-in-ccl ;; Поиск вглубину по данным ccl.
           )
  (:export res->ccl)
  (:documentation
   "Пакет @(mnas-ansys/exchande) определяет функции, позволяющие извлечь
    информацию из файлов, которые экспортирует Ansys"))

(in-package :mnas-ansys/cfx/file)

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
"@b(Описание:) метод @b(mon-table) возващает 2d-list, в каждой
 строке которого содержится информация относящаяся к одному монитору:

@begin(list)
  @item(номер по порядку;)
  @item(имя монитора;)
  @item(данные монитору на соответствующем временном шаге;)
@end(list)

 В 2d-list попадают мониторы, имена которых удовлетвоняют регулярному
выражению @b(regexp) согласно правилам пакета cl-ppcre."))
  

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
      (loop :for i :in (mnas-hash-table:keys (<res>-mon res))
            :when (ppcre:scan rgx i)
              :collect i))))

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
