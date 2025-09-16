;;;; ./src/ccl/core/core.lisp

(defpackage :mnas-ansys/ccl/core
  (:use #:cl)
  (:export for-list)
  (:intern <object>
           <object>-type
           )
  (:export <obj>)
  (:export <obj>-name
           <obj>-full-name
           full-names
           ) 
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
  (:export <table-cell>
           <table-cell>-row
           <table-cell>-col
           <table-cell>-equation
           <table-cell>-bold
           <table-cell>-italics
           <table-cell>-underline
           <table-cell>-justification
           <table-cell>-warp
           <table-cell>-font-size
           <table-cell>-font-name
           <table-cell>-rows
           <table-cell>-cols
           <table-cell>-format
           <table-cell>-show-units
           <table-cell>-foreground
           <table-cell>-background
           <table-cell>-show-value)
  (:export <table-cells>-cells)
  (:export <table>
           <table>-export-table-only
           <table>-table-exists
           <table>-table-export-format
           <table>-table-export-html-border-width
           <table>-table-export-html-caption-position
           <table>-table-export-html-cell-padding
           <table>-table-export-html-cell-spacing
           <table>-table-export-lines
           <table>-table-export-separator
           <table>-table-export-trailing-separators
           <table>-object-report-options
           <table>-table-cells)
  (:export <monitor-location-control>
           <monitor-location-control>-domain-name
           <monitor-location-control>-interpolation-type
           )
  (:export <position-update-frequency>
           <position-update-frequency>-option
           )
  (:export <monitor-point>
           <monitor-point>-cartesian-coordinates
           <monitor-point>-coord-frame
           <monitor-point>-option
           <monitor-point>-output-variables-list
           <monitor-point>-monitor-location-control
           <monitor-point>-position-update-frequency
           )
  (:export <monitor-objects>
           <monitor-objects>-objects)
  (:export <output-control>
           <output-control>-monitor-objects)
  (:export <flow>
           <flow>-output-control)
  (:export <clip-plane>
           <clip-plane>-flip-normal
           <clip-plane>-normal
           <clip-plane>-option
           <clip-plane>-point
           <clip-plane>-point-1
           <clip-plane>-point-2
           <clip-plane>-point-3
           <clip-plane>-slice-plane
           <clip-plane>-x
           <clip-plane>-y
           <clip-plane>-z
           )
  (:export <streamline>
           <streamline>-absolute-tolerance
           <streamline>-Apply-Instancing-Transform
           <streamline>-Colour
           <streamline>-Colour-Map
           <streamline>-Colour-Mode
           <streamline>-Colour-Scale
           <streamline>-Colour-Variable
           <streamline>-Colour-Variable-Boundary-Values
           <streamline>-Cross-Periodics
           <streamline>-Culling-Mode
           <streamline>-Domain-List
           <streamline>-Draw-Faces
           <streamline>-Draw-Lines
           <streamline>-Draw-Streams
           <streamline>-Draw-Symbols
           <streamline>-Grid-Tolerance
           <streamline>-Instancing-Transform
           <streamline>-Lighting
           <streamline>-Line-Width
           <streamline>-Location-List
           <streamline>-Locator-Sampling-Method
           <streamline>-Max
           <streamline>-Maximum-Number-of-Items
           <streamline>-Min
           <streamline>-Number-of-Samples
           <streamline>-Number-of-Sides
           <streamline>-Range
           <streamline>-Reduction-Factor
           <streamline>-Reduction-or-Max-Number
           <streamline>-Sample-Spacing
           <streamline>-Sampling-Aspect-Ratio
           <streamline>-Sampling-Grid-Angle
           <streamline>-Seed-Point-Type
           <streamline>-Simplify-Geometry
           <streamline>-Specular-Lighting
           <streamline>-Stream-Drawing-Mode
           <streamline>-Stream-Initial-Direction
           <streamline>-Stream-Size
           <streamline>-Stream-Symbol
           <streamline>-Streamline-Direction
           <streamline>-Streamline-Maximum-Periods
           <streamline>-Streamline-Maximum-Segments
           <streamline>-Streamline-Maximum-Time
           <streamline>-Streamline-Type
           <streamline>-Streamline-Width
           <streamline>-Surface-Drawing
           <streamline>-Surface-Streamline-Direction
           <streamline>-Symbol-Size
           <streamline>-Symbol-Start-Time
           <streamline>-Symbol-Stop-Time
           <streamline>-Symbol-Time-Interval
           <streamline>-Tolerance-Mode
           <streamline>-Transparency
           <streamline>-Variable
           <streamline>-Variable-Boundary-Values
           <streamline>-Visibility
           <streamline>-object-view-transform
           )
  (:export <colour-map>
           <colour-map>-Colour-Map-Colours
           <colour-map>-Colour-Map-Divisions
           <colour-map>-Colour-Map-Storage-Type
           <colour-map>-Colour-Map-Type
           )
  (:export  <output-settings>
            <output-settings>-Chart-Image-Type
            <output-settings>-Chart-Size
            <output-settings>-Custom-Chart-Size-Height
            <output-settings>-Custom-Chart-Size-Width
            <output-settings>-Custom-Figure-Size-Height
            <output-settings>-Custom-Figure-Size-Width
            <output-settings>-Figure-Image-Type
            <output-settings>-Figure-Size
            <output-settings>-Fit-Views)
  (:export <preview>
           <preview>-output-settings)
  (:export <publish>
           <publish>-Generate-CVF
           <publish>-Report-Format
           <publish>-Report-Path
           <publish>-Save-Images-In-Separate-Folder
           <publish>-output-settings)
  (:export <report>
           <report>-Preview
           <report>-Publish
           <report>-Mesh-Statistics-Options
           )
  (:export  <mesh-statistics-options>
            <mesh-statistics-options>-Include-In-Report
            <mesh-statistics-options>-Show-Connectivity-Number
            <mesh-statistics-options>-Show-Edge-Length-Ratio
            <mesh-statistics-options>-Show-Element-Volume-Ratio
            <mesh-statistics-options>-Show-Max-Face-Angle
            <mesh-statistics-options>-Show-Min-Face-Angle
            <mesh-statistics-options>-Show-Number-of-Elements
            <mesh-statistics-options>-Show-Number-of-Hexahedra
            <mesh-statistics-options>-Show-Number-of-Nodes
            <mesh-statistics-options>-Show-Number-of-Polyhedra
            <mesh-statistics-options>-Show-Number-of-Pyramids
            <mesh-statistics-options>-Show-Number-of-Tetrahedra
            <mesh-statistics-options>-Show-Number-of-Wedges
            <mesh-statistics-options>-This-Exists
            )
  (:export  <physics-summary-options>
            <physics-summary-options>-Include-In-Report
            <physics-summary-options>-Show-Boundary-Physics
            <physics-summary-options>-Show-Domain-Physics
            <physics-summary-options>-This-Exists
            )
  (:export <solution-summary-options>
           <solution-summary-options>-Include-In-Report
           <solution-summary-options>-Show-Boundary-Flow-Summary
           <solution-summary-options>-Show-Force-and-Torque-Summary
           <solution-summary-options>-Show-Forces
           <solution-summary-options>-Show-Torques
           <solution-summary-options>-This-Exists
           )
  (:export <file-information-options>
           <file-information-options>-Include-In-Report
           <file-information-options>-This-Exists
           )
  (:export <mesh-transformation>
           <mesh-transformation>-Angle-End
           <mesh-transformation>-Angle-Start
           <mesh-transformation>-Delete-Original
           <mesh-transformation>-Glue-Copied
           <mesh-transformation>-Glue-Reflected
           <mesh-transformation>-Glue-Strategy
           <mesh-transformation>-Nonuniform-Scale
           <mesh-transformation>-Normal
           <mesh-transformation>-Number-of-Copies
           <mesh-transformation>-Option
           <mesh-transformation>-Passages-in-360
           <mesh-transformation>-Passages-per-Mesh
           <mesh-transformation>-Passages-to-Model
           <mesh-transformation>-Point
           <mesh-transformation>-Point-1
           <mesh-transformation>-Point-2
           <mesh-transformation>-Point-3
           <mesh-transformation>-Preserve-Assembly-Name-Strategy
           <mesh-transformation>-Principal-Axis
           <mesh-transformation>-Reflection-Method
           <mesh-transformation>-Reflection-Option
           <mesh-transformation>-Rotation-Angle-Option
           <mesh-transformation>-Rotation-Axis-Begin
           <mesh-transformation>-Rotation-Axis-End
           <mesh-transformation>-Rotation-Option
           <mesh-transformation>-Rotation-Angle
           <mesh-transformation>-Scale-Method
           <mesh-transformation>-Scale-Option
           <mesh-transformation>-Scale-Origin
           <mesh-transformation>-Target-Location
           <mesh-transformation>-Theta-Offset
           <mesh-transformation>-Transform-Targets-Independently
           <mesh-transformation>-Translation-Deltas
           <mesh-transformation>-Translation-Option
           <mesh-transformation>-Translation-Root
           <mesh-transformation>-Translation-Tip
           <mesh-transformation>-Uniform-Scale
           <mesh-transformation>-Use-Coord-Frame
           <mesh-transformation>-Use-Multiple-Copy
           <mesh-transformation>-X-Pos
           <mesh-transformation>-Y-Pos
           <mesh-transformation>-Z-Pos
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

(defparameter *tabs* 1)

(defun tabs () *tabs*)

(defun tabs-incf ()
  (setf *tabs* (+ 2 *tabs*)))

(defun tabs-decf ()
  (setf *tabs* (+ -2 *tabs*)))

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
         (format nil (format nil "~~~At~~A = " (tabs))
                 (sb-mop:slot-definition-name slot))))
       '((" Of " " of ")
         (" Or " " or ")
         (" To Ar " " to AR ")
         (" Html " " HTML ")
         (" And " " and ")
         (" Cvf " " CVF ")
         ("Passages In "  "Passages in ")
         ("Passages Per " "Passages per ")
         ("Passages To "  "Passages to ")
         
         ))
      (slot-value class (sb-mop:slot-definition-name slot))))
    ((eq 'standard-class
         (type-of (class-of (slot-value class (sb-mop:slot-definition-name slot)))))
     (format stream (format nil "~~~At~~A" (tabs))
             (slot-value class (sb-mop:slot-definition-name slot))))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defclass <object> ()
  ((name :accessor <obj>-name
         :initform ""
         :initarg :name
         :documentation "<obj>-name")))

