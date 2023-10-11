# source d:/home/_namatv/PRG/msys64/home/namatv/quicklisp/local-projects/ANSYS/mnas-ansys/tcl/ic/mnas_help.tcl

package provide mnas_icem_utils 1.0

set procs {
    ch_part \
        remove_last \
        remove_first \
        base_name \
        path_name \
        ch_tan_curve \
        ch_tan_point \
        ch_tan \
        part_key_value \
        sort_by_size \
        del_part \
        parts \
        parts_print \
        del_asm \
        all_parents \
        not_empty_parts \
        not_empty_parents \
        empty_parents \
        clear_all \
        l_dlg_msh \
        dlg_msh_init \
        highlight \
        select_by_type \
        dlg_msh_print_action \
        dlg_msh_ok_action \
        make_basename \
        dlg_msh_rename_action \
        split_basename \
        part_name_prop \
        dlg_msh_move_action \
        make_keys \
        part_name_prefix \
        dlg_msh_setup \
        dlg_msh \
        get_array_value_if_index_exist \
        make_name \
        msh_prt_new \
        dlg_msh_prepare \
        mnas_help \
        vis \
        hid \
        show \
        hide \
        mk_line \
        mk_line_1 \
        mk_pline \
        mk_int \
        key_value \
        value_key \
        curve_length \
        curve_mesh_params \
        curves_mesh_params \
        topo \
        msh \
        msh_per \
        msh_par \
        fam_scale \
        msh_fam \
        msh_prt \
        obj_num \
        obj_num_part \
        ch_dg \
        init_arr \
        init_e_arr \
        bas \
        baz \
        foo \
        bar \
        pr \
        close_compute \
        dialog }

# Функция mnas_help дает краткую помощь по командам пакета
# mnas_icem_utils.
proc mnas_help {} {
    set lines {}
    lappend lines "=========================\n"    
    lappend lines "Command   - Description \n"
    lappend lines "=========================\n"
    lappend lines "mnas_help - give short help for mnas_icem_utils commands;\n"     
    lappend lines "ch_all    - Move  all points and curves which are coedged with surfaces to parts in which surfaces belong to;\n" 
    lappend lines "ch_vis    - Move visible points and curves which are coedged with lappend lines surfaces to parts in which surfaces belong to; \n"
    lappend lines "require_pkg - load package mnas_icem_utils 1.0; \n"
    lappend lines "make_auto   - make tclIndex for loading commands not included package mnas_icem_utils 1.0; \n"
    lappend lines "check_auto_path - print line by line auto_path variable; \n"
    lappend lines "dlg_msh   - part renaming, moving, change properties dialog; \n"
    foreach line $lines {
        mess $line} }

