# source d:/home/_namatv/PRG/msys64/home/namatv/quicklisp/local-projects/ANSYS/mnas-ansys/tcl/ic/mesh_curve.tcl
mess "source mesh_curve.tcl START... \n"

package provide mnas_icem_utils 1.0

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

proc topo {} {
    ic_undo_group_begin
    ic_geo_delete_unattached [ic_geo_non_empty_families] 0 1
    ic_build_topo 0.05 -angle 30 [ic_geo_non_empty_families]
    ic_geo_delete_unattached [ic_geo_non_empty_families]
    ic_undo_group_end }

proc msh {size {angle 0} {d_scale 0.25} {tetra_size_ratio 0.0}} {
    ch_all;   # Перенос кривых в семейства ицидентных с ними поверхностей
    clear_all;                     # Очистка неиспользуемые семейств    
    ch_tan;                
    
    # Настройка параметров сетки. Начало    
    msh_per $angle;                # С периодичностью
    msh_par $size;                 # Максимальный размер  
    msh_prt $d_scale $tetra_size_ratio; # Настройка размеров для семейств    
    # Настройка параметров сетки. Конец
    curves_mesh_params;            # Устанавливаем параметры для кривых
    # Настройка размеров для семейств. Повтор, но он нужен
    msh_prt $d_scale $tetra_size_ratio; 
}

mess "source mesh_curve.tcl FINISH. \n"
