;;;; ./src/ccl/core/core.lisp

(defpackage #:mnas-ansys/ccl/core
  (:use #:cl)
  (:export for-list)
  (:intern <object>
           <object>-type)
  (:intern <obj>)
  (:export <obj>-name
           <obj>-full-name)
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
  (:export <object-report-options>
           <object-report-options>-report-caption)
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
           <point>-visibility
           )
  (:export <line>
           <line>-apply-instancing-transform
           <line>-colour
           <line>-colour-map
           <line>-colour-mode
           <line>-colour-scale
           <line>-colour-variable
           <line>-colour-variable-boundary-values
           <line>-domain-list
           <line>-instancing-transform
           <line>-line-samples
           <line>-line-type
           <line>-line-width
           <line>-max
           <line>-min
           <line>-option
           <line>-point-1
           <line>-point-2
           <line>-point-2
           <line>-visibility
           <line>-object-view-transform
           )
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
  (:export <surface-of-revolution>
           <surface-of-revolution>-apply-instancing-transform
           <surface-of-revolution>-apply-texture
           <surface-of-revolution>-blend-texture
           <surface-of-revolution>-colour
           <surface-of-revolution>-colour-map
           <surface-of-revolution>-colour-mode
           <surface-of-revolution>-colour-scale
           <surface-of-revolution>-colour-variable
           <surface-of-revolution>-colour-variable-boundary-values
           <surface-of-revolution>-culling-mode
           <surface-of-revolution>-domain-list
           <surface-of-revolution>-draw-faces
           <surface-of-revolution>-draw-lines
           <surface-of-revolution>-ending-axial-shift
           <surface-of-revolution>-ending-radial-shift
           <surface-of-revolution>-instancing-transform
           <surface-of-revolution>-lighting
           <surface-of-revolution>-line-colour
           <surface-of-revolution>-line-colour-mode
           <surface-of-revolution>-line-width
           <surface-of-revolution>-location-list
           <surface-of-revolution>-max
           <surface-of-revolution>-meridional-point-1
           <surface-of-revolution>-meridional-point-2
           <surface-of-revolution>-meridional-points
           <surface-of-revolution>-min
           <surface-of-revolution>-option
           <surface-of-revolution>-principal-axis
           <surface-of-revolution>-project-to-ar-plane
           <surface-of-revolution>-range
           <surface-of-revolution>-render-edge-angle
           <surface-of-revolution>-rotation-axis-from
           <surface-of-revolution>-rotation-axis-to
           <surface-of-revolution>-rotation-axis-type
           <surface-of-revolution>-specular-lighting
           <surface-of-revolution>-starting-axial-shift
           <surface-of-revolution>-starting-radial-shift
           <surface-of-revolution>-surface-drawing
           <surface-of-revolution>-texture-angle
           <surface-of-revolution>-texture-direction
           <surface-of-revolution>-texture-file
           <surface-of-revolution>-texture-material
           <surface-of-revolution>-texture-position
           <surface-of-revolution>-texture-scale
           <surface-of-revolution>-texture-type
           <surface-of-revolution>-theta-points
           <surface-of-revolution>-tile-texture
           <surface-of-revolution>-transform-texture
           <surface-of-revolution>-transparency
           <surface-of-revolution>-use-angle-range
           <surface-of-revolution>-visibility
           <surface-of-revolution>-object-view-transform
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
           <view>-camera
           <view>-object-report-options)
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
  (:export <vector>
           <vector>-apply-instancing-transform
           <vector>-colour
           <vector>-colour-map
           <vector>-colour-mode
           <vector>-colour-scale
           <vector>-colour-variable
           <vector>-colour-variable-boundary-values
           <vector>-coord-frame
           <vector>-culling-mode
           <vector>-direction
           <vector>-domain-list
           <vector>-draw-faces
           <vector>-draw-lines
           <vector>-instancing-transform
           <vector>-lighting
           <vector>-line-width
           <vector>-location-list
           <vector>-locator-sampling-method
           <vector>-max
           <vector>-maximum-number-of-items
           <vector>-min
           <vector>-normalized
           <vector>-number-of-samples
           <vector>-projection-type
           <vector>-random-seed
           <vector>-range
           <vector>-reduction-factor
           <vector>-reduction-or-max-number
           <vector>-sample-spacing
           <vector>-sampling-aspect-ratio
           <vector>-sampling-grid-angle
           <vector>-specular-lighting
           <vector>-surface-drawing
           <vector>-symbol
           <vector>-symbol-size
           <vector>-transparency
           <vector>-variable
           <vector>-variable-boundary-values
           <vector>-visibility
           <vector>-object-view-transform
           )
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
      (mnas-string:replace-all-words
       (substitute
        #\Space #\- 
        (string-capitalize
         (format nil "  ~A = " (sb-mop:slot-definition-name slot))))
       '((" Of " " of ")
         (" Or " " or ")
         (" To Ar " " to AR ")
         )) 
      (slot-value class (sb-mop:slot-definition-name slot))))
    ((eq 'standard-class
         (type-of (class-of (slot-value class (sb-mop:slot-definition-name slot)))))
     (format stream "~A" (slot-value class (sb-mop:slot-definition-name slot))))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defclass <object> () ())

