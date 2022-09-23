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

"
ic_undo_group_begin 
ic_geo_set_family_params INLET/D_08.000 no_crv_inf prism 0 emax 1.5 ehgt 0.0 hrat 0 nlay 0 erat 0 ewid 12 emin 0.0 edev 0.0 split_wall 0 internal_wall 0
ic_undo_group_end 
ic_geo_params_blank_done part 1

ic_undo_group_begin 
ic_set_meshing_params global 0 gref 1.0 gmax 17.0 gfast 0 gedgec 0.2 gnat 0 gcgap 1 gnatref 10
ic_undo_group_end 
"

"
1. ic_undo_group_begin 
2. ic_set_meshing_params global 0 gref 1.0 gmax 16.0 gfast 0 gedgec 0.2 gnat 0 gcgap 1 gnatref 10
3. ic_undo_group_end 
4. ic_undo_group_begin 
5. ic_geo_set_family_params B/AIR_RL_OUT/N2/D_10.000 no_crv_inf prism 0 emax 2.0 ehgt 0.0 hrat 0 nlay 0 erat 1.5 ewid 0 emin 0.0 edev 0.0 split_wall 0 internal_wall 0
6. ic_undo_group_end 
7. ic_geo_params_blank_done part 1

"
