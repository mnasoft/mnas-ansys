;;;; ./src/tin/core/parameters.lisp

(in-package :mnas-ansys/tin)

(defparameter *rest-tin-types*
  '("affix" "bspline" "coedge"  "loop" "material_point" "polyline" "prescribed_point"
    "set_triangulation_tolerance" "trim_surface")
  "@b(Описание:) глобальная переменная содержит @b(*rest-tin-types*)
глобальная переменная содержит типы объектов начинающиеся
"
  )

(defparameter *defines*
  '("define_curve"
    "define_family"
    "define_model"
    "define_prism_meshing_parameters"
    "define_solid"
    "define_subset"
    "define_surface"
    "return")
  "@b(Описание:) глобальная переменная содержит типы объектов начинающиеся с
@b(define) плюс @b(return).
")

(defparameter *tin-top-objects*
  '(("define_family"    <family>)
    ("define_curve"     <curve>)
    ("define_surface"   <surface>)
    ("prescribed_point" <point>)
    
    ;;"define_model"
    ;;"define_prism_meshing_parameters"
    ;;"define_solid"
    ;;"define_subset"
    ;;"return"
    )
  "@b(Описание:) глобальная опредедяет теги объектов верхнего
уровня, считываемые объектом <tin>.

 Примечание: данный список будет расширяться.
")

;;;; (defparameter *coedge* (make-instance '<coedge>))

;;;; (defparameter *surface* (make-instance '<surface>))

;;;; (defparameter *tin* (make-instance '<tin>))

