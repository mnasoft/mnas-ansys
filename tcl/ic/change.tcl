# source d:/home/_namatv/PRG/msys64/home/namatv/quicklisp/local-projects/ANSYS/mnas-ansys/tcl/ic/change.tcl

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
    set n [llength $surfaces]
    mess "Moving point and curve for $n surfaces ... "
    foreach surface $surfaces {
        set part [ic_geo_get_family surface $surface]
        foreach curve [ic_geo_boundary surface $surface 0 0 1] {
            ic_geo_set_part curve $curve $part 0
            foreach point [ic_geo_boundary curve $curve 0 0 1] {
                ic_geo_set_part point $point $part 0 } } }
    mess "DONE.\n"}

# Перемещает точки и кривые сопряженные с видимыми поверхностями,
# в соответствующие им семейства.
proc ch_vis {} {
    set surfaces [ic_geo_list_visible_objects surface]
    set n [llength $surfaces]
    mess "Moving point and curve for $n surfaces ... "
    foreach surface $surfaces {
        set part [ic_geo_get_family surface $surface]
        foreach curve [ic_geo_boundary surface $surface 0 0 1] {
            ic_geo_set_part curve $curve $part 0
            foreach point [ic_geo_boundary curve $curve 0 0 1] {
                ic_geo_set_part point $point $part 0 } } }
    mess "DONE.\n"}

# Переносит кривую в часть, для которой параметер emax, определяющий
# максимальный рармер, является минимальным ненулевым, причем кривая
# должна быть сопряжена с поверхностью, принадлежащю этой части.
proc ch_curve {curve} {
    set surfaces [ic_geo_incident curve $curve]
    set parts {}
    set emaxes {}
    set parts_emaxes {}
    foreach surface $surfaces {
        set part [ic_geo_get_family surface $surface]
        lappend parts $part
        set emax [ic_geo_get_family_param $part emax]
        lappend emaxes $emax
        lappend parts_emaxes $part $emax}
    set i -1
    foreach {part emax} $parts_emaxes {
        if { [incr i] == 0 } then {
            ic_geo_set_part curve $curve $part 0
            set c_emax $emax 
        } else {
            if { [expr { [expr { $c_emax == 0.0 } ] && [expr { $emax != 0 } ] } ] } then {
                ic_geo_set_part curve $curve $part 0
                set c_emax $emax 
            } else {
                if { [expr { $emax != 0.0 } ] && [expr { $emax < $c_emax } ] } {
                    ic_geo_set_part curve $curve $part 0
                    set c_emax $emax } } } }
    return $parts_emaxes }

# Выполняет функцию ch_curve для всех кривых проекта.
proc ch_curves {} {
    set curves [ic_geo_get_objects curve]
    mess "ch_curves - moving [llength $curves] curves to apropriate parts ... "
    foreach curve $curves {
        ch_curve $curve }
    mess "DONE. \n"}

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
        lappend x [path_name [ic_geo_get_family surface $surface]] }
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

# Перемещает кривые, разграничивающие касательные поверхности, и
# точки инциндентные с этими кривыми в семейтво TAN.
proc ch_tan {} {
    foreach curve [ic_geo_get_objects curve] {
        ch_tan_curve $curve }
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
