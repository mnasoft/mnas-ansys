;;;; ./src/ccl/core/core.lisp

(defpackage #:mnas-ansys/ccl/core
  (:use #:cl)
  (:export for-list)
  (:export <obj>)
  (:export <obj>-name)
  (:export <point>)
  (:export <point>-apply-instancing-transform
           <point>-colour
           <point>-colour-map
           <point>-colour-mode
           <point>-colour-scale
           <point>-colour-variable
           <point>-colour-variable-boundary-values
           <point>-culling-mode
           <point>-domain-list
           <point>-draw-faces
           <point>-draw-lines
           <point>-instancing-transform
           <point>-lighting
           <point>-line-width
           <point>-max
           <point>-min
           <point>-node-number
           <point>-option
           <point>-point
           <point>-point-symbol
           <point>-range
           <point>-specular-lighting
           <point>-surface-drawing
           <point>-symbol-size
           <point>-transparency
           <point>-variable
           <point>-variable-boundary-values
           <point>-visibility)
  (:documentation
   "@b(Описание:) пакет @b(mnas-ansys/ccl/core) определяет некоторые
  объекты языка CCl ANSYS-CFX-Post."))

(in-package :mnas-ansys/ccl/core)

(defun for-list (stream parameter variable)
  "@b(Описание:) функция @b(for-list) выводит в поток @b(stream) переменную @b(variable).

 @b(Переменые:)
@begin(list)
 @item(stream - поток вывода;)
 @item(parameter - обозначение параметра; )
 @item(variable  - переменная (значение или список згачений).)
@end(list)

(for-list t \"    Rotation Axis From = \" '(\"0 [m]\"  \"0 [m]\" \"0 [m]\"))
->    Rotation Axis From = 0 [m], 0 [m], 0 [m]
"
  (when variable
  (format stream
          (concatenate
           'string
           parameter
           (cond
             ((consp variable) "~{~A~^, ~}")
             (t "~A"))
           "~%")
          variable)))

(defclass <obj> ()
  ((name :accessor <obj>-name
         :initform "On"
         :initarg :name
         :documentation "Имя объекта")))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defclass <object-view-transform> ()
  ((apply-reflection
    :accessor <object-view-transform>-apply-reflection
    :initform "Off"
    :initarg apply-reflection
    :documentation "apply-reflection")
   (apply-rotation
    :accessor <object-view-transform>-apply-rotation
    :initform "Off"
    :initarg apply-rotation
    :documentation "apply-rotation")
   (apply-scale
    :accessor <object-view-transform>-apply-scale
    :initform "Off"
    :initarg apply-scale
    :documentation "apply-scale")
   (apply-translation
    :accessor <object-view-transform>-apply-translation
    :initform "Off"
    :initarg apply-translation
    :documentation "apply-translation")
   (principal-axis
    :accessor <object-view-transform>-principal-axis
    :initform "Z"
    :initarg principal-axis
    :documentation "principal-axis")
   (reflection-plane-option
    :accessor <object-view-transform>-reflection-plane-option
    :initform "XY Plane"
    :initarg reflection-plane-option
    :documentation "reflection-plane-option")
   (rotation-angle
    :accessor <object-view-transform>-rotation-angle
    :initform "0.0 [degree]"
    :initarg rotation-angle
    :documentation "rotation-angle")
   (rotation-axis-from
    :accessor <object-view-transform>-rotation-axis-from
    :initform "0 [m], 0 [m], 0 [m]"
    :initarg rotation-axis-from
    :documentation "rotation-axis-from")
   (rotation-axis-to
    :accessor <object-view-transform>-rotation-axis-to
    :initform "0 [m], 0 [m], 0 [m]"
    :initarg rotation-axis-to
    :documentation "rotation-axis-to")
   (rotation-axis-type
    :accessor <object-view-transform>-rotation-axis-type
    :initform "Principal Axis"
    :initarg rotation-axis-type
    :documentation "rotation-axis-type")
   (scale-vector
    :accessor <object-view-transform>-scale-vector
    :initform "1 , 1 , 1"
    :initarg scale-vector
    :documentation "scale-vector")
   (translation-vector
    :accessor <object-view-transform>-translation-vector
    :initform "0 [m], 0 [m], 0 [m]"
    :initarg translation-vector
    :documentation "translation-vector")
   (x
    :accessor <object-view-transform>-x
    :initform "0.0 [m]"
    :initarg x
    :documentation "x")
   (y
    :accessor <object-view-transform>-y
    :initform "0.0 [m]"
    :initarg y
    :documentation "y")
   (z
    :accessor <object-view-transform>-z
    :initform "0.0 [m]"
    :initarg z
    :documentation "z")))

(defmethod print-object ((object-view-transform <object-view-transform>) s)
  (format s "  OBJECT VIEW TRANSFORM:~%")
  (loop :for i :in (sb-mop:class-direct-slots (find-class '<object-view-transform>))
        :do
           (for-list
            s
            (substitute
             #\Space #\- 
             (string-capitalize
              (format nil "    ~A = " (sb-mop:slot-definition-name i))))
            (slot-value object-view-transform (sb-mop:slot-definition-name i))))
  (format s "  END"))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defclass <point> (<obj>)
  ((apply-instancing-transform
    :accessor <point>-apply-instancing-transform
    :initform "On"
    :initarg :apply-instancing-transform
    :documentation "apply-instancing-transform")
   (colour
    :accessor <point>-colour
    :initform "1, 1, 0"
    :initarg :colour
    :documentation "colour")
   (colour-map
    :accessor <point>-colour-map
    :initform "Default Colour Map"
    :initarg :colour-map
    :documentation "colour-map")
   (colour-mode
    :accessor <point>-colour-mode
    :initform "Variable"
    :initarg :colour-mode
    :documentation "colour-mode")
   (colour-scale
    :accessor <point>-colour-scale
    :initform "Linear"
    :initarg :colour-scale
    :documentation "colour-scale")
   (colour-variable
    :accessor <point>-colour-variable
    :initform "Total Temperature"
    :initarg :colour-variable
    :documentation "colour-variable")
   (colour-variable-boundary-values
    :accessor <point>-colour-variable-boundary-values
    :initform "Hybrid"
    :initarg :colour-variable-boundary-values
    :documentation "colour-variable-boundary-values")
   (culling-mode
    :accessor <point>-culling-mode
    :initform "No Culling"
    :initarg :culling-mode
    :documentation "culling-mode")
   (domain-list
    :accessor <point>-domain-list
    :initform "/DOMAIN GROUP:All Domains"
    :initarg :domain-list
    :documentation "domain-list")
   (draw-faces
    :accessor <point>-draw-faces
    :initform "On"
    :initarg :draw-faces
    :documentation "draw-faces")
   (draw-lines
    :accessor <point>-draw-lines
    :initform "Off"
    :initarg :draw-lines
    :documentation "draw-lines")
   (instancing-transform
    :accessor <point>-instancing-transform
    :initform "/DEFAULT INSTANCE TRANSFORM:Default Transform"
    :initarg :instancing-transform
    :documentation "instancing-transform")
   (lighting
    :accessor <point>-lighting
    :initform "On"
    :initarg :lighting
    :documentation "lighting")
   (line-width
    :accessor <point>-line-width
    :initform "2"
    :initarg :line-width
    :documentation "line-width")
   (max
    :accessor <point>-max
    :initform "0.0 [C]"
    :initarg :max
    :documentation "max")
   (min
    :accessor <point>-min
    :initform "0.0 [C]"
    :initarg :min
    :documentation "min")
   (node-number
    :accessor <point>-node-number
    :initform "1"
    :initarg :node-number
    :documentation "node-number")
   (option
    :accessor <point>-option
    :initform "XYZ"
    :initarg :option
    :documentation "option")
   (point
    :accessor <point>-point
    :initform '(0.0 0.0 0.0)
    :initarg :point
    :documentation "point")
   (point-symbol
    :accessor <point>-point-symbol
    :initform "Ball"
    :initarg :point-symbol
    :documentation "point-symbol")
   (range
    :accessor <point>-range
    :initform "Global"
    :initarg :range
    :documentation "range")
   (specular-lighting
    :accessor <point>-specular-lighting
    :initform "On"
    :initarg :specular-lighting
    :documentation "specular-lighting")
   (surface-drawing
    :accessor <point>-surface-drawing
    :initform "Smooth Shading"
    :initarg :surface-drawing
    :documentation "surface-drawing")
   (symbol-size
    :accessor <point>-symbol-size
    :initform "0.1"
    :initarg :symbol-size
    :documentation "symbol-size")
   (transparency
    :accessor <point>-transparency
    :initform "0.0"
    :initarg :transparency
    :documentation "transparency")
   (variable
    :accessor <point>-variable
    :initform "Pressure"
    :initarg :variable
    :documentation "variable")
   (variable-boundary-values
    :accessor <point>-variable-boundary-values
    :initform "Hybrid"
    :initarg :variable-boundary-values
    :documentation "variable-boundary-values")
   (visibility
    :accessor <point>-visibility
    :initform "On"
    :initarg :visibility
    :documentation "visibility")
   (object-view-transform
    :accessor <point>-object-view-transform
    :initform (make-instance '<object-view-transform>)
    :initarg :object-view-transform
    :documentation "object-view-transform")))

(defmethod print-object ((point <point>) s)
  (format s "POINT: ~A~%" (<obj>-name point))
  (loop :for i :in (sb-mop:class-direct-slots (find-class '<point>))
        :do
           (for-list
            s
            (substitute
             #\Space #\- 
             (string-capitalize
              (format nil "  ~A = " (sb-mop:slot-definition-name i))))
            (slot-value point (sb-mop:slot-definition-name i)))))

(defmethod print-object :after ((point <point>) s)
  (format s "END~%"))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


(defclass <line> (<obj>)
  ((apply-instancing-transform
    :accessor <line>-<line>-apply-instancing-transform
    :initform "On"
    :initarg :apply-instancing-transform
    :documentation "apply-instancing-transform")
   (colour
    :accessor <line>-colour
    :initform '(1 0 0)
    :initarg :colour
    :documentation "colour")
   (colour-map
    :accessor <line>-colour-map
    :initform "Default Colour Map"
    :initarg :colour-map
    :documentation "colour-map")
  (colour-mode
   :accessor <line>-colour-mode
   :initform "Constant"
   :initarg :colour-mode
   :documentation "colour-mode")
  (colour-scale
   :accessor <line>-colour-scale
   :initform "Linear"
   :initarg :colour-scale
   :documentation "colour-scale")
  (colour-variable
   :accessor <line>-colour-variable
   :initform "Pressure"
   :initarg :colour-variable
   :documentation "colour-variable")
  (colour-variable-boundary-values
   :accessor <line>-colour-variable-boundary-values
   :initform "Hybrid"
   :initarg :colour-variable-boundary-values
   :documentation "colour-variable-boundary-values")
  (domain-list
   :accessor <line>-domain-list
   :initform "/DOMAIN GROUP:All Domains"
   :initarg :domain-list
   :documentation "domain-list")
  (instancing-transform
   :accessor <line>-instancing-transform
   :initform "/DEFAULT INSTANCE TRANSFORM:Default Transform"
   :initarg :instancing-transform
   :documentation "instancing-transform")
  (line-samples
   :accessor <line>-line-samples
   :initform "10"
   :initarg :line-samples
   :documentation "line-samples")
  (line-type
   :accessor <line>-line-type
   :initform "Sample"
   :initarg :line-type
   :documentation "line-type")
  (line-width
   :accessor <line>-line-width
   :initform "2"
   :initarg :line-width
   :documentation "line-width")
  (max
   :accessor <line>-max
   :initform "0.0 [Pa]"
   :initarg :max
   :documentation "max")
  (min
   :accessor <line>-min
   :initform "0.0 [Pa]"
   :initarg :min
   :documentation "min")
  (option
   :accessor <line>-option
   :initform "Two Points"
   :initarg :option
   :documentation "option")
  (point-1
   :accessor <line>-point-1
   :initform '(0.0 0.0 0.0)
   :initarg :point-1
   :documentation "point-1")
  (point-2
   :accessor <line>-point-2
   :initform '(1.0 0.0 0.0)
   :initarg :point-2
   :documentation "point-2")
  (range
   :accessor <line>-point-2
   :initform "Global"
   :initarg :range
   :documentation "range")
  (visibility
   :accessor <line>-visibility
   :initform "On"
   :initarg :visibility
   :documentation "visibility" )
  (object-view-transform
   :accessor <line>-object-view-transform
   :initform (make-instance '<object-view-transform>)
   :initarg :object-view-transform
   :documentation "object-view-transform")))

(defmethod print-object ((line <line>) s)
  (format s "LINE: ~A~%" (<obj>-name line))
  (loop :for i :in (sb-mop:class-direct-slots (find-class '<line>))
        :do
           (for-list
            s
            (substitute
             #\Space #\- 
             (string-capitalize
              (format nil "  ~A = " (sb-mop:slot-definition-name i))))
            (slot-value line (sb-mop:slot-definition-name i)))))

(defmethod print-object :after ((line <line>) s)
  (format s "END~%"))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defparameter *object-view-transform* (make-instance '<object-view-transform>))

(defparameter *point* (make-instance '<point> :name "Point 1" :apply-instancing-transform nil ))

(defparameter *line* (make-instance '<line> :name "Line 1" ))
