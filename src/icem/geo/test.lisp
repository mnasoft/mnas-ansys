;;;; ./src/icem/geometry-test.lisp

(in-package #:ic/geo)

(ic_geo_create_unstruct_curve_from_points
 "curve"
 "FAM/TOOL"
 '((1.0 0.0 0.0) (1.0 1.0 0.0) (-1.0 0.0 0.0)))

(ic_geo_cre_pnt "FAM/COOL" "pnt" '(50 50 50))

(ic_geo_cre_srf_cyl "family" "name"
                    '(100.0 100.0 50.0)
                    '(1.0 1.0 0.0) '(1.0 0.0 1.0) 100 0.0 180.0 800.0)

(cre-mat "fam" "name" '(400.0 100.0 50.0)) 

(ic_geo_cre_line "FAM/SOOL" "line" '(0.0 0.0 0.0) '(50 80 140))

(ic_geo_cre_arc_from_pnts "FAM/COOL" "arc"
                          '(100.0 0.0 0.0)
                          '(0.0 100.0 0.0)
                          '(-100.0 0.0 0.0))
