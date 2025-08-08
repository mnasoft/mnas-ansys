;;;; ./src/cfx/pre/class.lisp

(in-package :mnas-ansys/cfx/pre)

;; <cfx-domains>  -> <simulation>
;; *cfx-domains*  -> *simulation*
;; <icem-domains> -> <meshes>
;; <icem-domain>  -> <mesh>
;; <meshes>-domains -> ht

(defclass <mesh> ()
  ((mesh-3d-region-instance-number
    :accessor <mesh>-3d-region-instance-number
    :initarg  :3d-region-instance-number
    :initform 0
    :documentation "Количество 3d-регионов, которые ссылаются на эту сетку.")
   (mesh-tin-pathname
    :accessor <mesh>-tin-pathname
    :initarg  :tin-pathname
    :initform nil
    :documentation "Путь к в файловой системе tin-файлу геометрии.")
   (mesh-msh-pathname
    :accessor <mesh>-msh-pathname
    :initarg  :msh-pathname
    :initform nil
    :documentation "Путь в файловой системе к msh-файлу 3d-сетки.")
   (mesh-name
    :accessor <mesh>-name
    :initarg  :name
    :initform nil
    :documentation "Именя домена, например: \"G1\".")
   (2d-regions
    :accessor <mesh>-2d-regions ; <mesh>-surfaces <mesh>-2d-regions
    :initform (make-hash-table :test #'equal)
    :documentation "Хеш-таблица имен поверхностей, относящихся к домену по именному
соглашению ICEM."))
  (:documentation "Класс @b(<mesh>) представляет 3d-сетку системы ICEM."))

(defclass <3d-region> ()
  ((3d-region-mesh
    :accessor <3d-region>-mesh
    :initarg  :mesh
    :initform nil
    :documentation "Ссылка на объект типа <mesh>.")
   (3d-region-simulation
    :accessor <3d-region>-simulation
    :initarg  :simulation
    :initform nil
    :documentation "Ссылка на объект типа <simulation>.")
   (3d-region-3d-suffix
    :accessor <3d-region>-3d-suffix
    :initarg  :3d-suffix
    :initform nil
    :documentation "Суффикс 3d-региона. Например: 1, 2, 3.")
   (3d-region-2d-suffix
    :accessor <3d-region>-2d-suffix
    :initarg  :2d-suffix
    :initform nil
    :documentation "Суффикс для 2d-регионов. Например: 1, 2, 3.")))

(defclass <simulation> ()
  ((simulation-meshes
    :accessor <simulation>-meshes
    :initform (make-hash-table :test #'equal)
    :documentation "Представляет совокупность сеток загружаемых в симуляцию. Хеш-таблица
частей: ключ - имя; значение объект типа <mesh>.")
   (simulation-3d-regions
    :accessor <simulation>-3d-regions
    :initform (make-hash-table :test #'equal)
    :documentation
    "Хеш-таблица; ключ - объект типа <domain>; значение - объект типа
<domain>"))
  (:documentation "")
  )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


