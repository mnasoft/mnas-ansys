;;;; ./src/cfx/pre/generic.lisp

(in-package :mnas-ansys/cfx/pre)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; generic

(defgeneric add (item  collection)
  (:documentation
   "Добавляем объект @b(item) в коллекцию @b(collection)."))

(defgeneric 2d-region (key obj)
  (:documentation
   "Возвращает имя 2d-региона по ключу имя Icem."))

(defgeneric 2d-region-values (obj)
  (:documentation
   "Возвращает список имен 2d-регионов объекта @b(obj)."))

(defgeneric 2d-region-keys (obj)
  (:documentation
   "Возвращает список имен 2d-регионов объекта @b(obj)."))

(defgeneric 3d-regions (obj)
  (:documentation
   "Возвращает список имен 3d-регионов объекта @b(obj)."))

(defgeneric 3d-region (name obj)
  (:documentation
   "Возвращает 3d-регион для объекта @b(obj) по его имени."))

(defgeneric 3d-region-mesh (mesh-name obj)
  (:documentation "Возвращает список объектов типа @b(<3d-region>) по имени сетки
@b(mesh-name) для объекта @b(obj)."))

(defgeneric 3d-region-min (mesh-name obj)
  (:documentation "Возвращает объект типа @b(<3d-region>) с минимальным 3d-суффиксом по
имени сетки @b(mesh-name) для объекта @b(obj)"))

(defgeneric 3d-region-max (mesh-name obj)
  (:documentation "Возвращает объект типа @b(<3d-region>) с минимальным 3d-суффиксом по
имени сетки @b(mesh-name) для объекта @b(obj)"))

(defgeneric 3d-region-left (mesh-name obj)
  (:documentation "Возвращает список объектов типа @b(<3d-region>) с минимальными
3d-суффиксом по имени сетки @b(mesh-name) из симуляции @b(obj)."))

(defgeneric 3d-region-right (mesh-name obj)
  (:documentation "Возвращает список объектов типа @b(<3d-region>) с максимальными
3d-суффиксом по имени сетки @b(mesh-name) из симуляции @b(obj)."))
 
(defgeneric create-script (obj stream)
    (:documentation "Выводит в поток @b(stream) сценарий для вставки в командную строку
CFX."))

(defgeneric reset (obj)
  (:documentation "@b(Описание:) метод @b(reset) сбрасывает объект в исходное состояние и
возвращает его."))
