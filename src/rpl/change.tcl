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
    set newlist {}
    for {set i 0} {$i < [llength $mylist] - 1 } {incr i} {
        lappend newlist [lindex $mylist $i] }
    return $newlist
}

proc part_path {part} {
    return [join [remove_last [split $part {/}]] {/}]
}

proc ch_tan_curve {curve} {
    set x {}
    foreach surface [ic_geo_incident curve $curve 0] {
        lappend x [part_path [ic_geo_get_family surface $surface]]
    }
    if { [expr [llength [lsort -unique $x]] == 1] } {
    ic_geo_set_part curve $curve TAN 0 
    }
}

proc ch_tan_point {point} {
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
    foreach curve [ic_geo_get_objects curve] {
        ch_tan_curve $curve 
    }
    foreach point [ic_geo_get_objects point] {
        ch_tan_point $point
    }
}

####################################################################################################

