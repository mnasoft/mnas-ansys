;;;; ./src/mesh/mesh-log.lisp

(in-package :mnas-ansys/mesh-log)

(defclass <mesh-log> ()
  ((name
    :accessor <mesh-log>-name
    :initarg :name
    :initform nil
    :documentation "Имя файла без расширений")
   (nodes
    :accessor <mesh-log>-nodes
    :initarg :nodes
    :initform 0
    :documentation "Количество узлов в модели")
   (tetra
    :accessor <mesh-log>-tetra
    :initarg :tetra
    :initform 0
    :documentation "Количество тетраэдральных элементов")
   (prism
    :accessor <mesh-log>-prism
    :initarg :prism
    :initform 0
    :documentation "Количество призматических элементов")
   (hex
    :accessor <mesh-log>-hex
    :initarg :hex
    :initform 0
    :documentation "Количество гексаэдральных элементов")
   (scaling-factor
    :accessor <mesh-log>-scaling-factor
    :initarg :scaling-factor
    :initform '(1.0 1.0 1.0)
    :documentation "Масштабный коэффициент (x y z)")
   (has-refinements
    :accessor <mesh-log>-has-refinements
    :initarg :has-refinements
    :initform nil
    :documentation "Флаг наличия block refinements"))
  (:documentation "Класс для хранения данных из лог-файла ICEM CFD"))

(defclass <mesh-log-collection> ()
  ((pattern
    :accessor <mesh-log-collection>-pattern
    :initarg :pattern
    :initform "*.msh.log"
    :documentation "Шаблон для поиска лог-файлов")
   (logs
    :accessor <mesh-log-collection>-logs
    :initarg :logs
    :initform (make-hash-table :test 'equal)
    :documentation "Хеш-таблица: ключ - имя файла, значение - объект <mesh-log>"))
  (:documentation "Класс-контейнер для коллекции лог-файлов ICEM CFD"))
