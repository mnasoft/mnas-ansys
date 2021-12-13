(in-package #:mnas-ansys)

;; (defparameter *tin-file* "~/quicklisp/local-projects/ANSYS/mnas-ansys/tin/a32_GT-13.tin")
(defparameter *tin-file* "Z:/CFX/otd11/namatv/a32_base/PR-01/GT/a32_GT-15.tin")

(defparameter *tin* (open-tin-file *tin-file*))

(<tin>-families *tin*)
(<curve>-surfaces (first (tin-curves *tin*)))

(length
 (mnas-ansys/select:entities-by-families
  '(;; "GT_P15_STUB"
    "GT_P15_OUTER"
    )
  (<tin>-curves *tin*)))

(length (<tin>-curves *tin*))


(find-if
 #'(lambda (el)
     )
 )

(mnas-ansys/select:curves-by-families '("GT_P15_STUB") *tin*)

("GT_P15_STUB" "GT_P15_OUTER")
find-coincidense

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defparameter *parts* '("GT_P15_OUTER" "GT_P15_HOLES"))

(progn
  (defparameter *tin* (open-tin-file *tin-file*))
  (format t "~{~A~^ ~}" (curve-names-coeged-with-surface-in-family *parts* *tin*)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(<curve>-vertex1 (find-curve-by-name "E_1516615" *tin*))
(<curve>-vertex2 (find-curve-by-name "E_1516615" *tin*))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;; point

#|
;;"prescribed_point 44.900051116943 455.9228515625 -53.078517913818 family GEOM name TMP_TOPO_PART_NAME.1049876"
(<obj>-name (make-instance '<point>))
(elt *lines* 25)
(read-object *lines* 26 (make-instance '<point>))
|#

;;;; <family>

#| (read-object *lines* 16 (make-instance '<family>)) |#

#|
;;;; define_family ASM.02/P02 color 13675571
(make-instance '<family>)
|#


;;;; curve

#|
;; define_curve family ASM.02/P02_E_C tetra_size 1e+10 name E_1047322 vertex1 V_1047367 vertex2 V_1047364
(<obj>-name (make-instance '<curve>))
(read-object *lines* 626 (make-instance '<curve>))
(elt *lines* 626)
(position-if #'(lambda (el) (find el '("define_curve") :test #'string=))
	     *lines*
	     :start 627
	     :key (lambda (el) (first (mnas-string:split " " el))))
|#

;;;; <material-point>

;;;; coedge

#|

*coedge*
(read-object *lines* 18579 *coedge*)coedge 3dcurve   F_1048270e1325.3
(elt *lines* 18579)                "coedge 3dcurve   F_1048270e1325.3"
|#


;;;; surface

#|
*surface*
(read-object *lines* 18576 *surface*)
|#

;;(make-instance '<solid> :matlpoint "B.G-A.1.1" :name "B.G-A.1.0" :family "B.G-A.1")

;;;; define_solid body n_lumps 0 n_sheets 0 matlpoint B.G-A.1.1 name B.G-A.1.0 family B.G-A.1

;;;; tin

#|

(read-object *lines* 0 *tin*)
|#

#|
(curve-names-coeged-with-surface-in-family '("ASM.02/P02" "ASM.02/P02_H_S") *tin*)
|#

;;;(remove-method #'surface-names-coeged-with-surface-in-family (first (sb-mop:generic-function-methods #'surface-names-coeged-with-surface-in-family)))

(multiple-value-bind `(a b c)
    (values 1 2 3)
  c)
