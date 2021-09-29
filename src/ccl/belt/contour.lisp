;;;; ./src/ccl/belt/contour.lisp

(defpackage #:mnas-ansys/contour
  (:use #:cl #:mnas-ansys/belt)
  (:export make-contour)
  (:documentation
   "@b(Описание:) Пакет @b(mnas-ansys/ccl-belt) позволяет генерировать
 сценарии для построения поверхностей в программном комплексе ANSYS
 CFX на языке CCL.
"))

(in-package #:mnas-ansys/contour)

(defun contour-name ()
  "@b(Описание:) функция @b(line-name) возвращает строку, обозначающую
   имя поверхности."
  (format nil "Contour ~A"
          (obj-number-print)))

(defun make-contour (colour-variable
                     locations
                     &key
                       (max "0")
                       (min "0")
                       (number-of-contours 11)
                       (line-width 1)
                       (colour-variable-boundary-values "Hybrid")
                       (colour-scale "Linear")
                       (contour-range "Local")
                       (constant-contour-colour "On")
                       (name (progn (obj-number-incf)
                                    (contour-name))))
  "@b(Описание:) функция @b(make-contour)

 @b(Пример использования:)
@begin[lang=lisp](code)
 (make-contour  \"Total Temperature\" \"SURFACE 0001\")
@end(code)
"
  (format t "CONTOUR: ~A~%" name)
  (format t "  Apply Instancing Transform = On~%")
  (format t "  Clip Contour = Off~%")
  (format t "  Colour Map = Default Colour Map~%")
  (format t "  Colour Scale = ~A~%" colour-scale)
  (format t "  Colour Variable = ~A~%" colour-variable)
  (format t "  Colour Variable Boundary Values = ~A~%" colour-variable-boundary-values)
  (format t "  Constant Contour Colour = ~A~%" constant-contour-colour)
  (format t "  Contour Range = ~A~%" contour-range)
  (format t "  Culling Mode = No Culling~%")
  (format t "  Domain List = /DOMAIN GROUP:All Domains~%")
  (format t "  Draw Contours = On~%")
  (format t "  Font = Sans Serif~%")
  (format t "  Fringe Fill = On~%")
  (format t "  Instancing Transform = /DEFAULT INSTANCE TRANSFORM:Default Transform~%")
  (format t "  Lighting = On~%")
  (format t "  Line Colour = 0, 0, 0~%")
  (format t "  Line Colour Mode = Default~%")
  (format t "  Line Width = ~A~%" line-width)
  (for-list t "  Location List = " locations)
  (format t "  Max = ~A~%" max)
  (format t "  Min = ~A~%" min)
  (format t "  Number of Contours = ~A~%" number-of-contours)
  (format t "  Show Numbers = Off~%")
  (format t "  Specular Lighting = On~%")
  (format t "  Surface Drawing = Smooth Shading~%")
  (format t "  Text Colour = 0, 0, 0~%")
  (format t "  Text Colour Mode = Default~%")
  (format t "  Text Height = 0.024~%")
  (format t "  Transparency = 0.0~%")
  (format t "  Value List = 0 [C],1 [C]~%")
  (format t "  Visibility = On~%")
  (object-view-transform) 
  (format t "END~%"))

#+nil
(make-contour
 "Total Temperature" "SURFACE p0i00 p466i50 p411i00 p477i00 m11i25 p33i75")
#+nil
(make-contour
 "Total Temperature"
 (mapcar #'caddr (make-tangent-belts 10 1300 0 0 200 -90 90 0.0)))
