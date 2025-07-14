;;;; ./src/cfx/pre/class.lisp

(in-package :mnas-ansys/cfx/pre)

;; <dom-sur> -> <domain>

;; <cfx-domains>  -> <simulation>
;; *cfx-domains*  -> *simulation*
;; <cfx-domain>   -> <domain>
;; <icem-domains> -> <meshes>
;; <icem-domain>  -> <mesh>

(defclass <mesh> ()
  ((icem-domain-name
    :accessor <mesh>-name
    :initarg  :name
    :initform nil
    :documentation "Именя домена, например: \"G1\".")
   (icem-domain-surfases
    :accessor <mesh>-surfaces
    :initform (make-hash-table :test #'equal)
    :documentation "Хеш-таблица имен поверхностей, относящихся к домену по именному
соглашению ICEM.")))

(defclass <meshes> ()
  ((icem-domains
    :accessor <meshes>-domains
    :initform (make-hash-table :test #'equal)
    :documentation
    "Хеш-таблица частей, в которых присутствуют поверхности, для каждого
сеточного домена ICEM CFD.")))

(defclass <domain> ()
  ((cfx-domain-name
    :accessor <domain>-name
    :initarg  :name
    :initform nil
    :documentation "Именя домена, например: \"DG1 G1\".")
   (cfx-domain-surfaces
    :accessor <domain>-surfaсes
    ;; :initarg  :surfases
    :initform (make-hash-table :test #'equal)
    :documentation "Хеш-таблица имен поверхностей, относящихся к домену по именному
соглашению CFX.")))

(defclass <simulation> (<meshes>)
  ((cfx-domains
    :accessor <simulation>-domains
    :initform (make-hash-table :test #'equal)
    :documentation
    "Список частей, в которых присутствуют поверхности импортируется из
ICEM CFD.")
   (cfx-domainssurfaces
    :accessor <simulation>-surfaces
    :initform (make-hash-table :test #'equal)
    :documentation "Хеш-таблица имен поверхностей, относящихся ко всей симуляции по
именному соглашению CFX.")))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defmethod print-object ((domain <mesh>) s)
  (print-unreadable-object (domain s :type t)
    (format s "~S ~S"
            (<mesh>-name domain)
            (<mesh>-surfaces domain))))

(defmethod print-object ((domains <meshes>) s)
  (print-unreadable-object (domains s :type t)
    (format s "~S" (domains domains))))

(defmethod print-object ((domain <domain>) s)
  (print-unreadable-object (domain s :type t)
    (format s "~%~S~%~S"
            (<domain>-name domain)
            (sort (alexandria:hash-table-keys
                   (<domain>-surfaсes domain))
                  #'string<))))

(defmethod print-object ((simulation <simulation>) s)
  (print-unreadable-object (simulation s :type t)
    (format s "~%Meshes  : ~S"
            (sort
             (alexandria:hash-table-keys
              (<meshes>-domains simulation))
             #'string<))
    (format s "~%~S~%Surfaces: ~S"
            (sort 
             (alexandria:hash-table-values
              (<simulation>-domains simulation))
             #'string< :key #'<domain>-name)
            (<simulation>-surfaces simulation))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

#+nil
(defmethod initialize-instance :after ((cfx-domains <simulation>)
                                       &key icem-parts)
  (mapcar
   #'(lambda (el)
       (setf
        (gethash el
                 (<simulation>-icem-parts cfx-domains))
        el))
   icem-parts)
  cfx-domains)
