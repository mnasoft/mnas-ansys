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

(defgeneric solid-domains (dom-sur)
  (:documentation
   "Возвращает список солидовых доменов."))

(defgeneric faces (dom dom-sur)
  (:documentation
   "Возвращает список поверхностей домена @b(dom)."))

(defgeneric find-body (body dom-sur)
  (:documentation
   "Возвращает список доменов по имени тела (материальной точки)
body-name."))



;;(<dom-sur>-data *ds*)
;(solid-domains  *ds*)
;(<dom-sur>-parts *ds*)
;(faces "DG1 G1" *ds*)
;(domains "M1"  *ds*)
