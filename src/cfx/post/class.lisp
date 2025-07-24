;;;; ./src/cfx/post/class.lisp

(in-package :mnas-ansys/cfx/post)

(defclass <result> ()
  ((result
    :accessor <result>-result
    :initarg :result
    :type mnas-ansys/cfx/file:<res>
    :documentation "Файл с результатами расчета.")))

(defmethod print-object ((obj <result>) s)
  (print-unreadable-object (obj s)
    (format s "~S" (<result>-result obj))))

(defclass <res-report> (<result>)
  ((boundares
    :accessor <res-report>-boundares
    :initarg :boundares
    :initform *boundares*
    :documentation "Мониторы по граничным условиям.")
   (mfr-flame-tubes
    :accessor <res-report>-mfr-flame-tubes
    :initarg :flame-tubes
    :initform *mfr-flame-tubes*
    :documentation "Мониторы по тректам входа воздуха в ЖТ."))
  (:documentation "Содержит данные для составления отчета."))

(defclass <mfr-gt-tract> ()
  ((designation
    :accessor <mfr-gt-tract>-designation
    :initarg :designation
    :initform nil
    :documentation "Обозначение на рисунке.")
   (x
    :accessor <mfr-gt-tract>-x
    :initarg :x
    :initform nil
    :documentation "Координата от начала ЖТ.")
   (monitor
    :accessor <mfr-gt-tract>-monitor
    :initarg :monitor
    :initform nil
    :documentation "Обозначение монитора.")
   (group
    :accessor <mfr-gt-tract>-group
    :initarg :group
    :initform nil
    :documentation "Группа.")
   (description
    :accessor <mfr-gt-tract>-description
    :initarg :description
    :initform nil
    :documentation "Описание сечения.")
   (sign
    :accessor <mfr-gt-tract>-sign
    :initarg :sign
    :initform +1
    :documentation "Знак по отношению к домену представляющему ЖТ. Если указана
поверхность соседнего домена - знак минус; иначе плюс.")
   ))

(defclass <mfr-gt> (<result>)
  ((name
    :accessor <mfr-gt>-name
    :initarg :name
    :initform nil
    :documentation "Имя для ЖТ.")
   (tracts
    :accessor <mfr-gt>-tracts
    :initarg :tracts
    :initform nil
    :documentation "Именованая жаровая труба как список трактов для прохода воздуха.")))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defclass <tf-gt> (<result>)
  ((name
    :accessor <tf-gt>-name
    :initarg :name
    :initform nil
    :documentation "Имя для ЖТ.")
   (mon-prefix
    :accessor <tf-gt>-mon-prefix
    :initarg :mon-prefix
    :initform "GT R OUT"
    :documentation "Имя для ЖТ.")
   (r-max
    :accessor <tf-gt>-r-max
    :initarg :r-max
    :initform 477.0
    :documentation "R-max")
   (r-min
    :accessor <tf-gt>-r-min
    :initarg :r-min
    :initform 411.0
    :documentation "R-min")
   (r-num
    :accessor <tf-gt>-r-num
    :initarg :r-num
    :initform 15
    :documentation "R-num")
   (r-start-index
    :accessor <tf-gt>-r-start-index
    :initarg :r-start-index
    :initform 100
    :documentation "R-max")
   (r-small
    :accessor <tf-gt>-r-small
    :initarg :r-small
    :initform 2.5
    :documentation "r-small - радиус скругления")
   (n-tube
    :accessor <tf-gt>-n-tube
    :initarg :n-tube
    :initform 16
    :documentation "N-tube")
   (a
    :accessor <tf-gt>-a
    :initarg :a
    :initform 10.5
    :documentation "A")
   (a-num
    :accessor <tf-gt>-a-num
    :initarg :a-num
    :initform 31
    :documentation "A")
   (a-start-index
    :accessor <tf-gt>-a-start-index
    :initarg :a-start-index
    :initform 100
    :documentation "a-start-index")
   (delta
    :accessor <tf-gt>-delta
    :initarg :delta
    :initform 2.0524
    :documentation "Delta")))
