# source d:/home/_namatv/PRG/msys64/home/namatv/quicklisp/local-projects/ANSYS/mnas-ansys/src/rpl/change.tcl

proc ch_part {part} {
    # Перемещает точки и кривые сопряженные со всеми поверхностями,
    # находящимися в семействе part в это семейство.
  set surfaces [ic_geo_get_objects surface $part]
  foreach curve [ic_geo_boundary surface $surfaces 0 0 1] {
    ic_geo_set_part curve $curve $part 0
    foreach point [ic_geo_boundary curve $curve 0 0 1] {
      ic_geo_set_part point $point $part 0 } } }

proc ch_all {} {
    # Перемещает точки и кривые сопряженные со всеми поверхностями,
    #  в соответствующие им семейства.
    set surfaces [ic_geo_get_objects surface]
    foreach surface $surfaces {
        set part [ic_geo_get_family surface $surface]
        foreach curve [ic_geo_boundary surface $surface 0 0 1] {
            ic_geo_set_part curve $curve $part 0
            foreach point [ic_geo_boundary curve $curve 0 0 1] {
                ic_geo_set_part point $point $part 0 } } } }

proc ch_vis {} {
    # Перемещает точки и кривые сопряженные с видимыми поверхностями,
    # в соответствующие им семейства.
    set surfaces [ic_geo_list_visible_objects surface]
    foreach surface $surfaces {
        set part [ic_geo_get_family surface $surface]
        foreach curve [ic_geo_boundary surface $surface 0 0 1] {
            ic_geo_set_part curve $curve $part 0
            foreach point [ic_geo_boundary curve $curve 0 0 1] {
                ic_geo_set_part point $point $part 0 } } } }

####################################################################################################

proc remove_last {mylist} {
    # Удаляет последний элемент из списка.
    set newlist {}
    for {set i 0} {$i < [llength $mylist] - 1 } {incr i} {
        lappend newlist [lindex $mylist $i] }
    return $newlist
}

proc base_name {part} {
    # Возвращает его базовое имя, то что находится права
    # от превого слева разделителя "/".
    set x [split $part {/}]
    return [lindex  $x [expr [llength $x] - 1 ] ]
}

proc path_name {part} {
    # Возвращает для семейтва part путь к его родителю.
    return [join [remove_last [split $part {/}]] {/}]
}

proc ch_tan_curve {curve} {
    # Вспомогательная функция для ch_tan перемещает кривые в семейтсво TAN.
    set x {}
    foreach surface [ic_geo_incident curve $curve 0] {
        lappend x [path_name [ic_geo_get_family surface $surface]]
    }
    if { [expr [llength [lsort -unique $x]] == 1] } {
    ic_geo_set_part curve $curve TAN 0 
    }
}

proc ch_tan_point {point} {
    # Вспомогательная функция для ch_tan перемещает точки в семейтсво TAN.
    set x {}
    foreach curve [ic_geo_incident point $point] {
        set family [ic_geo_get_family curve $curve]
        if {[string compare $family TAN] != 0} {
            lappend x $family
        }
    }
    if { [expr [llength $x] <= 2]} {
        return [ic_geo_set_part point $point TAN 0]
    }
}

proc ch_tan {} {
    # Перемещает кривые, разграничивающие касательные поверхности, и
    # точки инциндентные с этими кривыми в семейтво TAN.
    foreach curve [ic_geo_get_objects curve] {
        ch_tan_curve $curve 
    }
    foreach point [ic_geo_get_objects point] {
        ch_tan_point $point
    }
}

####################################################################################################

proc part_key_value {part {key D}} {
    set x [base_name $part]
    set d [value_key $key [lreverse [split $x {_}]]]
    return $d
}

proc sort_by_size {} {
    set x {}
    foreach part [parts surface] {
        lappend x [list [part_key_value $part] $part]
    }
    return [lsort -increasing -real -index 0 $x]
}

# value_key
# base_name DG4/M0/GU/G2/07/05_D_08.000
# foo DG4/M0/GU/G2/07/05_D_08.000
