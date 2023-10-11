# source d:/home/_namatv/PRG/msys64/home/namatv/quicklisp/local-projects/ANSYS/mnas-ansys/tcl/ic/dlg_msh.tcl

package provide mnas_icem_utils 1.0

# surface curve point material density loop body

set file_proc "
 dlg_msh
 dlg_msh_init
 dlg_msh_move_action
 dlg_msh_separate_action
 dlg_msh_print_action
 dlg_msh_fam_params_action
 dlg_msh_setup
 dlg_msh_prepare
 highlight
 select_by_type

 make_basename
 dlg_msh_rename_action
 split_basename
 part_name_prop
 make_keys
 part_name_prefix
 get_array_value_if_index_exist
 make_name
 msh_prt_new
"

##################################################
# Глобальные переменные начало
##################################################
global global_vars
set global_vars {}

# dlg_msh_prefix содержит строку dlg_msh, используемую для
# формирования имен переменных, которые используются для значений
# связанных с окнами ввода entry.
global dlg_msh_prefix
set dlg_msh_prefix dlg_msh; lappend global_vars dlg_msh_prefix

# dlg_msh_param_data содержит записи, характеризующие параметры сетки
# и данные для настройки диалога. Каждая запись состоит из:
# 1. ключа, используемого в качестве метки;
# 2. обозначения параметра в имени части;
# 3. значения по умолчанию;
# 4. типа содержимого окна редактирования (entry);
# 5. координаты расположения метки (label);
# 6. расположения entry.
global dlg_msh_param_data
set dlg_msh_param_data {
    d_hid          D   0.0  float     {0 0} {0 1}
    scale          S   0.25 float     {0 2} {0 3}
    prism          PR  0    int_blank {1 0} {1 1} 
    ehgt           H   0.0  float     {1 2} {1 3}
    hrat           HR  0.0  float     {2 0} {2 1}
    nlay           NL  0    int_blank {2 2} {2 3}
    erat           TSR 0.0  float     {3 0} {3 1}
    ewid           TW  0.0  float     {3 2} {3 3}
    emin           MSL 0.0  float     {4 0} {4 1}
    edev           MD  0.0  float     {4 2} {4 3}
    split_wall     SW  0    int_blank {5 0} {5 1}
    internal_wall  IW  0    int_blank {5 2} {5 3} }
lappend global_vars dlg_msh_param_data

# key_des содержит массив, у которого:
# - ключами являются ключи из записей, находящихся в глобальной
# переменной dlg_msh_param_data;
# - значениями являются обозначения параметра в имени части;
# Например: scale - ключ, S - значение.
lappend global_vars key_des

# des_key - содержит массив, у которого:
# - ключами являются обозначения параметра в имени части;
# - значениями являются ключи из записей, находящихся в глобальной
# переменной dlg_msh_param_data;
# Например: S - ключ, scale - значение.
lappend global_vars des_key

# key_list содержит упорядоченный список ключей из переменной
# dlg_msh_param_data.
lappend  global_vars key_list

# mnas_base_dir содержит путь картинкам для кнопок.
global mnas_base_dir
set mnas_base_dir ${mnas_ansys_tcl_dir}/image

lappend global_vars mnas_base_dir

# var_surfaces содержит имена поверхностей.
# var_path содержит путь к части.
# var_prefix содержите префикс части.
# var_name содержит имя части.
lappend global_vars var_surfaces var_path var_prefix var_name

foreach {key des value type lbl entry} $dlg_msh_param_data {
    lappend global_vars ${dlg_msh_prefix}_$key}

##################################################
# Глобальные переменные конец
##################################################

# Функция dlg_msh_init выполняет действия по инициализации диалога.
proc dlg_msh_init {} {
    global global_vars; foreach {gvar} $global_vars { global $gvar }
    destroy .dlg_msh
    set key_list {}
    foreach {key des value type lbl entry} $dlg_msh_param_data {
        set key_des($key) $des
        set des_key($des) $key
        lappend key_list $key }
    foreach var {var_surfaces var_path var_prefix var_name} {
        set $var ""}}

