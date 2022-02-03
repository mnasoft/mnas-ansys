;;;; ./src/ccl/core/core.lisp

(defpackage #:mnas-ansys/ccl/core
  (:use #:cl)
  (:documentation
   "@b(Описание:) пакет @b(mnas-ansys/ccl/core) определяет некоторые
  объекты языка CCl ANSYS-CFX-Post."))

(defclass <obj> ()
  ((name :accessor name :documentation "Имя объекта")))

(defclass <point> (<obj>)
  ((point-symbol               :accessor point-symbol :initform "Ball"
		               :initarg :point-symbol :documentation "point-symbol")
   (point                      :accessor point        :initform '(0.0 0.0 0.0)
		               :initarg :point        :documentation "Координаты точки")
   (apply-instancing-transform :accessor apply-instancing-transform :initform "On"
			       :initarg :apply-instancing-transform :documentation "apply-instancing-transform")
   (colour                     :accessor colour    :initform  '(0 0 0)
	                       :initarg :colour    :documentation "apply-instancing-transform")
   (colour-map                 :accessor colour-map :initform  "Default Colour Map"
			       :initarg :colour-map :documentation "Default Colour Map" )
   (Colour Mode = Constant))))

  Colour Mode = Constant
  Colour Scale = Linear
  Colour Variable = Pressure
  Colour Variable Boundary Values = Hybrid
  Culling Mode = No Culling
  Domain List = /DOMAIN GROUP:All Domains
  Draw Faces = On
  Draw Lines = Off
  Instancing Transform = /DEFAULT INSTANCE TRANSFORM:Default Transform
  Lighting = On
  Line Width = 2
  Max = 0.0 [kPa]
  Min = 0.0 [kPa]
  Node Number = 1
  Option = XYZ~%")
  (format t "  Point = ~{~F [mm]~^, ~}~%" point)
  (format t "  Point Symbol = ~A~%" point-symbol)
  (format t "  Range = Global
  Specular Lighting = On
  Surface Drawing = Smooth Shading
  Symbol Size = 0.1
  Transparency = 0.0
  Variable = Pressure
  Variable Boundary Values = Hybrid
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
