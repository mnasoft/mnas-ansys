# source d:/home/_namatv/PRG/msys64/home/namatv/quicklisp/local-projects/ANSYS/mnas-ansys/tcl/ic/mesh_setup.tcl
mess "source mesh_setup.tcl START... \n"

package provide mnas_icem_utils 1.0

proc msh_per {{angle 0} {axis {1 0 0}} {base {0 0 0}}} {
    # Задает периодичность
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

mess "source mesh_setup.tcl FINISH. \n"
