# source d:/home/_namatv/PRG/msys64/home/namatv/quicklisp/local-projects/ANSYS/mnas-ansys/src/rpl/fv.tcl

proc vis {{min 0.0} {max 2.0}} {
    # Включает видимость для поверхностей с
    # гидравлическим диаметром в диапазоне (min max].
    foreach family [parts surface] {
        set size [part_key_value $family]
        if { [expr $min < $size && $size <= $max ] } then {
            ic_visible family $family 1
        }
    }
}

proc hid {{min 0.0} {max 2.0}} {
    # Выключает видимость для поверхностей с
    # гидравлическим диаметром в диапазоне (min max].
    foreach family [parts surface] {
        set size [part_key_value $family]
        if {[expr $min < $size && $size <= $max ]} then {
            ic_visible family $family 0
        }
    }
}
