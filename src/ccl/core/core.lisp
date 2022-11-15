;;;; ./src/ccl/core/core.lisp

(defpackage #:mnas-ansys/ccl/core
  (:use #:cl)
  (:export for-list)
  (:export <obj>)
  (:export <obj>-name)
  (:export <object-view-transform>
           <object-view-transform>-apply-reflection
           <object-view-transform>-apply-rotation
           <object-view-transform>-apply-scale
           <object-view-transform>-apply-translation
           <object-view-transform>-principal-axis
           <object-view-transform>-reflection-plane-option
           <object-view-transform>-rotation-angle
           <object-view-transform>-rotation-axis-from
           <object-view-transform>-rotation-axis-to
           <object-view-transform>-rotation-axis-type
           <object-view-transform>-scale-vector
           <object-view-transform>-translation-vector
           <object-view-transform>-x
           <object-view-transform>-y
           <object-view-transform>-z) 
  (:export <point>
           <point>-apply-instancing-transform
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
  (:export <plane>
           <plane>-apply-instancing-transform
           <plane>-apply-texture
           <plane>-blend-texture
           <plane>-bound-radius
           <plane>-colour
           <plane>-colour-map
           <plane>-colour-mode
           <plane>-colour-scale
           <plane>-colour-variable
           <plane>-colour-variable-boundary-values
           <plane>-culling-mode
           <plane>-direction-1-bound
           <plane>-direction-1-orientation
           <plane>-direction-1-points
           <plane>-direction-2-bound
           <plane>-direction-2-points
           <plane>-domain-list
           <plane>-draw-faces
           <plane>-draw-lines
           <plane>-instancing-transform
           <plane>-invert-plane-bound
           <plane>-lighting
           <plane>-line-colour
           <plane>-line-colour-mode
           <plane>-line-width
           <plane>-max
           <plane>-min
           <plane>-normal
           <plane>-option
           <plane>-plane-bound
           <plane>-plane-type
           <plane>-point
           <plane>-point-1
           <plane>-point-2
           <plane>-point-3
           <plane>-range
           <plane>-render-edge-angle
           <plane>-specular-lighting
           <plane>-surface-drawing
           <plane>-texture-angle
           <plane>-texture-direction
           <plane>-texture-file
           <plane>-texture-material
           <plane>-texture-position
           <plane>-texture-scale
           <plane>-texture-type
           <plane>-tile-texture
           <plane>-transform-texture
           <plane>-transparency
           <plane>-visibility
           <plane>-x
           <plane>-y
           <plane>-z
           <plane>-object-view-transform
           )
  (:export <contour>
           <contour>-apply-instancing-transform
           <contour>-clip-contour
           <contour>-colour-map
           <contour>-colour-scale
           <contour>-colour-variable
           <contour>-colour-variable-boundary-values
           <contour>-constant-contour-colour
           <contour>-contour-range
           <contour>-culling-mode
           <contour>-domain-list
           <contour>-draw-contours
           <contour>-font
           <contour>-fringe-fill
           <contour>-instancing-transform
           <contour>-lighting
           <contour>-line-colour
           <contour>-line-colour-mode
           <contour>-line-width
           <contour>-location-list
           <contour>-max
           <contour>-min
           <contour>-number-of-contours
           <contour>-show-numbers
           <contour>-specular-lighting
           <contour>-surface-drawing
           <contour>-text-colour
           <contour>-text-colour-mode
           <contour>-text-height
           <contour>-transparency
           <contour>-value-list
           <contour>-visibility
           <contour>-object-view-transform)
  (:export <camera>
           <camera>-option
           <camera>-pan
           <camera>-pivot-point
           <camera>-rotation
           <camera>-rotation-quaternion
           <camera>-scale
           <camera>-send-to-viewer
           )
  (:export <view>
           <view>-angular-coord-shift
           <view>-auto-center
           <view>-axis-visibility
           <view>-border-visibility
           <view>-camera-mode
           <view>-clip-plane
           <view>-clip-scene
           <view>-coord-transform
           <view>-hide-difference-case
           <view>-highlight-type
           <view>-is-a-figure
           <view>-light-angle
           <view>-local-object-list
           <view>-object-visibility-list
           <view>-projection
           <view>-ruler-visibility
           <view>-standard-view
           <view>-valid-case
           <view>-camera)
  (:export <default-legend>
           <default-legend>-colour
           <default-legend>-font
           <default-legend>-legend-aspect
           <default-legend>-legend-format
           <default-legend>-legend-orientation
           <default-legend>-legend-position
           <default-legend>-legend-resolution
           <default-legend>-legend-shading
           <default-legend>-legend-size
           <default-legend>-legend-ticks
           <default-legend>-legend-title
           <default-legend>-legend-title-mode
           <default-legend>-legend-x-justification
           <default-legend>-legend-y-justification
           <default-legend>-related-object
           <default-legend>-show-legend-units
           <default-legend>-text-colour-mode
           <default-legend>-text-height
           <default-legend>-text-rotation
           <default-legend>-visibility)
  (:export <legend>
           <legend>-colour
           <legend>-font
           <legend>-legend-aspect
           <legend>-legend-format
           <legend>-legend-orientation
           <legend>-legend-plot
           <legend>-legend-position
           <legend>-legend-size
           <legend>-legend-ticks
           <legend>-legend-title
           <legend>-legend-title-mode
           <legend>-legend-x-justification
           <legend>-legend-y-justification
           <legend>-show-legend-units
           <legend>-text-colour-mode
           <legend>-text-height
           <legend>-text-rotation
           <legend>-visibility)
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

(defun print-slot (slot class stream)
  (cond
    ((eq 'built-in-class
         (type-of (class-of (slot-value class (sb-mop:slot-definition-name slot)))))
     (for-list
      stream
      (mnas-string:replace-all
       (substitute
       #\Space #\- 
       (string-capitalize
        (format nil "  ~A = " (sb-mop:slot-definition-name slot))))
       " Of " " of ")      
      (slot-value class (sb-mop:slot-definition-name slot))))
    ((eq 'standard-class
         (type-of (class-of (slot-value class (sb-mop:slot-definition-name slot)))))
     (format stream "~A" (slot-value class (sb-mop:slot-definition-name slot))))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defclass <obj> ()
  ((name :accessor <obj>-name
         :initform "Name"
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
  (loop :for slot :in (sb-mop:class-direct-slots (find-class '<object-view-transform>))
        :do (print-slot slot object-view-transform s)))

(defmethod print-object :after ((object-view-transform <object-view-transform>) s)
  (format s "  END~%"))

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
  (loop :for slot :in (sb-mop:class-direct-slots (find-class '<point>))
        :do (print-slot slot point s)))

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
  (loop :for slot :in (sb-mop:class-direct-slots (find-class '<line>))
        :do (print-slot slot line s)))

(defmethod print-object :after ((line <line>) s)
  (format s "END~%"))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defclass <plane> (<obj>)
  ((apply-instancing-transform
    :accessor <plane>-apply-instancing-transform
    :initform "On"
    :initarg :apply-instancing-transform
    :documentation "apply-instancing-transform")
   (apply-texture
    :accessor <plane>-apply-texture
    :initform "Off"
    :initarg :apply-texture
    :documentation "apply-texture")
   (blend-texture
    :accessor <plane>-blend-texture
    :initform "On"
    :initarg :blend-texture
    :documentation "blend-texture")
   (bound-radius
    :accessor <plane>-bound-radius
    :initform "0.5 [m]"
    :initarg :bound-radius
    :documentation "bound-radius")
   (colour
    :accessor <plane>-colour
    :initform "0.75, 0.75, 0.75"
    :initarg :colour
    :documentation "colour")
   (colour-map
    :accessor <plane>-colour-map
    :initform "Default Colour Map"
    :initarg :colour-map
    :documentation "colour-map")
   (colour-mode
    :accessor <plane>-colour-mode
    :initform "Constant"
    :initarg :colour-mode
    :documentation "colour-mode")
   (colour-scale
    :accessor <plane>-colour-scale
    :initform "Linear"
    :initarg :colour-scale
    :documentation "colour-scale")
   (colour-variable
    :accessor <plane>-colour-variable
    :initform "Pressure"
    :initarg :colour-variable
    :documentation "colour-variable")
   (colour-variable-boundary-values
    :accessor <plane>-colour-variable-boundary-values
    :initform "Hybrid"
    :initarg :colour-variable-boundary-values
    :documentation "colour-variable-boundary-values")
   (culling-mode
    :accessor <plane>-culling-mode
    :initform "No Culling"
    :initarg :culling-mode
    :documentation "culling-mode")
   (direction-1-bound
    :accessor <plane>-direction-1-bound
    :initform "1.0 [m]"
    :initarg :direction-1-bound
    :documentation "direction-1-bound")
   (direction-1-orientation
    :accessor <plane>-direction-1-orientation
    :initform "0 [degree]"
    :initarg :direction-1-orientation
    :documentation "direction-1-orientation")
   (direction-1-points
    :accessor <plane>-direction-1-points
    :initform "10"
    :initarg :direction-1-points
    :documentation "direction-1-points")
   (direction-2-bound
    :accessor <plane>-direction-2-bound
    :initform "1.0 [m]"
    :initarg :direction-2-bound
    :documentation "direction-2-bound")
   (direction-2-points
    :accessor <plane>-direction-2-points
    :initform "10"
    :initarg :direction-2-points
    :documentation "direction-2-points")
   (domain-list
    :accessor <plane>-domain-list
    :initform "/DOMAIN GROUP:All Domains"
    :initarg :domain-list
    :documentation "domain-list")
   (draw-faces
    :accessor <plane>-draw-faces
    :initform "On"
    :initarg :draw-faces
    :documentation "draw-faces")
   (draw-lines
    :accessor <plane>-draw-lines
    :initform "Off"
    :initarg :draw-lines
    :documentation "draw-lines")
   (instancing-transform
    :accessor <plane>-instancing-transform
    :initform "/DEFAULT INSTANCE TRANSFORM:Default Transform"
    :initarg :instancing-transform
    :documentation "instancing-transform")
   (invert-plane-bound
    :accessor <plane>-invert-plane-bound
    :initform "Off"
    :initarg :invert-plane-bound
    :documentation "invert-plane-bound")
   (lighting
    :accessor <plane>-lighting
    :initform "On"
    :initarg :lighting
    :documentation "lighting")
   (line-colour
    :accessor <plane>-line-colour
    :initform "0, 0, 0"
    :initarg :line-colour
    :documentation "line-colour")
   (line-colour-mode
    :accessor <plane>-line-colour-mode
    :initform "Default"
    :initarg :line-colour-mode
    :documentation "line-colour-mode")
   (line-width
    :accessor <plane>-line-width
    :initform "1"
    :initarg :line-width
    :documentation "line-width")
   (max
    :accessor <plane>-max
    :initform "0.0 [kPa]"
    :initarg :max
    :documentation "max")
   (min
    :accessor <plane>-min
    :initform "0.0 [kPa]"
    :initarg :min
    :documentation "min")
   (normal
    :accessor <plane>-normal
    :initform "1 , 0 , 0"
    :initarg :normal
    :documentation "normal")
   (option
    :accessor <plane>-option
    :initform "YZ Plane"
    :initarg :option
    :documentation "option")
   (plane-bound
    :accessor <plane>-plane-bound
    :initform "None"
    :initarg :plane-bound
    :documentation "plane-bound")
   (plane-type
    :accessor <plane>-plane-type
    :initform "Slice"
    :initarg :plane-type
    :documentation "plane-type")
   (point
    :accessor <plane>-point
    :initform "0 [mm], 0 [mm], 0 [mm]"
    :initarg :point
    :documentation "point")
   (point-1
    :accessor <plane>-point-1
    :initform "0 [mm], 0 [mm], 0 [mm]"
    :initarg :point-1
    :documentation "point-1")
   (point-2
    :accessor <plane>-point-2
    :initform "1 [mm], 0 [mm], 0 [mm]"
    :initarg :point-2
    :documentation "point-2")
   (point-3
    :accessor <plane>-point-3
    :initform "0 [mm], 1 [mm], 0 [mm]"
    :initarg :point-3
    :documentation "point-3")
   (range
    :accessor <plane>-range
    :initform "Global"
    :initarg :range
    :documentation "range")
   (render-edge-angle
    :accessor <plane>-render-edge-angle
    :initform "0 [degree]"
    :initarg :render-edge-angle
    :documentation "render-edge-angle")
   (specular-lighting
    :accessor <plane>-specular-lighting
    :initform "On"
    :initarg :specular-lighting
    :documentation "specular-lighting")
   (surface-drawing
    :accessor <plane>-surface-drawing
    :initform "Smooth Shading"
    :initarg :surface-drawing
    :documentation "surface-drawing")
   (texture-angle
    :accessor <plane>-texture-angle
    :initform "0"
    :initarg :texture-angle
    :documentation "texture-angle")
   (texture-direction
    :accessor <plane>-texture-direction
    :initform "0 , 1 , 0"
    :initarg :texture-direction
    :documentation "texture-direction")
   (texture-file
    :accessor <plane>-texture-file
    :initform ""
    :initarg :texture-file
    :documentation "texture-file")
   (texture-material
    :accessor <plane>-texture-material
    :initform "Metal"
    :initarg :texture-material
    :documentation "texture-material")
   (texture-position
    :accessor <plane>-texture-position
    :initform "0 , 0"
    :initarg :texture-position
    :documentation "texture-position")
   (texture-scale
    :accessor <plane>-texture-scale
    :initform "1"
    :initarg :texture-scale
    :documentation "texture-scale")
   (texture-type
    :accessor <plane>-texture-type
    :initform "Predefined"
    :initarg :texture-type
    :documentation "texture-type")
   (tile-texture
    :accessor <plane>-tile-texture
    :initform "Off"
    :initarg :tile-texture
    :documentation "tile-texture")
   (transform-texture
    :accessor <plane>-transform-texture
    :initform "Off"
    :initarg :transform-texture
    :documentation "transform-texture")
   (transparency
    :accessor <plane>-transparency
    :initform "0.0"
    :initarg :transparency
    :documentation "transparency")
   (visibility
    :accessor <plane>-visibility
    :initform "On"
    :initarg :visibility
    :documentation "visibility")
   (x
    :accessor <plane>-x
    :initform "0.0 [mm]"
    :initarg :x
    :documentation "x")
   (y
    :accessor <plane>-y
    :initform "0.0 [mm]"
    :initarg :y
    :documentation "y")
   (z
    :accessor <plane>-z
    :initform "0.0 [mm]"
    :initarg :z
    :documentation "z")
   (object-view-transform
    :accessor <plane>-object-view-transform
    :initform (make-instance '<object-view-transform>)
    :initarg :object-view-transform
    :documentation "object-view-transform")))

(defmethod print-object ((plane <plane>) s)
  (format s "PLANE: ~A~%" (<obj>-name plane))
  (loop :for slot :in (sb-mop:class-direct-slots (find-class '<plane>))
        :do
           (print-slot slot plane s)))

(defmethod print-object :after ((plane <plane>) s)
  (format s "END~%"))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defclass <contour> (<obj>) 
  ((apply-instancing-transform
    :accessor <contour>-apply-instancing-transform
    :initform "On"
    :initarg :apply-instancing-transform
    :documentation "apply-instancing-transform")
   (clip-contour
    :accessor <contour>-clip-contour
    :initform "Off"
    :initarg :clip-contour
    :documentation "clip-contour")
   (colour-map
    :accessor <contour>-colour-map
    :initform "Default Colour Map"
    :initarg :colour-map
    :documentation "colour-map")
   (colour-scale
    :accessor <contour>-colour-scale
    :initform "Linear"
    :initarg :colour-scale
    :documentation "colour-scale")
   (colour-variable
    :accessor <contour>-colour-variable
    :initform "Total Temperature"
    :initarg :colour-variable
    :documentation "colour-variable")
   (colour-variable-boundary-values
    :accessor <contour>-colour-variable-boundary-values
    :initform "Hybrid"
    :initarg :colour-variable-boundary-values
    :documentation "colour-variable-boundary-values")
   (constant-contour-colour
    :accessor <contour>-constant-contour-colour
    :initform "On"
    :initarg :constant-contour-colour
    :documentation "constant-contour-colour")
   (contour-range
    :accessor <contour>-contour-range
    :initform "User Specified"
    :initarg :contour-range
    :documentation "contour-range")
   (culling-mode
    :accessor <contour>-culling-mode
    :initform "No Culling"
    :initarg :culling-mode
    :documentation "culling-mode")
   (domain-list
    :accessor <contour>-domain-list
    :initform "/DOMAIN GROUP:All Domains"
    :initarg :domain-list
    :documentation "domain-list")
   (draw-contours
    :accessor <contour>-draw-contours
    :initform "On"
    :initarg :draw-contours
    :documentation "draw-contours")
   (font
    :accessor <contour>-font
    :initform "Sans Serif"
    :initarg :font
    :documentation "font")
   (fringe-fill
    :accessor <contour>-fringe-fill
    :initform "On"
    :initarg :fringe-fill
    :documentation "fringe-fill")
   (instancing-transform
    :accessor <contour>-instancing-transform
    :initform "/DEFAULT INSTANCE TRANSFORM:Default Transform"
    :initarg :instancing-transform
    :documentation "instancing-transform")
   (lighting
    :accessor <contour>-lighting
    :initform "On"
    :initarg :lighting
    :documentation "lighting")
   (line-colour
    :accessor <contour>-line-colour
    :initform "0, 0, 0"
    :initarg :line-colour
    :documentation "line-colour")
   (line-colour-mode
    :accessor <contour>-line-colour-mode
    :initform "Default"
    :initarg :line-colour-mode
    :documentation "line-colour-mode")
   (line-width
    :accessor <contour>-line-width
    :initform "1"
    :initarg :line-width
    :documentation "line-width")
   (location-list
    :accessor <contour>-location-list
    :initform "/PLANE:Plane X p115i50"
    :initarg :location-list
    :documentation "location-list")
   (max
    :accessor <contour>-max
    :initform "1650 [C]"
    :initarg :max
    :documentation "max")
   (min
    :accessor <contour>-min
    :initform "350 [C]"
    :initarg :min
    :documentation "min")
   (number-of-contours
    :accessor <contour>-number-of-contours
    :initform "14"
    :initarg :number-of-contours
    :documentation "number-of-contours")
   (show-numbers
    :accessor <contour>-show-numbers
    :initform "On"
    :initarg :show-numbers
    :documentation "show-numbers")
   (specular-lighting
    :accessor <contour>-specular-lighting
    :initform "On"
    :initarg :specular-lighting
    :documentation "specular-lighting")
   (surface-drawing
    :accessor <contour>-surface-drawing
    :initform "Smooth Shading"
    :initarg :surface-drawing
    :documentation "surface-drawing")
   (text-colour
    :accessor <contour>-text-colour
    :initform "0, 0, 0"
    :initarg :text-colour
    :documentation "text-colour")
   (text-colour-mode
    :accessor <contour>-text-colour-mode
    :initform "Default"
    :initarg :text-colour-mode
    :documentation "text-colour-mode")
   (text-height
    :accessor <contour>-text-height
    :initform "0.012"
    :initarg :text-height
    :documentation "text-height")
   (transparency
    :accessor <contour>-transparency
    :initform "0.0"
    :initarg :transparency
    :documentation "transparency")
   (value-list
    :accessor <contour>-value-list
    :initform "0 [C],1 [C]"
    :initarg :value-list
    :documentation "value-list")
   (visibility
    :accessor <contour>-visibility
    :initform "On"
    :initarg :visibility
    :documentation "visibility")
   (object-view-transform
    :accessor <contour>-object-view-transform
    :initform (make-instance '<object-view-transform>)
    :initarg :object-view-transform
    :documentation "object-view-transform")))

(defmethod print-object ((contour <contour>) s)
  (format s "CONTOUR: ~A~%" (<obj>-name contour))
  (loop :for slot :in (sb-mop:class-direct-slots (find-class '<contour>))
        :do
           (print-slot slot contour s)))

(defmethod print-object :after ((contour <contour>) s)
  (format s "END~%"))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defclass <camera> ()
  ((option
    :accessor <camera>-option
    :initform "Pivot Point and Quaternion"
    :initarg :option
    :documentation "option")
   (pan
    :accessor <camera>-pan
    :initform "-0.00218911, 0.0109455"
    :initarg :pan
    :documentation "pan")
   (pivot-point
    :accessor <camera>-pivot-point
    :initform "0.0495, 0.338411, 7.45058e-09"
    :initarg :pivot-point
    :documentation "pivot-point")
   (rotation
    :accessor <camera>-rotation
    :initform "-90, 0, 0"
    :initarg :rotation
    :documentation "rotation")
   (rotation-quaternion
    :accessor <camera>-rotation-quaternion
    :initform "0, -0.707107, 0, 0.707107"
    :initarg :rotation-quaternion
    :documentation "rotation-quaternion")
   (scale
    :accessor <camera>-scale
    :initform "10.0214"
    :initarg :scale
    :documentation "scale")
   (send-to-viewer
    :accessor <camera>-send-to-viewer
    :initform "True"
    :initarg :send-to-viewer
    :documentation "send-to-viewer")))

(defmethod print-object ((camera <camera>) s)
  (format s "  CAMERA:~%")
  (loop :for slot :in (sb-mop:class-direct-slots (find-class '<camera>))
        :do
           (print-slot slot camera s)))

(defmethod print-object :after ((camera <camera>) s)
  (format s "  END~%"))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defclass <view> (<obj>)
  (
   (angular-coord-shift
    :accessor <view>-angular-coord-shift
    :initform "0.0"
    :initarg :angular-coord-shift
    :documentation "angular-coord-shift")
   (auto-center
    :accessor <view>-auto-center
    :initform "false"
    :initarg :auto-center
    :documentation "auto-center")
   (axis-visibility
    :accessor <view>-axis-visibility
    :initform "On"
    :initarg :axis-visibility
    :documentation "axis-visibility")
   (border-visibility
    :accessor <view>-border-visibility
    :initform "false"
    :initarg :border-visibility
    :documentation "border-visibility")
   (camera-mode
    :accessor <view>-camera-mode
    :initform "User Specified"
    :initarg :camera-mode
    :documentation "camera-mode")
   (clip-plane
    :accessor <view>-clip-plane
    :initform ""
    :initarg :clip-plane
    :documentation "clip-plane")
   (clip-scene
    :accessor <view>-clip-scene
    :initform "false"
    :initarg :clip-scene
    :documentation "clip-scene")
   (coord-transform
    :accessor <view>-coord-transform
    :initform "Cartesian"
    :initarg :coord-transform
    :documentation "coord-transform")
   (hide-difference-case
    :accessor <view>-hide-difference-case
    :initform "false"
    :initarg :hide-difference-case
    :documentation "hide-difference-case")
   (highlight-type
    :accessor <view>-highlight-type
    :initform "Surface Mesh"
    :initarg :highlight-type
    :documentation "highlight-type")
   (is-a-figure
    :accessor <view>-is-a-figure
    :initform "true"
    :initarg :is-a-figure
    :documentation "is-a-figure")
   (light-angle
    :accessor <view>-light-angle
    :initform "50, 110"
    :initarg :light-angle
    :documentation "light-angle")
   (local-object-list
    :accessor <view>-local-object-list
    :initform "/CONTOUR:Contour TTMP X p49i5 Figure 1,/PLANE:Plane X p49i5 Figure 1"
    :initarg :local-object-list
    :documentation "local-object-list")
   (object-visibility-list
    :accessor <view>-object-visibility-list
    :initform "/CONTOUR:Contour TTMP X p49i5 Figure 1,/DEFAULT LEGEND:Default Legend Figure 1"
    :initarg :object-visibility-list
    :documentation "object-visibility-list")
   (projection
    :accessor <view>-projection
    :initform "Orthographic"
    :initarg :projection
    :documentation "projection")
   (ruler-visibility
    :accessor <view>-ruler-visibility
    :initform "On"
    :initarg :ruler-visibility
    :documentation "ruler-visibility")
   (standard-view
    :accessor <view>-standard-view
    :initform "Isometric Y"
    :initarg :standard-view
    :documentation "standard-view")
   (valid-case
    :accessor <view>-valid-case
    :initform ""
    :initarg :valid-case
    :documentation "valid-case")
   (camera
    :accessor <view>-camera
    :initform (make-instance '<camera>)
    :initarg :camera
    :documentation "camera")
   ))

(defmethod print-object ((view <view>) s)
  (format s "VIEW: ~A~%" (<obj>-name view))
  (loop :for slot :in (sb-mop:class-direct-slots (find-class '<view>))
        :do
           (print-slot slot view s)))

(defmethod print-object :after ((view <view>) s)
  (format s "END~%"))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defclass <default-legend> (<obj>)
  ((colour
    :accessor <default-legend>-colour
    :initform "0, 0, 0"
    :initarg :colour
    :documentation "colour")
   (font
    :accessor <default-legend>-font
    :initform "Sans Serif"
    :initarg :font
    :documentation "font")
   (legend-aspect
    :accessor <default-legend>-legend-aspect
    :initform "0.04"
    :initarg :legend-aspect
    :documentation "legend-aspect")
   (legend-format
    :accessor <default-legend>-legend-format
    :initform "%4.1f"
    :initarg :legend-format
    :documentation "legend-format")
   (legend-orientation
    :accessor <default-legend>-legend-orientation
    :initform "Vertical"
    :initarg :legend-orientation
    :documentation "legend-orientation")
   (legend-position
    :accessor <default-legend>-legend-position
    :initform "0.02 , 0.15"
    :initarg :legend-position
    :documentation "legend-position")
   (legend-resolution
    :accessor <default-legend>-legend-resolution
    :initform "256"
    :initarg :legend-resolution
    :documentation "legend-resolution")
   (legend-shading
    :accessor <default-legend>-legend-shading
    :initform "Smooth"
    :initarg :legend-shading
    :documentation "legend-shading")
   (legend-size
    :accessor <default-legend>-legend-size
    :initform "1"
    :initarg :legend-size
    :documentation "legend-size")
   (legend-ticks
    :accessor <default-legend>-legend-ticks
    :initform "5"
    :initarg :legend-ticks
    :documentation "legend-ticks")
   (legend-title
    :accessor <default-legend>-legend-title
    :initform "Legend"
    :initarg :legend-title
    :documentation "legend-title")
   (legend-title-mode
    :accessor <default-legend>-legend-title-mode
    :initform "Variable and Location"
    :initarg :legend-title-mode
    :documentation "legend-title-mode")
   (legend-x-justification
    :accessor <default-legend>-legend-x-justification
    :initform "Left"
    :initarg :legend-x-justification
    :documentation "legend-x-justification")
   (legend-y-justification
    :accessor <default-legend>-legend-y-justification
    :initform "Top"
    :initarg :legend-y-justification
    :documentation "legend-y-justification")
   (related-object
    :accessor <default-legend>-related-object
    :initform "View 1"
    :initarg :related-object
    :documentation "related-object")
   (show-legend-units
    :accessor <default-legend>-show-legend-units
    :initform "On"
    :initarg :show-legend-units
    :documentation "show-legend-units")
   (text-colour-mode
    :accessor <default-legend>-text-colour-mode
    :initform "Default"
    :initarg :text-colour-mode
    :documentation "text-colour-mode")
   (text-height
    :accessor <default-legend>-text-height
    :initform "0.018"
    :initarg :text-height
    :documentation "text-height")
   (text-rotation
    :accessor <default-legend>-text-rotation
    :initform "0"
    :initarg :text-rotation
    :documentation "text-rotation")
   (visibility
    :accessor <default-legend>-visibility
    :initform "Off"
    :initarg :visibility
    :documentation "visibility")))

(defmethod print-object ((default-legend <default-legend>) s)
  (format s "DEFAULT LEGEND: ~A~%" (<obj>-name default-legend))
  (loop :for slot :in (sb-mop:class-direct-slots (find-class '<default-legend>))
        :do
           (print-slot slot default-legend s)))

(defmethod print-object :after ((default-legend <default-legend>) s)
  (format s "END~%"))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defclass <legend> (<obj>)
  ((colour
    :accessor <legend>-colour
    :initform "0, 0, 0"
    :initarg :colour
    :documentation "colour")
   (font
    :accessor <legend>-font
    :initform "Sans Serif"
    :initarg :font
    :documentation "font")
   (legend-aspect
    :accessor <legend>-legend-aspect
    :initform "0.05"
    :initarg :legend-aspect
    :documentation "legend-aspect")
   (legend-format
    :accessor <legend>-legend-format
    :initform "%4.1f"
    :initarg :legend-format
    :documentation "legend-format")
   (legend-orientation
    :accessor <legend>-legend-orientation
    :initform "Vertical"
    :initarg :legend-orientation
    :documentation "legend-orientation")
   (legend-plot
    :accessor <legend>-legend-plot
    :initform "/CONTOUR:Contour TTMP X p49i5"
    :initarg :legend-plot
    :documentation "legend-plot")
   (legend-position
    :accessor <legend>-legend-position
    :initform "0.02 , 0.15"
    :initarg :legend-position
    :documentation "legend-position")
   (legend-size
    :accessor <legend>-legend-size
    :initform "1.0"
    :initarg :legend-size
    :documentation "legend-size")
   (legend-ticks
    :accessor <legend>-legend-ticks
    :initform "5"
    :initarg :legend-ticks
    :documentation "legend-ticks")
   (legend-title
    :accessor <legend>-legend-title
    :initform "Legend"
    :initarg :legend-title
    :documentation "legend-title")
   (legend-title-mode
    :accessor <legend>-legend-title-mode
    :initform "Variable and Location"
    :initarg :legend-title-mode
    :documentation "legend-title-mode")
   (legend-x-justification
    :accessor <legend>-legend-x-justification
    :initform "Left"
    :initarg :legend-x-justification
    :documentation "legend-x-justification")
   (legend-y-justification
    :accessor <legend>-legend-y-justification
    :initform "Bottom"
    :initarg :legend-y-justification
    :documentation "legend-y-justification")
   (show-legend-units
    :accessor <legend>-show-legend-units
    :initform "On"
    :initarg :show-legend-units
    :documentation "show-legend-units")
   (text-colour-mode
    :accessor <legend>-text-colour-mode
    :initform "Default"
    :initarg :text-colour-mode
    :documentation "text-colour-mode")
   (text-height
    :accessor <legend>-text-height
    :initform "0.018"
    :initarg :text-height
    :documentation "text-height")
   (text-rotation
    :accessor <legend>-text-rotation
    :initform "0"
    :initarg :text-rotation
    :documentation "text-rotation")
   (visibility
    :accessor <legend>-visibility
    :initform "On"
    :initarg :visibility
    :documentation "visibility")))

(defmethod print-object ((legend <legend>) s)
  (format s "DEFAULT LEGEND: ~A~%" (<obj>-name legend))
  (loop :for slot :in (sb-mop:class-direct-slots (find-class '<legend>))
        :do
           (print-slot slot legend s)))

(defmethod print-object :after ((legend <legend>) s)
  (format s "END~%"))

(make-instance '<legend>)

(make-instance '<view>)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

#+nil (mnas-string:replace-all string " Of " " of ")

#+nil (let* ((x 80.0 )
       (plane
         (make-instance '<plane> :name (format nil "Plane X ~A" (mnas-ansys/belt:number-to-string x))
                                 :x (format nil "~A [mm]" x)))
       (contour
         (make-instance '<contour>
  :name (format nil "Contour X ~A" (mnas-ansys/belt:number-to-string x))
  :location-list (format nil "/PLANE:Plane X ~A" (mnas-ansys/belt:number-to-string x))))
       )
  (format t "~{~A~%~}" `(,contour))) ;   ,plane

#+nil (defparameter *plane*
  (make-instance '<plane> :name (format nil "Plane X ~A" (mnas-ansys/belt:number-to-string 115.5))
                          :x (format nil "~A [mm]" 115.5)))

#+nil (defparameter *contour*
  (make-instance '<contour>
  :name (format nil "Contour X ~A" (mnas-ansys/belt:number-to-string 115.5))
  :location-list (format nil "/PLANE:Plane X ~A" (mnas-ansys/belt:number-to-string 115.5))))

#+nil (defparameter *object-view-transform* (make-instance '<object-view-transform>))

#+nil (defparameter *point* (make-instance '<point> :name "Point 1" :apply-instancing-transform nil ))

#+nil (defparameter *line* (make-instance '<line> :name "Line 1" ))
