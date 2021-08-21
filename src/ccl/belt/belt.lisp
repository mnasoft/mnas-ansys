;;;; ./src/ccl/belt/belt.lisp

(defpackage #:mnas-icem/belt
  (:use #:cl )
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
  (:export make-line
           make-surface-of-revolution
           make-table-head
           make-table-end)
  (:export make-tangent-belts
           make-radial-belts)
  (:export make-table-tangent-belts
           make-table-radial-belts)
  (:export make-table-by-locations)
  (:documentation
   "@b(Описание:) Пакет @b(mnas-icem/ccl-belt) позволяет генерировать
 сценарии для построения поверхностей в программном комплексе ANSYS
 CFX на языке CCL.
"))

(in-package #:mnas-icem/belt)

(defvar *obj-number* 1)

(defun obj-number ()
  *obj-number*)

(defun obj-number-incf ()
  (incf *obj-number*))

(defun obj-number-reset ()
  (setf *obj-number* 0))

(defun obj-number-print (n)
  (format nil "~12,'0D" n))

(obj-number-reset)

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



(defun make-line (point-1
                  point-2
                  &key
                    (colour '(1 0 0))
                    (name (line-name point-1 point-2)))
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
  (format t "END~%"))

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

(defun belt-line-name (x y r-min r-max alpha)
  (line-name
   (list x 
         (* (cos (math/coord:dtr alpha)) (+ y r-min)) 
         (* (sin (math/coord:dtr alpha)) (+ y r-min)))
   (list x 
         (* (cos (math/coord:dtr alpha)) (+ y r-max)) 
         (* (sin (math/coord:dtr alpha)) (+ y r-max)))))

(defun make-line-belt (x y r-min r-max alpha &key (colour '(1 0 0)))
  (make-line
   (list x 
         (* (cos (math/coord:dtr alpha)) (+ y r-min)) 
         (* (sin (math/coord:dtr alpha)) (+ y r-min)))
   (list x 
         (* (cos (math/coord:dtr alpha)) (+ y r-max)) 
         (* (sin (math/coord:dtr alpha)) (+ y r-max)))
   :colour colour))

#+nil (make-line-belt 466.5 0.0 411.0 477.0 0.0 :colour '(1 0 0))

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
                                     (name (concatenate 'string
                                                        #+nil "SURFACE "
                                                        (cond
                                                          ((stringp location-list) location-list)
                                                          ((consp location-list) (first location-list))))))
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
  (when (stringp location-list)
    (format t "  Location List = /LINE:~A~%" location-list))
  (when (consp location-list)
    (format t "  Location List = /LINE:~{~A~^ ,~}~%" location-list))
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
  (format t "  Theta Max = ~A [degree]~%" theta-max)
  (format t "  Theta Min = ~A [degree]~%" theta-min)
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

(defun make-surface-belt (x y r-min r-max theta-min theta-max alpha &key (colour '(1 0 0))) 
 "@b(Описание:) функция @b(make-surface-belt) предназначена для создания одиночного пояса.

 @b(Пример использования:)
@begin[lang=lisp](code)
 (make-surface-belt 0 1200 0 100 -180 180 0.0)
@end(code)

"
  (make-surface-of-revolution
   (belt-line-name x y r-min r-max alpha)
   (list 0.0
         (* (cos (math/coord:dtr alpha)) y)
         (* (sin (math/coord:dtr alpha)) y))
   (list 1000.0
         (* (cos (math/coord:dtr alpha)) y) 
         (* (sin (math/coord:dtr alpha)) y))
   theta-min
   theta-max
   :colour colour
   :name  (belt-surface-name x y r-min r-max theta-min theta-max alpha)))

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
@end(code)

 @image[src=make-tangent-belts.png]()
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
                    (belt-surface-name x y r-i r-i+1 theta-min theta-max alpha))
              r-i-r-i+1-sur-names)))
    r-i-r-i+1-sur-names))

(defun make-belts (number locations rotation-axis-from rotation-axis-to theta-min theta-max)
  (let ((rez nil))
    (loop :for i :from 0 :below number :do
      (let* ((theta-i    (+ theta-min (* (/ i      number) (- theta-max theta-min))))
             (theta-i+1  (+ theta-min (* (/ (1+ i) number) (- theta-max theta-min))))
             (name       (make-surface-of-revolution
                          locations
                          rotation-axis-from
                          rotation-axis-to
                          theta-i
                          theta-i+1
                          :colour `(1 ,(nth-value 1 (floor (1+ i) 2)) 0))))
        (push name rez)))
    rez))


(make-belts 3 "Line" '(0.0 0.0 0.0) '(1000.0 300.0 0.0) -45.0 45.0)

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
  (let ((theta-i-theta-i+1-sur-names nil))
    (make-line-belt x y r-min r-max alpha :colour '(0 0 1))
    (loop :for i :from 0 :below number :do
      (let ((theta-i    (+ theta-min (* (/ i      number) (- theta-max theta-min))))
            (theta-i+1  (+ theta-min (* (/ (1+ i) number) (- theta-max theta-min)))))
        (make-surface-belt x y r-min r-max theta-i theta-i+1 alpha
                           :colour `(1 ,(nth-value 1 (floor (1+ i) 2)) 0))
        (push (list theta-i
                    theta-i+1
                    (belt-surface-name x y r-min r-max theta-i theta-i+1 alpha))
              theta-i-theta-i+1-sur-names)))
    theta-i-theta-i+1-sur-names))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun char+number (string number)
  (format nil "~A" (code-char (+ (char-code (elt string 0)) number))))

(defun make-cells (locations &key (equations '("" "=massFlow()@")) (col "A" ) (row 1) (format "%10.6f"))
  (loop :for location :in locations
        :for j :from row :do
          (loop :for equation :in equations
                :for k :from 0 :do
            (format t "    ~A~A = \"~A~A\", False, False, False, Left, False, 0, Font Name, 1|1, ~A, False, ffffff, 000000, True~%"
                    (char+number col k) j equation location format))))

(defun make-triple-cells (vmin-vmax-surfaces &key
                                              (equations "=massFlowAve(Total Temperature)@")
                                              (col "A" )
                                              (row 10)
                                              (format "%4.1f")
                                              (head-min "r-min")
                                              (head-max "r-max"))
  (format t "    ~A~A = \"~A\", False, False, False, Left, False, 0, Font Name, 1|1, ~A, False, ffffff, 000000, True~%"
          (char+number col 0) row head-min "%8.2f")
  (format t "    ~A~A = \"~A\", False, False, False, Left, False, 0, Font Name, 1|1, ~A, False, ffffff, 000000, True~%"
          (char+number col 1) row head-max "%8.2f")
  (when (stringp equations)
    (format t "  ~A~A = \"~A\", False, False, False, Left, False, 0, Font Name, 1|1, ~A, False, ffffff, 000000, True~%"
            (char+number col 2) row (string-trim "=@" equations) "%8.2f"))
  (when (consp equations)
    (loop :for eq :in equations
          :for k :from 2
          :do
             (format t "  ~A~A = \"~A\", False, False, False, Left, False, 0, Font Name, 1|1, ~A, False, ffffff, 000000, True~%"
                     (char+number col k) row (string-trim "=@" eq) "%8.2f")))
  (loop :for surf :in vmin-vmax-surfaces
        :for j :from (1+ row) :do
          (progn
            (format t "  ~A~A = \"~A\", False, False, False, Left, False, 0, Font Name, 1|1, ~A, False, ffffff, 000000, True~%"
                    (char+number col 0) j (first surf) "%8.2f")
            (format t "  ~A~A = \"~A\", False, False, False, Left, False, 0, Font Name, 1|1, ~A, False, ffffff, 000000, True~%"
                    (char+number col 1) j (second surf) "%8.2f")
            (when (stringp equations)
              (format t "  ~A~A = \"~A~A\", False, False, False, Left, False, 0, Font Name, 1|1, ~A, False, ffffff, 000000, True~%"
                      (char+number col 2) j equations (third  surf) format))
            (when (consp equations)
              (loop :for eq :in equations
                    :for k :from 2
                    :do
                       (format t "  ~A~A = \"~A~A\", False, False, False, Left, False, 0, Font Name, 1|1, ~A, False, ffffff, 000000, True~%"
                               (char+number col k) j eq (third  surf) format))))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;A10 = "10.5", False, False, False, Left, False, 0, Font Name, 1|1, %10.3e, True, ffffff, 000000, True

(defun make-table-tangent-belts (number x y r-min r-max theta-min theta-max alpha
                                 &key
                                   (equations "=massFlowAve(Total Temperature)@")
                                   (col "A" )
                                   (row 1)
                                   (format "%4.1f")
                                   (table 1))
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
 @item(format - формат вывода данных в таблицу.)
@end(list)

"
  (let ((r-min-r-max-sur-name
          (make-tangent-belts number x y r-min r-max theta-min theta-max alpha)))
    (make-table-head table)
    (make-triple-cells r-min-r-max-sur-name :equations equations :col col :row row :format format)
    (make-table-end)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun make-table-radial-belts (number x y r-min r-max theta-min theta-max alpha
                                &key
                                  (equations "=massFlowAve(Total Temperature)@")
                                  (col "E")
                                  (row 1)
                                  (format "%4.1f")
                                  (table 1))
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
 @item(format - формат вывода данных в таблицу.)
@end(list)
"
  (let ((alpha-min-alpha-max-sur-name
          (make-radial-belts number x y r-min r-max theta-min theta-max alpha)))
    (make-table-head table)
    (make-triple-cells
     alpha-min-alpha-max-sur-name
     :equations equations
     :col col
     :row row
     :format format
     :head-min "alpha-min"
     :head-max "alpha-max")
    (make-table-end)))

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

(make-surface-belt 1200.0 0.0 0.0 200.0 -180 +180 0.0)

(belt-surface-name 1200.0 0.0 0.0 200.0 -180 +180 0.0)
