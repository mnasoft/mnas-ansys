
proc mk_int {} {
    set x [ic_get_geo_selected]
    ic_geo_get_family surface [lindex $x 0]
}

