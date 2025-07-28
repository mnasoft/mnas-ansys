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
  ((domain-parent
    :accessor <domain>-parent
    :initarg  :parent
    :initform nil
    :documentation "Ссылка на объект типа <simulation>.")
   (domain-name
    :accessor <domain>-name
    :initarg  :name
    :initform nil
    :documentation "Имя домена, например: \"DG1 G1\".")
   (domain-surfaces
    :accessor <domain>-surfaсes
    ;; :initarg  :surfases
    :initform (make-hash-table :test #'equal)
    :documentation "Хеш-таблица имен поверхностей, относящихся к домену.
У которой ключ - строка в именном соглашении ICEM, а значение - строка
в именном соглашении CFX.")))

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


