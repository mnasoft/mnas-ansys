(in-package :mnas-ansys/tin)

(defun print-vector (v n stream)
  "@b(Описание:) функция @b(print-vector) выводит в поток @b(stream)
элементы вектора @b(v) по @b(n) элементов в строке, разделяя их
запятыми, и без запятой в конце строки."
  (loop :for i :from 0 :below (length v) :by n :do
    (let ((end (min (+ i n) (length v))))
      (loop :for j :from i :below end :do
        (progn
          (format stream "~A" (elt v j))
          (when (< j (1- end))
            (format stream ","))))
      (format stream "~%"))))

(defmethod print-object ((point <prescribed-point>) s)
  "prescribed_point 41.599998474121 465.65328979492 -64.346717834473 family ASM.02/P02 name V_1056684"
  (format s "~A ~16,10F ~16,10F ~16,10F family ~A name ~A~%"
          (<object>-tag point)
	  (<point>-x point)
	  (<point>-y point)
	  (<point>-z point)
	  (<ent>-family point)
	  (<obj>-name point)))

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

(defmethod print-object ((curve <curve>) s)
  "define_curve family ASM.02/P02_E_C tetra_size 1e+10 name E_1047322 vertex1 V_1047367 vertex2 V_1047364"
  (format s "~A family ~A tetra_size ~F name ~A vertex1 ~A vertex2 ~A~%"
          (<object>-tag curve)
	  (<ent>-family curve)
	  (<tetra>-size curve)
	  (<obj>-name curve)
	  (<curve>-vertex1 curve)
	  (<curve>-vertex2 curve)))

(defmethod print-object ((material-point <material-point>) s)
  " material_point -143.653214 578.922058 -0.000000 name B.G-A.1.1 family B.G-A.1"
  (format s "~A ~16,10F ~16,10F ~16,10F name ~A family ~A~%"
          (<object>-tag material-point)
	  (<point>-x    material-point)
	  (<point>-y    material-point)
	  (<point>-z    material-point)
	  (<obj>-name   material-point)
	  (<ent>-family material-point)))

(defmethod print-object ((coedge <coedge>) s)
  "coedge 3dcurve - F_1051295e1264"
  (format s "~A ~A ~A ~A~%"
          (<object>-tag coedge)
	  (<coedge>-curve-type coedge)
          (if (<coedge>-direction coedge) " " "-")
          (<coedge>-name coedge)))

(defmethod print-object ((surface <surface>) s)
  "~A family ASM.02/P02_E_C tetra_size 1e+10 name E_1047322 vertex1 V_1047367 vertex2 V_1047364"
  (format s "~A name ~A family ~A tetra_size ~F~%"
          (<object>-tag surface)
          (<obj>-name   surface)
	  (<ent>-family surface)
	  (<tetra>-size surface))
  (format s "~{~a~}" (<surface>-coedges surface)))

(defmethod print-object ((solid <solid>) s)
  "~A family ASM.02/P02_E_C tetra_size 1e+10 name E_1047322 vertex1 V_1047367 vertex2 V_1047364"
  (format s "~A body n_lumps ~A n_sheets ~A matlpoint ~A name ~A family ~A~%"
          (<object>-tag      solid)
          (<solid>-n-lumps   solid)
          (<solid>-n-sheets  solid)
          (<solid>-matlpoint solid)
          (<obj>-name        solid)
	  (<ent>-family      solid)))

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

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defmethod print-object ((bspline <bspline>) s)
  (format s "~A~%" (<object>-tag bspline))
  (format s "~A,~A,~A~%"
          (<bspline>-n bspline)
          (<bspline>-k bspline)
          (<bspline>-i bspline))
  (print-vector (<bspline>-knots bspline) 5 s))

