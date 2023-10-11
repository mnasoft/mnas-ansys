# source d:/home/_namatv/PRG/msys64/home/namatv/quicklisp/local-projects/ANSYS/mnas-ansys/tcl/ic/suface.tcl

package provide mnas_icem_utils 1.0

# Переносит видимые поверхности в газовый домен, имеющий суффикс
# dom_suffix.
proc ch_dg {dom_suffix} {
    set surfaces [ic_geo_list_visible_objects surface]
    set x {}
    foreach surface $surfaces {
        set part [ic_geo_get_family surface $surface]
        set newpart [join [lreplace [split $part {/}] 0 0 DG$dom_suffix] {/}]
        lappend x $newpart
        ic_geo_set_part surface $surface $newpart 0 }
    return $x }
