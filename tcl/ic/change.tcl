# source d:/home/_namatv/PRG/msys64/home/namatv/quicklisp/local-projects/ANSYS/mnas-ansys/tcl/ic/change.tcl
mess "source change.tcl START... \n"

package provide mnas_icem_utils 1.0

# Перемещает точки и кривые сопряженные со всеми поверхностями,
# находящимися в семействе part в это семейство.
proc ch_part {part} {
  set surfaces [ic_geo_get_objects surface $part]
  foreach curve [ic_geo_boundary surface $surfaces 0 0 1] {
    ic_geo_set_part curve $curve $part 0
    foreach point [ic_geo_boundary curve $curve 0 0 1] {
      ic_geo_set_part point $point $part 0 } } }

# Перемещает точки и кривые сопряженные со всеми поверхностями,
#  в соответствующие им семейства.
proc ch_all {} {
    set surfaces [ic_geo_get_objects surface]
    foreach surface $surfaces {
        set part [ic_geo_get_family surface $surface]
        foreach curve [ic_geo_boundary surface $surface 0 0 1] {
            ic_geo_set_part curve $curve $part 0
            foreach point [ic_geo_boundary curve $curve 0 0 1] {
                ic_geo_set_part point $point $part 0 } } } }

# Перемещает точки и кривые сопряженные с видимыми поверхностями,
# в соответствующие им семейства.
proc ch_vis {} {
    set surfaces [ic_geo_list_visible_objects surface]
    foreach surface $surfaces {
        set part [ic_geo_get_family surface $surface]
        foreach curve [ic_geo_boundary surface $surface 0 0 1] {
            ic_geo_set_part curve $curve $part 0
            foreach point [ic_geo_boundary curve $curve 0 0 1] {
                ic_geo_set_part point $point $part 0 } } } }

####################################################################################################

# Удаляет последний элемент из списка.
proc remove_last {mylist} {
    set len [llength $mylist]
    incr len -1
    return [lreplace $mylist $len $len]
}

# Удаляет последний элемент из списка.
proc remove_first {mylist} {
    return [lreplace $mylist 0 0] }

# Возвращает его базовое имя, то что находится права
# от превого слева разделителя "/".
proc base_name {part} {
    set x [split $part {/}]
    return [lindex  $x [expr [llength $x] - 1 ] ]
}

# Возвращает для семейтва part путь к его родителю.
proc path_name {part} {
    return [join [remove_last [split $part {/}]] {/}] }

# Вспомогательная функция для ch_tan перемещает кривые в семейтсво
# TAN.
proc ch_tan_curve {curve} {
    set x {}
    foreach surface [ic_geo_incident curve $curve 0] {
        lappend x [path_name [ic_geo_get_family surface $surface]]
    }
    if { [expr [llength [lsort -unique $x]] == 1] } {
        ic_geo_set_part curve $curve TAN 0 } }

# Вспомогательная функция для ch_tan перемещает точки в семейтсво TAN.
proc ch_tan_point {point} {
    set x {}
    foreach curve [ic_geo_incident point $point] {
        set family [ic_geo_get_family curve $curve]
        if {[string compare $family TAN] != 0} {
            lappend x $family } }
    if { [expr [llength $x] <= 2]} {
        return [ic_geo_set_part point $point TAN 0] } }

proc ch_tan {} {
    # Перемещает кривые, разграничивающие касательные поверхности, и
    # точки инциндентные с этими кривыми в семейтво TAN.
    foreach curve [ic_geo_get_objects curve] {
        ch_tan_curve $curve 
    }
    foreach point [ic_geo_get_objects point] {
        ch_tan_point $point } }

####################################################################################################

proc part_key_value {part {key D}} {
    set x [base_name $part]
    set d [value_key $key [lreverse [split $x {_}]]]
    return $d }

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

mess "source change.tcl FINISH. \n"
