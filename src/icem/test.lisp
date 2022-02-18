(in-package #:mnas-ansys/icem/geometry)

(ic_trans_tetin_step "D:/home/_namatv/CFX/test/test_01.tin"
                     "D:/home/_namatv/CFX/test/test_01.step")

(ic_trans_ddn_dxf  "D:/home/_namatv/CFX/test/test_01.tin" "D:/home/_namatv/CFX/test/test_01.dxf")

(ic_geo_cre_line "P1" "line" '(0.0 0.0 0.0) '(10.0 10. 0.0))

(ic_geo_cre_pnt "P1" "pnt" '(10.0 10.0 0.0))

(ic_geo_cre_arc_from_pnts "P1" "arc" '(0.0 0.0 0.0) '(5.0 3.0 0.0) '(10.0 10.0 0.0))

(ic_geo_cre_crv_arc_ctr_rad "P1" "arc" '(5 5 0) '(1 0 0) '(0 0 1) 20.0 10 50)

(ic_geo_cre_crv_ell "P1" "ell" '(10.0 20.0 0.0) '(20.0 20.0 0.0) '(10.0 25.0 0.0))

(ic_geo_create_curve_ends '("line" "ell"))

