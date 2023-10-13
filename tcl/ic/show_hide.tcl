# source d:/home/_namatv/PRG/msys64/home/namatv/quicklisp/local-projects/ANSYS/mnas-ansys/tcl/ic/fv.tcl

package provide mnas_icem_utils 1.0

# Включает видимость для поверхностей с
# гидравлическим диаметром в диапазоне (min max].
proc vis {{min 0.0} {max 2.0}} {
    foreach family [parts surface] {
        set size [part_key_value $family]
        if { [expr $min < $size && $size <= $max ] } then {
            ic_visible family $family 1 } } }

# Выключает видимость для поверхностей с
# гидравлическим диаметром в диапазоне (min max].
proc hid {{min 0.0} {max 2.0}} {
    foreach family [parts surface] {
        set size [part_key_value $family]
        if {[expr $min < $size && $size <= $max ]} then {
            ic_visible family $family 0 } } }

# Включает видимость объектов по типу.
proc show {types} {
    foreach type $types {
        foreach part [parts $type] {
            ic_geo_update_visibility $type $part 1 } } }

# Выключает видимость объектов по типу.  В качестве типов могут
# выступать: surface, curve, point, material, density, loop, body.
proc hide {types} {
    foreach type $types {
        foreach part [parts $type] {
            ic_geo_update_visibility $type $part 0 } } }

# Выключает видимость геометрических объектов
proc hide_objects {part} {
    foreach type {surface curve point material density loop body} {
        if { [ic_geo_is_loaded] } then {
            if { [ic_geo_num_objects all] } then {
                ic_geo_update_visibility $type TAN 0
                mess "FOOOL $type\n" } } } }
