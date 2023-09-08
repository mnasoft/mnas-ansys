# source d:/home/_namatv/PRG/msys64/home/namatv/quicklisp/local-projects/ANSYS/mnas-ansys/tcl/ic/mesh_curve.tcl

proc key_value {key list {default 0.0}} {
    # Возвращает из списка list значение,
    # следующее за ключом key.
    set index [lsearch -glob $list $key]
    if { $index != -1} then {
        return [lindex $list [expr $index+1]]
    } else {
        return $default }}

proc value_key {key list {default 0.0}} {
    # Возвращает из списка list значение,
    # предваряющее ключ key.
    set index [lsearch -glob $list $key]
    if { $index > 0} then {
        return [lindex $list [expr $index-1]]
    } else {
        return $default }}

proc curve_length {curve} {
    # Возвращает параметр emax - размер тетраэдрической ячейки для
    # кривой curve по размеру: - меньшему из ненулевых размеров
    # инциндентных поверхностей; - или нуль если у всех инциндентных
    # кривых размер тетры нулевой.
    set x {}
    foreach surface [ic_geo_incident curve $curve] {
        set surface_length [key_value emax [ic_get_meshing_params surface $surface]]
        if {[expr $surface_length > 0]} then {
            lappend x $surface_length } }
    if {[expr [llength $x] == 0] } then {
        return 0 } else {
        return [lindex [lsort -increasing -real $x] 0] }}

proc curve_mesh_params {curve {emax_scale 1.0}} {
    ic_set_meshing_params curve $curve \
        emax [expr [curve_length $curve] * $emax_scale] \
        emin 0 \
        ehgt 0 \
        edev 0 \
        hrat 0 \
        ewid 0 \
        nlay 0
    return [ic_get_meshing_params curve $curve] }

proc curves_mesh_params {{emax_scale 1.0}} {
    # Устанавливает максимальный размер
    # тетраэдрической ячееки для кривой.
    foreach curve [ic_geo_get_objects curve] {
        curve_mesh_params $curve $emax_scale }} 
