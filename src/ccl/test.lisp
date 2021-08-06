;;;; ./src/ccl/test.lisp

(in-package #:mnas-icem/ccl)

(require :mnas-string)

(defun number-to-string (val &key (fmt "~,2@F"))
  "@b(Описание:) функция @b(number-to-string) возвращает строку,
  которая представляет вещественое число в формате пригодном для
  вставки в CCL файл системы ANSYS CFX.

 @b(Пример использования:)
@begin[lang=lisp](code)
 (number-to-string  90.5645) => \"p90i56\"
 (number-to-string -90.5645) => \"m90i56\"
@end(code)
"
  (mnas-string/translit:translit
   (string-trim " " (format nil fmt val))
   :ht mnas-string/translit:*cfx->en*))

(defun mm->m (value)
  "@b(Описание:) функция @b(mm->m) переводит милиметры в метры."
  (/ value 1000.0))

(defun make-tangent-belts (number x y r-min r-max theta-min theta-max)
  "@b(Описание:) функция @b(make-tangent-belts) создает поверхности,
 представляющие из себя окружные пояса.

 @b(Переменые:) 
@begin(list) 
@item(number - количество окружных поясов;)
@item(x - плоскость, в которой строятся пояса;) 
@item(y - координата центра поясов;) 
@item(r-max - радиус минимальный;) 
@item(r-min - радиус максимальный;)
@item(theta-min - угол минимальный;)
@item(theta-max - угол максимальный.)  
@end(list)

 @b(Пример использования:)
@begin[lang=lisp](code)
 (make-tangent-belts 50 466.5 0.0 411.0 477.0 -11.25 11.25)
 (make-tangent-belts 50 466.5 0.0 411.0 477.0  11.25 33.75)
@end(code)
"
  (loop :for i :from 0 :below number :do
    (let ((r-i    (+ r-min (* (/ i      number) (- r-max r-min))))
          (r-i+1  (+ r-min (* (/ (1+ i) number) (- r-max r-min)))))
      (format t
              "LINE: Line ~A ~A ~A ~A
  Apply Instancing Transform = On
  Colour = 1, ~A, 0
  Colour Map = Default Colour Map
  Colour Mode = Constant
  Colour Scale = Linear
  Colour Variable = Pressure
  Colour Variable Boundary Values = Hybrid
  Domain List = /DOMAIN GROUP:All Domains
  Instancing Transform = /DEFAULT INSTANCE TRANSFORM:Default Transform
  Line Samples = 10
  Line Type = Sample
  Line Width = 2
  Max = 0.0 [Pa]
  Min = 0.0 [Pa]
  Option = Two Points
  Point 1 = ~A [m], ~A [m], 0 [m]
  Point 2 = ~A [m], ~A [m], 0 [m]
  Range = Global
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
"
              (number-to-string x) (number-to-string y) (number-to-string r-i) (number-to-string r-i+1)
              (nth-value 1 (floor (1+ i) 2))
              (mm->m x) (mm->m r-i  )
              (mm->m x) (mm->m r-i+1))
      (format t
              "
SURFACE OF REVOLUTION: SURFACE ~A ~A ~A ~A ~A
  Apply Instancing Transform = On
  Apply Texture = Off
  Blend Texture = On
  Colour = 1, ~A, 0
  Colour Map = Default Colour Map
  Colour Mode = Constant
  Colour Scale = Linear
  Colour Variable = Pressure
  Colour Variable Boundary Values = Hybrid
  Culling Mode = No Culling
  Domain List = /DOMAIN GROUP:All Domains
  Draw Faces = On
  Draw Lines = Off
  Ending Axial Shift = 0.0 [m]
  Ending Radial Shift = 0.0 [m]
  Instancing Transform = /DEFAULT INSTANCE TRANSFORM:Default Transform
  Lighting = On
  Line Colour = 0, 0, 0
  Line Colour Mode = Default
  Line Width = 1
  Location List = /LINE:Line ~A ~A ~A ~A
  Max = 0.0 [Pa]
  Meridional Point 1 = 0 [m], 1 [m]
  Meridional Point 2 = 1 [m], 2 [m]
  Meridional Points = 20
  Min = 0.0 [Pa]
  Option = From Line
  Principal Axis = X
  Project to AR Plane = On
  Range = Global
  Render Edge Angle = 0 [degree]
  Rotation Axis From = 0 [m], 0 [m], 0 [m]
  Rotation Axis To = 1 [m], 0 [m], 0 [m]
  Rotation Axis Type = Principal Axis
  Specular Lighting = On
  Starting Axial Shift = 0.0 [m]
  Starting Radial Shift = 0.0 [m]
  Surface Drawing = Smooth Shading
  Texture Angle = 0
  Texture Direction = 0 , 1 , 0
  Texture File = 
  Texture Material = Metal
  Texture Position = 0 , 0
  Texture Scale = 1
  Texture Type = Predefined
  Theta Max = ~A [degree]
  Theta Min = ~A [degree]
  Theta Points = 10
  Tile Texture = Off
  Transform Texture = Off
  Transparency = 0.0
  Use Angle Range = On
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
    Rotation Axis To = 1 [m], 0 [m], 0 [m]
    Rotation Axis Type = Principal Axis
    Scale Vector = 1 , 1 , 1
    Translation Vector = 0 [m], 0 [m], 0 [m]
    X = 0.0 [m]
    Y = 0.0 [m]
    Z = 0.0 [m]
  END
END
"
              (number-to-string x) (number-to-string r-i) (number-to-string r-i+1) (number-to-string theta-min) (number-to-string theta-max)
              (nth-value 1 (floor (1+ i) 2)) ;; color
              (number-to-string x) (number-to-string y) (number-to-string r-i) (number-to-string r-i+1) ;; Location
              theta-max theta-min))))



(defun make-radial-belts (number x y r-min r-max theta-min theta-max)
  "@b(Описание:) функция @b(make-radial-belts) создает поверхности,
 представляющие из себя радиальные пояса.

 @b(Переменые:)
@begin(list)
 @item(number - количество радиальных поясов;)
 @item(x - плоскость, в которой строятся пояса;)
 @item(y - координата центра поясов;)
 @item(r-max - радиус минимальный;)
 @item(r-min - радиус максимальный;)
 @item(theta-min - угол минимальный;)
 @item(theta-max - угол максимальный.)
@end(list)"
  (format t
          "LINE: Line ~A ~A ~A ~A
  Apply Instancing Transform = On
  Colour = 1, ~A, 0
  Colour Map = Default Colour Map
  Colour Mode = Constant
  Colour Scale = Linear
  Colour Variable = Pressure
  Colour Variable Boundary Values = Hybrid
  Domain List = /DOMAIN GROUP:All Domains
  Instancing Transform = /DEFAULT INSTANCE TRANSFORM:Default Transform
  Line Samples = 10
  Line Type = Sample
  Line Width = 2
  Max = 0.0 [Pa]
  Min = 0.0 [Pa]
  Option = Two Points
  Point 1 = ~A [m], ~A [m], 0 [m]
  Point 2 = ~A [m], ~A [m], 0 [m]
  Range = Global
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
"
          (number-to-string x) (number-to-string y) (number-to-string r-min) (number-to-string r-max)
          (nth-value 1 (floor 1 2)) ;; color
          (mm->m x) (mm->m (+ y r-min))
          (mm->m x) (mm->m (+ y r-max)))
  
  (loop :for i :from 0 :below number :do
    (let ((theta-i    (+ theta-min (* (/ i      number) (- theta-max theta-min))))
          (theta-i+1  (+ theta-min (* (/ (1+ i) number) (- theta-max theta-min)))))

      (format t
              "
SURFACE OF REVOLUTION: SURFACE ~A ~A ~A ~A ~A
  Apply Instancing Transform = On
  Apply Texture = Off
  Blend Texture = On
  Colour = 1, ~A, 0
  Colour Map = Default Colour Map
  Colour Mode = Constant
  Colour Scale = Linear
  Colour Variable = Pressure
  Colour Variable Boundary Values = Hybrid
  Culling Mode = No Culling
  Domain List = /DOMAIN GROUP:All Domains
  Draw Faces = On
  Draw Lines = Off
  Ending Axial Shift = 0.0 [m]
  Ending Radial Shift = 0.0 [m]
  Instancing Transform = /DEFAULT INSTANCE TRANSFORM:Default Transform
  Lighting = On
  Line Colour = 0, 0, 0
  Line Colour Mode = Default
  Line Width = 1
  Location List = /LINE:Line ~A ~A ~A ~A
  Max = 0.0 [Pa]
  Meridional Point 1 = 0 [m], 1 [m]
  Meridional Point 2 = 1 [m], 2 [m]
  Meridional Points = 20
  Min = 0.0 [Pa]
  Option = From Line
  Principal Axis = X
  Project to AR Plane = On
  Range = Global
  Render Edge Angle = 0 [degree]
  Rotation Axis From = 0 [m], ~A [m], 0 [m]
  Rotation Axis To = 1 [m], ~A [m], 0 [m]
  Rotation Axis Type = Rotation Axis
  Specular Lighting = On
  Starting Axial Shift = 0.0 [m]
  Starting Radial Shift = 0.0 [m]
  Surface Drawing = Smooth Shading
  Texture Angle = 0
  Texture Direction = 0 , 1 , 0
  Texture File = 
  Texture Material = Metal
  Texture Position = 0 , 0
  Texture Scale = 1
  Texture Type = Predefined
  Theta Max = ~A [degree]
  Theta Min = ~A [degree]
  Theta Points = 10
  Tile Texture = Off
  Transform Texture = Off
  Transparency = 0.0
  Use Angle Range = On
  Visibility = On
  OBJECT VIEW TRANSFORM: 
    Apply Reflection = Off
    Apply Rotation = On
    Apply Scale = Off
    Apply Translation = Off
    Principal Axis = X
    Reflection Plane Option = XY Plane
    Rotation Angle = 0.0 [degree]
    Rotation Axis From = 0 [m], 0 [m], 0 [m]
    Rotation Axis To = 1 [m], 0 [m], 0 [m]
    Rotation Axis Type = Principal Axis
    Scale Vector = 1 , 1 , 1
    Translation Vector = 0 [m], 0 [m], 0 [m]
    X = 0.0 [m]
    Y = 0.0 [m]
    Z = 0.0 [m]
  END
END
"
              (number-to-string x) (number-to-string r-min) (number-to-string r-max) (number-to-string theta-i) (number-to-string theta-i+1) 
              (nth-value 1 (floor (1+ i) 2)) ;; color
              (number-to-string x) (number-to-string y) (number-to-string r-min) (number-to-string r-max) ;; Location
              (mm->m y) ;; Rotation Axis From y
              (mm->m y) ;; Rotation Axis To y
              theta-i theta-i+1
              ))))

(make-radial-belts 10 50.0 530 14.0 24.0 -180.00 180.0)

(defun mk-lines (l-prefix x-coord r-max r-min by)
  (loop :for i :from r-min :below r-max :by by :do
    (format t
            "LINE: Line ~A ~A ~A
  Apply Instancing Transform = On
  Colour = 1, ~A, 0
  Colour Map = Default Colour Map
  Colour Mode = Constant
  Colour Scale = Linear
  Colour Variable = Pressure
  Colour Variable Boundary Values = Hybrid
  Domain List = /DOMAIN GROUP:All Domains
  Instancing Transform = /DEFAULT INSTANCE TRANSFORM:Default Transform
  Line Samples = 10
  Line Type = Sample
  Line Width = 2
  Max = 0.0 [Pa]
  Min = 0.0 [Pa]
  Option = Two Points
  Point 1 = ~A [m], ~A [m], 0 [m]
  Point 2 = ~A [m], ~A [m], 0 [m]
  Range = Global
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
"
            l-prefix i (+ i 3)
            (nth-value 1 (floor (1+ i) 2))
            (/ x-coord 1000.0) (/ i 1000.0)
            (/ x-coord 1000.0) (/ (+ i by) 1000.0))))
  )

