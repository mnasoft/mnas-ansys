;;;; ./src/cfx/pre/generic.lisp

(in-package :mnas-ansys/cfx/pre)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; generic

(defgeneric domains (domains)
  (:documentation
   "Возвращает список доменов."))

(defgeneric fluid-domains (dom-sur)
  (:documentation
   "Возвращает список флюидовых доменов."))

(defgeneric solid-domains (dom-sur)
  (:documentation
   "Возвращает список солидовых доменов."))

(defgeneric icem-domains (domains)
  (:documentation
   "Возвращает список солтдовых доменов на основании списка поверхностей
ICEM."))

(defgeneric fluid-meshes (obj)
  (:documentation
   "Возвращает список флюидовых доменов на основании списка поверхностей
ICEM."))

(defgeneric solid-meshes (obj)
  (:documentation
   "Возвращает список солтдовых доменов на основании списка поверхностей
ICEM."))

(defgeneric fluid-mesh-p (name obj)
  (:documentation
   "Возвращает T, если имя представляет флюидовый домен на основании
списка поверхностей ICEM, иначе - NIL."))

(defgeneric solid-mesh-p (name obj)
  (:documentation
   "Возвращает T, если имя представляет солидовый домен на основании
списка поверхностей ICEM, иначе - NIL."))

(defgeneric find-icem-surfaces (name domains)
  (:documentation
   "Возвращает список поверхностей T, если имя представляет солидовый домен на основании
списка поверхностей ICEM, иначе - NIL."))

(defgeneric surfaces (obj)
  (:documentation
   "Возвращает список поверхностей объекта @b(obj)."))

(defgeneric add (item  collection)
  (:documentation
   "Добавляем объект @b(item) в коллекцию @b(collection)."))

;;;;;;;;;;;;;;;;;;;;

(defgeneric faces (name domains)
  (:documentation
   "Возвращает список поверхностей домена @b(name)."))

(defgeneric find-body (name domains)
  (:documentation
   "Возвращает список доменов по имени тела (материальной точки)
body-name."))
