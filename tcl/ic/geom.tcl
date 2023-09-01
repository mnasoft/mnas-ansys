# source d:/home/_namatv/PRG/msys64/home/namatv/quicklisp/local-projects/ANSYS/mnas-ansys/tcl/ic/geom.tcl

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

