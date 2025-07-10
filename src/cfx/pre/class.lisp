;;;; ./src/cfx/pre/class.lisp

(in-package :mnas-ansys/cfx/pre)

;; <dom-sur> -> <cfx-domain>

;; <cfx-domains>  -> <simulation>
;; <cfx-domain>   -> <domain>
;; <icem-domains> -> <meshes>
;; <icem-domain>  -> <mesh>

(defclass <icem-domain> ()
  ((icem-domain-name
    :accessor <icem-domain>-name
    :initarg  :name
    :initform nil
    :documentation "Именя домена, например: \"G1\".")
   (icem-domain-surfases
    :accessor <icem-domain>-surfaces
    :initform (make-hash-table :test #'equal)
    :documentation "Хеш-таблица имен поверхностей, относящихся к домену по именному
соглашению ICEM.")))

(defclass <icem-domains> ()
  ((icem-domains
    :accessor <icem-domains>-domains
    :initform (make-hash-table :test #'equal)
    :documentation
    "Хеш-таблица частей, в которых присутствуют поверхности, для каждого
сеточного домена ICEM CFD.")))

(defclass <cfx-domain> ()
  ((cfx-domain-name
    :accessor <cfx-domain>-name
    :initarg  :name
    :initform nil
    :documentation "Именя домена, например: \"DG1 G1\".")
   (cfx-domain-surfaces
    :accessor <cfx-domain>-surfaсes
    ;; :initarg  :surfases
    :initform (make-hash-table :test #'equal)
    :documentation "Хеш-таблица имен поверхностей, относящихся к домену по именному
соглашению CFX.")))

(defclass <cfx-domains> (<icem-domains>)
  ((cfx-domains
    :accessor <cfx-domains>-domains
    :initform (make-hash-table :test #'equal)
    :documentation
    "Список частей, в которых присутствуют поверхности импортируется из
ICEM CFD.")
   (cfx-domainssurfaces
    :accessor <cfx-domains>-surfaces
    :initform (make-hash-table :test #'equal)
    :documentation "Хеш-таблица имен поверхностей, относящихся ко всей симуляции по
именному соглашению CFX.")))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defmethod print-object ((domain <icem-domain>) s)
  (print-unreadable-object (domain s :type t)
    (format s "~S ~S"
            (<icem-domain>-name domain)
            (<icem-domain>-surfaces domain))))

(defmethod print-object ((domains <icem-domains>) s)
  (print-unreadable-object (domains s :type t)
    (format s "~S" (domains domains))))

(defmethod print-object ((domain <cfx-domain>) s)
  (print-unreadable-object (domain s :type t)
    (format s "~%~S~%~S"
            (<cfx-domain>-name domain)
            (sort (alexandria:hash-table-keys
                   (<cfx-domain>-surfaсes domain))
                  #'string<))))

(defmethod print-object ((domains <cfx-domains>) s)
  (print-unreadable-object (domains s :type t)
    (format s "~%Meshes  : ~S"
            (sort
             (alexandria:hash-table-keys
              (<icem-domains>-domains *cfx-domains*))
             #'string<))
    (format s "~%~S~%Surfaces: ~S"
            (sort 
             (alexandria:hash-table-values
              (<cfx-domains>-domains domains))
             #'string< :key #'<cfx-domain>-name)
            (<cfx-domains>-surfaces domains))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

#+nil
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