(defun mk-lines (l-prefix x-coord r-max r-min by)
  (loop :for i :from r-min :below r-max :by by :do
    (format t
            "LINE: Line ~A ~A ~A
  Apply Instancing Transform = On
  Colour = 1, ~A, 0
  Colour Map = Default Colour Map
  Colour Mode = Constant
  Colour Scale = Linear
  Colour Variable = Pressure
  Colour Variable Boundary Values = Hybrid
  Domain List = /DOMAIN GROUP:All Domains
  Instancing Transform = /DEFAULT INSTANCE TRANSFORM:Default Transform
  Line Samples = 10
  Line Type = Sample
  Line Width = 2
  Max = 0.0 [Pa]
  Min = 0.0 [Pa]
  Option = Two Points
  Point 1 = ~A [m], ~A [m], 0 [m]
  Point 2 = ~A [m], ~A [m], 0 [m]
  Range = Global
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
"
            l-prefix i (+ i 3)
            (nth-value 1 (floor (1+ i) 2))
            (/ x-coord 1000.0) (/ i 1000.0)
            (/ x-coord 1000.0) (/ (+ i by) 1000.0))))

(mk-lines "466i5" 466.5 477 411 3)

(defun mk-surf-rings (s-prefix line-group-name Theta-Max Theta-Min r-max r-min by)
  (loop :for i :from r-min :below r-max :by by :do
    (format t
            "
SURFACE OF REVOLUTION: ~A ~A ~A ~A
  Apply Instancing Transform = On
  Apply Texture = Off
  Blend Texture = On
  Colour = 1, ~A, 0
  Colour Map = Default Colour Map
  Colour Mode = Constant
  Colour Scale = Linear
  Colour Variable = Pressure
  Colour Variable Boundary Values = Hybrid
  Culling Mode = No Culling
  Domain List = /DOMAIN GROUP:All Domains
  Draw Faces = On
  Draw Lines = Off
  Ending Axial Shift = 0.0 [m]
  Ending Radial Shift = 0.0 [m]
  Instancing Transform = /DEFAULT INSTANCE TRANSFORM:Default Transform
  Lighting = On
  Line Colour = 0, 0, 0
  Line Colour Mode = Default
  Line Width = 1
  Location List = /LINE:Line ~A ~A ~A
  Max = 0.0 [Pa]
  Meridional Point 1 = 0 [m], 1 [m]
  Meridional Point 2 = 1 [m], 2 [m]
  Meridional Points = 20
  Min = 0.0 [Pa]
  Option = From Line
  Principal Axis = X
  Project to AR Plane = On
  Range = Global
  Render Edge Angle = 0 [degree]
  Rotation Axis From = 0 [m], 0 [m], 0 [m]
  Rotation Axis To = 1 [m], 0 [m], 0 [m]
  Rotation Axis Type = Principal Axis
  Specular Lighting = On
  Starting Axial Shift = 0.0 [m]
  Starting Radial Shift = 0.0 [m]
  Surface Drawing = Smooth Shading
  Texture Angle = 0
  Texture Direction = 0 , 1 , 0
  Texture File = 
  Texture Material = Metal
  Texture Position = 0 , 0
  Texture Scale = 1
  Texture Type = Predefined
  Theta Max = ~A [degree]
  Theta Min = ~A [degree]
  Theta Points = 10
  Tile Texture = Off
  Transform Texture = Off
  Transparency = 0.0
  Use Angle Range = On
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
    Rotation Axis To = 1 [m], 0 [m], 0 [m]
    Rotation Axis Type = Principal Axis
    Scale Vector = 1 , 1 , 1
    Translation Vector = 0 [m], 0 [m], 0 [m]
    X = 0.0 [m]
    Y = 0.0 [m]
    Z = 0.0 [m]
  END
END
"
            s-prefix
            line-group-name i (+ i 3) (nth-value 1 (floor (1+ i) 2))
            line-group-name i (+ i 3)
            Theta-Max Theta-Min)))

(mk-surf-rings "S R" "466i5" 33.75 11.25 477 411 3)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


(/ (- 2.25972 2.13042 ) 2.25972)  ; => 0.057219528 (5.721953%)


(+ 0.0157 0.0889)   ; => 0.1046 (10.46%)

(/ 0.0157 0.1046)  ; => 0.1500956 (15.00956%)

(* 0.1046 0.12)  ; => 0.012552 (1.2551999%)

0.012552

(* 0.1046 (- 1 0.12)) ; => 0.092048 (9.2048%)