(defmethod <object>-type ((object <object>))
  (nsubstitute #\Space #\-
               (string-trim "<>"
                            (format nil "~A"
                                    (class-name (class-of object))))))

(defmethod print-object :after ((x <object>) s)
  (loop :for slot :in (sb-mop:class-direct-slots (class-of x))
        :do (print-slot slot x s))
  (format s "END~%"))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defclass <obj> (<object>)
  ((name :accessor <obj>-name
         :initform "Name"
         :initarg :name
         :documentation "Имя объекта")))

(defmethod print-object :after ((x <obj>) s)
  )

(defmethod <obj>-full-name ((obj <obj>))
  (format nil "/~A: ~A"
          (<object>-type obj)
          (<obj>-name obj)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defclass <object-view-transform> (<object>)
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

(defmethod print-object ((x <object-view-transform>) s)
  (format s "  ~A:~%" (<object>-type x))
  #+nil (loop :for slot :in (sb-mop:class-direct-slots (class-of x))
        :do (print-slot slot x s)))

(defmethod print-object :after ((x <object-view-transform>) s)
  #+nil(format s "  END~%"))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defclass <object-report-options> (<object>)
  ((report-caption
   :accessor <object-report-options>-report-caption
   :initform "Caption for Report"
   :initarg :report-caption
   :documentation "report-caption")))

(defmethod print-object ((x <object-report-options>) s)
  (format s "  ~A:~%" (<object>-type x))
  #+nil (loop :for slot :in (sb-mop:class-direct-slots (class-of x))
        :do (print-slot slot x s)))

