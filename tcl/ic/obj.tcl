#source d:/home/_namatv/PRG/msys64/home/namatv/quicklisp/local-projects/ANSYS/mnas-ansys/tcl/ic/obj.tcl

proc obj_num {{types {point curve surface}}} {
    # Возвращает количество общее объектов определенного типа.
    set x {}
    foreach type $types {
        lappend x [list $type [llength [ic_geo_get_objects $type]]]
    }
    return $x
}

proc obj_num_part {{types {point curve surface}} {part TAN}} {
    # Возвращает количество общее объектов определенного типа,
    # содержащихся в части TAN.
    set x {}
    foreach type $types {
        lappend x [list $type [llength [ic_geo_get_objects $type $part]]]
    }
    return $x
}
