# source d:/home/_namatv/PRG/msys64/home/namatv/quicklisp/local-projects/ANSYS/mnas-ansys/src/rpl/load_all.tcl

proc load_all {} {
    set directiry d:/home/_namatv/PRG/msys64/home/namatv/quicklisp/local-projects/ANSYS/mnas-ansys/src/rpl/
    set extension *.tcl
    foreach file [glob  -nocomplain -type f $directiry$extension] {
        source $file
    }
}

proc obj_num {{types {point curve surface}}} {
    set x {}
    foreach type $types {
        lappend x [list $type [llength [ic_geo_get_objects $type]]]
    }
    return $x
}

proc obj_num_part {{types {point curve surface}} {part TAN}} {
    set x {}
    foreach type $types {
        lappend x [list $type [llength [ic_geo_get_objects $type $part]]]
    }
    return $x
}
