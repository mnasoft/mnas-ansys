;;;; ./src/ccl/test.lisp

(defpackage #:mnas-icem/belt
  (:use #:cl )
  (:intern number-to-string
           mm->m
           make-line-belt
           make-surface-belt
           )
  (:export make-tangent-belts
           make-radial-belts
           )
  (:documentation
   "@b(Описание:) Пакет @b(mnas-icem/ccl-belt) позволяет генерировать
 сценарии для построения поверхностей в программном комплексе ANSYS
 CFX на языке CCL.
"))

(in-package #:mnas-icem/belt)

(defun number-to-string (val &key (fmt "~,2@F"))
  "@b(Описание:) функция @b(number-to-string) возвращает строку,
  которая представляет вещественое число в формате пригодном для
  вставки в CCL файл системы ANSYS CFX в качестве имени.

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

(defun make-line-belt (x y r-i r-i+1 alpha &key (colour '(1 0 0)))
  (format t
          "
LINE: Line ~A ~A ~A ~A ~A 
  Apply Instancing Transform = On
  Colour = ~F, ~F, ~F
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
  Point 1 = ~F [m], ~F [m], ~F [m]
  Point 2 = ~F [m], ~F [m], ~F [m]
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
          ;; Header
          (number-to-string alpha)
          (number-to-string x)
          (number-to-string y)
          (number-to-string r-i)
          (number-to-string r-i+1)
          ;; Color
          (first colour) (second colour) (third colour)
          ;; x, y , z Point 1
          (mm->m x) 
          (* (cos (math/coord:dtr alpha)) (mm->m (+ y r-i))) 
          (* (sin (math/coord:dtr alpha)) (mm->m (+ y r-i)))
          ;; x, y, z Point 2
          (mm->m x) 
          (* (cos (math/coord:dtr alpha)) (mm->m (+ y r-i+1))) 
          (* (sin (math/coord:dtr alpha)) (mm->m (+ y r-i+1)))))

#+nil (make-line-belt 466.5 0.0 411.0 477.0 0.0 :colour '(1 0 0))

(defun make-surface-belt (x y r-i r-i+1 theta-min theta-max alpha &key (colour '(1 0 0))) 
  (format t
          "
SURFACE OF REVOLUTION: SURFACE ~A ~A ~A ~A ~A ~A
  Apply Instancing Transform = On
  Apply Texture = Off
  Blend Texture = On
  Colour = ~F, ~F, ~F
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
  Location List = /LINE:Line ~A ~A ~A ~A ~A
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
  Rotation Axis From = 0 [m], ~F [m], ~F [m]
  Rotation Axis To = 1 [m], ~F [m], ~F [m]
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
  Theta Points = 50
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
          ;; SURFACE OF REVOLUTION:
          (number-to-string alpha)
          (number-to-string x)
          (number-to-string r-i)
          (number-to-string r-i+1)
          (number-to-string theta-min)
          (number-to-string theta-max) 
          ;; Colour
          (first colour) (second colour) (third colour)
          ;; Location
          (number-to-string alpha)
          (number-to-string x)
          (number-to-string y)
          (number-to-string r-i)
          (number-to-string r-i+1) 
          ;; y, z Rotation Axis From 
          (* (cos (math/coord:dtr alpha)) (mm->m y)) 
          (* (sin (math/coord:dtr alpha)) (mm->m y))
          ;; y, z Rotation Axis To
          (* (cos (math/coord:dtr alpha)) (mm->m y)) 
          (* (sin (math/coord:dtr alpha)) (mm->m y))
          theta-max
          theta-min))

(defun make-tangent-belts (number x y r-min r-max theta-min theta-max alpha)
  "@b(Описание:) функция @b(make-tangent-belts) предназначена для создания поверхностей,
 представляющих из себя окружные пояса.

 @b(Переменые:) 
@begin(list) 
 @item(number - количество окружных поясов;)
 @item(x - плоскость, в которой строятся пояса;) 
 @item(y - координата центра поясов;) 
 @item(r-max - радиус минимальный;) 
 @item(r-min - радиус максимальный;)
 @item(theta-min - угол минимальный;)
 @item(theta-max - угол максимальный;)
 @item(alpha - угол поворота поясов вокруг оси X, градусы.)
@end(list)

 @b(Пример использования:)
@begin[lang=lisp](code)
 (progn
   (make-tangent-belts 10 450 530 10 110 -180.0 180. 0.0)
   (make-tangent-belts 10 450 530 10 110 -180.0 180. 22.5))
@end(code)
"
  (let ((r-i-r-i+1-sur-names nil))
    (loop :for i :from 0 :below number :do
      (let ((r-i    (+ r-min (* (/ i      number) (- r-max r-min))))
            (r-i+1  (+ r-min (* (/ (1+ i) number) (- r-max r-min)))))
        (make-line-belt x y r-i r-i+1 alpha
                        :colour `(1 ,(nth-value 1 (floor (1+ i) 2)) 0))
        (make-surface-belt x y r-i r-i+1 theta-min theta-max alpha
                           :colour `(1 ,(nth-value 1 (floor (1+ i) 2)) 0))
        (push (list r-i
                    r-i+1
                    (format nil "SURFACE ~A ~A ~A ~A ~A ~A"
                            (number-to-string alpha)
                            (number-to-string x)
                            (number-to-string r-i)
                            (number-to-string r-i+1)
                            (number-to-string theta-min)
                            (number-to-string theta-max)))
              r-i-r-i+1-sur-names)))
    r-i-r-i+1-sur-names))

(defun make-radial-belts (number x y r-min r-max theta-min theta-max alpha)
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
 @item(theta-max - угол максимальный;)
 @item(alpha - угол поворота поясов вокруг оси X, градусы.)
@end(list)

 @b(Пример использования:)
@begin[lang=lisp](code)
 (progn
   (make-radial-belts 10 50.0 530 10.0 110 -180.00 180.0 0)
   (make-radial-belts 10 50.0 530 10.0 110 -180.00 180.0 22.5))
@end(code)
"
  (make-line-belt x y r-min r-max alpha :colour '(0 0 1))
  (loop :for i :from 0 :below number :do
    (let ((theta-i    (+ theta-min (* (/ i      number) (- theta-max theta-min))))
          (theta-i+1  (+ theta-min (* (/ (1+ i) number) (- theta-max theta-min)))))
      (make-surface-belt x y r-min r-max theta-i theta-i+1 alpha
                         :colour `(1 ,(nth-value 1 (floor (1+ i) 2)) 0)))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



(defun make-cell (surfaces &key (equation "massFlowAve(Total Temperature)") (col "B" ) (row 10) (format "%4.1f"))
  (loop :for surf :in surfaces
      :for j :from row :do
        (format t "~A~A = \"=~A@~A\", False, False, False, Left, False, 0, Font Name, 1|1, ~A, False, ffffff, 000000, True~%" col j equation surf format)))

#+nil
(mnas-icem/belt:make-tangent-belts 10 466.5 0.0 411.0 477.0 -11.25 11.25 0.0)

#+nil
(make-cell
 (mnas-icem/belt:make-tangent-belts 10 466.5 0.0 411.0 477.0 -11.25 11.25 0.0))