dlg_msh_init

# Функция подсвечивает (при on=1) или снимает подсвечивание (при on=0)
# с объектов с именами names, имеющих тип type.
# Пример использования:
# highlight surface $surfaces 0
proc highlight {type names on} {
    ic_highlight 
    ic_image delete preview
    ic_show_geo_selected $type $names $on }

# Функция select_by_type позволяет сделать интерактивно выбрать оъекты
# определенного типа (по умолчанию - поверхности). Возвращает имена
# выбранных объектов.
# Пример использования:
# select_by_type -> srf.04.cut.0.0 srf.02.cut.0.0
proc select_by_type {{type surface}} {
    set obj [geo_select $type]
    highlight $type $obj 0
    return $obj}

# Акция на нажатие клавиши print
proc dlg_msh_print_action {} {
    global global_vars; foreach {gvar} $global_vars { global $gvar }
    mess "\n"
    mess "==========================\n"
    mess "Names of selected surfaces:\n"
    mess "==========================\n"
    foreach object $var_surfaces { mess "$object\n" }
    mess "\n"
    mess "==========================\n"
    mess "Parts of selected surfaces:\n"
    mess "==========================\n"
    foreach object $var_surfaces {
        mess "[ic_geo_get_family surface $object]\n" }
    mess "\n"
    mess "==========================\n"    
    mess "Part name to move to:\n"
    mess "==========================\n"
    mess "$var_path/$var_name\n\n" }

# Устанавливает значения по умолчанию для части part.
proc fam_params_clear {part} {
    ic_geo_set_family_params $part \
        no_crv_inf \
        prism 0 \
        emax 0.0 \
        ehgt 0.0 \
        hrat 0 \
        nlay 0 \
        erat 0.0 \
        ewid 0 \
        emin 0.0 \
        edev 0.0 \
        split_wall 0 \
        internal_wall 0 }


# Устанавливает значения по умолчанию для всех частей, в которыъ
# содержатся поверхности.
proc fams_params_clear {} {
    foreach part [parts surface] {
        fam_params_clear $part } }

# Устанавливает парамерты настройки сетки для части на основе ее
# имени.
proc fam_params_set {part} {
    global global_vars; foreach {gvar} $global_vars { global $gvar }
    fam_params_clear $part
    set pnp [part_name_prop $part]
    set d_hid 0.0
    set scale 0.25
    set d_hid_scale {d_hid scale}
    set x {}
    foreach {des val} $pnp {
        if { [info exists des_key($des)] == 1 } then {
            set d_hid_scale_index [lsearch $d_hid_scale $des_key($des)]
            if { $d_hid_scale_index != -1 } then {
                set [lindex $d_hid_scale $d_hid_scale_index] $val
            } else {
                lappend x $des_key($des) $val } } }
    lappend x emax [expr { $d_hid * $scale } ]
    set cmd "ic_geo_set_family_params $part no_crv_inf $x"
    eval $cmd
    return $x }

# Акция на нажатие клавиши Fam params
proc dlg_msh_fam_params_action {} {
    global global_vars; foreach {gvar} $global_vars { global $gvar }
    ch_curves
    foreach part [parts surface] {
        fam_params_set $part } }

# Формирует базовое имя для части.
proc make_basename {} {
    global global_vars; foreach {gvar} $global_vars { global $gvar }
    set x {}
    foreach {key des value type lbl entry} $dlg_msh_param_data {
        global ${dlg_msh_prefix}_$key }
    foreach {key des value type lbl entry} $dlg_msh_param_data {
        upvar ${dlg_msh_prefix}_$key val
        if { $val != 0 } {
            lappend x $key_des($key)
            lappend x $val } }
    set rez [join $x _]
    if { [string equal $var_prefix {} ] } then {
        set v_pref {}
    } else {
        set v_pref ${var_prefix}_ }
    if { [string equal $rez {} ] } then {
        set var_name ${v_pref}D_0.0
    } else {
        set var_name ${v_pref}$rez } }