(defmethod print-object :after ((x <object-report-options>) s)
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

(defmethod print-object ((x <point>) s)
  (format s "~A: ~A~%"
          (<object>-type x)
          (<obj>-name x)))

(make-instance '<point>)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defclass <line> (<obj>)
  ((apply-instancing-transform
    :accessor <line>-apply-instancing-transform
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

(defmethod print-object ((x <line>) s)
  (format s "~A: ~A~%"
          (<object>-type x)
          (<obj>-name x)))

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

(defmethod print-object ((x <plane>) s)
  (format s "~A: ~A~%"
          (<object>-type x)
          (<obj>-name x)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defclass <surface-of-revolution> (<obj>)
  ((apply-instancing-transform
    :accessor <surface-of-revolution>-apply-instancing-transform
    :initform "On"
    :initarg :apply-instancing-transform
    :documentation "apply-instancing-transform")
   (apply-texture
    :accessor <surface-of-revolution>-apply-texture
    :initform "Off"
    :initarg :apply-texture
    :documentation "apply-texture")
   (blend-texture
    :accessor <surface-of-revolution>-blend-texture
    :initform "On"
    :initarg :blend-texture
    :documentation "blend-texture")
   (colour
    :accessor <surface-of-revolution>-colour
    :initform "0.75, 0.75, 0.75"
    :initarg :colour
    :documentation "colour")
   (colour-map
    :accessor <surface-of-revolution>-colour-map
    :initform "Default Colour Map"
    :initarg :colour-map
    :documentation "colour-map")
   (colour-mode
    :accessor <surface-of-revolution>-colour-mode
    :initform "Constant"
    :initarg :colour-mode
    :documentation "colour-mode")
   (colour-scale
    :accessor <surface-of-revolution>-colour-scale
    :initform "Linear"
    :initarg :colour-scale
    :documentation "colour-scale")
   (colour-variable
    :accessor <surface-of-revolution>-colour-variable
    :initform "Pressure"
    :initarg :colour-variable
    :documentation "colour-variable")
   (colour-variable-boundary-values
    :accessor <surface-of-revolution>-colour-variable-boundary-values
    :initform "Hybrid"
    :initarg :colour-variable-boundary-values
    :documentation "colour-variable-boundary-values")
   (culling-mode
    :accessor <surface-of-revolution>-culling-mode
    :initform "No Culling"
    :initarg :culling-mode
    :documentation "culling-mode")
   (domain-list
    :accessor <surface-of-revolution>-domain-list
    :initform "/DOMAIN GROUP:All Domains"
    :initarg :domain-list
    :documentation "domain-list")
   (draw-faces
    :accessor <surface-of-revolution>-draw-faces
    :initform "On"
    :initarg :draw-faces
    :documentation "draw-faces")
   (draw-lines
    :accessor <surface-of-revolution>-draw-lines
    :initform "Off"
    :initarg :draw-lines
    :documentation "draw-lines")
   (ending-axial-shift
    :accessor <surface-of-revolution>-ending-axial-shift
    :initform "0 [mm]"
    :initarg :ending-axial-shift
    :documentation "ending-axial-shift")
   (ending-radial-shift
    :accessor <surface-of-revolution>-ending-radial-shift
    :initform "0.0 [m]"
    :initarg :ending-radial-shift
    :documentation "ending-radial-shift")
   (instancing-transform
    :accessor <surface-of-revolution>-instancing-transform
    :initform "/DEFAULT INSTANCE TRANSFORM:Default Transform"
    :initarg :instancing-transform
    :documentation "instancing-transform")
   (lighting
    :accessor <surface-of-revolution>-lighting
    :initform "On"
    :initarg :lighting
    :documentation "lighting")
   (line-colour
    :accessor <surface-of-revolution>-line-colour
    :initform "0, 0, 0"
    :initarg :line-colour
    :documentation "line-colour")
   (line-colour-mode
    :accessor <surface-of-revolution>-line-colour-mode
    :initform "Default"
    :initarg :line-colour-mode
    :documentation "line-colour-mode")
   (line-width
    :accessor <surface-of-revolution>-line-width
    :initform "1"
    :initarg :line-width
    :documentation "line-width")
   (location-list
    :accessor <surface-of-revolution>-location-list
    :initform "/LINE:Line Zav2 Out"
    :initarg :location-list
    :documentation "location-list")
   (max
    :accessor <surface-of-revolution>-max
    :initform "0.0 [Pa]"
    :initarg :max
    :documentation "max")
   (meridional-point-1
    :accessor <surface-of-revolution>-meridional-point-1
    :initform "300 [mm], 31.5 [mm]"
    :initarg :meridional-point-1
    :documentation "meridional-point-1")
   (meridional-point-2
    :accessor <surface-of-revolution>-meridional-point-2
    :initform "1 [mm], 45 [mm]"
    :initarg :meridional-point-2
    :documentation "meridional-point-2")
   (meridional-points
    :accessor <surface-of-revolution>-meridional-points
    :initform "50"
    :initarg :meridional-points
    :documentation "meridional-points")
   (min
    :accessor <surface-of-revolution>-min
    :initform "0.0 [Pa]"
    :initarg :min
    :documentation "min")
   (option
    :accessor <surface-of-revolution>-option
    :initform "From Line"
    :initarg :option
    :documentation "option")
   (principal-axis
    :accessor <surface-of-revolution>-principal-axis
    :initform "X"
    :initarg :principal-axis
    :documentation "principal-axis")
   (project-to-ar-plane
    :accessor <surface-of-revolution>-project-to-ar-plane
    :initform "On"
    :initarg :project-to-ar-plane
    :documentation "project-to-ar-plane")
   (range
    :accessor <surface-of-revolution>-range
    :initform "Global"
    :initarg :range
    :documentation "range")
   (render-edge-angle
    :accessor <surface-of-revolution>-render-edge-angle
    :initform "0 [degree]"
    :initarg :render-edge-angle
    :documentation "render-edge-angle")
   (rotation-axis-from
    :accessor <surface-of-revolution>-rotation-axis-from
    :initform "0 [mm], 335 [mm], 0 [mm]"
    :initarg :rotation-axis-from
    :documentation "rotation-axis-from")
   (rotation-axis-to
    :accessor <surface-of-revolution>-rotation-axis-to
    :initform "1000 [mm], 335 [mm], 0 [mm]"
    :initarg :rotation-axis-to
    :documentation "rotation-axis-to")
   (rotation-axis-type
    :accessor <surface-of-revolution>-rotation-axis-type
    :initform "Rotation Axis"
    :initarg :rotation-axis-type
    :documentation "rotation-axis-type")
   (specular-lighting
    :accessor <surface-of-revolution>-specular-lighting
    :initform "On"
    :initarg :specular-lighting
    :documentation "specular-lighting")
   (starting-axial-shift
    :accessor <surface-of-revolution>-starting-axial-shift
    :initform "0 [mm]"
    :initarg :starting-axial-shift
    :documentation "starting-axial-shift")
   (starting-radial-shift
    :accessor <surface-of-revolution>-starting-radial-shift
    :initform "0.0 [m]"
    :initarg :starting-radial-shift
    :documentation "starting-radial-shift")
   (surface-drawing
    :accessor <surface-of-revolution>-surface-drawing
    :initform "Smooth Shading"
    :initarg :surface-drawing
    :documentation "surface-drawing")
   (texture-angle
    :accessor <surface-of-revolution>-texture-angle
    :initform "0"
    :initarg :texture-angle
    :documentation "texture-angle")
   (texture-direction
    :accessor <surface-of-revolution>-texture-direction
    :initform "0 , 1 , 0"
    :initarg :texture-direction
    :documentation "texture-direction")
   (texture-file
    :accessor <surface-of-revolution>-texture-file
    :initform ""
    :initarg :texture-file
    :documentation "texture-file")
   (texture-material
    :accessor <surface-of-revolution>-texture-material
    :initform "Metal"
    :initarg :texture-material
    :documentation "texture-material")
   (texture-position
    :accessor <surface-of-revolution>-texture-position
    :initform "0 , 0"
    :initarg :texture-position
    :documentation "texture-position")
   (texture-scale
    :accessor <surface-of-revolution>-texture-scale
    :initform "1"
    :initarg :texture-scale
    :documentation "texture-scale")
   (texture-type
    :accessor <surface-of-revolution>-texture-type
    :initform "Predefined"
    :initarg :texture-type
    :documentation "texture-type")
   (theta-points
    :accessor <surface-of-revolution>-theta-points
    :initform "50"
    :initarg :theta-points
    :documentation "theta-points")
   (tile-texture
    :accessor <surface-of-revolution>-tile-texture
    :initform "Off"
    :initarg :tile-texture
    :documentation "tile-texture")
   (transform-texture
    :accessor <surface-of-revolution>-transform-texture
    :initform "Off"
    :initarg :transform-texture
    :documentation "transform-texture")
   (transparency
    :accessor <surface-of-revolution>-transparency
    :initform "0.0"
    :initarg :transparency
    :documentation "transparency")
   (use-angle-range
    :accessor <surface-of-revolution>-use-angle-range
    :initform "Off"
    :initarg :use-angle-range
    :documentation "use-angle-range")
   (visibility
    :accessor <surface-of-revolution>-visibility
    :initform "On"
    :initarg :visibility
    :documentation "visibility")
   (object-view-transform
    :accessor <surface-of-revolution>-object-view-transform
    :initform (make-instance '<object-view-transform>)
    :initarg :object-view-transform
    :documentation "object-view-transform")))

(defmethod print-object ((x <surface-of-revolution>) s)
  (format s "~A: ~A~%"
          (<object>-type x)
          (<obj>-name x)))

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
    :initform "0.018"
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

(defmethod print-object ((x <contour>) s)
  (format s "~A: ~A~%"
          (<object>-type x)
          (<obj>-name x)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defclass <camera> (<object>)
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

(defmethod print-object ((x <camera>) s)
  (format s "  ~A:~%" (<object>-type x)))

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
   (object-report-options
    :accessor <view>-object-report-options
    :initform (make-instance '<object-report-options>)
    :initarg :object-report-options
    :documentation "object-report-options")))

(defmethod print-object ((x <view>) s)
  (format s "~A: ~A~%"
          (<object>-type x)
          (<obj>-name x)))

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

(defmethod print-object ((x <default-legend>) s)
  (format s "~A: ~A~%"
          (<object>-type x)
          (<obj>-name x)))

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

(defmethod print-object ((x <legend>) s)
  (format s "~A: ~A~%"
          (<object>-type x)
          (<obj>-name x)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defclass <vector> (<obj>)
  (
   (apply-instancing-transform
    :accessor <vector>-apply-instancing-transform
    :initform "On"
    :initarg :apply-instancing-transform
    :documentation "apply-instancing-transform")
   (colour
    :accessor <vector>-colour
    :initform "0.75, 0.75, 0.75"
    :initarg :colour
    :documentation "colour")
   (colour-map
    :accessor <vector>-colour-map
    :initform "Default Colour Map"
    :initarg :colour-map
    :documentation "colour-map")
   (colour-mode
    :accessor <vector>-colour-mode
    :initform "Use Plot Variable"
    :initarg :colour-mode
    :documentation "colour-mode")
   (colour-scale
    :accessor <vector>-colour-scale
    :initform "Linear"
    :initarg :colour-scale
    :documentation "colour-scale")
   (colour-variable
    :accessor <vector>-colour-variable
    :initform "Velocity"
    :initarg :colour-variable
    :documentation "colour-variable")
   (colour-variable-boundary-values
    :accessor <vector>-colour-variable-boundary-values
    :initform "Hybrid"
    :initarg :colour-variable-boundary-values
    :documentation "colour-variable-boundary-values")
   (coord-frame
    :accessor <vector>-coord-frame
    :initform "Global"
    :initarg :coord-frame
    :documentation "coord-frame")
   (culling-mode
    :accessor <vector>-culling-mode
    :initform "No Culling"
    :initarg :culling-mode
    :documentation "culling-mode")
   (direction
    :accessor <vector>-direction
    :initform "X"
    :initarg :direction
    :documentation "direction")
   (domain-list
    :accessor <vector>-domain-list
    :initform "/DOMAIN GROUP:All Domains"
    :initarg :domain-list
    :documentation "domain-list")
   (draw-faces
    :accessor <vector>-draw-faces
    :initform "On"
    :initarg :draw-faces
    :documentation "draw-faces")
   (draw-lines
    :accessor <vector>-draw-lines
    :initform "Off"
    :initarg :draw-lines
    :documentation "draw-lines")
   (instancing-transform
    :accessor <vector>-instancing-transform
    :initform "/DEFAULT INSTANCE TRANSFORM:Default Transform"
    :initarg :instancing-transform
    :documentation "instancing-transform")
   (lighting
    :accessor <vector>-lighting
    :initform "On"
    :initarg :lighting
    :documentation "lighting")
   (line-width
    :accessor <vector>-line-width
    :initform "1"
    :initarg :line-width
    :documentation "line-width")
   (location-list
    :accessor <vector>-location-list
    :initform "/PLANE:Plane V Z p0i0"
    :initarg :location-list
    :documentation "location-list")
   (locator-sampling-method
    :accessor <vector>-locator-sampling-method
    :initform "Vertex"
    :initarg :locator-sampling-method
    :documentation "locator-sampling-method")
   (max
    :accessor <vector>-max
    :initform "110 [m s^-1]"
    :initarg :max
    :documentation "max")
   (maximum-number-of-items
    :accessor <vector>-maximum-number-of-items
    :initform "100"
    :initarg :maximum-number-of-items
    :documentation "maximum-number-of-items")
   (min
    :accessor <vector>-min
    :initform "0 [m s^-1]"
    :initarg :min
    :documentation "min")
   (normalized
    :accessor <vector>-normalized
    :initform "Off"
    :initarg :normalized
    :documentation "normalized")
   (number-of-samples
    :accessor <vector>-number-of-samples
    :initform "100"
    :initarg :number-of-samples
    :documentation "number-of-samples")
   (projection-type
    :accessor <vector>-projection-type
    :initform "None"
    :initarg :projection-type
    :documentation "projection-type")
   (random-seed
    :accessor <vector>-random-seed
    :initform "1"
    :initarg :random-seed
    :documentation "random-seed")
   (range
    :accessor <vector>-range
    :initform "User Specified"
    :initarg :range
    :documentation "range")
   (reduction-factor
    :accessor <vector>-reduction-factor
    :initform "30"
    :initarg :reduction-factor
    :documentation "reduction-factor")
   (reduction-or-max-number
    :accessor <vector>-reduction-or-max-number
    :initform "Reduction"
    :initarg :reduction-or-max-number
    :documentation "reduction-or-max-number")
   (sample-spacing
    :accessor <vector>-sample-spacing
    :initform "0.1"
    :initarg :sample-spacing
    :documentation "sample-spacing")
   (sampling-aspect-ratio
    :accessor <vector>-sampling-aspect-ratio
    :initform "1"
    :initarg :sampling-aspect-ratio
    :documentation "sampling-aspect-ratio")
   (sampling-grid-angle
    :accessor <vector>-sampling-grid-angle
    :initform "0 [degree]"
    :initarg :sampling-grid-angle
    :documentation "sampling-grid-angle")
   (specular-lighting
    :accessor <vector>-specular-lighting
    :initform "On"
    :initarg :specular-lighting
    :documentation "specular-lighting")
   (surface-drawing
    :accessor <vector>-surface-drawing
    :initform "Smooth Shading"
    :initarg :surface-drawing
    :documentation "surface-drawing")
   (symbol
    :accessor <vector>-symbol
    :initform "Line Arrow"
    :initarg :symbol
    :documentation "symbol")
   (symbol-size
    :accessor <vector>-symbol-size
    :initform "5"
    :initarg :symbol-size
    :documentation "symbol-size")
   (transparency
    :accessor <vector>-transparency
    :initform "0.0"
    :initarg :transparency
    :documentation "transparency")
   (variable
    :accessor <vector>-variable
    :initform "Velocity"
    :initarg :variable
    :documentation "variable")
   (variable-boundary-values
    :accessor <vector>-variable-boundary-values
    :initform "Hybrid"
    :initarg :variable-boundary-values
    :documentation "variable-boundary-values")
   (visibility
    :accessor <vector>-visibility
    :initform "On"
    :initarg :visibility
    :documentation "visibility")
   (object-view-transform
    :accessor <vector>-object-view-transform
    :initform (make-instance '<object-view-transform>)
    :initarg :object-view-transform
    :documentation "object-view-transform")))

(defmethod print-object ((x <vector>) s)
  (format s "~A: ~A~%"
          (<object>-type x)
          (<obj>-name x)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