(defmethod <object>-type ((object <object>))
  (nsubstitute #\Space #\-
               (string-trim "<>"
                            (format nil "~A"
                                    (class-name (class-of object))))))

(defmethod print-object ((x <object>) s)
  (format s (format nil "~~~At~~A:" (tabs))
          (<object>-type x))
  (format s " ~A~%" (<obj>-name x)))

(defmethod print-object :after ((x <object>) s)
  (tabs-incf)
  (loop :for slot :in (sb-mop:class-direct-slots (class-of x))
        :do (print-slot slot x s))
  (tabs-decf)
  (format s (format nil "~~~AtEND~%" (tabs))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defclass <obj> (<object>)
  ((name :initform ""
         :documentation "<obj>-name")))

(defmethod <obj>-full-name ((obj <obj>))
  (format nil "/~A:~A"
          (<object>-type obj)
          (<obj>-name obj)))

(defun full-names (&rest names)
  (format nil "~{~A~^,~}" (mapcar #'<obj>-full-name names)))

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

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defclass <object-report-options> (<object>)
  ((associated-case-name
    :accessor <object-report-options>-associated-case-name
    :initform ""
    :initarg :associated-case-name
    :documentation "associated-case-name")
   (automatic-item
    :accessor <object-report-options>-automatic-item
    :initform "None"
    :initarg :automatic-item
    :documentation "automatic-item")
   (generation
    :accessor <object-report-options>-generation
    :initform "Manual"
    :initarg :generation
    :documentation "generation")
   (report-caption
    :accessor <object-report-options>-report-caption
    :initform "Caption for Report"
    :initarg :report-caption
    :documentation "report-caption")))

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

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defclass <camera> (<object>)
  ((option
    :accessor <camera>-option
    :initform "Pivot Point and Quaternion"
    :initarg :option
    :documentation "option")
   (pan
    :accessor <camera>-pan
    :initform "0.0, 0.0"
    :initarg :pan
    :documentation "pan")
   (pivot-point
    :accessor <camera>-pivot-point
    :initform "0.0, 0.0, 0.0"
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

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

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
    :initform ""
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
    :initform "0.03"
    :initarg :legend-aspect
    :documentation "legend-aspect")
   (legend-format
    :accessor <legend>-legend-format
    :initform "%4.0f"
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

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defclass <table-cell> ()
  ((row
    :accessor <table-cell>-row
    :initform 1
    :initarg :row)
   (col
    :accessor <table-cell>-col
    :initform 1
    :initarg :col)
   (equation
    :accessor <table-cell>-equation
    :initform ""
    :initarg :equation)
   (bold
    :accessor <table-cell>-bold
    :initform "False"
    :initarg :bold)
   (italics
    :accessor <table-cell>-italics
    :initform "False"
    :initarg :italics)
   (underline
    :accessor <table-cell>-underline
    :initform "False"
    :initarg :underline)
   (justification
    :accessor <table-cell>-justification
    :initform "Left"
    :initarg :justification
    :documentation "Left, Center, Right")
   (warp
    :accessor <table-cell>-warp
    :initform "False"
    :initarg :warp
    :documentation "True, False")
   (font-size
    :accessor <table-cell>-font-size
    :initform 0
    :initarg :font-size
    :documentation "-3, -2 -1, 0, 1, 2, 3")
   (font-name
    :accessor <table-cell>-font-name
    :initform "Font Name"
    :initarg :font-name)
   (rows
    :accessor <table-cell>-rows
    :initform 1
    :initarg :rows)
   (cols
    :accessor <table-cell>-cols
    :initform 1
    :initarg :cols)
   (format
    :accessor <table-cell>-format
    :initform "%10.3e"
    :initarg :format
    :documentation "%10.3e, %10.3f")
   (show-units
    :accessor <table-cell>-show-units
    :initform "True"
    :initarg :show-units)
   (foreground
    :accessor <table-cell>-foreground
    :initform '(#Xff #Xff #Xff)
    :initarg :foreground)
   (background
    :accessor <table-cell>-background
    :initform '(#X00 #X00 #X00)
    :initarg :background)   
   (show-value
    :accessor <table-cell>-show-value
    :initform "True"
    :initarg :show-value))
  (:documentation
   "
  D10 = \"=massFlow()@C_1_3_1 Side 2\", False, False,  False,     Left  , False, 2,        Font Name, 1|1, %10.3e, False,     ffffff    , 000000     , True
  D10 = \"=massFlow()@C_1_3_1 Side 2\", True, False,   False,     Left  , False, 0,        Font Name, 1|1, %10.3e, False,     ffffff    , 000000     , True
                                        Bold, Italics, Underline, Left  , Warp , font-size,Font Name, rows|cols, format, show-units,Background, Foreground , show-value
                                                                  Center,
                                                                  Right ,
(make-instance '<table-cell> :equation \"=massFlow()@C_1_2 X_071i5 Side 2\")
"))

(defmethod print-object ((x <table-cell>) s)
  (labels ((char+number (string number)
             (format nil "~A" (code-char (+ (char-code (elt string 0)) number)))))
    (format s "~A~A = "
            (char+number "A" (1- (<table-cell>-col x)))
            (<table-cell>-row x))
    (format s "\"~A\"," (<table-cell>-equation x))
    (format s "~A," (<table-cell>-bold x))
    (format s "~A," (<table-cell>-italics x))
    (format s "~A," (<table-cell>-underline x))
    (format s "~A," (<table-cell>-justification x))
    (format s "~A," (<table-cell>-warp x))
    (format s "~A," (<table-cell>-font-size x))
    (format s "~A," (<table-cell>-font-name x))
    (format s "~A|~A," (<table-cell>-rows x) (<table-cell>-cols x))
    (format s "~A," (<table-cell>-format x))
    (format s "~A," (<table-cell>-show-units x))
    (format s "~A," (string-downcase (format nil "~{~2,'0X~}" (<table-cell>-foreground x))))
    (format s "~A," (string-downcase (format nil "~{~2,'0X~}" (<table-cell>-background x))))  
    (format s "~A" (<table-cell>-show-value x))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defclass <table-cells> ()
  ((cells
    :accessor <table-cells>-cells
    :initform nil
    :initarg :cells))
  (:documentation
   "
 @b(Пример использования:)
@begin[lang=lisp](code)
 (defparameter *cells* (make-instance '<table-cells>))
 (push (make-instance '<table-cell>
   :equation \"massFlow()@C_1_2 X_071i5 Side 2\"
   :row 1
   :col 2)
      (<table-cells>-cells *cells*))
@end(code)
"))

(defmethod print-object ((x <table-cells>) s)
  (format s (format nil "~~~At~~A: ~%" (tabs)) "TABLE CELLS")
  (tabs-incf)
  (loop :for i :in (<table-cells>-cells x) :do
    (format s (format nil "~~~At~~A~%" (tabs)) i))
  (tabs-decf)
  (format s (format nil "~~~At~~A~%" (tabs)) "END"))
 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defclass <table> (<obj>)
  (
   (export-table-only 
    :accessor <table>-export-table-only 
    :initform "True"
    :initarg :export-table-only 
    :documentation "export-table-only")
   (table-default-case-name
    :accessor <table>-table-default-case-name
    :initform ""
    :initarg :table-default-case-name
    :documentation "table-default-case-name")
   (table-exists
    :accessor <table>-table-exists
    :initform "True"
    :initarg :table-exists
    :documentation "table-exists")
   (table-export-format
    :accessor <table>-table-export-format
    :initform "State"
    :initarg :table-export-format
    :documentation "table-export-format")
   (table-export-html-border-width
    :accessor <table>-table-export-html-border-width
    :initform "1"
    :initarg :table-export-html-border-width
    :documentation "table-export-html-border-width")
   (table-export-html-caption
    :accessor <table>-table-export-html-caption
    :initform ""
    :initarg :table-export-html-caption
    :documentation "table-export-html-caption"
    )
   (table-export-html-caption-position
    :accessor <table>-table-export-html-caption-position
    :initform "Bottom"
    :initarg :table-export-html-caption-position
    :documentation "table-export-html-caption-position")
   (table-export-html-cell-padding
    :accessor <table>-table-export-html-cell-padding
    :initform "5"
    :initarg :table-export-html-cell-padding
    :documentation "table-export-html-cell-padding")
   (table-export-html-cell-spacing
    :accessor <table>-table-export-html-cell-spacing
    :initform "1"
    :initarg :table-export-html-cell-spacing
    :documentation "table-export-html-cell-spacing")
   (table-export-html-title
    :accessor <table>-table-export-html-title
    :initform ""
    :initarg :table-export-lines
    :documentation "table-export-html-title")
   (table-export-lines
    :accessor <table>-table-export-lines
    :initform "All"
    :initarg :table-export-lines
    :documentation "table-export-lines")
   (table-export-separator
    :accessor <table>-table-export-separator
    :initform "Tab"
    :initarg :table-export-separator
    :documentation "table-export-separator")
   (table-export-trailing-separators
    :accessor <table>-table-export-trailing-separators
    :initform "True"
    :initarg :table-export-trailing-separators
    :documentation "table-export-trailing-separators")
   (object-report-options
    :accessor <table>-object-report-options
    :initform (make-instance '<object-report-options>)
    :initarg :object-report-options
    :documentation "object-report-options")
   (table-cells
    :accessor <table>-table-cells
    :initform (make-instance '<table-cells>)
    :initarg :table-cells
    :documentation "table-cells"))
  (:documentation
   "
 @b(Пример использования:)
@begin[lang=lisp](code)
 (defparameter *table* (make-instance '<table>))

 (push (make-instance '<table-cell>
                     :row 1 :col 1
                     :equation
                     \"=massFlow()@C_1_3_1 Side 2\")
      (<table-cells>-cells (<table>-table-cells *table*)))
@end(code)
"))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defclass <monitor-location-control> (<obj>)
  ((domain-name
    :accessor <monitor-location-control>-domain-name
    :initform "D1"
    :initarg :domain-name
    :documentation "domain-name")
   (interpolation-type
    :accessor <monitor-location-control>-interpolation-type
    :initform "Nearest Vertex"
    :initarg :interpolation-type
    :documentation "interpolation-type")))

(defclass <position-update-frequency> (<obj>)
  ((option
    :accessor <position-update-frequency>-option
    :initform "Initial Mesh Only"
    :initarg :option
    :documentation "option")))

(defclass <monitor-point> (<obj>)
  ((cartesian-coordinates
    :accessor <monitor-point>-cartesian-coordinates
    :initform '("0.0 [mm]" "0.0 [mm]"  "0.0 [mm]")
    :initarg :cartesian-coordinates
    :documentation "cartesian-coordinates")
   (coord-frame
    :accessor <monitor-point>-coord-frame
    :initform "Coord 0"
    :initarg :coord-frame
    :documentation "coord-frame")
   (expression-value
    :accessor <monitor-point>-expression-value
    :initform nil ;; "massFlow()@REGION:C G2 G2 R GT D_4.0 4"
    :initarg :expression-value
    :documentation "Expression Value")
   (monitor-location-control
    :accessor <monitor-point>-monitor-location-control
    :initform (make-instance '<monitor-location-control> :name "")
    :initarg :monitor-location-control
    :documentation "monitor-location-control")
   (option
    :accessor <monitor-point>-option
    :initform "Cartesian Coordinates"   ; "Expression"
    :initarg :option
    :documentation "option")
   (output-variables-list
    :accessor <monitor-point>-output-variables-list
    :initform "Total Pressure"
    :initarg :output-variables-list
    :documentation "output-variables-list")
   (position-update-frequency
    :accessor <monitor-point>-position-update-frequency
    :initform (make-instance '<position-update-frequency> :name "")
    :initarg :position-update-frequency
    :documentation "position-update-frequency")
   ))

(defclass <monitor-objects> (<obj>)
  ((objects
    :accessor <monitor-objects>-objects
    :initform nil
    :initarg :objects
    :documentation "objects")))

(defmethod print-object :around ((x <monitor-objects>) s)
  (format s (format nil "~~~At~~A: ~%" (tabs)) "MONITOR OBJECTS")
  (tabs-incf)
  (loop :for i :in (<monitor-objects>-objects x) :do
    (format s (format nil "~~~At~~A~%" (tabs)) i))
  (tabs-decf)
  (format s (format nil "~~~At~~A~%" (tabs)) "END"))

(defclass <output-control> (<obj>)
  ((monitor-objects
    :accessor <output-control>-monitor-objects
    :initform (make-instance '<monitor-objects>)
    :initarg :objects
    :documentation "monitor-objects")))

(defclass <flow> (<obj>)
  ((output-control
    :accessor <flow>-output-control
    :initform (make-instance '<output-control> :name "")
    :initarg :output-control
    :documentation "output-control")))

(defclass <clip-plane> (<obj>)
  ((flip-normal
    :accessor <clip-plane>-flip-normal
    :initform "Off"
    :initarg :flip-normal
    :documentation "flip-normal: On; Off")
   (normal
    :accessor <clip-plane>-normal
    :initform "1 , 0 , 0"
    :initarg :normal
    :documentation "normal: 1 , 0 , 0")
   (option
    :accessor <clip-plane>-option
    :initform "From Slice Plane"
    :initarg :option
    :documentation "option: From Slice Plane")
   (point
    :accessor <clip-plane>-Point
    :initform "0 [m], 0 [m], 0 [m]"
    :initarg :point
    :documentation "point: 0 [m], 0 [m], 0 [m]")
   (point-1
    :accessor <clip-plane>-point-1
    :initform "0 [m], 0 [m], 0 [m]"
    :initarg :point-1
    :documentation "point: 0 [m], 0 [m], 0 [m]")
   (point-2
    :accessor <clip-plane>-point-2
    :initform "1 [m], 0 [m], 0 [m]"
    :initarg :point-2
    :documentation "point: 1 [m], 0 [m], 0 [m]")
   (point-3
    :accessor <clip-plane>-point-3
    :initform "0 [m], 1 [m], 0 [m]"
    :initarg :point-3
    :documentation "point: 0 [m], 1 [m], 0 [m]")
   (slice-plane
    :accessor <clip-plane>-slice-plane
    :initform nil
    :initarg :slice-plane
    :documentation "slice-plane")
   (x
    :accessor <clip-plane>-x
    :initform "0 [m]"
    :initarg :x
    :documentation "x")
   (y
    :accessor <clip-plane>-y
    :initform "0 [m]"
    :initarg :y
    :documentation "y")
   (z
    :accessor <clip-plane>-z
    :initform "0 [m]"
    :initarg :z
    :documentation "z")
   )
  )

(defclass <streamline> (<obj>)
  (
   (absolute-tolerance
    :accessor <streamline>-absolute-tolerance
    :initform "0.0 [mm]"
    :initarg :absolute-tolerance
    :documentation "absolute-tolerance")
   (Apply-Instancing-Transform
    :accessor <streamline>-Apply-Instancing-Transform
    :initform "On"
    :initarg :Apply-Instancing-Transform
    :documentation "Apply-Instancing-Transform")
   (Colour
    :accessor <streamline>-Colour
    :initform "0.75, 0.75, 0.75"
    :initarg :Colour
    :documentation "Colour")
   (Colour-Map
    :accessor <streamline>-Colour-Map
    :initform "Default Colour Map"
    :initarg :Colour-Map
    :documentation "Colour-Map")
   (Colour-Mode
    :accessor <streamline>-Colour-Mode
    :initform "Use Plot Variable"
    :initarg :Colour-Mode
    :documentation "Colour-Mode")
   (Colour-Scale
    :accessor <streamline>-Colour-Scale
    :initform "Linear"
    :initarg :Colour-Scale
    :documentation "Colour-Scale")
   (Colour-Variable
    :accessor <streamline>-Colour-Variable
    :initform "Velocity"
    :initarg :Colour-Variable
    :documentation "Colour-Variable")
   (Colour-Variable-Boundary-Values
    :accessor <streamline>-Colour-Variable-Boundary-Values
    :initform "Conservative"
    :initarg :Colour-Variable-Boundary-Values
    :documentation "Colour-Variable-Boundary-Values")
   (Cross-Periodics
    :accessor <streamline>-Cross-Periodics
    :initform "On"
    :initarg :Cross-Periodics
    :documentation "Cross-Periodics")
   (Culling-Mode
    :accessor <streamline>-Culling-Mode
    :initform "No Culling"
    :initarg :Culling-Mode
    :documentation "Culling-Mode")
   (Domain-List
    :accessor <streamline>-Domain-List
    :initform "D1"
    :initarg :Domain-List
    :documentation "Domain-List")
   (Draw-Faces
    :accessor <streamline>-Draw-Faces
    :initform "On"
    :initarg :Draw-Faces
    :documentation "Draw-Faces")
   (Draw-Lines
    :accessor <streamline>-Draw-Lines
    :initform "Off"
    :initarg :Draw-Lines
    :documentation "Draw-Lines")
   (Draw-Streams
    :accessor <streamline>-Draw-Streams
    :initform "On"
    :initarg :Draw-Streams
    :documentation "Draw-Streams")
   (Draw-Symbols
    :accessor <streamline>-Draw-Symbols
    :initform "Off"
    :initarg :Draw-Symbols
    :documentation "Draw-Symbols")
   (Grid-Tolerance
    :accessor <streamline>-Grid-Tolerance
    :initform "0.01"
    :initarg :Grid-Tolerance
    :documentation "Grid-Tolerance")
   (Instancing-Transform
    :accessor <streamline>-Instancing-Transform
    :initform "/DEFAULT INSTANCE TRANSFORM:Default Transform"
    :initarg :Instancing-Transform
    :documentation "Instancing-Transform")
   (Lighting
    :accessor <streamline>-Lighting
    :initform "On"
    :initarg :Lighting
    :documentation "Lighting")
   (Line-Width
    :accessor <streamline>-Line-Width
    :initform "1"
    :initarg :Line-Width
    :documentation "Line-Width")
   (Location-List
    :accessor <streamline>-Location-List
    :initform "G1 G2 02 01 Side 1,G1 G2 02 02 Side 1,G1 G2 02 03 Side 1,G1 G2 02 04 Side 1,G1 G2 02 05 Side 1,G1 G2 02 06 Side 1,G1 G2 02 07 Side 1,G1 G2 02 08 Side 1,G1 G2 02 09 Side 1,G1 G2 02 10 Side 1"
    :initarg :Location-List
    :documentation "Location-List")
   (Locator-Sampling-Method
    :accessor <streamline>-Locator-Sampling-Method
    :initform "Equally Spaced"
    :initarg :Locator-Sampling-Method
    :documentation "Locator-Sampling-Method")
   (Max
    :accessor <streamline>-Max
    :initform "150 [m s^-1]"
    :initarg :Max
    :documentation "Max")
   (Maximum-Number-of-Items
    :accessor <streamline>-Maximum-Number-of-Items
    :initform "25"
    :initarg :Maximum-Number-of-Items
    :documentation "Maximum-Number-of-Items")
   (Min
    :accessor <streamline>-Min
    :initform "50 [m s^-1]"
    :initarg :Min
    :documentation "Min")
   (Number-of-Samples
    :accessor <streamline>-Number-of-Samples
    :initform "100"
    :initarg :Number-of-Samples
    :documentation "Number-of-Samples")
   (Number-of-Sides
    :accessor <streamline>-Number-of-Sides
    :initform "8"
    :initarg :Number-of-Sides
    :documentation "Number-of-Sides")
   (Range
    :accessor <streamline>-Range
    :initform "User Specified"
    :initarg :Range
    :documentation "Range")
   (Reduction-Factor
    :accessor <streamline>-Reduction-Factor
    :initform "1.0"
    :initarg :Reduction-Factor
    :documentation "Reduction-Factor")
   (Reduction-or-Max-Number
    :accessor <streamline>-Reduction-or-Max-Number
    :initform "Max Number"
    :initarg :Reduction-or-Max-Number
    :documentation "Reduction-or-Max-Number")
   (Sample-Spacing
    :accessor <streamline>-Sample-Spacing
    :initform "0.1"
    :initarg :Sample-Spacing
    :documentation "Sample-Spacing")
   (Sampling-Aspect-Ratio
    :accessor <streamline>-Sampling-Aspect-Ratio
    :initform "1"
    :initarg :Sampling-Aspect-Ratio
    :documentation "Sampling-Aspect-Ratio")
   (Sampling-Grid-Angle
    :accessor <streamline>-Sampling-Grid-Angle
    :initform "0 [degree]"
    :initarg :Sampling-Grid-Angle
    :documentation "Sampling-Grid-Angle")
   (Seed-Point-Type
    :accessor <streamline>-Seed-Point-Type
    :initform "Equally Spaced Samples"
    :initarg :Seed-Point-Type
    :documentation "Seed-Point-Type")
   (Simplify-Geometry
    :accessor <streamline>-Simplify-Geometry
    :initform "Off"
    :initarg :Simplify-Geometry
    :documentation "Simplify-Geometry")
   (Specular-Lighting
    :accessor <streamline>-Specular-Lighting
    :initform "On"
    :initarg :Specular-Lighting
    :documentation "Specular-Lighting")
   (Stream-Drawing-Mode
    :accessor <streamline>-Stream-Drawing-Mode
    :initform "Line"
    :initarg :Stream-Drawing-Mode
    :documentation "Stream-Drawing-Mode")
   (Stream-Initial-Direction
    :accessor <streamline>-Stream-Initial-Direction
    :initform "0 , 0 , 0"
    :initarg :Stream-Initial-Direction
    :documentation "Stream-Initial-Direction")
   (Stream-Size
    :accessor <streamline>-Stream-Size
    :initform "1.0"
    :initarg :Stream-Size
    :documentation "Stream-Size")
   (Stream-Symbol
    :accessor <streamline>-Stream-Symbol
    :initform "Ball"
    :initarg :Stream-Symbol
    :documentation "Stream-Symbol")
   (Streamline-Direction
    :accessor <streamline>-Streamline-Direction
    :initform "Forward"
    :initarg :Streamline-Direction
    :documentation "Streamline-Direction")
   (Streamline-Maximum-Periods
    :accessor <streamline>-Streamline-Maximum-Periods
    :initform "1"
    :initarg :Streamline-Maximum-Periods
    :documentation "Streamline-Maximum-Periods")
   (Streamline-Maximum-Segments
    :accessor <streamline>-Streamline-Maximum-Segments
    :initform "10000"
    :initarg :Streamline-Maximum-Segments
    :documentation "Streamline-Maximum-Segments")
   (Streamline-Maximum-Time
    :accessor <streamline>-Streamline-Maximum-Time
    :initform "0.01 [s]"
    :initarg :Streamline-Maximum-Time
    :documentation "Streamline-Maximum-Time")
   (Streamline-Type
    :accessor <streamline>-Streamline-Type
    :initform "3D Streamline"
    :initarg :Streamline-Type
    :documentation "Streamline-Type")
   (Streamline-Width
    :accessor <streamline>-Streamline-Width
    :initform "2"
    :initarg :Streamline-Width
    :documentation "Streamline-Width")
   (Surface-Drawing
    :accessor <streamline>-Surface-Drawing
    :initform "Smooth Shading"
    :initarg :Surface-Drawing
    :documentation "Surface-Drawing")
   (Surface-Streamline-Direction
    :accessor <streamline>-Surface-Streamline-Direction
    :initform "Forward and Backward"
    :initarg :Surface-Streamline-Direction
    :documentation "Surface-Streamline-Direction")
   (Symbol-Size
    :accessor <streamline>-Symbol-Size
    :initform "1.0"
    :initarg :Symbol-Size
    :documentation "Symbol-Size")
   (Symbol-Start-Time
    :accessor <streamline>-Symbol-Start-Time
    :initform "10.0 [s]"
    :initarg :Symbol-Start-Time
    :documentation "Symbol-Start-Time")
   (Symbol-Stop-Time
    :accessor <streamline>-Symbol-Stop-Time
    :initform "-10.0 [s]"
    :initarg :Symbol-Stop-Time
    :documentation "Symbol-Stop-Time")
   (Symbol-Time-Interval
    :accessor <streamline>-Symbol-Time-Interval
    :initform "1.0 [s]"
    :initarg :Symbol-Time-Interval
    :documentation "Symbol-Time-Interval")
   (Tolerance-Mode
    :accessor <streamline>-Tolerance-Mode
    :initform "Grid Relative"
    :initarg :Tolerance-Mode
    :documentation "Tolerance-Mode")
   (Transparency
    :accessor <streamline>-Transparency
    :initform "0.0"
    :initarg :Transparency
    :documentation "Transparency")
   (Variable
    :accessor <streamline>-Variable
    :initform "Velocity"
    :initarg :Variable
    :documentation "Variable")
   (Variable-Boundary-Values
    :accessor <streamline>-Variable-Boundary-Values
    :initform "Conservative"
    :initarg :Variable-Boundary-Values
    :documentation "Variable-Boundary-Values")
   (Visibility
    :accessor <streamline>-Visibility
    :initform "On"
    :initarg :Visibility
    :documentation "Visibility")
   (object-view-transform
    :accessor <streamline>-object-view-transform
    :initform (make-instance '<object-view-transform>)
    :initarg :object-view-transform
    :documentation "object-view-transform")
   ))

(defclass <colour-map> (<obj>)
  (
   (Colour-Map-Colours
    :accessor <colour-map>-Colour-Map-Colours
    :initform "0.000000,0.000000,0.000000,1.000000,1.000000,1.000000,1.000000,0.000000,0.015686,1.000000"
    :initarg :Colour-Map-Colours
    :documentation "Colour-Map-Colours")
   (Colour-Map-Divisions
    :accessor <colour-map>-Colour-Map-Divisions
    :initform "2"
    :initarg :Colour-Map-Divisions
    :documentation "Colour-Map-Colours")
   (Colour-Map-Storage-Type
    :accessor <colour-map>-Colour-Map-Storage-Type
    :initform "State"
    :initarg :Colour-Map-Storage-Type
    :documentation "Colour-Map-Storage-Type")
   (Colour-Map-Type
    :accessor <colour-map>-Colour-Map-Type
    :initform "Gradient"
    :initarg :Colour-Map-Type
    :documentation "Colour-Map-Type")   
   ))

(defclass <output-settings> (<object>)
  ((Chart-Image-Type
    :accessor <output-settings>-Chart-Image-Type
    :initform "png"
    :initarg Chart-Image-Type
    :documentation "Chart-Image-Type")
   (Chart-Size
    :accessor <output-settings>-Chart-Size
    :initform "Same As Figure"
    :initarg Chart-Size
    :documentation "Chart-Size")
   (Custom-Chart-Size-Height
    :accessor <output-settings>-Custom-Chart-Size-Height
    :initform "384"
    :initarg Custom-Chart-Size-Height
    :documentation "Custom-Chart-Size-Height")
   (Custom-Chart-Size-Width
    :accessor <output-settings>-Custom-Chart-Size-Width
    :initform "512"
    :initarg Custom-Chart-Size-Width
    :documentation "Custom-Chart-Size-Width")
   (Custom-Figure-Size-Height
    :accessor <output-settings>-Custom-Figure-Size-Height
    :initform "900"
    :initarg Custom-Figure-Size-Height
    :documentation "Custom-Figure-Size-Height")
   (Custom-Figure-Size-Width
    :accessor <output-settings>-Custom-Figure-Size-Width
    :initform "1600"
    :initarg Custom-Figure-Size-Width
    :documentation "Custom-Figure-Size-Width")
   (Figure-Image-Type
    :accessor <output-settings>-Figure-Image-Type
    :initform "png"
    :initarg Figure-Image-Type
    :documentation "Figure-Image-Type")
   (Figure-Size
    :accessor <output-settings>-Figure-Size
    :initform "Custom"
    :initarg Figure-Size
    :documentation "Figure-Size")
   (Fit-Views
    :accessor <output-settings>-Fit-Views
    :initform "Off"
    :initarg Fit-Views
    :documentation "Fit-Views")
   ))

(defclass <preview> (<object>)
  ((output-settings
    :accessor <preview>-output-settings
    :initform (make-instance '<output-settings>)
    :initarg output-settings
    :documentation "Output-Settings")))

(defclass <publish> (<object>)
  ((Generate-CVF
    :accessor <publish>-Generate-CVF
    :initform "Off"
    :initarg Generate-CVF
    :documentation "Generate-CVF")
   (Report-Format
    :accessor <publish>-Report-Format
    :initform "HTML"
    :initarg Report-Format
    :documentation "Report-Format")
   (Report-Path
    :accessor <publish>-Report-Path
    :initform "Z:/CFX/n70/cfx/DP=003/N70_prj_34/Reports/N70_prj_34_003/Report_D.htm"
    :initarg Report-Path
    :documentation "Report-Path")
   (Save-Images-In-Separate-Folder
    :accessor <publish>-Save-Images-In-Separate-Folder
    :initform "On"
    :initarg Save-Images-In-Separate-Folder
    :documentation "Save-Images-In-Separate-Folder")
   (output-settings
    :accessor <publish>-output-settings
    :initform (make-instance '<output-settings>)
    :initarg output-settings
    :documentation "Output-Settings")))

(defclass <file-information-options> (<object>)
  ((Include-In-Report
    :accessor <file-information-options>-Include-In-Report
    :initform "false"
    :initarg Include-In-Report
    :documentation "Include-In-Report")
   (This-Exists
    :accessor <file-information-options>-This-Exists
    :initform "true"
    :initarg This-Exists
    :documentation "This-Exists")))

(defclass <mesh-statistics-options> (<object>)
  ((Include-In-Report
    :accessor <mesh-statistics-options>-Include-In-Report
    :initform "false"
    :initarg Include-In-Report
    :documentation "Include-In-Report")
   (Show-Connectivity-Number
    :accessor <mesh-statistics-options>-Show-Connectivity-Number
    :initform "false"
    :initarg Show-Connectivity-Number
    :documentation "Show-Connectivity-Number")
   (Show-Edge-Length-Ratio
    :accessor <mesh-statistics-options>-Show-Edge-Length-Ratio
    :initform "false"
    :initarg Show-Edge-Length-Ratio
    :documentation "Show-Edge-Length-Ratio")
   (Show-Element-Volume-Ratio
    :accessor <mesh-statistics-options>-Show-Element-Volume-Ratio
    :initform "false"
    :initarg Show-Element-Volume-Ratio
    :documentation "Show-Element-Volume-Ratio")
   (Show-Max-Face-Angle
    :accessor <mesh-statistics-options>-Show-Max-Face-Angle
    :initform "false"
    :initarg Show-Max-Face-Angle
    :documentation "Show-Max-Face-Angle")
   (Show-Min-Face-Angle
    :accessor <mesh-statistics-options>-Show-Min-Face-Angle
    :initform "false"
    :initarg Show-Min-Face-Angle
    :documentation "Show-Min-Face-Angle")
   (Show-Number-of-Elements
    :accessor <mesh-statistics-options>-Show-Number-of-Elements
    :initform "true"
    :initarg Show-Number-of-Elements
    :documentation "Show-Number-of-Elements")
   (Show-Number-of-Hexahedra
    :accessor <mesh-statistics-options>-Show-Number-of-Hexahedra
    :initform "false"
    :initarg Show-Number-of-Hexahedra
    :documentation "Show-Number-of-Hexahedra")
   (Show-Number-of-Nodes
    :accessor <mesh-statistics-options>-Show-Number-of-Nodes
    :initform "true"
    :initarg Show-Number-of-Nodes
    :documentation "Show-Number-of-Nodes")
   (Show-Number-of-Polyhedra
    :accessor <mesh-statistics-options>-Show-Number-of-Polyhedra
    :initform "false"
    :initarg Show-Number-of-Polyhedra
    :documentation "Show-Number-of-Polyhedra")
   (Show-Number-of-Pyramids
    :accessor <mesh-statistics-options>-Show-Number-of-Pyramids
    :initform "false"
    :initarg Show-Number-of-Pyramids
    :documentation "Show-Number-of-Pyramids")
   (Show-Number-of-Tetrahedra
    :accessor <mesh-statistics-options>-Show-Number-of-Tetrahedra
    :initform "false"
    :initarg Show-Number-of-Tetrahedra
    :documentation "Show-Number-of-Tetrahedra")
   (Show-Number-of-Wedges
    :accessor <mesh-statistics-options>-Show-Number-of-Wedges
    :initform "false"
    :initarg Show-Number-of-Wedges
    :documentation "Show-Number-of-Wedges")
   (This-Exists
    :accessor <mesh-statistics-options>-This-Exists
    :initform "true"
    :initarg This-Exists
    :documentation "This-Exists")))

(defclass <physics-summary-options> (<object>)
  ((Include-In-Report
    :accessor <physics-summary-options>-Include-In-Report
    :initform "false"
    :initarg Include-In-Report
    :documentation "Include-In-Report")
   (Show-Boundary-Physics
    :accessor <physics-summary-options>-Show-Boundary-Physics
    :initform "true"
    :initarg Show-Boundary-Physics
    :documentation "Show-Boundary-Physics")
   (Show-Domain-Physics
    :accessor <physics-summary-options>-Show-Domain-Physics
    :initform "true"
    :initarg Show-Domain-Physics
    :documentation "Show-Domain-Physics")
   (This-Exists
    :accessor <physics-summary-options>-This-Exists
    :initform "true"
    :initarg This-Exists
    :documentation "This-Exists")))

(defclass <solution-summary-options> (<object>)
  ((Include-In-Report
    :accessor <solution-summary-options>-Include-In-Report
    :initform "false"
    :initarg Include-In-Report
    :documentation "Include-In-Report")
   (Show-Boundary-Flow-Summary
    :accessor <solution-summary-options>-Show-Boundary-Flow-Summary
    :initform "true"
    :initarg Show-Boundary-Flow-Summary
    :documentation "Show-Boundary-Flow-Summary")
   (Show-Force-and-Torque-Summary
    :accessor <solution-summary-options>-Show-Force-and-Torque-Summary
    :initform "false"
    :initarg Show-Force-and-Torque-Summary
    :documentation "Show-Force-and-Torque-Summary")
   (Show-Forces
    :accessor <solution-summary-options>-Show-Forces
    :initform  "true"
    :initarg Show-Forces
    :documentation "Show-Forces")
   (Show-Torques
    :accessor <solution-summary-options>-Show-Torques
    :initform "true"
    :initarg Show-Torques
    :documentation "Show-Torques")
   (This-Exists
    :accessor <solution-summary-options>-This-Exists
    :initform "true"
    :initarg This-Exists
    :documentation "This-Exists")
   ))


(defclass <report> (<object>)
  ((Excluded-Report-Items
    :accessor <report>-Excluded-Report-Items
    :initform "/TITLE PAGE,/COMMENT:User Data"
    :initarg Excluded-Report-Items
    :documentation "Excluded-Report-Items")
   (Report-Items
    :accessor <report>-Report-Items
    :initform "/TITLE PAGE,/REPORT/FILE INFORMATION OPTIONS,/REPORT/MESH STATISTICS OPTIONS,/REPORT/PHYSICS SUMMARY OPTIONS,/REPORT/SOLUTION SUMMARY OPTIONS,/COMMENT:User Data"
    :initarg Report-Items
    :documentation "Report-Items")
   (File-Information-Options
    :accessor <report>-File-Information-Options
    :initform (make-instance '<File-Information-Options>)
    :initarg File-Information-Options
    :documentation "File-Information-Options")
   (Mesh-Statistics-Options
    :accessor <report>-Mesh-Statistics-Options
    :initform (make-instance '<mesh-statistics-options>)
    :initarg Mesh-Statistics-Options
    :documentation "Mesh-Statistics-Options")
   (Physics-Summary-Options
    :accessor <report>-Physics-Summary-Options
    :initform (make-instance '<physics-summary-options>)
    :initarg Physics-Summary-Options
    :documentation "Physics-Summary-Options")   
   (Preview
    :accessor <report>-Preview
    :initform (make-instance '<preview>)
    :initarg Preview
    :documentation "Preview")
   (Publish
    :accessor <report>-Publish
    :initform (make-instance '<publish>)
    :initarg Publish
    :documentation "Publish")
   (Solution-Summary-Options
    :accessor <report>-Solution-Summary-Options
    :initform (make-instance '<solution-summary-options>)
    :initarg Solution-Summary-Options
    :documentation "Solution-Summary-Options")
   ))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defclass <mesh-transformation> (<object>)
  (
   (Angle-End
    :initform "0 , 0 , 0"
    :accessor <mesh-transformation>-Angle-End
    :initarg :Angle-End
    :documentation "Angle-End")
   (Angle-Start
    :initform "0 , 0 , 0"
    :accessor <mesh-transformation>-Angle-Start
    :initarg :Angle-Start
    :documentation "Angle-Start")
   (Delete-Original
    :initform "Off"
    :accessor <mesh-transformation>-Delete-Original
    :initarg :Delete-Original
    :documentation "Delete-Original")
   (Glue-Copied
    :initform "Off"
    :accessor <mesh-transformation>-Glue-Copied
    :initarg :Glue-Copied
    :documentation "Glue-Copied")
   (Glue-Reflected
    :initform "On"
    :accessor <mesh-transformation>-Glue-Reflected
    :initarg :Glue-Reflected
    :documentation "Glue-Reflected")
   (Glue-Strategy
    :initform "Location And Transformed Only"
    :accessor <mesh-transformation>-Glue-Strategy
    :initarg :Glue-Strategy
    :documentation "Glue-Strategy")
   (Nonuniform-Scale
    :initform "1 , 1 , 1"
    :accessor <mesh-transformation>-Nonuniform-Scale
    :initarg :Nonuniform-Scale
    :documentation "Nonuniform-Scale")
   (Normal
    :initform "0 , 0 , 0"
    :accessor <mesh-transformation>-Normal
    :initarg :Normal
    :documentation "Normal")
   (Number-of-Copies
    :initform "1"
    :accessor <mesh-transformation>-Number-of-Copies
    :initarg :Number-of-Copies
    :documentation "Number-of-Copies")
   (Option
    :initform "Rotation"
    :accessor <mesh-transformation>-Option
    :initarg :Option
    :documentation "Option")
   (Passages-in-360
    :initform "1"
    :accessor <mesh-transformation>-Passages-in-360
    :initarg :Passages-in-360
    :documentation "Passages-in-360")
   (Passages-per-Mesh
    :initform "1"
    :accessor <mesh-transformation>-Passages-per-Mesh
    :initarg :Passages-per-Mesh
    :documentation "Passages-per-Mesh")
   (Passages-to-Model
    :initform "1"
    :accessor <mesh-transformation>-Passages-to-Model
    :initarg :Passages-to-Model
    :documentation "Passages-to-Model")
   (Point
    :initform "0 , 0 , 0"
    :accessor <mesh-transformation>-Point
    :initarg :Point
    :documentation "Point")
   (Point-1
    :initform "0 , 0 , 0"
    :accessor <mesh-transformation>-Point-1
    :initarg :Point-1
    :documentation "Point-1")
   (Point-2
    :initform "0 , 0 , 0"
    :accessor <mesh-transformation>-Point-2
    :initarg :Point-2
    :documentation "Point-2")
   (Point-3
    :initform "0 , 0 , 0"
    :accessor <mesh-transformation>-Point-3
    :initarg :Point-3
    :documentation "Point-3")
   (Preserve-Assembly-Name-Strategy
    :initform "Existing"
    :accessor <mesh-transformation>-Preserve-Assembly-Name-Strategy
    :initarg :Preserve-Assembly-Name-Strategy
    :documentation "Preserve-Assembly-Name-Strategy")
   (Principal-Axis
    :initform "X"
    :accessor <mesh-transformation>-Principal-Axis
    :initarg :Principal-Axis
    :documentation "Principal-Axis")
   (Reflection-Method
    :initform "Original (No Copy)"
    :accessor <mesh-transformation>-Reflection-Method
    :initarg :Reflection-Method
    :documentation "Reflection-Method")
   (Reflection-Option
    :initform "YZ Plane"
    :accessor <mesh-transformation>-Reflection-Option
    :initarg :Reflection-Option
    :documentation "Reflection-Option")
   (Rotation-Angle
    :initform "-22.5 [degree]"
    :accessor <mesh-transformation>-Rotation-Angle
    :initarg :Rotation-Angle
    :documentation "Rotation-Angle")
   (Rotation-Angle-Option
    :initform "Specified"
    :accessor <mesh-transformation>-Rotation-Angle-Option
    :initarg :Rotation-Angle-Option
    :documentation "Rotation-Angle-Option")
   (Rotation-Axis-Begin
    :initform "0 , 0 , 0"
    :accessor <mesh-transformation>-Rotation-Axis-Begin
    :initarg :Rotation-Axis-Begin
    :documentation "Rotation-Axis-Begin")
   (Rotation-Axis-End
    :initform "0 , 0 , 0"
    :accessor <mesh-transformation>-Rotation-Axis-End
    :initarg :Rotation-Axis-End
    :documentation "Rotation-Axis-End")
   (Rotation-Option
    :initform "Principal Axis"
    :accessor <mesh-transformation>-Rotation-Option
    :initarg :Rotation-Option
    :documentation "Rotation-Option")
   (Scale-Method
    :initform "Original (No Copy)"
    :accessor <mesh-transformation>-Scale-Method
    :initarg :Scale-Method
    :documentation "Scale-Method")
   (Scale-Option
    :initform "Uniform"
    :accessor <mesh-transformation>-Scale-Option
    :initarg :Scale-Option
    :documentation "Scale-Option")
   (Scale-Origin
    :initform "0 , 0 , 0"
    :accessor <mesh-transformation>-Scale-Origin
    :initarg :Scale-Origin
    :documentation "Scale-Origin")
   (Target-Location
    :initform "DG2 G2"
    :accessor <mesh-transformation>-Target-Location
    :initarg :Target-Location
    :documentation "Target-Location")
   (Theta-Offset
    :initform "0.0 [degree]"
    :accessor <mesh-transformation>-Theta-Offset
    :initarg :Theta-Offset
    :documentation "Theta-Offset")
   (Transform-Targets-Independently
    :initform "Off"
    :accessor <mesh-transformation>-Transform-Targets-Independently
    :initarg :Transform-Targets-Independently
    :documentation "Transform-Targets-Independently")
   (Translation-Deltas
    :initform "0 , 0 , 0"
    :accessor <mesh-transformation>-Translation-Deltas
    :initarg :Translation-Deltas
    :documentation "Translation-Deltas")
   (Translation-Option
    :initform "Deltas"
    :accessor <mesh-transformation>-Translation-Option
    :initarg :Translation-Option
    :documentation "Translation-Option")
   (Translation-Root
    :initform "0 , 0 , 0"
    :accessor <mesh-transformation>-Translation-Root
    :initarg :Translation-Root
    :documentation "Translation-Root")
   (Translation-Tip
    :initform "0 , 0 , 0"
    :accessor <mesh-transformation>-Translation-Tip
    :initarg :Translation-Tip
    :documentation "Translation-Tip")
   (Uniform-Scale
    :initform "1.0"
    :accessor <mesh-transformation>-Uniform-Scale
    :initarg :Uniform-Scale
    :documentation "Uniform-Scale")
   (Use-Coord-Frame
    :initform "Off"
    :accessor <mesh-transformation>-Use-Coord-Frame
    :initarg :Use-Coord-Frame
    :documentation "Use-Coord-Frame")
   (Use-Multiple-Copy
    :initform "On"
    :accessor <mesh-transformation>-Use-Multiple-Copy
    :initarg :Use-Multiple-Copy
    :documentation "Use-Multiple-Copy")
   (X-Pos
    :initform "0.0"
    :accessor <mesh-transformation>-X-Pos
    :initarg :X-Pos
    :documentation "X-Pos")
   (Y-Pos
    :initform "0.0"
    :accessor <mesh-transformation>-Y-Pos
    :initarg :Y-Pos
    :documentation "Y-Pos")
   (Z-Pos
    :initform "0.0"
    :accessor <mesh-transformation>-Z-Pos
    :initarg :Z-Pos
    :documentation "Z-Pos")   
   ))
