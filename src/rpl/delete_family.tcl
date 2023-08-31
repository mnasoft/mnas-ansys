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
    # Возвращает список семейств, в которых
    # присутствуют бъекты типов types.
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

# ic_geo_list_families
# ic_geo_family_is_empty

# ic_geo_family_is_empty DG1/B1/AIR_RL_OUT/N2/D_05.000


# clear_all

proc all_parents {part} {
    set x {}
    set p $part
    while { $p != {} } {
        lappend x $p    
        set p [path_name $p]
    }
    return $x
}

proc not_empty_parts {} {
    # Возвращает непустые семейства.
    set not_empty {}
    foreach  family [ic_geo_list_families] {
        if {[ic_geo_family_is_empty $family] == 0} then {
            lappend not_empty $family
        }
    }
    return $not_empty
}

proc not_empty_parents {} {
    # Возвращает непустые семейства и их родителей.
    set x {}
    foreach fam [not_empty_parts]  {
        foreach fam [all_parents $fam] {
            lappend x $fam
        }
    }
    return [lsort -unique $x]
}

proc empty_parents {} {
    # Возвращает пустые семейства и их родителей.
    set x {}
    set not_empty_parents [not_empty_parents]
    foreach  family [ic_geo_list_families] {
        if {[lsearch -exact $not_empty_parents $family] == -1} then {
            lappend x $family
        }
    }
    return [lsort -unique $x]
}

proc clear_all {} {
    # Удаляет все неиспользуемае семейства и их предков. 
    foreach family [empty_parents] {
        ic_geo_delete_family $family
    }
}
