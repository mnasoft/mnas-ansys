;;;; ./src/cfx/pre/class.lisp

(in-package :mnas-ansys/cfx/pre)

;; <dom-sur> -> <cfx-domain>

(defclass <cfx-domain> ()
  ((name :accessor <cfx-domain>-name
         :initarg  :name
         :initform nil
         :documentation "Именя домена, например: \"DG1 G1\".")
   (surfases
    :accessor <cfx-domain>-surfases
    ;; :initarg  :surfases
    :initform (make-hash-table :test #'equal)
    :documentation "Хеш-таблица имен поверхностей, относящихся к домену по именному
соглашению CFX.")))

(defclass <cfx-domains> ()
  ((icem-parts
    :accessor <cfx-domains>-icem-parts
    ;;:initarg  :parts
    :initform (make-hash-table :test #'equal)
    :documentation
    "Хеш-таблица частей, в которых присутствуют поверхности импортируется
из ICEM CFD.")
   (domains
    :accessor <cfx-domains>-domains
    ;; :initarg  :domains
    :initform (make-hash-table :test #'equal)
    :documentation
    "Список частей, в которых присутствуют поверхности импортируется из
ICEM CFD.")))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defmethod print-object ((domain <cfx-domain>) s)
  (print-unreadable-object (domain s :type t)
    (format s "~S ~S" (<cfx-domain>-name domain) (<cfx-domain>-surfases domain))))

;; (make-instance '<cfx-domain> :name "DG1 G1")

(defmethod print-object ((domains <cfx-domains>) s)
  (print-unreadable-object (domains s :type t)
    (format s "icem-parts: ~S ~S"
            (hash-table-count (<cfx-domains>-icem-parts domains))
            (<cfx-domains>-domains domains))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defmethod initialize-instance :after ((cfx-domains <cfx-domains>)
                                       &key icem-parts)
  (mapcar
   #'(lambda (el)
       (setf
        (gethash el
                 (<cfx-domains>-icem-parts cfx-domains))
        el))
   icem-parts)
  cfx-domains)
