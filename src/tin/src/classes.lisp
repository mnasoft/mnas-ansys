;;;; ./src/tin/core/classes.lisp

(in-package :mnas-ansys/tin)

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
@item(<prescribed-point>;) @item(<curve>;) @item(<surface>.)  @end(list)"))

(defclass <point> ()
  ((x :accessor <point>-x :initarg :x :initform 0.0d0 :type double-float
      :documentation "@b(Описание:) слот @b(x) определяет координату х.")
   (y :accessor <point>-y :initarg :y :initform 0.0d0 :type double-float
      :documentation "@b(Описание:) слот @b(x) определяет координату y.")
   (z :accessor <point>-z :initarg :z :initform 0.0d0 :type double-float
      :documentation "@b(Описание:) слот @b(x) определяет координату z."))
    (:documentation "@b(Описание:) класс @b(<point>) представляет точку."))

(defclass <prescribed-point> (<point> <ent>)
  ()
  (:documentation "@b(Описание:) класс @b(<prescribed-point>) представляет точку.

 @b(Пример записи в tin-файле:)
@begin[lang=lisp](code)
 prescribed_point 41.599998474121 465.65328979492 -64.346717834473 family ASM.02/P02 name V_1056684
@end(code)
"))

(defclass <tetra> ()
  ((size :accessor <tetra>-size :initarg :x :initform 1e+10)))

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

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defclass <bspline> ()
  ((n        :accessor <bspline>-n  :initarg :n :initform 2 :type integer
             :documentation "@b(Описание:) слот @b(n) количество вершин.")
   (k        :accessor <bspline>-k  :initarg :k :initform 2 :type integer
             :documentation "@b(Описание:) слот @b(k) определяет степень сплайна.")
   (i        :accessor <bspline>-i  :initarg :i :initform 0
             :documentation "@b(Описание:) слот @b(i). Пока не используется.")
   (knots    :accessor <bspline>-knots :initform nil
             :documentation "Вектор координат узлов.")
   (points   :accessor <bspline>-points :initform nil
             :documentation "Вектор точек.")
   )
  (:documentation "@b(Описание:) класс @b(<curve>) представляет кривую.

 @b(Пример записи в tin-файле:)
@begin[lang=lisp](code)
 bspline
 2,2,0
 0,0,1,1
 -0.715436241611,-0.234228187919,0
 -0.620134228188,-0.121476510067,0
@end(code)

 @b(Пример записи в tin-файле:)
@begin[lang=lisp](code)
bspline
6,4,0
0,0,0,0,0.30382264221938
0.5302509147985,0.97259245893749,0.97259245893749,0.97259245893749,0.97259245893749
-0.715436241611,-0.234228187919,0
-0.66848624119026,-0.14561823780716,0
-0.5110031434075,-0.020919024542826,0
-0.16535550685116,-0.095724667296346,0
-0.040609472581351,-0.30590809847363,0
0.123489932886,-0.321476510067,0
@end(code)
"))
