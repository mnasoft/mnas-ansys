;;;; ./src/cfx/file/mon/mon.lisp

(defpackage :mnas-ansys/cfx/file/mon
  (:use #:cl)
  (:export <mon>-number
           <mon>-des
           <mon>-name
           <mon>-domen
           <mon>-coords
           <mon>-location
           <mon>-type
           <mon>-data
           mk-key       ;; fam+name+type
           )
  (:export mk-mon)
  (:documentation
   "Пакет @(mnas-ansys/exchande) определяет функции, позволяющие извлечь
    информацию из файлов, которые экспортирует Ansys"))

(in-package :mnas-ansys/cfx/file/mon)

(defclass <mon> (serializable-object:serializable-object)
  ((number
    :accessor <mon>-number
    :initarg :number
    :initform nil
    :documentation "Номер.")
   (des
    :accessor <mon>-des
    :initarg :number
    :initform nil
    :documentation "Обозначение (полное).")
   (fam
    :accessor <mon>-fam
    :initarg :number
    :initform nil
    :documentation "Семейство (первый аргумент).")
   (name
    :accessor <mon>-name
    :initarg :number
    :initform nil
    :documentation "Имя (второй аргумент).")
   (domen
    :accessor <mon>-domen
    :initarg :domen
    :initform nil
    :documentation "Домен (третий аргумент).")
   (location
    :accessor <mon>-location
    :initarg :location
    :initform nil
    :documentation "Домен (четвертый аргумент).")
   (coords
    :accessor <mon>-coords
    :initarg :location
    :initform nil
    :documentation "Координаты (последние три из второго аргумента).")
   (type
    :accessor <mon>-type
    :initarg :type
    :initform nil
    :documentation "Домен (третий аргумент).")
   (data
    :accessor <mon>-data
    :initarg :number
    :initform nil
    :documentation "Данные монитора. Вектор значений.")
   ))

(defmethod print-object ((mon <mon>) stream)
  (format stream "number   = ~S~%" (<mon>-number mon))
  (format stream "des      = ~S~%" (<mon>-des mon))
  (format stream "fam      = ~S~%" (<mon>-fam mon))
  (format stream "name     = ~S~%" (<mon>-name mon))

  (format stream "domen    = ~S~%" (<mon>-domen mon))
  (format stream "location = ~S~%" (<mon>-location mon))
  (format stream "coords   = ~S~%" (<mon>-coords mon))
  (format stream "type     = ~S~%" (<mon>-type mon)))

(defun mk-mon (mon-num-name)
  (let ((mon (make-instance '<mon>)))
    (setf
     (<mon>-number   mon)   (mnas-ansys/cfx/file/mon/core:mon-number   mon-num-name)
     (<mon>-des      mon)   (mnas-ansys/cfx/file/mon/core:mon-des      mon-num-name)
     (<mon>-fam      mon)   (mnas-ansys/cfx/file/mon/core:mon-fam      mon-num-name)
     (<mon>-name     mon)   (mnas-ansys/cfx/file/mon/core:mon-name     mon-num-name)
     (<mon>-domen    mon)   (mnas-ansys/cfx/file/mon/core:mon-domen    mon-num-name)
     (<mon>-coords   mon)   (mnas-ansys/cfx/file/mon/core:mon-coords   mon-num-name)
     (<mon>-location mon)   (mnas-ansys/cfx/file/mon/core:mon-location mon-num-name)
     (<mon>-type     mon)   (mnas-ansys/cfx/file/mon/core:mon-type     mon-num-name))
    mon))

(defmethod mk-key ((mon <mon>))
  (cond
  ((<mon>-name mon)
   (format nil "~{~A~^,~}" (list (<mon>-name mon) (<mon>-type mon))))
  ((<mon>-fam mon))))

#+nil
(let ((rez ""))
    (when (<mon>-fam mon)
      (setf rez (concatenate 'string rez (<mon>-fam mon))))
    (when (<mon>-name mon)
      (setf rez (concatenate 'string rez "," (<mon>-name mon))))
    (when (<mon>-type mon)
      (setf rez (concatenate 'string rez "," (<mon>-type mon))))
    rez)
  
#+nil (vector 1.0  2.0 3.0)
