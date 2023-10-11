# source d:/home/_namatv/PRG/msys64/home/namatv/quicklisp/local-projects/ANSYS/mnas-ansys/tcl/ic/geom.tcl
mess "source geom.tcl START... \n"

# ic_point {} GEOM pnt.02 {-0.407799278471 0.112614026691 0}

proc mk_line {name points {part GEOM}} {
    ic_curve point $part $name $points
}

proc mk_line_1 {name point1 point2 {part GEOM}} {
    return [ic_curve point $part $name [list $point1 $point2]]
}

# mk_line crv {{0 0 0} {10 10 10}}

proc mk_pline {name points {part GEOM}} {
    set lines {}
    for {set x 1} {$x<[llength $points]} {incr x} {
        lappend lines [mk_line_1 $name [lindex $points [expr $x - 1]] [lindex $points $x] $part]
    }
    return $lines
}

# mk_pline pl {{0 0 0} {10 0 0} {10 10 0} {0 10 0} {0 0 0}} 


mess "source geom.tcl FINISH. \n"


1. ic_geo_is_loaded 
2. ic_geo_num_visible_objects body
3. ic_highlight 
4. ic_image delete preview
5. ic_highlight 
6. ic_image delete preview
7. ic_show_geo_selected body DG3/G3.1.0.0 1
8. ic_highlight 
9. ic_image delete preview
10. ic_geo_get_part body DG3/G3.1.0.0
11. ic_geo_body_lower_entities DG3/G3.1.0.0
12. ic_geo_get_body_location DG3/G3.1.0.0
13. ic_csystem_get_current 
14. ic_geo_get_body_matlpnt DG3/G3.1.0.0
15. ic_reset_geo_selected 
16. ic_highlight body DG3/G3.1.0.0
17. ic_geo_get_types DG3/G3.1.0.0


ic_geo_get_body_location [geo_select body]
ic_geo_create_volume {-303.15242 351 0} {} DG3/G3


