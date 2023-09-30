# source d:/home/_namatv/PRG/msys64/home/namatv/quicklisp/local-projects/ANSYS/mnas-ansys/tcl/ic/dia/dialog.tcl

set close_famname {d:/home/_namatv}
set close_dist 0.456

proc close_compute {} {
    mess "Close compute \n"
}

proc dialog {} {
    global close_famname close_dist
    array set fam_active {
        red   1
        green 5
        blue  4
        white 9 }
    set fams [array names fam_active]
    if {$fams == ""} {
        error "There are no families defined" }
    if {[llength $fams] == 1} {
        set close_famname [lindex $fams 0] }
    set buts {
        { Compute { close_compute } }
        { Cancel  { form_done .close } } }
    set d [form_init .close "Close check" diag $buts]
    if {$d != ""} {
        form_frame $d.fr sunken 3 {0 0}
        set d $d.fr

        form_label $d.faml "Family name" {0 0}
        form_label $d.distl "Distance" {1 0}

        futil_listentry $d.fam close_famname "list $fams" {0 1}
        form_entry $d.dist close_dist float {1 1}
        set a $d.fam
        set b $d.dist
        # form_finish bot
        form_finish 
    } }

# dialog

####################################################################################################
