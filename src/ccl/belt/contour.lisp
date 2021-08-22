;;;; ./src/ccl/belt/contour.lisp

(defpackage #:mnas-icem/contour
  (:use #:cl #:mnas-icem/belt)
  (:export make-contour)
  (:documentation
   "@b(Описание:) Пакет @b(mnas-icem/ccl-belt) позволяет генерировать
 сценарии для построения поверхностей в программном комплексе ANSYS
 CFX на языке CCL.
"))

(in-package #:mnas-icem/contour)

(defun contour-name ()
  "@b(Описание:) функция @b(line-name) возвращает строку, обозначающую
   имя поверхности."
  (format nil "Contour ~A"
          (obj-number-print)))

(defun make-contour (colour-variable
                     locations
                     &key
                       (max "0 [C]")
                       (min "0 [C]")
                       (number-of-contours 11)
                       (line-width 1)
                       (name (progn (obj-number-incf)
                                    (contour-name))))
  "@b(Описание:) функция @b(make-contour)

 @b(Пример использования:)
@begin[lang=lisp](code)
 (make-contour  \"Total Temperature\" \"SURFACE 0001\")
@end(code)
"
  (format t "CONTOUR: ~A~%" name)
  (format t "  Apply Instancing Transform = On
  Clip Contour = Off
  Colour Map = Default Colour Map
  Colour Scale = Linear
")
  (format t "  Colour Variable = ~A~%" colour-variable)
  (format t "  Colour Variable Boundary Values = Hybrid
  Constant Contour Colour = Off
  Contour Range = Local
  Culling Mode = No Culling
  Domain List = /DOMAIN GROUP:All Domains
  Draw Contours = On
  Font = Sans Serif
  Fringe Fill = On
  Instancing Transform = /DEFAULT INSTANCE TRANSFORM:Default Transform
  Lighting = On
  Line Colour = 0, 0, 0
  Line Colour Mode = Default
")
  (format t "  Line Width = ~A~%" line-width)
  (for-list t "  Location List = " locations)
  (format t "  Max = ~A~%" max)
  (format t "  Min = ~A~%" min)
  (format t "  Number of Contours = ~A~%" number-of-contours)
  (format t "  Show Numbers = Off
  Specular Lighting = On
  Surface Drawing = Smooth Shading
  Text Colour = 0, 0, 0
  Text Colour Mode = Default
  Text Height = 0.024
  Transparency = 0.0
  Value List = 0 [C],1 [C]
  Visibility = On
  OBJECT VIEW TRANSFORM: 
    Apply Reflection = Off
    Apply Rotation = Off
    Apply Scale = Off
    Apply Translation = Off
    Principal Axis = Z
    Reflection Plane Option = XY Plane
    Rotation Angle = 0.0 [degree]
    Rotation Axis From = 0 [m], 0 [m], 0 [m]
    Rotation Axis To = 0 [m], 0 [m], 0 [m]
    Rotation Axis Type = Principal Axis
    Scale Vector = 1 , 1 , 1
    Translation Vector = 0 [m], 0 [m], 0 [m]
    X = 0.0 [m]
    Y = 0.0 [m]
    Z = 0.0 [m]
  END
END
"))

#+nil
(make-contour
 "Total Temperature" "SURFACE p0i00 p466i50 p411i00 p477i00 m11i25 p33i75")

(make-contour
 "Total Temperature"
 (mapcar #'caddr (make-tangent-belts 10 1300 0 0 200 -90 90 0.0)))
