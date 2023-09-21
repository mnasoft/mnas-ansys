# source d:/home/_namatv/PRG/msys64/home/namatv/quicklisp/local-projects/ANSYS/mnas-ansys/tcl/ic/mesh_setup.tcl

proc msh_per {{angle 0} {axis {1 0 0}} {base {0 0 0}}} {
    # Задает периодисность
    if {$angle == 0} {
        ic_undo_group_begin
        ic_coords_dir_into_global {1 0 0} global
        ic_geo_set_periodic_data {axis {1 0 0} type none angle 36 base {0 0 0}}
        ic_undo_group_end
    } else {
        set data {}
        lappend data axis $axis type rot angle $angle base $base
        ic_undo_group_begin
        ic_coords_dir_into_global {1 0 0} global
        ic_geo_set_periodic_data $data
        ic_undo_group_end
    }
    return $angle 
}

proc msh_par {{gmax 6}} {
    # Задает глоальные параметры сетки
    set gref 1
#    set gmax 2
    set gnat 0
    set gnatref 10
    set gedgec 0.2
    set gcgap 1
    set gttol 0.001
    set gfast 0
    set igwall 0
    set gtrel 1
    set grat 1.5
    ic_set_meshing_params global 0 gref $gref gmax $gmax gnat $gnat gnatref $gnatref gedgec $gedgec gcgap $gcgap gttol $gttol gfast $gfast igwall $igwall gtrel $gtrel grat $grat
}

proc fam_scale {part} {
    set x [split $part {/_}]
    set len [llength $x]
    if {[string compare D [lindex $x [expr $len - 2 ]]] == 0} then {
        return [lindex $x [expr $len - 1 ]] } else {
            return 0 } }

proc msh_fam {part {d_scale 0.25} {erat 0.0}} {
    ic_geo_set_family_params $part \
        no_crv_inf \
        prism 0 \
        emax [expr $d_scale * [fam_scale $part]] \
        ehgt 0.0 \
        hrat 0 \
        nlay 0 \
        erat $erat \
        ewid 0 \
        emin 0.0 \
        edev 0.0 \
        split_wall 0 \
        internal_wall 0 }

proc msh_prt {{d_scale 0.25} {tetra_size_ratio 0.0}} {
    # Устанавливает для всех семейств размер в соответствии с именем
    # семейства, в котором зашифрован гидравлический диаметр.
    # Размер для семейства определяется по формуле S=d_scale * D,
    # где:
    #      D - гидравлический диаметр;
    #      d_scale - коэффициент маштабирования гидравлического диаметра.
    foreach part [parts surface] {
        msh_fam $part $d_scale $tetra_size_ratio } }

####################################################################################################

proc get_array_value_if_index_exist {arrName index} {
    # Возвращает значение, связанное с индексом массава, если индекс
    # есть в перечне индексов. Если индекс отвутствует возвращается
    # пустой список.
    upvar $arrName arr
    if { [lsearch -exact [array names arr] $index] != -1 } {
        return $arr($index) 
    } else {
        return {}
    }
}

proc split_basename {name} {
    return [lreverse [split $name _]]}

proc part_name_prop {name} {
    set rez {}
    foreach {val name} [split_basename $name] {
        if { $name != {} } {
            lappend rez $name
            lappend rez $val } }
    return $rez }

proc make_name {name} {
    global ob_name ob_value ob_list
    set props $name
    array set arr $props
    set x {}
    foreach index $ob_list {
        set name $ob_name($index)
        if { [get_array_value_if_index_exist arr $name] != {} } {
            lappend x $name
            lappend x $arr($name) } }
    return $x }

proc msh_prt_new {{params {dhir 00.000 scale 1.0}}} {
    global ob_name ob_value arr
     foreach {name val} $params {
         set arr($ob_name($name)) $val
     }
}

proc remove_last {mylist} {
    # Удаляет последний элемент из списка.
    set newlist {}
    for {set i 0} {$i < [llength $mylist] - 1 } {incr i} {
        lappend newlist [lindex $mylist $i] }
    return $newlist
}

####################################################################################################

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

#set surfaces [ic_geo_list_visible_objects surface]

#foreach surface $surfaces {
#    set part [ic_geo_get_family surface $surface]
#    set newpart [join [lreplace [split $part {/}] 0 0 DG$dom_suffix] {/}]
#    lappend x $newpart
#    ic_geo_set_part surface $surface $newpart 0
#}
