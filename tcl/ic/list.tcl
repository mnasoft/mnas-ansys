# source d:/home/_namatv/PRG/msys64/home/namatv/quicklisp/local-projects/ANSYS/mnas-ansys/tcl/ic/list.tcl

package provide mnas_icem_utils 1.0

# Удаление элемента списка с заданным значением.
proc ldelete { list value } { 
    set ix [lsearch -exact $list $value] 
    if {$ix >= 0} { 
        return [lreplace $list $ix $ix] 
    } else { 
        return $list }}
