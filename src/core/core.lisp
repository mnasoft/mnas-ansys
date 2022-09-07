;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; package

(defpackage #:mnas-ansys
  (:use #:cl #:mnas-ansys/read)
  (:export open-tin-file)
;;;; generics
  (:export <object>-tag
           read-object
           coedged
           )
;;;; classes ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; <obj>
  (:export <obj>
           <obj>-name)
;;;; <ent>
  (:export <ent>
           <ent>-family)
;;;; <tetra>
  (:export <tetra>
           <tetra>-size)
;;;; <point>  
  (:export <point>
           <point>-x
           <point>-y
           <point>-z)
;;;; <family>
  (:export <family>
           <family>-color
           <family>-prism
           <family>-internal-wall
           <family>-split-wall
           <family>-tetra-size
           <family>-height
           <family>-hratio
           <family>-nlay
           <family>-ratio
           <family>-width
           <family>-min
           <family>-dev)
;;;; <curve>
  (:export <curve>
           <curve>-vertex1
           <curve>-vertex2
           <curve>-bspline
           <curve>-surfaces)
;;;; <material-point>  
  (:export <material-point>)
;;;; <coedge>  
  (:export <coedge>
           <coedge>-curve-type
           <coedge>-direction
           <coedge>-name)
;;;; <surface>
  (:export <surface>
           <surface>-coedges)
  (:export <solid>
           <solid>-material-point
           <solid>-n-lumps
           <solid>-n-sheets
           <solid>-matlpoint
           )
;;;; <tin>
  (:export <tin>
           <tin>-file-name
           <tin>-families
           <tin>-points
           <tin>-curves
           <tin>-surfaces
           <tin>-triangulation-tolerance
           tin-curves
           tin-surfaces           
           )
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  (:export find-curve-by-name
           find-surface-by-name
           )
  (:export find-coincidense)
  (:intern position-tin-in-objects
           populate-by-name
           init-curves
           )
  (:export find-curve-by-name
           find-surface-by-name
           find-surfaces-coeged-with-curves
           )
  (:export families
           names
           surface-coeged-with-surfaces
           )
  (:export count-surface) 
  (:documentation
   " Пакет предназначен для выполнения операций с представлением tin-файлов 
 (представления геометрии) системы ANSYS ICEM.

 Для того, чтобы осуществлять манипуляции с геометрическими объектами
 сначала необходимо выполнить открытие и разбор tin-файлова при помощи
 функции @b(open-tin-file)."
   ))

(in-package #:mnas-ansys)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; parameters 

(defparameter *rest-tin-types*
  '("affix" "bspline" "coedge"  "loop" "material_point" "polyline" "prescribed_point"
    "set_triangulation_tolerance" "trim_surface")
  "@b(Описание:) глобальная переменная содержит @b(*rest-tin-types*)
глобальная переменная содержит типы объектов начинающиеся
"
  )

(defparameter *defines*
  '("define_curve"
    "define_family"
    "define_model"
    "define_prism_meshing_parameters"
    "define_solid" "define_subset"
    "define_surface"
    "return")
  "@b(Описание:) глобальная переменная содержит типы объектов начинающиеся с
@b(define) плюс @b(return).
")

(defparameter *tin-top-objects*
  '(("define_family"    <family>)
    ("define_curve"     <curve>)
    ("define_surface"   <surface>)
    ("prescribed_point" <point>)
    
    ;;"define_model"
    ;;"define_prism_meshing_parameters"
    ;;"define_solid"
    ;;"define_subset"
    ;;"return"
    )
  "@b(Описание:) глобальная опредедяет теги объектов верхнего
уровня, считываемые объектом <tin>.

 Примечание: данный список будет расширяться.
")

;;;; (defparameter *coedge* (make-instance '<coedge>))

;;;; (defparameter *surface* (make-instance '<surface>))

;;;; (defparameter *tin* (make-instance '<tin>))

;;;; parameters
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; generics

(defgeneric <object>-tag (object)
  (:documentation
   "@b(Описание:) обобщенная_функция @b(<object>-tag) тег объекта."))

(defgeneric read-object (lines n object)
  (:documentation
   "@b(Описание:) обобщенная_функция @b(lines-to-object) считывает данные из tin-файла.
Должна возвращать два значения:
@begin(list)
@item(первое - считанный объект;)
@item(второе - количество считанных строк.)
 
 @b(Переменые:)
@begin(list)
@item(lines - список строк, из которых производится считывание ниформации;)
@item(n - номер строки, соответствующих началу размещения объекта;)
@item(object - объект, данные которого считываются.)
@end(list)
"))

(defgeneric coedged (object container)
  (:documentation "@b(Описание:) обобщенная функция @b(coedged) возвращает 
список объектов, имеющих с объектом @b(object) совпадающие грани.
 
 Для кривых типа @b(<curve>) должны возвращаться поверхности типа @b(<surfaces>),
находящиеся в контейненре @b(container).

 Для поверхностей типа @b(<surfaces>) должны возвращаться кривые типа @b(<curve>),
находящиеся в контейненре @b(container)."))

;;;; generics
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; classes 

(defclass <obj> ()
  ((name  :accessor <obj>-name :initarg :name :initform "Part_XXX" :type string
          :documentation "@b(Описание:) слот @b(name) определяет имя,
          связанное с объектом."))
    (:documentation "@b(Описание:) класс @b(<obj>) представляет
  объект, который имеет свойтство @b(name). Не подлежит
  непосредственному использованию."))

(defclass <ent> (<obj>)
  ((family :accessor <ent>-family :initarg :family :initform "Family_XXX" :type string
           :documentation "@b(Описание:) @b(family) определяет семейство 
"))
  (:documentation "@b(Описание:) класс @b(<ent>) представляет
  графический объект, который имеет свойтство @b(family). Не подлежит
  непосредственному использованию.

 От него порождены объекты следующи типов: @begin(list)
@item(<point>;) @item(<curve>;) @item(<surface>.)  @end(list)"))

(defclass <tetra> ()
  ((size :accessor <tetra>-size :initarg :x :initform 1e+10)))

(defclass <point> (<ent>)
  ((x :accessor <point>-x :initarg :x :initform 0.0d0 :type double-float
      :documentation "@b(Описание:) слот @b(x) определяет координату х.")
   (y :accessor <point>-y :initarg :y :initform 0.0d0 :type double-float
      :documentation "@b(Описание:) слот @b(x) определяет координату y.")
   (z :accessor <point>-z :initarg :z :initform 0.0d0 :type double-float
      :documentation "@b(Описание:) слот @b(x) определяет координату z."))
  (:documentation "@b(Описание:) класс @b(<point>) представляет точку.

 @b(Пример записи в tin-файле:)
@begin[lang=lisp](code)
 prescribed_point 41.599998474121 465.65328979492 -64.346717834473 family ASM.02/P02 name V_1056684
@end(code)
"))

(defclass <family> (<obj>)
  ((color :accessor <family>-color :initarg :color :initform 0 :type integer
          :documentation "@b(Описание:) слот @b(color) определяет
          номер цвета для графических объектов, относящихся к данному
          семейству.")
   (prism
    :accessor <family>-prism :initarg :prism :initform 0 :type integer :documentation
    "@b(Описание:) слот @b(prism) определяет признак генерирования
    призматических слоев при создании сетки. Генерирование
    призматических слоев при значении:

   @begin(list) @item(0 - не выполняется;) 
                @item(1 - выполняется.)
   @end(list)")
   (internal-wall
    :accessor <family>-internal-wall :initarg :internal-wall :initform 0 :type integer :documentation
    "@b(Описание:) слот @b(internal-wall) определяет тип поверхностей,
    находящихся в семействе как внутреннюю стенку (прозрачную для
    течения сквозь нее потока жидкости).")
   (split-wall
    :accessor <family>-split-wall :initarg :split-wall :initform 0 :type integer :documentation
    "@b(Описание:) слот @b(internal-wall) определяет тип поверхностей,
    находящихся в семействе как разделительную стенку (прозрачную для
    течения сквозь нее потока жидкости).")
   (tetra-size
    :accessor <family>-tetra-size :initarg :tetra-size :initform 0 :type number :documentation
    "@b(Описание:) слот @b(tetra-size) определяет максимальный размер
    стороны тетраэбрической сетки.")
   (height
    :accessor <family>-height :initarg :height :initform 0 :type number :documentation
    "@b(Описание:) слот @b(height) определяет ... предположиельно
    максимальную высоту призм.")
   (hratio
    :accessor <family>-hratio :initarg :hratio :initform 0 :type number :documentation
    "@b(Описание:) слот @b(height) определяет ... предположиельно
    максимальную высоту призм.")
   (nlay
    :accessor <family>-nlay :initarg :nlay :initform 0 :type integer :documentation
    "@b(Описание:) слот @b(height) определяет количество слоёв при
    генерации сетки.")
   (ratio
    :accessor <family>-ratio :initarg :ratio :initform 0 :type number :documentation
    "@b(Описание:) слот @b(ratio) определяет насколько быстро
    увеличивается размер тетраэдрической сетки.")
   (width
    :accessor <family>-width :initarg :width :initform 0 :type number :documentation
    "@b(Описание:) слот @b(width) определяет ...")
   (min
    :accessor <family>-min :initarg :min :initform 0 :type number :documentation
    "@b(Описание:) слот @b(width) определяет ...")
   (dev
    :accessor <family>-dev :initarg :dev :initform 0 :type number :documentation
    "@b(Описание:) слот @b(width) определяет ...")
   )
  (:documentation "@b(Описание:) класс @b(<family>) представляет
  семейство. Все объекты типа <ent> и их потомки относятся к
  определенному семейству.  Семейства используются для группировки
  графических объектов.

 @b(Пример записи в tin-файле:)
@begin[lang=lisp](code)
 define_family ASM.02/P02 color 13675571
 define_family GEOM prism 0 tetra_size 8.0 height 0 hratio 0 nlay 0 ratio 0 width 0 min 0 dev 0 color 8336365
 define_family C/PART.1 internal_wall 1 prism 1 tetra_size 1.0 height 2.0 hratio 3 nlay 4 ratio 5 width 6 min 7.0 dev 8.0 color 13675571
 define_family C/PART.1 split_wall 1 prism 1 tetra_size 1.0 height 2.0 hratio 3 nlay 4 ratio 5 width 6 min 7.0 dev 8.0 color 13675571
@end(code)
"))

(defclass <curve> (<ent> <tetra>)
  ((vertex1  :accessor <curve>-vertex1  :initarg :vertex1 :initform "vertex1" :type string
             :documentation "@b(Описание:) слот @b(vertex1) определяет имя начальной точки.")
   (vertex2  :accessor <curve>-vertex2  :initarg :vertex2 :initform "vertex2" :type string
             :documentation "@b(Описание:) слот @b(vertex1) определяет имя конечной точки.")
   (bspline  :accessor <curve>-bspline  :initarg :bspline :initform nil
             :documentation "@b(Описание:) слот @b(bspline) объект
             типа @b(<bspline>), который определяет промежуточные
             точки кривой типа @b(<curve>). Пока не используется.")
   (surfaces :accessor <curve>-surfaces :initform nil
             :documentation "Список поверхностей, сопряженных с этой кривой."))
  (:documentation "@b(Описание:) класс @b(<curve>) представляет кривую.

 @b(Пример записи в tin-файле:)
@begin[lang=lisp](code)
 define_curve family ASM.02/P02_E_C tetra_size 1e+10 name E_1048326 vertex1 V_1047351 vertex2 V_1047386
@end(code)
"))

(defclass <material-point> (<point>)
  ()
  (:documentation
   " @b(Описание:) класс @b(<material-point>)

 @b(Пример записи в tin-файле:) 
 @begin[lang=tin](code) 
  material_point -143.653214 578.922058 -0.000000 name B.G-A.1.1 family B.G-A.1
 @end(code)"))

(defclass <coedge> () 
  ((curve-type :accessor <coedge>-curve-type :initarg :curve-type :initform "3dcurve"
               :documentation "@b(Описание:) слот @b(curve-type)
               определяет тип ссылочной кривой. 

 Возможные типы кривых требуют уточнения.")
   (direction  :accessor <coedge>-direction  :initarg :direction  :initform t
               :documentation "@b(Описание:) слот @b(direction)
 предположительно определяет совпадение или несовпадение направления
 кривой, связанной объектом типа @b(<coedge>), и направления контура
 типа @b(<loop>):
 @begin(list)
 
 @item(t - направления совпадают;) 
 @item(nil - направления противоположные.) 
 @end(list)

 @b(Пример записи в tin-файле:)
@begin[lang=lisp](code)
 coedge 3dcurve   E_1056643
@end(code)

")
   (name       :accessor <coedge>-name       :initarg :direction  :initform "COEDGE-NAME"
               :documentation "@b(Описание:) слот @b(name) определяет
               имя сопряженной кривой типа @b(<curve>)." ))
  (:documentation "@b(Описание:) класс @b(<coedge>) представляет
  ссылку на кривую типа <curve>, сопряженную с поверхностью типа <surface>."))

(defclass <surface> (<ent> <tetra>)
  ((loops
    :documentation "@b(Описание:) слот @b(loops) содержит список
    контуров, на поверхости @b(<surface>).
   
 Пока не используется." )
   (coedges :accessor <surface>-coedges :initarg :coedges :initform nil
            :documentation "@b(Описание:) слот @b(coedges) содержит
            список объектов типа <coedge>, которые указывают на кривые сопряженные с
            настоящей поверхностью.
"))
  (:documentation "@b(Описание:) класс @b(<surface>) представляет поверхность.

 @b(Пример записи в tin-файле:)
@begin[lang=tin](code)
 define_surface name F_1050388 family ASM.02/P02 tetra_size 1e+10
@end(code)
"))

(defclass <solid> (<ent>)
  ((material-point :accessor <solid>-material-point                     :initform nil
                   :documentation "@b(Описание:) слот @b(material-point). Требуется уточнение.")
   (n-lumps        :accessor <solid>-n-lumps        :initarg :n-lumps   :initform 0
                   :documentation "@b(Описание:) слот @b(n-lumps). Требуется уточнение.")
   (n-sheets       :accessor <solid>-n-sheets       :initarg :n-sheets  :initform 0
                   :documentation "@b(Описание:) слот @b(n-sheets). Требуется уточнение.")
   (matlpoint      :accessor <solid>-matlpoint      :initarg :matlpoint :initform "matlpoint-name"
                   :documentation "@b(Описание:) слот @b(matlpoint)
   содержит имя материальной точки, связанной с объектом <solid>.") )
  (:documentation "@b(Описание:) класс @b(<solid>) представляет 

 @b(Пример записи в tin-файле:)
@begin[lang=tin](code)
 define_solid body n_lumps 0 n_sheets 0 matlpoint B.G-A.1.1 name B.G-A.1.0 family B.G-A.1
@end(code)
"))

(defclass <tin> ()
  ((file-name :accessor <tin>-file-name :initarg :file-name :initform "File-Name"
              :documentation
              "@b(Описание:) слот @b(file-name) содержит имя
               tin-файла, из которого выполнялось считывание
               геометрических данных.")
   (families   :accessor <tin>-families   :initarg :families   :initform nil
               :documentation
               "@b(Описание:) слот @b(families) содержит список семейств.")
   (points    :accessor <tin>-points    :initarg :points    :initform (make-hash-table :test #'equal)
              :documentation
              "@b(Описание:) слот @b(points) содержит список точек.")
   (curves    :accessor <tin>-curves    :initarg :curves    :initform (make-hash-table :test #'equal)
              :documentation
              "@b(Описание:) слот @b(curves) содержит хешированную
              таблицу кривых. Ключ - имя кривой. Значение - кривая.")
   (surfaces  :accessor <tin>-surfaces  :initarg :surfaces  :initform (make-hash-table :test #'equal)
              :documentation
              "@b(Описание:) слот @b(surfaces) содержит хешированную
              таблицу поверхностей. Ключ - имя поверхности. Значение -
              поверхность.")
   (triangulation-tolerance
    :accessor <tin>-triangulation-tolerance :initarg :triangulation_tolerance :initform 0.001
    :documentation
    "@b(Описание:) слот @b(triangulation-tolerance) содержит значение
    триангуляции по умолчанию."))
  (:documentation "@b(Описание:) класс @b(<tin>) представляет доступ к
  объектам, находящимся в tin-файле, генерируемом программой ICEM
  комплекса ANSYS."))

;;;; classes 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; method

(defmethod <object>-tag ((point <point>)) "prescribed_point")

(defmethod print-object ((point <point>) s)
  "prescribed_point 41.599998474121 465.65328979492 -64.346717834473 family ASM.02/P02 name V_1056684"
  (format s "~A ~16,10F ~16,10F ~16,10F family ~A name ~A~%"
          (<object>-tag point)
	  (<point>-x point)
	  (<point>-y point)
	  (<point>-z point)
	  (<ent>-family point)
	  (<obj>-name point)))

(defmethod read-object (lines n (point <point>))
  "@b(Описание:) метод @b(read-object) возвращает два значения:
@begin(list)
 @item(объект типа <point>;)
 @item(количество считанных строк.)
@end(list)
"
  (let ((params (mnas-string:split " " (elt lines n))))
    (setf (<point>-x point) (read-x-by-key (<object>-tag point) params))
    (setf (<point>-y point) (read-y-by-key (<object>-tag point) params))
    (setf (<point>-z point) (read-z-by-key (<object>-tag point) params))
    (setf (<ent>-family point) (read-by-key "family" params))
    (setf (<obj>-name  point) (read-by-key "name" params))
    (values point 1)))

(defmethod read-object (lines n (family <family>))
  "@b(Описание:) метод @b(read-object) возвращает два значения:
@begin(list)
 @item(объект типа <family>;)
 @item(количество считанных строк.)
@end(list)
"
  (let ((params (mnas-string:split " " (elt lines n))))
    (setf (<obj>-name             family) (read-by-key     "define_family" params))
    (setf (<family>-color         family) (read-int-by-key "color"         params))
#|    
    (setf (<family>-prism         family) (read-int-by-key "prism"         params))
    (setf (<family>-internal-wall family) (read-int-by-key "internal_wall" params))
    (setf (<family>-split-wall    family) (read-int-by-key "split_wall"    params))
    (setf (<family>-tetra-size    family) (read-x-by-key   "tetra_size"    params))
    (setf (<family>-height        family) (read-x-by-key   "height"        params))
    (setf (<family>-hratio        family) (read-x-by-key   "hratio"        params))
    (setf (<family>-nlay          family) (read-int-by-key "nlay"          params))
    (setf (<family>-ratio         family) (read-x-by-key   "ratio"         params))
    (setf (<family>-width         family) (read-x-by-key   "width"         params))
    (setf (<family>-min           family) (read-x-by-key   "min"           params))
    (setf (<family>-dev           family) (read-x-by-key   "dev"           params))
|#
    (values family 1)))

(defmethod print-object ((family <family>) s)
  "define_family ASM.02/P02 color 13675571
   define_family ASM.02/P02 color 13675571
   define_family GEOM prism 0 tetra_size 8.0 height 0 hratio 0 nlay 0 ratio 0 width 0 min 0 dev 0 color 8336365
   define_family C/PART.1 internal_wall 1 prism 1 tetra_size 1.0 height 2.0 hratio 3 nlay 4 ratio 5 width 6 min 7.0 dev 8.0 color 13675571
   define_family C/PART.1 split_wall 1 prism 1 tetra_size 1.0 height 2.0 hratio 3 nlay 4 ratio 5 width 6 min 7.0 dev 8.0 color 13675571
"
  (format s "define_family ~A "   (<obj>-name family))
  (format s "prism ~A "           (<family>-prism family))
  (when (= 1 (<family>-internal-wall family))
    (format s "internal_wall ~D " (<family>-internal-wall family)))
  (when (= 1                      (<family>-split-wall family))
    (format s "split_wall ~D "    (<family>-split-wall family)))
  (format s "tetra_size ~F "      (<family>-tetra-size family))
  (format s "height  ~F "         (<family>-height family))
  (format s "hratio ~F "          (<family>-hratio family))
  (format s "nlay ~D "            (<family>-nlay family))
  (format s "ratio ~F "           (<family>-ratio family))
  (format s "width ~F "           (<family>-width family))
  (format s "min ~F "             (<family>-min family))
  (format s "dev ~F "             (<family>-dev family))
  (format s "color ~D~%" (<family>-color family)))

(defmethod <object>-tag ((curve <curve>)) "define_curve")

(defmethod print-object ((curve <curve>) s)
  "define_curve family ASM.02/P02_E_C tetra_size 1e+10 name E_1047322 vertex1 V_1047367 vertex2 V_1047364"
  (format s "~A family ~A tetra_size ~F name ~A vertex1 ~A vertex2 ~A~%"
          (<object>-tag curve)
	  (<ent>-family curve)
	  (<tetra>-size curve)
	  (<obj>-name curve)
	  (<curve>-vertex1 curve)
	  (<curve>-vertex2 curve)))

(defmethod read-object (lines n (curve <curve>))
  "@b(Описание:) метод @b(read-object) возвращает два значения:
@begin(list)
 @item(объект типа <curve>;)
 @item(количество считанных строк.)
@end(list)
"
  (let ((params (mnas-string:split " " (elt lines n))))
    (setf (<ent>-family curve) (read-by-key "family" params))
    (setf (<tetra>-size curve) (read-by-key "tetra_size" params))
    (setf (<obj>-name  curve) (read-by-key "name" params))
    (setf (<curve>-vertex1 curve) (read-by-key "vertex1" params))
    (setf (<curve>-vertex2 curve) (read-by-key "vertex2" params))
    (values curve (- (position-if #'(lambda (el) (find el *defines* :test #'string=))
				  lines
				  :start (1+ n)
				  :key (lambda (el) (first (mnas-string:split " " el))))
		     n))))

(defmethod <object>-tag ((material-point <material-point>)) "material_point")

(defmethod print-object ((material-point <material-point>) s)
  " material_point -143.653214 578.922058 -0.000000 name B.G-A.1.1 family B.G-A.1"
  (format s "~A ~16,10F ~16,10F ~16,10F name ~A family ~A~%"
          (<object>-tag material-point)
	  (<point>-x    material-point)
	  (<point>-y    material-point)
	  (<point>-z    material-point)
	  (<obj>-name   material-point)
	  (<ent>-family material-point)))

(defmethod read-object (lines n (material-point <material-point>))
  "@b(Описание:) метод @b(read-object) возвращает два значения:
@begin(list)
 @item(объект типа <point>;)
 @item(количество считанных строк.)
@end(list)
"
  (let ((params (mnas-string:split " " (elt lines n))))
    (setf (<point>-x material-point) (read-x-by-key (<object>-tag material-point) params))
    (setf (<point>-y material-point) (read-y-by-key (<object>-tag material-point) params))
    (setf (<point>-z material-point) (read-z-by-key (<object>-tag material-point) params))
    (setf (<ent>-family material-point) (read-by-key "family" params))
    (setf (<obj>-name  material-point) (read-by-key "name" params))
    (values material-point 1)))

(defmethod <object>-tag ((coedge <coedge>)) "coedge")

(defmethod print-object ((coedge <coedge>) s)
  "coedge 3dcurve - F_1051295e1264"
  (format s "~A ~A ~A ~A~%"
          (<object>-tag coedge)
	  (<coedge>-curve-type coedge)
          (if (<coedge>-direction coedge) " " "-")
          (<coedge>-name coedge)))

(defmethod read-object (lines n (coedge <coedge>))
  "@b(Описание:) метод @b(read-object) возвращает два значения:
@begin(list)
 @item(объект типа <coedge>;)
 @item(количество считанных строк.)
@end(list)
"
  (let ((params (mnas-string:split " " (elt lines n))))
    (setf (<coedge>-curve-type coedge) (nth 1  params))
    (ecase  (length params)
      (1 (setf (<coedge>-direction  coedge) t
               (<coedge>-name  coedge) ""))
      (2 (setf (<coedge>-direction  coedge) t
               (<coedge>-name  coedge) ""))
      (3 (setf (<coedge>-direction  coedge) t
               (<coedge>-name  coedge) (nth 2 params)))
      (4 (setf (<coedge>-direction  coedge) nil
               (<coedge>-name  coedge) (nth 3 params))))
    (values coedge 1)))

(defmethod <object>-tag ((surface <surface>)) "define_surface")

(defmethod print-object ((surface <surface>) s)
  "~A family ASM.02/P02_E_C tetra_size 1e+10 name E_1047322 vertex1 V_1047367 vertex2 V_1047364"
  (format s "~A name ~A family ~A tetra_size ~F~%"
          (<object>-tag surface)
          (<obj>-name   surface)
	  (<ent>-family surface)
	  (<tetra>-size surface))
  (format s "~{~a~}" (<surface>-coedges surface)))

(defmethod read-object (lines n (surface <surface>))
  "@b(Описание:) метод @b(read-object) возвращает два значения:
@begin(list)
 @item(объект типа <curve>;)
 @item(количество считанных строк.)
@end(list)
"
  (let ((params (mnas-string:split " " (elt lines n)))
        (end-position (position-if
                       #'(lambda (el) (find el *defines* :test #'string=))
		       lines
		       :start (1+ n)
		       :key (lambda (el) (first (mnas-string:split " " el))))))
    (setf (<obj>-name   surface) (read-by-key "name" params))
    (setf (<ent>-family surface) (read-by-key "family" params))
    (setf (<tetra>-size surface) (read-by-key "tetra_size" params))
    (let ((rez nil))
      (loop :for i :from (1+ n) :below (position-tin-in-objects lines :objects *defines* :start (1+ n))
            :do (when (string= "coedge" (key-tin-in-objects lines i))
                  (push (read-object lines i (make-instance '<coedge>)) rez)))
      (setf (<surface>-coedges surface) (nreverse rez)))
    (values surface (- end-position n))))

(defmethod <object>-tag ((solid <solid>)) "define_solid")

(defmethod print-object ((solid <solid>) s)
  "~A family ASM.02/P02_E_C tetra_size 1e+10 name E_1047322 vertex1 V_1047367 vertex2 V_1047364"
  (format s "~A body n_lumps ~A n_sheets ~A matlpoint ~A name ~A family ~A~%"
          (<object>-tag      solid)
          (<solid>-n-lumps   solid)
          (<solid>-n-sheets  solid)
          (<solid>-matlpoint solid)
          (<obj>-name        solid)
	  (<ent>-family      solid)))

(defmethod read-object (lines n (solid <solid>))
  "@b(Описание:) метод @b(read-object) возвращает два значения:
@begin(list)
 @item(объект типа <solid>;)
 @item(количество считанных строк - одну строку.)
@end(list)
"
  (let ((params (mnas-string:split " " (elt lines n))))
    (setf (<obj>-name        solid) (read-by-key "name"   params))
    (setf (<ent>-family      solid) (read-by-key "family" params))
    (setf (<solid>-n-lumps   solid) (read-int-by-key "n_lumps" params))
    (setf (<solid>-n-sheets  solid) (read-int-by-key "n_sheets" params))
    (setf (<solid>-matlpoint solid) (read-by-key "matlpoint" params))
    (values solid 1)))

(defmethod tin-points ((tin <tin>))
  "@b(Описание:) метод @b(tin-points) возвращает список точек tin-файла."
  (loop :for k :being :the :hash-key
          :using (hash-value v) :of (<tin>-points tin)
      :collect v))

(defmethod tin-curves ((tin <tin>))
  "@b(Описание:) метод @b(tin-curves) возвращает список кривых tin-файла."
  (loop :for k :being :the :hash-key
          :using (hash-value v) :of (<tin>-curves tin)
      :collect v))

(defmethod tin-surfaces ((tin <tin>))
  "@b(Описание:) метод @b(tin-curves) возвращает список поверхностей tin-файла."
  (loop :for k
          :being :the :hash-key
          :using (hash-value v) :of (<tin>-surfaces tin)
      :collect v))

(defmethod print-object ((tin <tin>) s)
  ""
  ;;(format s "set_triangulation_tolerance ~F" (<tin>-triangulation-tolerance tin))
  (format s "// tetin file version 1.1~%")
  (format s "// Tetin file generated by ~A version ~A~%" "mnas-ansys" (mpkg/sys:version "mnas-ansys"))
  (format s "// ~A~%" (<tin>-file-name tin))
  (format s "~{~A~}"  (<tin>-families  tin))
  (format s "~{~A~}"  (tin-points      tin))
  (format s "~{~A~}"  (tin-curves      tin))
  (format s "~{~A~}"  (tin-surfaces    tin))
  ;; (<tin>-surfaces  tin)
  )

(defun add-obj-to-ht-by-name (obj ht)
  (setf (gethash (<obj>-name obj) ht) obj))

(defun populate-by-name (hash-table obj-list)
  " @b(Описание:) функция @b(populate-by-name) вспомогательная функция
 добавляет в хеш-таблицу @b(hash-table) элементы, находящиеся в
 таблице @b(obj-list) в качестве ключей имена объектов, в качестве
 значений используются собственно объекты.

 Планируется к использованию с кривыми и повехностями tin-файла."
  (map nil
       #'(lambda (el)
	   (setf (gethash (<obj>-name el) hash-table) el))
       obj-list)
  hash-table)

(defmethod init-curves ((tin <tin>))
  "@b(Описание:) метод @b(init-curves) выполняет инициализацию кривых."
  (map nil #'(lambda (surf)
               (map nil #'(lambda (curv)
                            (push surf (mnas-ansys::<curve>-surfaces curv)))
                    (mnas-ansys:coedged surf tin)))
       (mnas-ansys::tin-surfaces tin)))

(defmethod read-object (lines n-start (tin <tin>))
  "@b(Описание:) метод @b(read-object) возвращает два значения:
@begin(list)
 @item(объект типа <family>;)
 @item(количество считанных строк.)
@end(list)
"
  (labels ((find-next-tltob (lines n)
	     (position-tin-in-objects lines :objects (mapcar #'first *tin-top-objects*) :start n)))
    (do ((ob-symol nil)
	 (object   nil)
	 (families  nil)
	 (n (find-next-tltob lines n-start) (find-next-tltob lines (1+ n))))
	((and (null n))
	 (setf (<tin>-families  tin) (nreverse families)
               )
         (init-curves tin)
	 (values tin 0))
      (setf ob-symol (second (find (key-tin-in-objects lines n) *tin-top-objects* :key #'first :test #'string=))
            object (read-object lines n (make-instance ob-symol)))
      (ecase ob-symol
	(<family>  (push object families))
        (<curve>   (add-obj-to-ht-by-name object (<tin>-curves   tin)))
       	(<surface> (add-obj-to-ht-by-name object (<tin>-surfaces tin)))
        (<point>
         nil
         ;; (add-obj-to-ht-by-name object (<tin>-points   tin))
         )))))

(defmethod coedged ((curve <curve>) (surface <surface>))
  "@b(Описание:) метод @b(coedged) возвращает объект типа @b(surface),
если кривая @b(curve) имеет совпадающие грани с поверхностью @b(surface)
или @b(nil) в противном случае.

 Реализация весьма странная (нелогичная, не соответствующая духу
 обобщенной функции). Лучше переименовать coedged -> coedged-p ."
  (when (find (<obj>-name curve)
	      (<surface>-coedges surface)
	      :key #'<coedge>-name :test #'string=)
    surface))

(defmethod coedged ((curve <curve>) (tin <tin>))
  " @b(Описание:) метод @b(coedged) возвращает список объектов типа
 @b(<surface>), у которых грани (кромки) совпадают с кривой @b(curve)."
  (loop :for i :in (tin-surfaces tin)
        ;; (<tin>-surfaces tin)
        :when (coedged curve i) :collect :it))

(defmethod coedged ((surface <surface>) (tin <tin>))
  "@b(Описание:) метод @b(coedged) возвращает список объектов типа
 @b(curve), сопряженных с поверхностью @b(surface)."
  (loop :for i :in (<surface>-coedges surface)
        :when (find-curve-by-name (<coedge>-name i) tin) :collect :it))

(defmethod coedged ((coedge <coedge>) (tin <tin>))
  " @b(Описание:) метод @b(coedged) возвращает объект типа @b(<curve>)
 из набора объектов @b(tin), по имени кривой.
"
  (nreverse
   (reduce
    #'(lambda (lst sur)
	(if (coedged coedge sur) (cons sur lst)
	    lst))
    (tin-surfaces tin)
    ;; (<tin>-surfaces tin)
    :initial-value ())))

(defmethod find-curve-by-name ((name string) (tin <tin>))
  (gethash name (<tin>-curves tin))
  )

(defmethod find-surface-by-name ((name string) (tin <tin>))
  (gethash name (<tin>-surfaces tin))
  )

(defmethod find-curves-coeged-with-surfases (surfaces (tin <tin>))
  (remove-duplicates
   (apply #'append
          (mapcar #'(lambda (sur) (coedged sur tin)) surfaces))))

(defmethod find-surfaces-coeged-with-curves (curves (tin <tin>))
  (remove-duplicates
   (apply #'append
          (mapcar #'(lambda (sur) (coedged sur tin)) curves))))



(defmethod families (entytes)
  "@b(Описание:) метод @b(families) возвращает список семейств,
  содержащий уникальные имена.

 @b(Пример использования:)
@begin[lang=lisp](code)
 (families (<tin>-surfaces *tin*))
 (families (<tin>-curves  *tin*))
 (families (<tin>-points  *tin*))
@end(code)"
  (remove-duplicates 
   (mapcar #'(lambda(el) (<ent>-family el)) entytes)
   :test #'equal))

(defun names (entities &optional (stream t))
  "@b(Описание:) функция @b(entities) 
"
  (let ((names (sort (loop :for i :in entities
                           :collect (<obj>-name i))
                     #'string<)))
    (format stream "~{~A~^ ~}~2%" names)
    names))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defmethod surface-coeged-with-surfaces (surf (tin <tin>)
                                         &key
                                           (excluded nil)
                                           (times 1))
  " @b(Описание:) метод @b(surface-coeged-with-surfaces) возвращает
  поверхности, сопряженные с поверхностями из списка @b(surf) для
  контейнера геометрии @b(tin). 

  Параметр   @b(times) задает глубину поиска - количество итераций.

  На каждом шаге @b(times) поверхности, задаваемые ключевым параметром
  @(excluded) из результирующего списка исключаются.  
"
  (let* ((family-surfaces surf)
         (surfaces-excluded excluded)
         (start-surfaces family-surfaces))
    (loop :for i :from 0 :below times :do
          (let* ((curves  (mnas-ansys::find-curves-coeged-with-surfases start-surfaces tin))
                 (sufaces (mnas-ansys::find-surfaces-coeged-with-curves curves tin)))
            (map nil #'(lambda (el) (setf sufaces (remove el sufaces))) surfaces-excluded)
            (setf start-surfaces sufaces)))
    (map nil #'(lambda (el) (setf start-surfaces (remove el start-surfaces))) family-surfaces)
    start-surfaces))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defmethod count-surface ((tin <tin>))
  "@b(Описание:) метод @b(count-surface) возвращает список каждым
  элементом которого явяется список, содержащий имя семейства и
  количество поверхностей, которые находятся в этих семействах.

 @b(Пример использования:)
@begin[lang=lisp](code)
  (count-surface 
    (open-tin-file \"D:/home/_namatv/CFX/a32_base/PR-01/tin/DOMAINS/D-4/a32-D-4.tin\"))
    => ( (\"D1/C/C_1-3_N01_D024.00_S01.61\" 2) 
         (\"D1/C/C_1-4_N01_D032.00_S04.32\" 2)
         ...
         )
@end(code)"
  (let ((rez (make-hash-table :test #'equal)))
    (mapcar
     #'(lambda (sur)
         (if (null (gethash (<ent>-family sur) rez))
             (setf (gethash (<ent>-family sur) rez) 1)
             (setf (gethash (<ent>-family sur) rez) (1+ (gethash (<ent>-family sur) rez)))))
     (tin-surfaces tin))
    (sort 
     (mnas-hash-table:to-list rez)
     #'string<
     :key #'first)))

;;;; method
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; open
(defun position-tin-in-objects (lines 
				  &key (objects *defines*) from-end (start 0) end
				    (key #'(lambda (el) (first (mnas-string:split " " el)))))
  "@b(Описание:) функция @b(position-tin-in-objects) возвращает номер строки
из списка строк @b(lines) для, которого было найдено совпадение первой
строки из списка типов объектов @b(objects)"
  (position-if #'(lambda (el) (find el objects :test #'string=))
               lines :start start :key key :from-end from-end :end end))

(defun key-tin-in-objects (lines n)
  (first (mnas-string:split " " (elt lines n))))


(defun open-tin-file (f-name)
  "@b(Описание:) функция @b(open-tin-file) возвращает объект типа
  @b(<tin>), представляющий содержимое tin-файла с сменем
  @b(f-name). 

 В настоящий момент производится частичное считыванние tin-файла.
"
  (when (probe-file f-name)
    (let* ((lines (read-file-as-lines f-name))
           (tin (make-instance '<tin>)))
      (setf (<tin>-file-name tin) (truename f-name))
      (read-object lines 0 tin))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun exclude-by-families (objects families)
  "@b(Описание:) метод @b(exclude-by-families) возвращает
  список объектов среди, которых нет объектов из семейств @b(families)."
  (reduce #'(lambda (lst surf)
              (if (find (<ent>-family surf) families :test #'string=)
                  lst
                  (cons surf lst)))
          objects
          :initial-value ()))

;;;; open
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

