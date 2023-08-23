# source d:/home/_namatv/PRG/msys64/home/namatv/quicklisp/local-projects/ANSYS/mnas-ansys/src/rpl/delete_family.tcl

proc del_part {part} {
    ic_undo_group_begin
    ic_start_bigunsop
    ic_delete_elements family $part no_undo 1
    ic_delete_geometry all families $part 1 1
    ic_geo_delete_family $part
    ic_finish_bigunsop 
    ic_undo_group_end
}

proc parts {types} {
    set x {}
    foreach type $types {
        foreach object [ic_geo_get_objects $type] {
            lappend x [ic_geo_get_family $type $object]
        }
    }
    return [lsort -unique $x]
}

# append [parts surface] [parts curve] [parts point]

proc del_asm {assembles} {
    foreach assembly $assembles {
        foreach part [parts {body point curve surface}] {
            if {[regexp $assembly $part]} then {
                del_part $part
            }
        }
    }
}

