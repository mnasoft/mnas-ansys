# source d:/home/_namatv/PRG/msys64/home/namatv/quicklisp/local-projects/ANSYS/mnas-ansys/tcl/ic/interface.tcl
mess "source interface.tcl START... \n"

proc mk_int {} {
    set x [ic_get_geo_selected]
    ic_geo_get_family surface [lindex $x 0]
}

mess "source interface.tcl FINISH. \n"
