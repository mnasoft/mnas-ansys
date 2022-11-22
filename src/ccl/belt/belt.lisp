;;;; ./src/ccl/belt/belt.lisp

(defpackage #:mnas-ansys/belt
  (:use #:cl)
  (:intern mm->m
           line-name
           belt-line-name
           belt-surface-name
           make-line-belt
           make-surface-belt
           char+number)
  (:export number-to-string)
  (:export obj-number
           obj-number-incf
           obj-number-reset
           obj-number-print )
  (:export object-view-transform)
  (:export for-list)
  (:export make-point
           make-line
           make-plane
           make-surface-of-revolution
           make-table-head
           make-cell
           make-cells
           make-triple-cells           
           make-table-end)
  (:export make-legend)
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
  (format stream
          (concatenate 'string
                       parameter
                       (cond
                         ((consp variable) "~{~A~^, ~}")
                         (t "~A"))
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

(defun make-table-head (table
                        &key
                          (report-caption ""))
  "@b(Описание:) функция @b(make-table-head) возвращает строку,
  которая представляет заголовок таблицы в формате пригодном для
  вставки в CCL файл системы ANSYS CFX.
"
  (for-list t "TABLE: " table)
  (for-list t "  Export Table Only = " "True")
  (for-list t "  Table Exists = " "True")
  (for-list t "  Table Export Format = " "State")
  (for-list t "  Table Export HTML Border Width = " "1")
  (for-list t "  Table Export HTML Caption Position = " "Bottom")
  (for-list t "  Table Export HTML Cell Padding = " "5")
  (for-list t "  Table Export HTML Cell Spacing = " "1")
  (for-list t "  Table Export Lines = " "All")
  (for-list t "  Table Export Separator = " "Tab")
  (for-list t "  Table Export Trailing Separators = " "True")
  (for-list t "  OBJECT REPORT OPTIONS: " "")
  (for-list t "  Report Caption = " report-caption)
  (for-list t "  END" "")
  (for-list t "  TABLE CELLS: " ""))

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
    (make-table-end)
    (mapcar #'third rmin-rmax-sname)
    ))

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
                           (table "Table 1"))
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

(defun point-name ()
  "@b(Описание:) функция @b(point-name) возвращает строку,
   обозначающую имя точки."
  (format nil "Point ~A"
          (obj-number-print)))

(defun make-point-bak (point &key (point-symbol "Ball"))
  (obj-number-incf)
  (format t "POINT: ~A~%" (point-name))
  (format t "  Apply Instancing Transform = On
  Colour = 0, 0, 0
  Colour Map = Default Colour Map
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
"))

(defun make-point (name
                   &key
                     (Apply-Instancing-Transform "On")
                     (Colour "1, 1, 0")
                     (Colour-Map "Default Colour Map")
                     (Colour-Mode "Variable")
                     (Colour-Scale "Linear")
                     (Colour-Variable "Total Temperature")
                     (Colour-Variable-Boundary-Values "Hybrid")
                     (Culling-Mode "No Culling")
                     (Domain-List "/DOMAIN GROUP:All Domains")
                     (Draw-Faces "On")
                     (Draw-Lines "Off")
                     (Instancing-Transform "/DEFAULT INSTANCE TRANSFORM:Default Transform")
                     (Lighting "On")
                     (Line-Width "2")
                     (Max "0.0 [C]")
                     (Min "0.0 [C]")
                     (Node-Number "1")
                     (Option "XYZ")
                     (Point '(0.0 0.0 0.0))
                     (Point-Symbol "Ball")
                     (Range "Global")
                     (Specular-Lighting "On")
                     (Surface-Drawing "Smooth Shading")
                     (Symbol-Size "0.1")
                     (Transparency "0.0")
                     (Variable "Pressure")
                     (Variable-Boundary-Values "Hybrid")
                     (Visibility "On"))
  (for-list t  "POINT: " name)
  (for-list t  "  Apply Instancing Transform = " Apply-Instancing-Transform )
  (for-list t  "  Colour = " Colour )
  (for-list t  "  Colour Map = " Colour-Map )
  (for-list t  "  Colour Mode = " Colour-Mode )
  (for-list t  "  Colour Scale = " Colour-Scale )
  (for-list t  "  Colour Variable = " Colour-Variable )
  (for-list t  "  Colour Variable Boundary Values = " Colour-Variable-Boundary-Values )
  (for-list t  "  Culling Mode = " Culling-Mode )
  (for-list t  "  Domain List = " Domain-List )
  (for-list t  "  Draw Faces = " Draw-Faces )
  (for-list t  "  Draw Lines = " Draw-Lines )
  (for-list t  "  Instancing Transform = " Instancing-Transform )
  (for-list t  "  Lighting = " Lighting )
  (for-list t  "  Line Width = " Line-Width )
  (for-list t  "  Max = " Max )
  (for-list t  "  Min = " Min )
  (for-list t  "  Node Number = " Node-Number )
  (for-list t  "  Option = " Option )
  (for-list t  "  Point = " Point )
  (for-list t  "  Point Symbol = " Point-Symbol )
  (for-list t  "  Range = " Range )
  (for-list t  "  Specular Lighting = " Specular-Lighting )
  (for-list t  "  Surface Drawing = " Surface-Drawing )
  (for-list t  "  Symbol Size = " Symbol-Size )
  (for-list t  "  Transparency = " Transparency )
  (for-list t  "  Variable = " Variable )
  (for-list t  "  Variable Boundary Values = " Variable-Boundary-Values )
  (for-list t  "  Visibility = " Visibility)
  (for-list t  "  OBJECT VIEW TRANSFORM: " "")
  (for-list t  "    Apply Reflection = " "Off")
  (for-list t  "    Apply Rotation = " "Off")
  (for-list t  "    Apply Scale = " "Off")
  (for-list t  "    Apply Translation = " "Off")
  (for-list t  "    Principal Axis = " "Z")
  (for-list t  "    Reflection Plane Option = " "XY Plane")
  (for-list t  "    Rotation Angle = " "0.0 [degree]")
  (for-list t  "    Rotation Axis From = " "0 [mm], 0 [mm], 0 [mm]")
  (for-list t  "    Rotation Axis To = " "0 [mm], 0 [mm], 0 [mm]")
  (for-list t  "    Rotation Axis Type = " "Principal Axis")
  (for-list t  "    Scale Vector = " "1 , 1 , 1")
  (for-list t  "    Translation Vector = " "0 [mm], 0 [mm], 0 [mm]")
  (for-list t  "    X = " "0.0 [mm]")
  (for-list t  "    Y = " "0.0 [mm]")
  (for-list t  "    Z = " "0.0 [mm]")
  (for-list t  "  END" "")
  (for-list t  "END" ""))

(make-point "name")
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; Примеры использования функций

(make-tangent-belts 50 1200.0 0.0 0.0 200.0 -180 +180 0.0)

(make-table-tangent-belts
 50 1200.0 0.0 0.0 200.0 -180 +180 0.0
 :equations '("=massFlowAve(Velocity u)@" "=massFlowAve(Velocity v)@" "=massFlowAve(Velocity w)@"
 "=areaAve(Velocity u)@" "=areaAve(Velocity v)@" "=areaAve(Velocity w)@"))

(make-tangent-belts 1 1200.0 0.0 0.0 200.0 -180 +180 0.0)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun make-legend (&key
		      (name "Legend 1")
		      (Colour '(0 0 0))
		      (Font "Sans Serif")
		      (Legend-Aspect 0.05)
		      (Legend-Format "%3.0f") ;;"%10.3e"
		      (Legend-Orientation "Horizontal") ;; "Vertical"
		      (Legend-Plot "/CONTOUR:Contour 000000000931")
		      (Legend-Position '(0.2 0.02))
                      (legend-resolution 256)
                      (legend-shading "Smooth")
		      (Legend-Size 0.8)
		      (Legend-Ticks 5)
		      (Legend-Title "Legend")
		      (Legend-Title-Mode "Variable and Location")
		      (Legend-X-Justification "None") ;; "Center"
		      (Legend-Y-Justification "None") ;; "Bottom"
                      (Related-Object         "View 1")
		      (Show-Legend-Units      "On")
		      (Text-Colour-Mode "Default")
		      (Text-Height 0.018)
		      (Text-Rotation 0)
		      (Visibility "On"))
  "@b(Описание:) функция @b(make-legend) 
"
  (for-list t "LEGEND: " name)
  (for-list t "  Colour = " Colour)
  (for-list t "  Font = " Font)
  (for-list t "  Legend Aspect = " Legend-Aspect)
  (for-list t "  Legend Format = " Legend-Format)
  (for-list t "  Legend Orientation = " Legend-Orientation)
  (for-list t "  Legend Plot = " Legend-Plot)
  (for-list t "  Legend Position = " Legend-Position)
  (for-list t "  Legend Resolution =" legend-resolution)
  (for-list t "  Legend Shading = " Legend-Shading)
  (for-list t "  Legend Size = " Legend-Size)
  (for-list t "  Legend Ticks = " Legend-Ticks)
  (for-list t "  Legend Title = " Legend-Title)
  (for-list t "  Legend Title Mode = " Legend-Title-Mode)
  (for-list t "  Legend X Justification = " Legend-X-Justification)
  (for-list t "  Legend Y Justification = " Legend-Y-Justification)
  (for-list t "  Related Object = " Related-Object)
  (for-list t "  Show Legend Units = " Show-Legend-Units)
  (for-list t "  Text Colour Mode = " Text-Colour-Mode)
  (for-list t "  Text Height = " Text-Height)
  (for-list t "  Text Rotation = " Text-Rotation)
  (for-list t "  Visibility = " Visibility)
  (for-list t "END" (format nil "~%~%")))

(defun make-plane (name
                   &key
                     (x "530.0 [mm]")
                     (y "0.0 [mm]")
                     (z "0.0 [mm]")
                     (plane-bound "None"))
  "@b(Описание:) функция @b(make-plane)

 @b(Пример использования:)
@begin[lang=lisp](code)
 (make-plane \"foo\" :x (format nil \"~A [mm]\" 450.0))
@end(code)
"
  (for-list t "PLANE: " name)
  (for-list t "  Apply Instancing Transform = " "On")
  (for-list t "  Apply Texture = " "Off")
  (for-list t "  Blend Texture = " "On")
  (for-list t "  Bound Radius = " "0.5 [m]")
  (for-list t "  Colour = " "0.75, 0.75, 0.75")
  (for-list t "  Colour Map = " "Default Colour Map")
  (for-list t "  Colour Mode = " "Constant")
  (for-list t "  Colour Scale = " "Linear")
  (for-list t "  Colour Variable = " "Pressure")
  (for-list t "  Colour Variable Boundary Values = " "Hybrid")
  (for-list t "  Culling Mode = " "No Culling")
  (for-list t "  Direction 1 Bound = " "1.0 [m]")
  (for-list t "  Direction 1 Orientation = " "0 [degree]")
  (for-list t "  Direction 1 Points = " "10")
  (for-list t "  Direction 2 Bound = " "1.0 [m]")
  (for-list t "  Direction 2 Points = " "10")
  (for-list t "  Domain List = " "/DOMAIN GROUP:All Domains")
  (for-list t "  Draw Faces = " "On")
  (for-list t "  Draw Lines = " "Off")
  (for-list t "  Instancing Transform = " "/DEFAULT INSTANCE TRANSFORM:Default Transform")
  (for-list t "  Invert Plane Bound = " "Off")
  (for-list t "  Lighting = " "On")
  (for-list t "  Line Colour = " "0, 0, 0")
  (for-list t "  Line Colour Mode = " "Default")
  (for-list t "  Line Width = " "1")
  (for-list t "  Max = " "0.0 [kPa]")
  (for-list t "  Min = " "0.0 [kPa]")
  (for-list t "  Normal = " "1 , 0 , 0")
  (for-list t "  Option = " "YZ Plane")
  (for-list t "  Plane Bound = " plane-bound)
  (for-list t "  Plane Type = " "Slice")
  (for-list t "  Point = " "0 [mm], 0 [mm], 0 [mm]")
  (for-list t "  Point 1 = " "0 [mm], 0 [mm], 0 [mm]")
  (for-list t "  Point 2 = " "1 [mm], 0 [mm], 0 [mm]")
  (for-list t "  Point 3 = " "0 [mm], 1 [mm], 0 [mm]")
  (for-list t "  Range = " "Global")
  (for-list t "  Render Edge Angle = " "0 [degree]")
  (for-list t "  Specular Lighting = " "On")
  (for-list t "  Surface Drawing = " "Smooth Shading")
  (for-list t "  Texture Angle = " "0")
  (for-list t "  Texture Direction = " "0 , 1 , 0")
  (for-list t "  Texture File = " "")
  (for-list t "  Texture Material = " "Metal")
  (for-list t "  Texture Position = " "0 , 0")
  (for-list t "  Texture Scale = " "1")
  (for-list t "  Texture Type = " "Predefined")
  (for-list t "  Tile Texture = " "Off")
  (for-list t "  Transform Texture = " "Off")
  (for-list t "  Transparency = " "0.0")
  (for-list t "  Visibility = " "On")
  (for-list t "  X = " x)
  (for-list t "  Y = " y)
  (for-list t "  Z = " z)
  (for-list t "  OBJECT VIEW TRANSFORM: " "")
  (for-list t "    Apply Reflection = " "Off")
  (for-list t "    Apply Rotation = " "Off")
  (for-list t "    Apply Scale = " "Off")
  (for-list t "    Apply Translation = " "Off")
  (for-list t "    Principal Axis = " "Z")
  (for-list t "    Reflection Plane Option = " "XY Plane")
  (for-list t "    Rotation Angle = " "0.0 [degree]")
  (for-list t "    Rotation Axis From = " "0 [mm], 0 [mm], 0 [mm]")
  (for-list t "    Rotation Axis To = " "0 [mm], 0 [mm], 0 [mm]")
  (for-list t "    Rotation Axis Type = " "Principal Axis")
  (for-list t "    Scale Vector = " "1 , 1 , 1")
  (for-list t "    Translation Vector = " "0 [mm], 0 [mm], 0 [mm]")
  (for-list t "    X = " "0.0 [mm]")
  (for-list t "    Y = " "0.0 [mm]")
  (for-list t "    Z = " "0.0 [mm]")
  (for-list t "  END" "")
  (for-list t "END" "")
  )