# Акция по нажалию кнопки Rename. Переименовывает часть, которая
# содержит относится к первой выбранной поверхности.
proc dlg_msh_rename_action {} {
    global global_vars; foreach {gvar} $global_vars { global $gvar }
    if { [llength $var_surfaces] >= 1 } then {
        set surface    [lindex $var_surfaces 0]
        set family_cur [ic_geo_get_family surface $surface]
        set family_cur_color [ic_geo_get_family_param $family_cur color]
        if { $var_path != {} } then {
            set family_new $var_path/$var_name
        } else {
            set family_new $var_name }
        ic_geo_get_valid_namelen
        ic_geo_rename_family $family_cur $family_new 0
        ic_geo_rename_family $family_cur $family_new 1
        ic_geo_set_family_params $family_cur color $family_cur_color } }

# Функция split_basename разделяет базовое имя на составляющие.
# Пример использования:
# split_basename OUTLET_D_0.33 -> 0.33 D OUTLET
proc split_basename {name} {
    return [lreverse [split $name _]]}

# Функция part_name_prop возвращает список, состоящий из пар:
# (обозначение значение параметра). Параметр name должен содержать
# имя семейства.
# Пример использования:
# part_name_prop DG1/B/INLET_D_0.25_S_0.33 -> S 0.33 D 0.25
proc part_name_prop {name} {
    set rez {}
    foreach {val name} [split_basename [base_name $name]] {
        if { $name != {} } {
            lappend rez $name
            lappend rez $val } }
    return $rez }

# Разделяет поверхности по подчастям 
proc dlg_msh_separate_action {} {
    global global_vars; foreach {gvar} $global_vars { global $gvar }
    set l_surfaces [llength $var_surfaces]
    if { $var_path != {} } then {
        set f_prefix $var_path
    } else {
        set f_prefix {} }
    set i 0
    foreach surface $var_surfaces {
        incr i
        ic_undo_group_begin
        ic_geo_set_part surface $surface ${f_prefix}/[format "%#03d" $i]/$var_name 0
        ic_undo_group_end } }

# Акция по нажалию кнопки Move. Перемещает все выбранные поверхности в
# новую или существующую часть.
proc dlg_msh_move_action {} {
    global global_vars; foreach {gvar} $global_vars { global $gvar }
    if { $var_path != {} } then {
        set family_new $var_path/$var_name
    } else {
        set family_new $var_name }
    set family_new $var_path/$var_name
    foreach surface $var_surfaces {
        ic_undo_group_begin
        ic_geo_set_part surface $surface $family_new 0
        ic_undo_group_end } }

proc make_keys {} {
    global global_vars; foreach {gvar} $global_vars { global $gvar }
    foreach {des value} [part_name_prop $var_name] {
        set key $des_key($des)
        set key_var ${dlg_msh_prefix}_${key}
        set $key_var $value } }

# Функция part_name_prefix возвращает список состоящий из пар -
# обозначение и значение.
# Пример использования:
# part_name_prefix OUTLET_D_0.33 -> OUTLET
proc part_name_prefix {name} {
    set rez {}
    foreach {val name} [split_basename $name] {
        if { $name == {} } {
            lappend rez $val } }
    return $rez }

proc dlg_msh_setup {surfaces} {
    global global_vars; foreach {gvar} $global_vars { global $gvar }
    set surface         [lindex $surfaces 0]
    set family          [ic_geo_get_family surface $surface]
    set base_name       [base_name $family]
    set var_surfaces    $surfaces
    set var_path        [path_name [ic_geo_get_family surface $surface] ]
    set var_prefix [part_name_prefix $base_name ]
    set var_name        $base_name
    make_keys }

