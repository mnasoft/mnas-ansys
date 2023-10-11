# source d:/home/_namatv/PRG/msys64/home/namatv/quicklisp/local-projects/ANSYS/mnas-ansys/tcl/ic/fv.tcl

package provide mnas_icem_utils 1.0

proc vis {{min 0.0} {max 2.0}} {
    # Включает видимость для поверхностей с
    # гидравлическим диаметром в диапазоне (min max].
    foreach family [parts surface] {
        set size [part_key_value $family]
        if { [expr $min < $size && $size <= $max ] } then {
            ic_visible family $family 1 }}}

proc hid {{min 0.0} {max 2.0}} {
    # Выключает видимость для поверхностей с
    # гидравлическим диаметром в диапазоне (min max].
    foreach family [parts surface] {
        set size [part_key_value $family]
        if {[expr $min < $size && $size <= $max ]} then {
            ic_visible family $family 0 }}}

proc show {types} {
    foreach type $types {
        foreach part [parts $type] {
            ic_geo_update_visibility $type $part 1 }}}

proc hide {types} {
    foreach type $types {
        foreach part [parts $type] {
            ic_geo_update_visibility $type $part 0 }}}
