;;;; ./src/ic/ic.lisp

(defpackage :mnas-ansys/ic
  (:use #:cl)
  (:export point
           curve-point)
  (:documentation
   " Пакет предназначен для создания геометрии через API системы ANSYS ICEM CFD."))

(in-package :mnas-ansys/ic)

(defun point (fam name point)
  (format
   t
   "ic_point {} ~A ~A ~{~F~^,~}; " fam name point))

(defun curve-point (fam name point-names)
  (format
   t
   "ic_curve point ~A ~A {~{~F~^ ~}}; " fam name point-names))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(progn
  (point "GEOM" "pnt.01" '( 0  0  0))
  (point "GEOM" "pnt.02" '( 0 10  0))
  (point "GEOM" "pnt.03" '(20 10  0))
  (point "GEOM" "pnt.04" '(20  0  0))
  (point "GEOM" "pnt.05" '(20  5  0))
  (point "GEOM" "pnt.06" '(30  5  0))
  (point "GEOM" "pnt.07" '(30  0  0))
  (point "GEOM" "pnt.08" '(30 30  0))
  (point "GEOM" "pnt.09" '(60 30  0))
  (point "GEOM" "pnt.10" '(60  0  0))
  
  (curve-point "GEOM" "crv.01" '("pnt.01" "pnt.02"))
  (curve-point "GEOM" "crv.02" '("pnt.02" "pnt.03"))
  (curve-point "GEOM" "crv.03" '("pnt.05" "pnt.03"))
  (curve-point "GEOM" "crv.04" '("pnt.05" "pnt.06"))
  (curve-point "GEOM" "crv.05" '("pnt.06" "pnt.07"))  
  (curve-point "GEOM" "crv.06" '("pnt.06" "pnt.08"))
  (curve-point "GEOM" "crv.07" '("pnt.08" "pnt.09"))
  (curve-point "GEOM" "crv.08" '("pnt.09" "pnt.10"))

  (geo:cre-srf-rev "GEOM" "srf.01"
                   (loop :for i :from 1 :to 8 :collect (format nil "crv.~2,'0D" i))
                   "pnt.01"
                   '(1 0 0) 0 360)

  (geo:set-part "surface" '("srf.01") "IN" 0)
  (geo:set-part "surface" '("srf.01.7") "OUT" 0)

  (geo:set-part "surface"
                '("srf.01.1"
                  "srf.01.2"
                  "srf.01.3"
                  "srf.01.5"
                  "srf.01.6")
                "WALL"
                0
                )
  (geo:set-part "surface" '("srf.01.5") "INT" 0)
  
  (format t "~%~%")
  )
