;;;; ./src/cfx/pre/class.lisp

(in-package :mnas-ansys/cfx/pre)

;; <dom-sur> -> <domain>

;; <cfx-domains>  -> <simulation>
;; *cfx-domains*  -> *simulation*
;; <cfx-domain>   -> <domain>
;; <icem-domains> -> <meshes>
;; <icem-domain>  -> <mesh>
;; <meshes>-domains -> ht

(defclass <mesh> ()
  ((mesh-name
    :accessor <mesh>-name
    :initarg  :name
    :initform nil
    :documentation "Именя домена, например: \"G1\".")
   (surfaces
    :accessor <mesh>-surfaces
    :initform (make-hash-table :test #'equal)
    :documentation "Хеш-таблица имен поверхностей, относящихся к домену по именному
соглашению ICEM."))
  (:documentation "Класс @b(<mesh>) представляет 3d-сетку системы ICEM."))

(defclass <meshes> ()
  ((meshes
    :accessor <meshes>-meshes
    :initform (make-hash-table :test #'equal)
    :documentation
    "Хеш-таблица частей, в которых присутствуют поверхности, для каждого
сеточного домена ICEM CFD.")))

(defclass <domain> ()
  ((domain-name
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
  ((simulation-domains
    :accessor <simulation>-domains
    :initform (make-hash-table :test #'equal)
    :documentation
    "Список частей, в которых присутствуют поверхности импортируется из
ICEM CFD.")
   (simulation-surfaces
    :accessor <simulation>-surfaces
    :initform (make-hash-table :test #'equal)
    :documentation "Хеш-таблица имен поверхностей, относящихся ко всей симуляции по
именному соглашению CFX.")))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



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
