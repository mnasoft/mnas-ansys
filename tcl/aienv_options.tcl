array set options { expert 1 remote_path {} tree_disp_quad 2 tree_disp_pyra 0 evaluate_diagnostic 0 histo_show_default 1 select_toggle_corners 0 remove_all 0 keep_existing_file_names 0 record_journal 0 edit_wait 0 face_mode all select_mode some med_save_emergency_tetin 1 user_name namatv diag_which all uns_warn_if_display 500000 bubble_delay 1000 external_num 1 tree_disp_tri 2 apply_all 0 default_solver {ANSYS CFX} temporary_directory {} flood_select_angle 0 home_after_load 1 project_active 0 histo_color_by_quality_default 1 undo_logging 1 tree_disp_hexa 0 histo_solid_default 1 host_name N133907 xhidden_full 1 editor notepad mouse_color orange clear_undo 1 remote_acn {} remote_sh csh tree_disp_penta 0 n_processors 8 remote_host {} save_to_new 0 quality_info Quality tree_disp_node 0 med_save_emergency_mesh 1 redtext_color red tree_disp_line 0 select_edge_mode 0 use_dlremote 0 max_mesh_map_size {} show_tris 1 remote_user {} auto_save_views 1 max_cad_map_size {} display_origin 0 uns_warn_user_if_display 1000000 detail_info 0 win_java_help 0 show_factor 1 boundary_mode all clean_up_tmp_files 1 med_save_emergency_blocking 1 max_binary_tetin 0 tree_disp_tetra 0 }
set use_xwindows 0
set icon_size1 24
set icon_size2 35
set undo_max_memory 0
set undo_save_whole_mesh 1
set geom_fast_dynamics 1
set med_fast_dynamics 1
set tdv_rubbox_overlay 1
set tdv_dynamics_speed_thresh 300
set tdv_home_shrink 0.95
set med_float_precision 0
set tdv_quadratic_accuracy 9
set med_index_base 1
set disp_options(uns_cut_delay_count) 1000
set mesh_min_moving_element_aspect 0.1
set auto_pick_mode 1
set product_mode -cfx
set hexa_off_mode 0
set vis3_off_mode 1
set cart3d_mode 0
set gui_style_mode wb
set beta_mode 0
if {[info exists env(AI_ENV_BETA)]} {unset env(AI_ENV_BETA)}
set solver_setup_global 0
array set tdv_mouse_bindings { trans 2 scale 3 select 1 rot 1 wheel 5 wheelactive 1 scale_dir 1 done 2 cancel 3 }
set tdv_background_color {0 #000000 #ffffff}
set tdv_show_ansys_logo 0
set tdv_start_spaceball 1
set tdv_lighting(ambient) 0.2
set tdv_lighting(diffuse) 0.8
set tdv_lighting(specular) 0.2
set tdv_lighting(shininess) 5
set tdv_lighting(dir) {0.3 -0.3 1}
set tdv_control_display_lists 4095
set tdv_use_opengl_feedback 1
set tdv_use_opengl_lighting 1
set tdv_auto_simplify_geom 0
set tdv_geom_simp 10
set tdv_use_dual_lighting 0
set tdv_skip_visible_check 0
if {[info exists env(ICEM_NO_OVERLAY)]} {unset env(ICEM_NO_OVERLAY)}
set prompt_for_bld_topo 0
set prompt_for_bld_topo_opts 0
set named_sels_as_parts 1
set allow_plane_selection 1
set display_mesh_selection 0
array set vid_options { wb_NS_to_subset 0 auxiliary 0 show_name 0 do_intersect_self_part 1 inherit 1 default_part GEOM new_srf_topo 1 DelPerFlag 1 edit_replay_filter 0 show_item_name 0 composite_tolerance 1.0 wb_import_scale_geo 0 replace 0 same_pnt_tol 1e-4 tdv_axes 1 vid_mode 0 DelBlkPerFlag 0 }
array set hex_option { default_bunching_ratio 2.0 floating_grid 0 n_tetra_smoothing_steps 20 trfDeg 1 wr_hexa7 0 smooth_ogrid 0 find_worst 1-3 hexa_verbose_mode 0 old_eparams 0 uns_face_mesh_method uniform_quad multigrid_level 0 uns_face_mesh one_tri check_blck 0 proj_limit 0 check_inv 0 project_bspline 0 hexa_update_mode 1 default_bunching_law BiGeometric }
