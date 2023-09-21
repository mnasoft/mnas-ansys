# source d:/home/_namatv/PRG/msys64/home/namatv/quicklisp/local-projects/ANSYS/mnas-ansys/tcl/ic/dia/dlg_msh.tcl
set dlg_msh_param_data {
    d_hid          D   0.0 float     {0 0}  {0 1}
    scale          S   1.0 float     {1 0}  {1 1}
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

proc dlg_msh_init {} {
    global dlg_msh_param_data
    global ob_name ob_value ob_list
    set ob_list {}
    foreach {key des value type lbl entry} $dlg_msh_param_data {
        set ob_name($key) $des
        set ob_value($key) $value ; # Эта переменная вероятно будет удалена
        lappend ob_list $key } }

proc dlg_msh {} {
    global dlg_msh_param_data
    set prefix dlg_msh_param_
    foreach {key des value type lbl entry} $dlg_msh_param_data {
        global $prefix$key
        set $prefix$key $value }
    set buts {
        { {Make Basename} { make_basename } }
        { Cancel  { form_done .dlg_msh } } }
    set d [form_init .dlg_msh "Dlg msh param" "" $buts]
    if {$d != ""} {
        form_frame $d.fr sunken 1 {0 0}
        set d $d.fr
        foreach {key des value type lbl entry} $dlg_msh_param_data {
            form_label $d.l_$key "$key" $lbl
            form_entry $d.e_$key  $prefix$key $type $entry }
        form_finish 
    } }

proc make_basename {} {
    global dlg_msh_param_data
    global ob_name ob_value ob_list
    set prefix dlg_msh_param_
    set x {}
    foreach {key des value type lbl entry} $dlg_msh_param_data {
        global $prefix$key }
    foreach {key des value type lbl entry} $dlg_msh_param_data {
        upvar $prefix$key val
        if { $val != 0 } {
            lappend x $ob_name($key)
            lappend x $val } }
    set rez [join $x _]
    mess "$rez \n"
}

proc foo {} {
    return [geo_select surface]
}

# source d:/home/_namatv/PRG/msys64/home/namatv/quicklisp/local-projects/ANSYS/mnas-ansys/tcl/ic/dia/dlg_msh.tcl
dlg_msh_init
# dlg_msh

