# source d:/home/_namatv/PRG/msys64/home/namatv/quicklisp/local-projects/ANSYS/mnas-ansys/tcl/ic/dia/dlg_msh.tcl

# Глобальная переменная dlg_msh_param_data содержит записи,
# характеризующие параметры сетки и данные для настройки
# диалога. Каждая запись состоит из:
# 1. ключа, используемого в качестве метки;
# 2. обозначения параметра в имени;
# 3. значения по умолчанию;
# 4. типа содержимого окна редактирования (entry);
# 5. координаты расположения метки (label);
# 6. расположения entry.
set dlg_msh_param_data {
    d_hid          D   0.0 float     {0 0}  {0 1}
    scale          S   0.0 float     {1 0}  {1 1}
    emax           MS  0.0 float     {2 0}  {2 1}
    ehgt           H   0.0 float     {3 0}  {3 1}
    hrat           HR  0.0 float     {4 0}  {4 1}
    nlay           NL  0   int_blank {5 0}  {5 1}
    erat           TSR 0.0 float     {6 0}  {6 1}
    ewid           TW  0.0 float     {7 0}  {7 1}
    emin           MSL 0.0 float     {8 0}  {8 1}
    edev           MD  0.0 float     {9 0}  {9 1}
    split_wall     SW  0   int_blank {10 0} {10 1}
    internal_wall  IW  0   int_blank {11 0} {11 1}
}

# Глобальная переменная ob_name содержит массив, у которого:

# - ключами являются ключи из записей, находящихся в
# dlg_msh_param_data;
# - значениями являются 

scale S
proc dlg_msh_init {} {
    global dlg_msh_param_data var_prefix
    global ob_name ob_value ob_list
    global var_surfaces var_path var_name_prefix var_name
    destroy .dlg_msh
    set var_prefix dlg_msh_
    set ob_list {}
    foreach {key des value type lbl entry} $dlg_msh_param_data {
        set ob_name($key) $des
        set ob_value($key) $value ; # Эта переменная вероятно будет удалена
        lappend ob_list $key }
    foreach var {var_surfaces var_path var_name_prefix var_name} {
        set $var ""}}

proc dlg_msh {} {
    global dlg_msh_param_data var_prefix
    global guibase_dir
    global var_surfaces var_path var_name_prefix var_name
    foreach {key des value type lbl entry} $dlg_msh_param_data {
        global $var_prefix$key
        set $var_prefix$key $value }
    set buts {
        { {Make Basename} { make_basename } }
        { {Cancel}        { dlg_msh_cancel_action } }
        { {OK}            { dlg_msh_ok_action } } }
    set d [form_init .dlg_msh "Dlg msh param" "" $buts]
    if {$d != ""} {
        form_frame $d.fr_0 sunken 1 {0 0}
        set s $d.fr_0
        form_label $s.l_select "Select" {0 0}
        form_button_bitmap $s.b_select @$guibase_dir/goup.xbm \
            { dlg_msh_select } {0 1}
        form_entry $s.e_select var_surfaces string {0 2}
        
        form_label $s.l_path "Path" {1 0}
        form_entry $s.e_path var_path string {1 2}

        form_label $s.l_name_prefix "Name.Prefix" {2 0}
        form_entry $s.e_name_prefix var_name_prefix string {2 2}

        form_label $s.l_name "Name" {3 0}
        form_entry $s.e_name var_name string {3 2}
        
        form_frame $d.fr sunken 1 {1 0}
        set d $d.fr
        foreach {key des value type lbl entry} $dlg_msh_param_data {
            form_label $d.l_$key "$key" $lbl
            form_entry $d.e_$key  $var_prefix$key $type $entry }
        form_finish } }

proc make_basename {} {
    global dlg_msh_param_data var_prefix
    global ob_name ob_value ob_list
    set x {}
    foreach {key des value type lbl entry} $dlg_msh_param_data {
        global $var_prefix$key }
    foreach {key des value type lbl entry} $dlg_msh_param_data {
        upvar $var_prefix$key val
        if { $val != 0 } {
            lappend x $ob_name($key)
            lappend x $val } }
    set rez [join $x _]
    mess "$rez \n"
}

####################################################################################################

proc get_array_value_if_index_exist {arrName index} {
    # Возвращает значение, связанное с индексом массава, если индекс
    # есть в перечне индексов. Если индекс отвутствует возвращается
    # пустой список.
    upvar $arrName arr
    if { [lsearch -exact [array names arr] $index] != -1 } {
        return $arr($index) 
    } else {
        return {} } }

proc split_basename {name} {
    return [lreverse [split $name _]]}

proc part_name_prop {name} {
    set rez {}
    foreach {val name} [split_basename $name] {
        if { $name != {} } {
            lappend rez $name
            lappend rez $val } }
    return $rez }

proc part_name_prefix {name} {
    set rez {}
    foreach {val name} [split_basename $name] {
        if { $name == {} } {
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
         set arr($ob_name($name)) $val } }

####################################################################################################

proc highlight {type names on} {
    # Подсвечивает (при on=1) или снимает подсвечивание (при on=0) с
    # объектов с именами names, имеющих тип type.
    ic_highlight 
    ic_image delete preview
    ic_show_geo_selected $type $names $on }

proc dlg_msh_select {} {
    global var_surfaces var_path var_name_prefix var_name
    set surfaces [geo_select surface]
    highlight surface $surfaces 0
    set x {}
    mess $surfaces
    set var_surfaces $surfaces
    set var_path [path_name [ic_geo_get_family surface $surfaces] ]
    set var_name_prefix \
        [part_name_prefix \
             [base_name \
                  [ic_geo_get_family surface $surfaces] ] ]

    return  $surfaces }

proc dlg_msh_prepare {surface} {
    global dlg_msh_param_data
    global ob_name ob_value ob_list
    set family [ic_geo_get_family surface $surface]
    set prop   [part_name_prop $family]
    set arr array set prop
    set prefix [part_name_prefix $family] }

proc dlg_msh_cancel_action {} {
    # Акция на нажатие клавиши Сancel
    form_done .dlg_msh 
}

proc dlg_msh_ok_action {} {
    form_done .dlg_msh
}

# source d:/home/_namatv/PRG/msys64/home/namatv/quicklisp/local-projects/ANSYS/mnas-ansys/tcl/ic/dia/dlg_msh.tcl
# foreach surface $surfaces {lappend x [ic_geo_get_family surface $surface]}
dlg_msh_init
dlg_msh