# Диалог dlg_msh
proc dlg_msh {} {
    global global_vars; foreach {gvar} $global_vars { global $gvar }
    foreach {key des value type lbl entry} $dlg_msh_param_data {
        global ${dlg_msh_prefix}_$key
        set ${dlg_msh_prefix}_$key $value }
    set buts {
        { {Print}      { dlg_msh_print_action      } }
        { {Rename}     { dlg_msh_rename_action     } }
        { {Fam PRM}    { dlg_msh_fam_params_action } } }
    set d [form_init .dlg_msh "Dlg msh param" "" $buts]
    if {$d != ""} {
        form_frame $d.fr_0 sunken 1 {0 0}
        set s $d.fr_0
        form_label $s.l_select "Select" {0 0}
        form_button_bitmap $s.b_select @$mnas_base_dir/diag.xbm \
            { dlg_msh_setup [select_by_type] } {0 1}
        form_entry $s.e_select var_surfaces string {0 2}
####
        form_label $s.l_path "Path" {1 0}
        form_entry $s.e_path var_path string {1 2}
####
        form_label $s.l_name_prefix "Name.Prefix" {2 0}
        form_entry $s.e_name_prefix var_prefix string {2 2}
####
        form_label $s.l_name "Name" {3 0}
        form_entry $s.e_name var_name string {3 2}
##########
        form_frame $d.fr_1 sunken 1 {1 0}
        set s $d.fr_1
        
        form_button $s.b_move "Move" {dlg_msh_move_action}  {0 0} 
        form_button_bitmap $s.b_make_basename @$mnas_base_dir/goup.xbm { make_basename } {0 1}
        form_button_bitmap $s.b_make_keys @$mnas_base_dir/godown.xbm   { make_keys }     {0 2}
        form_button $s.b_separate "Separate" {dlg_msh_separate_action}  {0 3}
        form_button $s.b_ch_vis "Ch Vis" {ch_vis}  {0 4}
        form_button $s.b_ch_all "Ch All" {ch_all}  {0 5}
        form_button $s.b_ch_cur "Ch Curves" {ch_curves}     {1 0}
        form_button $s.b_dlg_msh_init "Dlg Init" {dlg_msh_init}  {1 3}
        form_button $s.b_fams_params_clear "Fam CLR" {fams_params_clear}  {1 4}

##########        
        form_frame $d.fr sunken 1 {2 0}
        set d $d.fr
        foreach {key des value type lbl entry} $dlg_msh_param_data {
            form_label $d.l_$key "$key" $lbl
            form_entry $d.e_$key  ${dlg_msh_prefix}_$key $type $entry }
        form_finish } }

####################################################################################################
####################################################################################################

# Возвращает значение, связанное с индексом массава, если индекс есть
# в перечне индексов. Если индекс отвутствует возвращается пустой
# список.
proc get_array_value_if_index_exist {arrName index} {
    upvar $arrName arr
    if { [lsearch -exact [array names arr] $index] != -1 } {
        return $arr($index) 
    } else {
        return {} } }

# Функция make_name пока не используется и не готова.
proc make_name {name} {
    global global_vars; foreach {gvar} $global_vars { global $gvar }
    set props $name
    array set arr $props
    set x {}
    foreach index $key_list {
        set name $key_des($index)
        if { [get_array_value_if_index_exist arr $name] != {} } {
            lappend x $name
            lappend x $arr($name) } }
    return $x }

proc msh_prt_new {{params {dhir 00.000 scale 1.0}}} {
    global global_vars; foreach {gvar} $global_vars { global $gvar }
    global arr
     foreach {name val} $params {
         set arr($key_des($name)) $val } }

# Функция dlg_msh_prepare пока не используется.
proc dlg_msh_prepare {surface} {
    global global_vars; foreach {gvar} $global_vars { global $gvar }
    set family [ic_geo_get_family surface $surface]
    set prop   [part_name_prop $family]
    set arr array set prop
    set prefix [part_name_prefix $family] }
