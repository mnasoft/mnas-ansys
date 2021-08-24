;;;; ./src/ccl/belt/belt.lisp

(defpackage #:mnas-ansys/belt
  (:use #:cl)
  (:intern number-to-string
           mm->m
           line-name
           belt-line-name
           belt-surface-name
           make-line-belt
           make-surface-belt
           char+number
           make-cells
           make-triple-cells)
  (:export obj-number
           obj-number-incf
           obj-number-reset
           obj-number-print )
  (:export for-list)
  (:export make-line
           make-surface-of-revolution
           make-table-head
           make-table-end)
  (:export make-tangent-belts
           make-radial-belts
           make-belts)
  (:export make-table-tangent-belts
           make-table-radial-belts)
  (:export make-table-belts)
  (:export make-table-by-locations)
  (:documentation
   "@b(Описание:) Пакет @b(mnas-ansys/ccl-belt) позволяет генерировать
 сценарии для построения поверхностей в программном комплексе ANSYS
 CFX на языке CCL.
"))

(in-package #:mnas-ansys/belt)

(defvar *obj-number* 1)

(defun obj-number ()
  *obj-number*)

(defun obj-number-incf ()
  (incf *obj-number*))

(defun obj-number-reset ()
  (setf *obj-number* 0))

(defun obj-number-print ()
  (format nil "~12,'0D" *obj-number*))

#+nil
(obj-number-reset)

(defun for-list (stream parameter variable)
  (format stream
          (concatenate 'string
                       parameter
                       (cond ((consp variable) "~{~A~^, ~}") (t "~A"))
                       "~%")
          variable))

(defun divide-min-max (x-min x-max number)
  "@b(Описание:) функция @b(divide-min-max) делит отрезок 
  (@b(x-min); @b(x-max)) на (number) равных по длите отрезков.
 Возвращает список результирующих отрезков.

 @b(Пример использования:)
@begin[lang=lisp](code)
 (divide-min-max -11.25 11.25 4) 
 => ((-11.25 -5.625) (-5.625 0.0) (0.0 5.625) (5.625 11.25))
@end(code)"
  (let ((d-x (- x-max x-min)))
    (loop :for i :from 0 :below number
          :for j :from 1
          :collect
          (list (+ x-min (* (/ i number) d-x)) (+ x-min (* (/ j number) d-x))))))

(defun object-view-transform ()
  (format t "  OBJECT VIEW TRANSFORM: 
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
  END~%"))

#+nil
(defun line-name (point-1 point-2)
  "@b(Описание:) функция @b(line-name) возвращает строку, обозначающую
   имя отрезка. Строка основана на координатах концевых точек
   отрезка.

 @b(Пример использования:)
@begin[lang=lisp](code)
 (line-name '(0 50 100) '(-10 -60 110)) =>
 \"Line p0i00 p50i00 p100i00 m10i00 m60i00 p110i00\"
@end(code)"
  (format nil "Line ~{~A~^ ~}"
          (mapcar #'number-to-string (append point-1 point-2))))

(defun line-name ()
  "@b(Описание:) функция @b(line-name) возвращает строку, обозначающую
   имя отрезка."
  (format nil "Line ~A"
          (obj-number-print)))

(defun surface-name ()
  "@b(Описание:) функция @b(line-name) возвращает строку, обозначающую
   имя поверхности."
  (format nil "Surface ~A"
          (obj-number-print)))

(defun make-line (point-1
                  point-2
                  &key
                    (colour '(1 0 0))
                    (name (progn (obj-number-incf)
                                 (line-name))))
  "@b(Описание:) функция @b(make-line) возвращает строку,
  которая представляет отрезок в формате пригодном для
  вставки в CCL файл системы ANSYS CFX.

 @b(Пример использования:)
@begin[lang=lisp](code)
 (make-line '(0 50 100) '(50 150 200))
@end(code)"
  (format t "~%LINE: ~A~%" name)
  (format t "  Apply Instancing Transform = On~%")
  (format t "  Colour = ~{~F~^, ~}~%" colour)
  (format t "  Colour Map = Default Colour Map
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
  Option = Two Points~%")
  (format t "  Point 1 = ~{~F [mm]~^, ~}~%" point-1)
  (format t "  Point 2 = ~{~F [mm]~^, ~}~%" point-2)
  (format t "  Range = Global
  Visibility = On~%")
  (object-view-transform)
  (format t "END~%")
  name)

(defun make-lines (point-1 point-2 number)
  "@b(Описание:) функция @b(make-lines) выводит на стандартный вывод
 данные в формате CCL ANSYS, представляющие из себя отрезки, делящие
 отрезок (@b(point-1); @b(point-2)) на @b(number) равных частей.

 Возвращает список имен воновьсозданных отрезков. Имена в списке идут
 от точки @b(point-1) к точке @b(point-2).

 Вторым значением возвращает список расстояний минимальных и
 максимальных до концевых точек отрезков от точки @b(point-1).

 @b(Пример использования:)
@begin[lang=lisp](code)
 (make-lines '(0.0 50.0 0.0) '(100. 75.0 0.0) 2) 
 => (\"Line 000000000326\" \"Line 000000000327\"), ((0.0 51.538822) (51.538822 103.077644))
@end(code)"
  (flet ((sq (x) (* x x))         )
  (let ((min-max-lenth-from-point-1 nil)
        (x0 (first  point-1))
        (y0 (second point-1))
        (z0 (third  point-1))
        (dx (- (first  point-2) (first  point-1)))
        (dy (- (second point-2) (second point-1)))
        (dz (- (third  point-2) (third  point-1))))
    (values
     (loop :for i :from 0 :below number
           :for j :from 1 
           :collect
           (let ((x-i (+ x0 (* (/ i number) dx)))
                 (x-j (+ x0 (* (/ j number) dx)))
                 (y-i (+ y0 (* (/ i number) dy)))
                 (y-j (+ y0 (* (/ j number) dy)))
                 (z-i (+ z0 (* (/ i number) dz)))
                 (z-j (+ z0 (* (/ j number) dz))))
             (push (list
                    (sqrt (+ (sq (- x-i x0)) (sq (- y-i y0)) (sq (- z-i z0))))
                    (sqrt (+ (sq (- x-j x0)) (sq (- y-j y0)) (sq (- z-j z0)))))
                   min-max-lenth-from-point-1)
             (make-line
              (list x-i y-i z-i)
              (list x-j y-j z-j)
              :colour
              `(1 ,(nth-value 1 (floor (1+ i) 2)) 0))))
     (nreverse min-max-lenth-from-point-1)))))

(defun make-table-head (table)
  "@b(Описание:) функция @b(make-table-head) возвращает строку,
  которая представляет заголовок таблицы в формате пригодном для
  вставки в CCL файл системы ANSYS CFX.
"
  (format t "~%TABLE: Table ~A~%" table)
    (format t "  Export Table Only = True
  Table Exists = True
  Table Export Format = State
  Table Export HTML Border Width = 1
  Table Export HTML Caption Position = Bottom
  Table Export HTML Cell Padding = 5
  Table Export HTML Cell Spacing = 1
  Table Export Lines = All
  Table Export Separator = Tab
  Table Export Trailing Separators = True
  OBJECT REPORT OPTIONS: 
    Report Caption = 
  END
  TABLE CELLS: ~%"))

(defun make-table-end ()
  (format t "  END~%END~%~%"))

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

(defun make-line-belt (x y r-min r-max alpha &key (colour '(1 0 0)))
  "@b(Описание:) функция @b(make-line-belt) выводит на стандартный
вывод данные в формате CCL ANSYS, представляющие из себя отрезок,
который предназначен для формирования поверхности пояса.

 Возвращает имя сгенерированного отрезка.

 @b(Пример использования:)
@begin[lang=lisp](code)
 (make-line-belt 466.5 0.0 411.0 477.0 0.0 :colour '(1 0 0))
@end(code)"
  (make-line
   (list x 
         (* (cos (math/coord:dtr alpha)) (+ y r-min)) 
         (* (sin (math/coord:dtr alpha)) (+ y r-min)))
   (list x 
         (* (cos (math/coord:dtr alpha)) (+ y r-max)) 
         (* (sin (math/coord:dtr alpha)) (+ y r-max)))
   :colour colour))

(defun belt-surface-name (x y r-min r-max theta-min theta-max alpha)
  (format nil "SURFACE ~A ~A ~A ~A ~A ~A ~A"
          (number-to-string alpha)
          (number-to-string x)
          (number-to-string y)
          (number-to-string r-min)
          (number-to-string r-max)
          (number-to-string theta-min)
          (number-to-string theta-max)))


(defun make-surface-of-revolution (location-list
                                   rotation-axis-from
                                   rotation-axis-to
                                   theta-min
                                   theta-max
                                   &key
                                     (colour '(1 0 0))
                                     (name (progn (obj-number-incf)
                                                  (surface-name))))
  ;;#+nil
  (format t "~%SURFACE OF REVOLUTION: ~A
  Apply Instancing Transform = On
  Apply Texture = Off
  Blend Texture = On~%" name)
  (format t "  Colour = ~{~F~^, ~}~%" colour)
  (format t "  Colour Map = Default Colour Map
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
  Line Width = 1~%")
  (for-list t "  Location List = /LINE:" location-list)
  (format t "  Max = 0.0 [Pa]
  Meridional Point 1 = 0 [m], 1 [m]
  Meridional Point 2 = 1 [m], 2 [m]
  Meridional Points = 20
  Min = 0.0 [Pa]
  Option = From Line
  Principal Axis = X
  Project to AR Plane = On
  Range = Global
  Render Edge Angle = 0 [degree]~%")
  (format t "  Rotation Axis From = ~{~F [mm]~^, ~}~%" rotation-axis-from)
  (format t "  Rotation Axis To = ~{~F [mm]~^, ~}~%" rotation-axis-to)
  (format t "  Rotation Axis Type = Rotation Axis
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
  Texture Type = Predefined~%")
  (format t "  Theta Max = ~F [degree]~%" theta-max)
  (format t "  Theta Min = ~F [degree]~%" theta-min)
  (format t "  Theta Points = 50
  Tile Texture = Off
  Transform Texture = Off
  Transparency = 0.0
  Use Angle Range = On
  Visibility = On~%")
  (object-view-transform)
  (format t "END~%")
  name)

#+nil
(progn 
  (make-line `(-48.589 ,(+ 530 73/2) 0) `(-36.589 ,(+ 530 73/2) 0) :name "Line")
  (make-line `(-22.589 ,(+ 530 136/2) 0) `(-6.389 ,(+ 530 136/2) 0) :name "Line 1")
  (make-surface-of-revolution '("Line")
                              '(0 530 0)
                              '(1 530 0)
                              -180
                              180)
  (make-surface-of-revolution "Line 1"
                              '(0 530 0)
                              '(1 530 0)
                              -180
                              180))

(defun make-surface-belt (location y theta-min theta-max alpha &key (colour '(1 0 0))) 
 "@b(Описание:) функция @b(make-surface-belt) выводит на стандартный
 вывод данные в формате CCL ANSYS, представляющие из себя элемент
 одиночного пояса (поверхность вращения).

 @b(Переменые:)
@begin(list)
 @item(location - строка с именем отрезка;) 
 @item(y - смещение оси x=0 вращения пояса в направлении y;)
 @item(theta-min - угол в градусах минимальный;)
 @item(theta-max - угол в градусах максиальный;)
 @item(alpha - поворот пояса вокруг оси x=0;)
 @item(colour - цвет в формате RGB.) 
@end(list)

 @b(Пример использования:)
@begin[lang=lisp](code)
 (make-surface-belt \"Line\" 100 -180 180 0.0)
@end(code)"
  (make-surface-of-revolution location
                              (list 0.0
                                    (* (cos (math/coord:dtr alpha)) y)
                                    (* (sin (math/coord:dtr alpha)) y))
                              (list 1000.0
                                    (* (cos (math/coord:dtr alpha)) y) 
                                    (* (sin (math/coord:dtr alpha)) y))
                              theta-min
                              theta-max
                              :colour colour))

(defun make-tangent-belts (number x y r-min r-max theta-min theta-max alpha)
  "@b(Описание:) функция @b(make-tangent-belts) выводит на стандартный
 вывод данные в формате CCL ANSYS, представляющие из себя окружные
 пояса. 

 Возвращает список длиной в @b(number) элементов, каждым элементом
 которого являются:
@begin(list)
 @item(меньший угол пояса;)
 @item(больший угол пояса;)
 @item(имя поверхности.)
@end(list)

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
   (make-tangent-belts 3 1200 200.0 100 200.0 -45.0 +45.0 0)
   (make-tangent-belts 3 1200 200.0 100 200.0 -45.0 +45.0 60.0))
 ((166.66667 200.0 \"Surface 000000000419\")
  (133.33334 166.66667 \"Surface 000000000417\")
  (100.0 133.33334 \"Surface 000000000415\"))
@end(code)

 @image[src=make-tangent-belts.png]()
"
  (let ((ri-rj-snames nil)
        (r-s (divide-min-max r-min r-max number)))
    (loop :for (r-i r-j) :in r-s
          :for i :from 1 :do
      (let* ((line (make-line-belt
                   x y r-i r-j alpha
                   :colour `(1 ,(nth-value 1 (floor i 2)) 0)))
            (sur (make-surface-belt
                  line
                  y theta-min theta-max alpha
                  :colour `(1 ,(nth-value 1 (floor i 2)) 0))))
        (push (list r-i r-j sur) ri-rj-snames)))
    ri-rj-snames))

(defun make-radial-belts (number x y r-min r-max theta-min theta-max alpha)
  "@b(Описание:) функция @b(make-radial-belts) выводит на стандартный
 вывод данные в формате CCL ANSYS, представляющие из себя радиальные
 пояса. 

 Возвращает список длиной в @b(number) элементов, каждым элементом
 которого являются:
@begin(list)
 @item(меньший угол пояса;)
 @item(больший угол пояса;)
 @item(имя поверхности.)
@end(list)

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
   (make-radial-belts 3 1200 200.0 100 200.0 -45.0 +45.0 0)
   (make-radial-belts 3 1200 200.0 100 200.0 -45.0 +45.0 60.0))
@end(code)

 @image[src=make-radial-belts.png]()
"
  (let ((ti-tj-snames nil)
        (tetas (divide-min-max theta-min theta-max number))
        (line (make-line-belt x y r-min r-max alpha :colour '(0 0 1))))
    (loop :for (t-i t-j) :in tetas
          :for i :from 0 :do
            (let ((sur (make-surface-belt line y t-i t-j alpha
                                           :colour `(1 ,(nth-value 1 (floor i 2)) 0))))
              (push (list t-i t-j sur) ti-tj-snames)))
    ti-tj-snames))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun make-belts (u-number v-number point-1 point-2 rotation-axis-from rotation-axis-to theta-min theta-max)
  "@b(Описание:) функция @b(make-belts) выводит на стандартный вывод
   данные в формате CCL ANSYS, представляющие из себя сетку из
   поверхностей.

 Возвращает список списков имен, вновьобразованных поверхностей. По
строкам рост в направлении от point-1 к point-2. По столбцам рост от
theta-min к theta-max.

 @b(Переменые:)
@begin(list)
@iterm(u-number - количество делений отрезка point-1 point-2;)
@iterm(v-number - количество делений угла theta-min theta-max;)
@iterm(point-1 - начальная точка образующей;)
@iterm(point-2 - конечная точка образующей;)
@iterm(rotation-axis-from - первая точка на оси;)
@iterm(rotation-axis-to - вторая точка на оси;)
@iterm(theta-min - угол минимальный;)
@iterm(theta-max - угол максимальный.)
@end(list)

 @b(Пример использования:)
@begin[lang=lisp](code)
 (make-belts 6 12 
            '(466.5 411.0 0.0) '(466.5 477.0 0.0) 
            '(0.0 0.0 0.0)     '(1000.0 0.0 0.0)
            -11.25 11.25)
@end(code)

"
  (let ((tetas (divide-min-max theta-min theta-max v-number)))
    (multiple-value-bind  (lines dists) (make-lines point-1 point-2 u-number)
      (values
       
       (nreverse (loop :for u :in lines :for i :from 0
                       :collect
                       (loop :for (t-min t-max) :in tetas :for j :from 0
                             :collect
                             (let ((name (make-surface-of-revolution
                                          u
                                          rotation-axis-from
                                          rotation-axis-to
                                          t-min
                                          t-max
                                          :colour `(1 ,(nth-value 1 (floor i 2)) ,(nth-value 1 (floor j 2))))))
                               name))))
       (nreverse dists)
       tetas))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun char+number (string number)
  (format nil "~A" (code-char (+ (char-code (elt string 0)) number))))


(defun make-cell (row col location &key (equation "") (format "%10.6f"))
  (format t "    ~A~A = \"~A~A\", False, False, False, Left, False, 0, Font Name, 1|1, ~A, False, ffffff, 000000, True~%"
          (char+number "A" (1- col)) row equation location format))


(defun make-cells-by-row (tbl &key (equation "") (row 1) (col 1) (format "%10.6f"))
   "
 @b(Переменые:)
@begin(list)
 @item(equation - \"=massFlow()@\";)
 @item( )
@end(list)
" 
  (loop :for r :in tbl :for i :from 0
        :collect
        (loop :for val :in r :for j :from 0
              :collect
              (make-cell (+ i row) (+ col j) val :equation equation :format format))))

(defun make-cells-by-col (tbl &key (equation "") (row 1) (col 1) (format "%10.6f"))
  "
 @b(Переменые:)
@begin(list)
 @item(equation - \"=massFlow()@\";)
 @item( )
@end(list)
"
  (loop :for r :in tbl :for i :from 0
        :collect
        (loop :for val :in r :for j :from 0
              :collect
              (make-cell (+ j row) (+ i col) val :equation equation :format format))))

(defun make-cells (locations &key (equations '("" "=massFlow()@")) (row 1) (col 1) (format "%10.6f"))
  (loop :for location :in locations
        :for i :from row :do
          (loop :for equation :in equations
                :for j :from col :do
                  (make-cell i j location :equation equation :format format))))

(defun make-triple-cells (vmin-vmax-surfaces &key
                                               (equations "=massFlowAve(Total Temperature)@")
                                               (col 1)
                                               (row 1)
                                               (format "%4.1f")
                                               (head-min "r-min")
                                               (head-max "r-max"))
  (make-cell (+ row 0) (+ col 0) head-min)
  (make-cell (+ row 0) (+ col 1) head-max)
  (when (stringp equations) (make-cell (+ row 0) (+ col 2) (string-trim "=@" equations)))
  (when (consp equations)
    (loop :for eq :in equations :for j :from 2 :do
      (make-cell (+ row 0) (+ col j) (string-trim "=@" eq))))
  (loop :for (v-min v-max surf) :in vmin-vmax-surfaces
        :for i :from (1+ row) :do
          (progn
            (make-cell i (+ col 0) v-min)
            (make-cell i (+ col 1) v-max)
            (when (stringp equations) (make-cell i (+ col 2) surf :equation equations :format format))
            (when (consp equations)
              (loop :for eq :in equations
                    :for j :from 2
                    :do
                       (make-cell i (+ col j) surf :equation eq :format format))))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun make-table-tangent-belts (number x y r-min r-max theta-min theta-max alpha
                                 &key
                                   (equations "=massFlowAve(Total Temperature)@")
                                   (row 1)
                                   (col 1)
                                   (format "%4.1f")
                                   (table 1)
                                   (head-min "a-min")
                                   (head-max "a-max")
                                   )
  "@b(Описание:) функция @b(make-table-tangent-belts) выводит на
 стандартный вывод данные, пригодные для формирования вертикальной
 эпюры поля значений.

 @b(Переменые:) 
@begin(list) 
 @item(number - количество окружных поясов;)
 @item(x - плоскость, в которой строятся пояса;) 
 @item(y - координата центра поясов;) 
 @item(r-min - радиус максимальный;)
 @item(r-max - радиус минимальный;) 
 @item(theta-min - угол минимальный;)
 @item(theta-max - угол максимальный;)
 @item(alpha - угол поворота поясов вокруг оси X, градусы;)
 @item(equations - строка, представляющая функцию на языке CCL;)
 @item(col - левая колонка начала размещения таблицы;)
 @item(row - верхняя строка начала размещения таблицы;)
 @item(format - формат вывода данных в таблицу;)
 @item(table - номер таблицы;)
 @item(head-min - заголовок для столбца минимальных значений;)
 @item(head-max - заголовок для столбца макисмальных значений.)
@end(list)

"
  (let ((rmin-rmax-sname
          (make-tangent-belts number x y r-min r-max theta-min theta-max alpha)))
    (make-table-head table)
    (make-triple-cells rmin-rmax-sname :equations equations :col col :row row :format format :head-min head-min :head-max head-max)
    (make-table-end)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun make-table-radial-belts (number x y r-min r-max theta-min theta-max alpha
                                &key
                                  (equations "=massFlowAve(Total Temperature)@")
                                  (col 1)
                                  (row 1)
                                  (format "%4.1f")
                                  (table 1)
                                  (head-min "a-min")
                                  (head-max "a-max")
                                  )
  "@b(Описание:) функция @b(make-table-radial-belts) выводит на
 стандартный вывод данные, пригодные для формирования окружной эпюры
 поля значений.

 @b(Переменые:) 
@begin(list) 
 @item(number - количество окружных поясов;)
 @item(x - плоскость, в которой строятся пояса;) 
 @item(y - координата центра поясов;) 
 @item(r-min - радиус максимальный;)
 @item(r-max - радиус минимальный;) 
 @item(theta-min - угол минимальный;)
 @item(theta-max - угол максимальный;)
 @item(alpha - угол поворота поясов вокруг оси X, градусы;)
 @item(equations - строка, представляющая функцию на языке CCL;)
 @item(col - левая колонка начала размещения таблицы;)
 @item(row - верхняя строка начала размещения таблицы;)
 @item(format - формат вывода данных в таблицу;)
 @item(table - номер таблицы;)
 @item(head-min - заголовок для столбца минимальных значений;)
 @item(head-max - заголовок для столбца макисмальных значений.)
@end(list)
"
  (let ((amin-amax-sname
          (make-radial-belts number x y r-min r-max theta-min theta-max alpha)))
    (make-table-head table)
    (make-triple-cells amin-amax-sname :equations equations :col col :row row :format format :head-min head-min :head-max head-max)
    (make-table-end)))


(defun make-table-belts (u-number v-number point-1 point-2 rotation-axis-from rotation-axis-to theta-min theta-max
                         &key
                           (equations '("=massFlowAve(Total Temperature)@" "=massFlowAve(Velocity)@"))
                           (formats   '("%4.1f"                            "%4.1f"))
                           (col 1)
                           (row 1)
                           (format-r "%6.2f")
                           (format-a "%6.2f")
                           (table 1))
  "@b(Описание:) функция @b(make-table-belts)  выводит на
 стандартный вывод данные, пригодные для формирования 
 полей значений, вычисленых по выражениям @b(equations).

 @b(Пример использования:)
@begin[lang=lisp](code)
 (make-table-belts 5 4 
                  '(1200 50 0)   '(1200 150 0.0) 
                  '(0.0 0.0 0.0) '(1000.0 0.0 0.0)
                  -90 90)
@end(code)
"
  (multiple-value-bind (loc-tbl r-tbl a-tbl)
      (make-belts u-number v-number point-1 point-2 rotation-axis-from rotation-axis-to theta-min theta-max)
    (make-table-head table)
    (loop :for eq :in equations :for fmt :in formats :for n :from 0 :by (+ (length r-tbl) 5) :do
      (block cells
        (make-cells-by-row `((,(string-trim "=@" eq))) :row (+ row 0 n) :col (+ col 0))
        (make-cells-by-row '(("r-min" "r-max")) :row (+ row 2 n) :col (+ col 0))
        (make-cells-by-col '(("a-min" "a-max")) :row (+ row 0 n) :col (+ col 2))
        (make-cells-by-row r-tbl                :row (+ row 3 n) :col (+ col 0) :format format-r)
        (make-cells-by-col a-tbl                :row (+ row 0 n) :col (+ col 3) :format format-a)
        (make-cells-by-row loc-tbl :equation eq :row (+ row 3 n) :col (+ col 3) :format fmt)))
    (make-table-end)))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun make-table-by-locations (locations
                                &key
                                  (equations '("" "=massFlow()@"))
                                  (col "A")
                                  (row 1)
                                  (format "%4.1f")
                                  (table 1))
  "@b(Описание:) функция @b(make-table-by-locations) выводит на
 стандартный вывод данные, пригодные для формирования таблицы на языке
 CCL.

 @b(Переменые:) 
@begin(list) 
 @item(locations - список строк содержащих локации, для которых
 выполняется функци(я/и) equation;)
 @item(equations - список строк, представляющих функцию на языке CCL;)
 @item(col - левая колонка начала размещения таблицы;)
 @item(row - верхняя строка начала размещения таблицы;)
 @item(format - формат вывода данных в таблицу.)
@end(list)
"
  (make-table-head table)
  (make-cells locations :equations equations :col col :row row :format format)
  (make-table-end))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; Примеры использования функций

(make-tangent-belts 50 1200.0 0.0 0.0 200.0 -180 +180 0.0)

(make-table-tangent-belts
 50 1200.0 0.0 0.0 200.0 -180 +180 0.0
 :equations '("=massFlowAve(Velocity u)@" "=massFlowAve(Velocity v)@" "=massFlowAve(Velocity w)@"
 "=areaAve(Velocity u)@" "=areaAve(Velocity v)@" "=areaAve(Velocity w)@"))

(make-tangent-belts 1 1200.0 0.0 0.0 200.0 -180 +180 0.0)
