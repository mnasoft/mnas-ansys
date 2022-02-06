;;;; ./src/icem/geometry.lisp

(defpackage #:mnas-ansys/icem/geometry
  (:use #:cl)
  (:export ic_geo_cre_pnt
           ic_geo_cre_line)
;;;; generics

  (:documentation
   " Пакет предназначен для создания геометрии через API системы ANSYS ICEM CFD."
   ))

(in-package #:mnas-ansys/icem/geometry)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun ic_load_tetin (filenames &optional (tri_tolerance 0) (keep_model_params 1) (blanks 0) (quiet 0))
  (format
   t
   "ic_load_tetin ~A ~A ~A ~A ~A~%"
   filenames tri_tolerance keep_model_params blanks quiet))

(defun ic_empty_tetin ()
  (format
   t
   "ic_empty_tetin~%"))

(defun ic_save_tetin (file &optional (only_visible 0) (v4 0) (only_fams "") (only_ents "") (v10 0) (quiet 0) (clear_undo 1))
  (format
   t
   "ic_save_tetin ~A ~A ~A ~A ~A ~A ~A ~A~%"
   file only_visible v4 only_fams only_ents v10 quiet clear_undo))

(defun ic_unload_tetin (&optional (quiet 0))
  (format
   t
   "ic_unload_tetin ~A~%"
   quiet))


(defun ic_geo_import_mesh (&optional  (domains "") (do_seg 1) (no_orfn 1) (do_merge 1))
    (format
     t
     "ic_geo_import_mesh ~A ~A ~A ~A ~%"
     domains do_seg no_orfn do_merge))

(defun update_surface_display (obj)
  (format
   t
   "update_surface_display ~A~%"
   obj))

(defun ic_geo_export_to_mesh (merge &optional (fams "") (quiet 0))
  (format
   t
   "ic_geo_export_to_mesh ~A ~A ~A~%"
   merge fams quiet))

(defun ic_ddn_app (type partname partdir extra_cmds &optional (batch 1))
  (format
   t
   "ic_ddn_app ~A ~A ~A ~A ~A~%"
   type partname partdir extra_cmds batch))

(defun ic_geo_summary ()
  (format
   t
   "ic_geo_summary~%"
   ))

(defun ic_geo_lookup_family_pid (fam)
  (format
   t
   "ic_geo_lookup_family_pid ~A~%"
   fam))

(defun ic_geo_is_loaded ()
  (format
   t
   "ic_geo_is_loaded~%"
   ))

(defun ic_geo_is_modified ()
  (format
   t
   "ic_geo_is_modified~%"
   ))

(defun ic_geo_valid_name (name no_colon )
  (format
   t
   "ic_geo_valid_name ~A ~A~%"
   name no_colon ))

(defun ic_geo_set_modified (on )
  (format
   t
   "ic_geo_set_modified ~A~%"
   on ))

(defun ic_geo_check_family (name )
  (format
   t
   "ic_geo_check_family ~A~%"
   name))

(defun ic_geo_check_part (name )
  (format
   t
   "ic_geo_check_part ~A~%"
   name ))

(defun ic_geo_new_family (name &optional (do_update 1) )

  (format
   t
   "ic_geo_new_family ~A ~A~%"
   name do_update))

(defun ic_geo_new_name (type prefix )

  (format
   t
   "ic_geo_new_name "
   type prefix ))

(defun ic_geo_get_unused_part (prefix &optional (no_first_num 0))
  (format
   t
   "ic_geo_get_unused_part ~A ~A~%"
   prefix no_first_num ))

(defun ic_geo_delete_family (names )
  (format
   t
   "ic_geo_delete_family ~A~%"
   names ))

(defun ic_geo_params_blank_done (type &optional (reset 0) )
  (format
   t
   "ic_geo_params_blank_done ~A ~A~%"
   type reset))

(defun ic_geo_match_name (type pat )
  (format
   t
   "ic_geo_match_name ~A ~A~%"
   type pat ))

(defun ic_geo_update_visibility (type vis_fams visible )
  (format
   t
   "ic_geo_update_visibility ~A ~A ~A~%"
   type vis_fams visible ))

(defun ic_geo_get_visibility (type name)
  (format
   t
   "ic_geo_get_visibility ~A ~A~%"
   type name))

(defun ic_geo_set_visible_override (type name val )
  (format
   t
   "ic_geo_set_visible_override ~A ~A ~A~%"
   type name val ))

(defun ic_geo_temporary_visible (type objects vis &optional (force 0) )
  (format
   t
   "ic_geo_temporary_visible ~A ~A ~A ~A~%"
   type objects vis force ))

(defun ic_geo_get_temporary_invisible (type &optional (entity ""))
  (format
   t
   "ic_geo_get_temporary_invisible ~A ~A~%"
   type entity))

(defun ic_geo_set_visible_override_families_and_types (fams types )
  (format
   t
   "ic_geo_set_visible_override_families_and_types ~A ~A~%"
   fams types ))

(defun ic_redraw_geometry (type name )
  (format
   t
   "ic_redraw_geometry ~A ~A~%"
   type name ))

(defun ic_geo_incident (type names &optional (even_if_dormant 0))

  (format
   t
   "ic_geo_incident ~A ~A~%"
   type names even_if_dormant))

(defun ic_geo_surface_get_objects (surface type &optional (embedded_points "") )

  (format
   t
   "ic_geo_surface_get_objects ~A ~A ~A~%"
   surface type embedded_points))

(defun ic_geo_loop_get_objects (loop type &optional (surface ""))
  (format
   t
   "ic_geo_loop_get_objects ~A ~A ~A~%"
   loop type surface ))

(defun ic_geo_surface_edges_incident_to_curve (surfname curvename )
  (format
   t
   "ic_geo_surface_edges_incident_to_curve ~A ~A~%"
   surfname curvename ))

(defun ic_geo_surface_normals_orient (&optional (refsurfname "") (outward 1) )

  (format
   t
   "ic_geo_surface_normals_orient ~A ~A~%"
   refsurfname outward))

(defun ic_geo_get_side_surfaces (tol how &optional (list "") )
  (format
   t
   "ic_geo_get_side_surfaces ~A ~A ~A~%"
   tol how list))

(defun ic_geo_boundary (type &optional (names "") (outer 0) (even_if_dormant 0) (embedded 0))
  (format
   t
   "ic_geo_boundary ~A ~A ~A ~A ~A~%"
   type names outer even_if_dormant embedded))

(defun ic_geo_object_visible (type names visible )
  (format
   t
   "ic_geo_object_visible ~A ~A ~A~%"
   type names visible ))

(defun ic_geo_configure_objects (type simp shade st sp sh sq
                                 names wide dnodes count nnum tnum norms
                                 thickness lshow lfull lst lsq
                                 &optional
                                   (comp 0)
                                   (grey_scale 0)
                                   (transparent 0)
                                   (count_quad 0)
                                   (dormant 0)
                                   (protect 0)
                                   (hardsize 0))
  (format
   t
   "ic_geo_configure_objects ~A ~A ~A ~A ~A ~A ~A ~A ~A ~A ~A ~A ~A ~A ~A ~A ~A ~A ~A ~A ~A ~A ~A ~A ~A ~A~%"
   type simp shade st sp sh sq
   names wide dnodes count nnum tnum norms
   thickness lshow lfull lst lsq
   comp grey_scale transparent
   count_quad
   dormant
   protect hardsize ))

(defun ic_geo_configure_one_attribute (type what val )
  (format
   t
   "ic_geo_configure_one_attribute ~A ~A ~A~%"
   type what val ))

(defun ic_geo_configure_one_object (type name what &optional (val "-"))
  (format
   t
   "ic_geo_configure_one_object ~A ~A ~A ~A~%"
   type name what val))

(defun ic_geo_list_families (&optional (only_material 0) (non_empty 0))
  (format
   t
   "ic_geo_list_families ~A ~A~%"
   only_material non_empty ))

(defun ic_geo_list_parts (&optional (prefix "") (non_empty 0))
  (format
   t
   "ic_geo_list_parts ~A ~A~%"
   prefix non_empty ))

(defun ic_geo_check_part (name )
  (format
   t
   "ic_geo_check_part ~A~%"
   name ))

(defun ic_geo_list_families_in_part (part )

  (format
   t
   "ic_geo_list_families_in_part ~A~%"
   part ))

(defun ic_geo_list_families_with_group (gname )
  (format
   t
   "ic_geo_list_families_with_group ~A~%"
   gname ))

(defun ic_geo_list_parts_with_group (gname )
  (format
   t
   "ic_geo_list_parts_with_group ~A~%"
   gname ))

(defun ic_geo_family_is_empty (fam )
  (format
   t
   "ic_geo_family_is_empty ~A~%"
   fam ))

(defun ic_geo_family_is_empty_except_dormant (fam )

  (format
   t
   "ic_geo_family_is_empty_except_dormant ~A~%"
   fam ))

(defun ic_geo_non_empty_families ()
  (format
   t
   "ic_geo_non_empty_families~%"
   ))

(defun ic_geo_non_empty_families_except_dormant ()
  (format
   t
   "ic_geo_non_empty_families_except_dormant~%"
   ))

(defun ic_geo_num_objects (type )
  (format
   t
   "ic_geo_num_objects ~A~%"
   type ))

(defun ic_geo_list_visible_objects (type &optional (even_if_dormant 1))
  (format
   t
   "ic_geo_list_visible_objects ~A ~A~%"
   type even_if_dormant ))

(defun ic_geo_num_visible_objects (type &optional (any 0) )
  (format
   t
   "ic_geo_num_visible_objects ~A ~A~%"
   type any))

(defun ic_geo_num_segments (type name )
  (format
   t
   "ic_geo_num_segments ~A ~A~%"
   type name ))

(defun ic_geo_set_family (type newfam how objs &optional (rename 1) )
  (format
   t
   "ic_geo_set_family ~A ~A ~A ~A ~A~%"
   type newfam how objs rename ))

(defun ic_geo_set_part (type names newpart &optional (rename_part 1) )
  (format
   t
   "ic_geo_set_part ~A ~A ~A ~A~%"
   type names newpart rename_part ))

(defun ic_geo_set_name (type name newname &optional (make_new 0) (warn 1))
  (format
   t
   "ic_geo_set_name ~A ~A ~A ~A ~A~%"
   type name newname make_new warn))

(defun ic_geo_rename_family (fam newfam &optional (rename_ents 1) )
  (format
   t
   "ic_geo_rename_family ~A ~A ~A~%"
   fam newfam rename_ents ))

(defun ic_geo_replace_entity (type e1name e2name )
  (format
   t
   "ic_geo_replace_entity ~A ~A ~A~%"
   type e1name e2name ))

(defun ic_geo_get_ref_size ()
  (format
   t
   "ic_geo_get_ref_size ~%"
   ))

(defun ic_set_meshing_params (type num args )

  (format
   t
   "ic_set_meshing_params ~A ~A ~A~%"
   type num args ))

(defun ic_get_mesh_growth_ratio ()
  (format
   t
   "ic_get_mesh_growth_ratio~%"
   ))

(defun ic_get_meshing_params (type num )
  (format
   t
   "ic_get_meshing_params ~A ~A~%"
   type num ))

(defun ic_geo_scale_meshing_params (types factor )
  (format
   t
   "ic_geo_scale_meshing_params ~A ~A~%"
   types factor ))

(defun ic_geo_set_curve_bunching (curves args )
  (format
   t
   "ic_geo_set_curve_bunching ~A ~A~%"
   curves args ))

(defun ic_geo_get_curve_bunching (name )
  (format
   t
   "ic_geo_get_curve_bunching ~A~%"
   name ))

(defun ic_geo_create_surface_segment (name how args )
  (format
   t
   "ic_geo_create_surface_segment ~A ~A ~A~%"
   name how args ))

(defun ic_geo_create_curve_segment (name how args )
  (format
   t
   "ic_geo_create_curve_segment ~A ~A ~A~%"
   name how args ))

(defun ic_geo_split_curve (curve points )
  (format
   t
   "ic_geo_split_curve ~A ~A~%"
   curve points ))

(defun ic_geo_split_curve_at_point (curve point &optional (tol 0) )
  (format
   t
   "ic_geo_split_curve_at_point ~A ~A ~A~%"
   curve point tol ))

(defun ic_geo_create_loop (name fam how curves all_separate surfs
                           &optional (fams "") (pts "") (crs ""))
  (format
   t
   "ic_geo_create_loop ~A ~A ~A ~A ~A ~A ~A ~A ~A~%"
   name fam how curves all_separate surfs
   fams  pts  crs ))

(defun ic_geo_modify_loop (name curves
                           &optional
                             (surfs "")
                             (pts "")
                             (crs ""))
  (format
   t
   "ic_geo_modify_loop ~A ~A ~A ~A ~A~%"
   name curves surfs pts crs ))

(defun ic_geo_pick_location (args )

  (format
   t
   "ic_geo_pick_location ~A~%"
   args ))

(defun ic_geo_get_object_type (type names )

  (format
   t
   "ic_geo_get_object_type ~A ~A~%"
   type names ))

(defun ic_geo_trim_surface (surf curves &optional (build_topo 1) )
  (format
   t
   "ic_geo_trim_surface ~A ~A ~A~%"
   surf curves build_topo))

(defun ic_geo_intersect_surfaces (fam surfs
                                  &optional
                                    (bsp_flag "")
                                    (multi_flag ""))
  (format
   t
   "ic_geo_intersect_surfaces ~A ~A ~A ~A~%"
   fam surfs bsp_flag  multi_flag ))

(defun ic_geo_intersect_surfs_by_groups (groups &optional
                                                  (fam "")
                                                  (bsp_flag "")
                                                  (multi_flag ""))
  (format
   t
   "ic_geo_intersect_surfs_by_groups ~A ~A ~A ~A~%"
   groups fam bsp_flag multi_flag ))

(defun ic_geo_create_unstruct_curve_from_points (name fam pts)
  (format t "ic_geo_create_unstruct_curve_from_points ~A ~A {~{ {~{~A~^ ~}} ~}}~%"
          name fam pts)
  (format
   t
   "ic_geo_create_unstruct_curve_from_points "
   name fam pts))

(defun ic_geo_create_unstruct_surface_from_points (name fam pts )
  (format
   t
   "ic_geo_create_unstruct_surface_from_points ~A ~A ~A~%"
   name fam pts ))

(defun ic_geo_create_empty_unstruct_surface (name fam )
  (format
   t
   "ic_geo_create_empty_unstruct_surface ~A ~A ~%"
   name fam ))

(defun ic_geo_create_empty_unstruct_curve (name fam )
  (format
   t
   "ic_geo_create_empty_unstruct_curve ~A ~A~%"
   name fam ))

(defun ic_geo_create_curve_ends (names )
  (format
   t
   "ic_geo_create_curve_ends ~A~%"
   names ))

(defun ic_geo_mod_crv_set_end (crv pnt crvend &optional (tol -1)] )
  (format
   t
   "ic_geo_mod_crv_set_end ~A ~A ~A ~A~%"
   crv pnt crvend tol))

(defun ic_geo_crv_get_end (crv crvend )

  (format
   t
   "ic_geo_crv_get_end ~A ~A~%"
   crv crvend ))

(defun ic_geo_create_points_curveinter (curves tol fam &optional (name) )
  (format
   t
   "ic_geo_create_points_curveinter ~A ~A ~A ~A~%"
   curves tol fam name))

(defun ic_geo_create_point_location (fam pt &optional (in_lcs 1) )
  (format
   t
   "ic_geo_create_point_location ~A ~A ~A~%"
   fam pt in_lcs))

(defun ic_geo_create_material_location (fam pt )
  (format
   t
   "ic_geo_create_material_location ~A~A~%"
   fam pt ))

(defun ic_geo_create_density (name size pts
                              &optional
                                (width 0.0)
                                (ratio 0.0)
                                (strfac 1.0)
                                (strvec ""))

  (format
   t
   "ic_geo_create_density ~A ~A ~A ~A ~A ~A ~A~%"
   name size pts width ratio strfac strvec  ))

(defun ic_geo_extract_points (names angle )

  (format
   t
   "ic_geo_extract_points "
   names angle ))

(defun ic_geo_extract_curves (names bound angle minedge )
  (format
   t
   "ic_geo_extract_curves ~A ~A ~A ~A~%"
   names bound angle minedge ))

(defun ic_geo_create_surface_edges (names )
  (format
   t
   "ic_geo_create_surface_edges ~A~%"
   names ))

(defun ic_geo_get_srf_edges (srf )
  (format
   t
   "ic_geo_get_srf_edges ~A~%"
   srf ))

(defun ic_geo_stats (type name )
  (format
   t
   "ic_geo_stats ~A ~A~%"
   type name ))

(defun ic_geo_get_point_location (name )
  (format
   t
   "ic_geo_get_point_location ~A~%"
   name ))

(defun ic_geo_get_material_location (name )
  (format
   t
   "ic_geo_get_material_location ~A~%"
   name ))

(defun ic_set_point_location (args )
  (format
   t
   "ic_set_point_location ~A~%"
   args ))

(defun ic_set_material_location (args )
  (format
   t
   "ic_set_material_location ~A~%"
   args ))

(defun ic_delete_material (names )
  (format
   t
   "ic_delete_material ~A~%"
   names ))

(defun ic_geo_check_objects_exist (type args )
  (format
   t
   "ic_geo_check_objects_exist ~A ~A~%"
   type args ))

(defun ic_geo_get_objects (types
                           &optional
                             (fams "")
                             (even_if_dormant 0))
  (format
   t
   "ic_geo_get_objects ~A ~A ~A~%"
   types fams even_if_dormant))

(defun ic_geo_count_in_family (types fams )
  (format
   t
   "ic_geo_count_in_family ~A ~A~%"
   types fams ))

(defun ic_geo_objects_in_family (types fams )
  (format
   t
   "ic_geo_objects_in_family ~A ~A~%"
   types fams ))

(defun ic_geo_objects_in_parts (types parts )
  (format
   t
   "ic_geo_objects_in_parts ~A ~A~%"
   types parts ))

(defun ic_geo_get_internal_object (type name )
  (format
   t
   "ic_geo_get_internal_object ~A ~A~%"
   type name ))

(defun ic_geo_get_name_of_internal_object (obj )
  (format
   t
   "ic_geo_get_name_of_internal_object ~A~%"
   obj ))

(defun ic_geo_get_text_point (type name )
  (format
   t
   "ic_geo_get_text_point ~A ~A~~%"
   type name ))

(defun ic_geo_get_centroid (type name )

  (format
   t
   "ic_geo_get_centroid "
   type name ))

(defun ic_geo_num_segments (type name )

  (format
   t
   "ic_geo_num_segments ~A ~A~%"
   type name ))

(defun ic_geo_num_nodes (type name )
  (format
   t
   "ic_geo_num_nodes ~A ~A~%"
   type name ))

(defun ic_geo_get_node (type name num )
  (format
   t
   "ic_geo_get_node ~A ~A ~A~%"
   type name num ))

(defun ic_geo_drag_nodes (type name ptnums startpts startmouse spos svec how )
  (format
   t
   "ic_geo_drag_nodes ~A ~A ~A ~A ~A ~A ~A ~A~%"
   type name ptnums startpts startmouse spos svec how ))

(defun ic_geo_drag_point (name startpt startmouse spos svec )

  (format
   t
   "ic_geo_drag_point "
   name startpt startmouse spos svec ))

(defun ic_geo_drag_material (name startpt startmouse spos svec )
  (format
   t
   "ic_geo_drag_material ~A ~A~%"
   name startpt startmouse spos svec ))

(defun ic_geo_drag_body (name startpt startmouse spos svec )
  (format
   t
   "ic_geo_drag_body ~A ~A ~A ~A ~A~%"
   name startpt startmouse spos svec ))

(defun ic_geo_project_point (type names pt &optional
                                             (dir '(0 0 0))
                                             (tan_ext 0))
  (format
   t
   "ic_geo_project_point ~A ~A ~A ~A ~A~%"
   type names pt dir tan_ext ))

(defun ic_geo_project_and_move_point (type names pt
                                      &optional
                                        (dir '(0 0 0))
                                        (tan_ext 0)
                                        (fam ""))
  (format
   t
   "ic_geo_project_and_move_point ~A ~A ~A ~A ~A ~A~%"
   type names pt dir tan_ext fam ))

(defun ic_geo_project_coords (type names ptloc
                              &optional
                                (dir '(0 0 0))
                                (tan_ext 0))
  (format
   t
   "ic_geo_project_coords ~A ~A ~A ~A ~A~%"
   type names ptloc dir tan_ext))

(defun ic_geo_nearest_object (type pt
                              &optional
                                (dir '(0 0 0))
                                (tol 0) )
  (format
   t
   "ic_geo_nearest_object ~A~A~A~A~%"
   type pt dir tol))

(defun ic_geo_project_curve_to_surface (crvs surfs name
                                        &optional
                                          (fam "")
                                          (new_name 0)
                                          (bld_topo 0))
  (format
   t
   "ic_geo_project_curve_to_surface ~A ~A ~A ~A ~A ~A~%"
   crvs surfs name fam new_name bld_topo))

(defun ic_geo_create_surface_curves (crv1 crv2 name )

  (format
   t
   "ic_geo_create_surface_curves "
   crv1 crv2 name ))

(defun ic_geo_create_surface_curtain (crvs surfs name fam
                                      &optional
                                        (bld_topo 0)
                                        (quiet 0) )
  (format
   t
   "ic_geo_create_surface_curtain ~A ~A ~A ~A ~A ~A~%"
   crvs surfs name fam bld_topo quiet ))

(defun ic_geo_set_node (type name num pt )

  (format
   t
   "ic_geo_set_node ~A ~A ~A ~A~%"
   type name num pt ))

(defun ic_geo_get_family (type name )
  (format
   t
   "ic_geo_get_family ~A ~A~%"
   type name ))

(defun ic_geo_get_part (type name )
  (format
   t
   "ic_geo_get_part ~A ~A~%"
   type name ))

(defun ic_build_topo (args)
  (format
   t
   "ic_build_topo ~A~%"
   args ))

(defun ic_geo_default_topo_tolerance_old ()
  (format
   t
   "ic_geo_default_topo_tolerance_old~%"
   ))

(defun ic_delete_geometry (type how &optional
                                      (objects "")
                                      (report_err 1)
                                      (even_if_dormant 0))
  (format
   t
   "ic_delete_geometry ~A ~A ~A ~A ~A~%"
   type how objects report_err even_if_dormant))

(defun ic_geo_pnt_mrg_inc_crv (how objects )

  (format
   t
   "ic_geo_pnt_mrg_inc_crv ~A ~A~%"
   how objects ))

(defun ic_facetize_geometry (type name args )

  (format
   t
   "ic_facetize_geometry ~A ~A ~A~%"
   type name args ))

(defun ic_move_geometry (type args )

  (format
   t
   "ic_move_geometry ~A ~A~%"
   type args ))

(defun ic_geo_duplicate (type name &optional
                                     (newname "")
                                     (facetize 0))
  (format
   t
   "ic_geo_duplicate "
   type name newname facetize))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun ic_geo_fixup (&optional
                       (mesh))
  (format
   t
   "ic_geo_fixup ~A~%"
   mesh))

(defun ic_geo_min_edge_length (args )
  (format
   t
   "ic_geo_min_edge_length ~A~%"
   args ))

(defun ic_geo_coarsen (args )
  (format
   t
   "ic_geo_coarsen ~A~%"
   args ))

(defun ic_geo_gap_repair (args )
  (format
   t
   "ic_geo_gap_repair ~A~%"
   args ))

(defun ic_geo_midsurface (args )
  (format
   t
   "ic_geo_midsurface ~A~%"
   args ))

(defun ic_geo_lookup (types how spec)
  (format
   t
   "ic_geo_lookup ~A ~A ~A~%"
   types how spec))

(defun ic_geo_get_entity_types (entnames)
  (format
   t
   "ic_geo_get_entity_types ~A~%"
   entnames ))

(defun ic_geo_memory_used ()
  (format
   t
   "ic_geo_memory_used~%"
   ))

(defun ic_geo_project_mode (which )
  (format
   t
   "ic_geo_project_mode ~A~%"
   which ))

(defun ic_csystem_get_current ()
  (format
   t
   "ic_csystem_get_current~%"
   ))

(defun ic_csystem_set_current (what )
  (format
   t
   "ic_csystem_set_current ~A~%"
   what ))

(defun ic_csystem_list ()
  (format
   t
   "ic_csystem_list~%"
   ))

(defun ic_csystem_get (name )
  (format
   t
   "ic_csystem_get ~A~%"
   name ))

(defun ic_csystem_delete (name )
  (format
   t
   "ic_csystem_delete ~A~%"
   name ))

(defun ic_csystem_create (name type center axis0 axis1 axis2 )
  (format
   t
   "ic_csystem_create ~A ~A ~A ~A ~A ~A~%"
   name type center axis0 axis1 axis2 ))

(defun ic_coords_into_global (pt &optional (system "") )
  (format
   t
   "ic_coords_into_global ~A ~A~%"
   pt system ))

(defun ic_coords_dir_into_global (pt
                                  &optional
                                    (system ""))
  (format
   t
   "ic_coords_dir_into_global ~A ~A~%"
   pt system ))

(defun ic_coords_into_local (pt &optional (system ""))
  (format
   t
   "ic_coords_into_local ~A ~A~%"
   pt system ))

(defun ic_csystem_display (name on )

  (format
   t
   "ic_csystem_display ~A ~A~%"
   name on ))

(defun ic_geo_untrim_surface (surf )
  (format
   t
   "ic_geo_untrim_surface ~A"
   surf ))

(defun ic_geo_get_thincuts ()
  (format
   t
   "ic_geo_get_thincuts~%"))

(defun ic_geo_set_thincuts (data )
  (format
   t
   "ic_geo_set_thincuts ~A~%"
   data ))

(defun ic_geo_get_periodic_data ()
  (format
   t
   "ic_geo_get_periodic_data~%"
   ))

(defun ic_geo_set_periodic_data (data )
  (format
   t
   "ic_geo_set_periodic_data ~A~%"
   data ))

(defun ic_geo_get_family_param (fam name )
  (format
   t
   "ic_geo_get_family_param ~A ~A~%"
   fam name ))

(defun ic_geo_set_family_params (fam args )
  (format
   t
   "ic_geo_set_family_params ~A ~A~%"
   fam args ))

(defun ic_geo_reset_family_params (fams params )
  (format
   t
   "ic_geo_reset_family_params ~A ~A~%"
   fams params ))

(defun ic_geo_delete_unattached (&optional
                                   (fams "")
                                   (quiet 0)
                                   (only_if_dormant 0))
  (format
   t
   "ic_geo_delete_unattached ~A ~A ~A~%"
   fams quiet only_if_dormant))

(defun ic_geo_remove_feature (curves )
  (format
   t
   "ic_geo_remove_feature ~A~%"
   curves ))

(defun ic_geo_merge_curves (curves )
  (format
   t
   "ic_geo_merge_curves ~A~%"
   curves ))

(defun ic_geo_modify_curve_reappr (curves tol
                                   &optional
                                     (ask 1)
                                     (quiet 0))
  (format
   t
   "ic_geo_modify_curve_reappr ~A ~A ~A ~A~%"
   curves tol ask quiet ))

(defun ic_geo_modify_surface_reappr (surfaces tol
                                     &optional (ask 1) (each 0) (curves "") )
  (format
   t
   "ic_geo_modify_surface_reappr ~A ~A ~A ~A~%"
   surfaces tol ask  each  curves ))

(defun ic_geo_reset_data_structures ()
  (format
   t
   "ic_geo_reset_data_structures~%"
   ))

(defun ic_geo_params_update_show_size (type size )

  (format
   t
   "ic_geo_params_update_show_size ~A ~A~%"
   type size ))

(defun ic_geo_stlrepair_holes (type segs add_nodes int_surf
                               &optional
                                 (complete_edges 1)
                                 (dcurves "")
                                 (toler "")
                                 (part ""))
  (format
   t
   "ic_geo_stlrepair_holes ~A ~A ~A ~A ~A ~A ~A ~A~%"
   type segs add_nodes int_surf complete_edges dcurves toler part ))

(defun ic_geo_stlrepair_edges (type segs merge_tol &optional (merge_ends -1))
  (format
   t
   "ic_geo_stlrepair_edges ~A ~A ~A ~A~%"
   type segs merge_tol merge_ends))

(defun ic_show_geo_selected (type names on
                             &optional
                               (color "")
                               (force_visible 0))
  (format
   t
   "ic_show_geo_selected ~A ~A ~A ~A ~A~%"
   type names on color force_visible))

(defun ic_reset_geo_selected ()
  (format
   t
   "ic_reset_geo_selected~%"
   ))

(defun ic_get_geo_selected ()

  (format
   t
   "ic_get_geo_selected~%"
   ))

(defun ic_set_geo_selected (selected on )
  (format
   t
   "ic_set_geo_selected ~A ~A~%"
   selected on ))

(defun ic_select_geometry_option ()
  (format
   t
   "ic_select_geometry_option~%"
   ))

(defun ic_geo_add_segment (type name item pts )
  (format
   t
   "ic_geo_add_segment ~A ~A ~A ~A~%"
   type name item pts ))

(defun ic_geo_delete_segments (type name item pts )
  (format
   t
   "ic_geo_delete_segments ~A ~A ~A ~A~%"
   type name item pts ))

(defun ic_geo_restrict_segments (type name item pts )
  (format
   t
   "ic_geo_restrict_segments ~A ~A ~A ~A~%"
   type name item pts))

(defun ic_geo_split_segments (type name item how pts )
  (format
   t
   "ic_geo_split_segments ~A ~A ~A ~A ~A~%"
   type name item how pts ))

(defun ic_geo_split_edges (type name pts )
  (format
   t
   "ic_geo_split_edges ~A ~A ~A~%"
   type name pts ))

(defun ic_geo_split_one_edge (type name ed )
  (format
   t
   "ic_geo_split_one_edge ~A ~A ~A~%"
   type name ed ))

(defun ic_geo_swap_edges (type name pts )

  (format
   t
   "ic_geo_swap_edges ~A ~A ~A~%"
   type name pts ))

(defun ic_geo_move_segments (type name1 name2 item pts )

  (format
   t
   "ic_geo_move_segments ~A ~A ~A ~A ~A~%"
   type name1 name2 item pts ))

(defun ic_geo_move_node (type name nodes args )
  (format
   t
   "ic_geo_move_node ~A ~A ~A ~A~%"
   type name nodes args ))

(defun ic_geo_merge_nodes (type name nodes )
  (format
   t
   "ic_geo_merge_nodes ~A ~A ~A~%"
   type name nodes ))

(defun ic_geo_merge_nodes_tol (type name tol )
  (format
   t
   "ic_geo_merge_nodes_tol ~A ~A ~A~%"
   type name tol ))

(defun ic_geo_merge_surfaces (to from )
  (format
   t
   "ic_geo_merge_surfaces ~A ~A~%"
   to from))

(defun ic_geo_merge_objects (type dest objs )
  (format
   t
   "ic_geo_merge_objects ~A ~A ~A~%"
   type dest objs ))

(defun ic_geo_merge_points_tol (pts tol )
  (format
   t
   "ic_geo_merge_points_tol ~A ~A~%"
   pts tol ))

(defun ic_geo_finish_edit (type name )
  (format
   t
   "ic_geo_finish_edit ~A ~A~%"
   type name ))

(defun ic_geo_delete_if_empty (type name )
  (format
   t
   "ic_geo_delete_if_empty ~A ~A~%"
   type name ))

(defun ic_geo_smallest_segment (type name )
  (format
   t
   "ic_geo_smallest_segment ~A ~A~%"
   type name ))

(defun ic_geo_get_config_param (type name param )
  (format
   t
   "ic_geo_get_config_param ~A ~A ~A~%"
   type name param ))

(defun ic_geo_set_config_param (type name param val )

  (format
   t
   "ic_geo_set_config_param ~A ~A ~A ~A~%"
   type name param val ))

(defun ic_geo_set_tag (type names tagname on )

  (format
   t
   "ic_geo_set_tag "
   type names tagname on ))

(defun ic_geo_highlight_segments (type name add hsmode segs )
  (format
   t
   "ic_geo_highlight_segments ~A ~A ~A ~A ~A~%"
   type name add hsmode segs ))

(defun ic_geo_bounding_box (objlist )
  (format
   t
   "ic_geo_bounding_box ~A~%"
   objlist ))

(defun ic_geo_bounding_box2 (objlist )
  (format
   t
   "ic_geo_bounding_box2 ~A~%"
   objlist ))

(defun ic_geo_model_bounding_box ()
  (format
   t
   "ic_geo_model_bounding_box~%"
   ))

(defun ic_geo_feature_size (type name )
  (format
   t
   "ic_geo_feature_size ~A ~A~%"
   type name ))

(defun ic_geo_replace_surface_mesh (name pts tris )
  (format
   t
   "ic_geo_replace_surface_mesh ~A ~A ~A~%"
   name pts tris ))

(defun ic_geo_replace_curve_mesh (name pts bars )
  (format
   t
   "ic_geo_replace_curve_mesh ~A ~A ~A~%"
   name pts bars ))

(defun ic_geo_vec_diff (p1 p2 )
  (format
   t
   "ic_geo_vec_diff ~A ~A~%"
   p1 p2 ))

(defun ic_geo_vec_dot (v1 v2 )
  (format
   t
   "ic_geo_vec_dot ~A ~A~%"
   v1 v2 ))

(defun ic_geo_vec_mult (v1 v2 )
  (format
   t
   "ic_geo_vec_mult ~A ~A~%"
   v1 v2 ))

(defun ic_geo_vec_nrm (vec )
  (format
   t
   "ic_geo_vec_nrm ~A~%"
   vec ))

(defun ic_geo_vec_len (vec )
  (format
   t
   "ic_geo_vec_len ~A~%"
   vec ))

(defun ic_geo_pnt_dist (pnt1 pnt2 )
  (format
   t
   "ic_geo_pnt_dist ~A ~A~%"
   pnt1 pnt2 ))

(defun ic_geo_vec_smult (vec scal )
  (format
   t
   "ic_geo_vec_smult ~A ~A~%"
   vec scal ))

(defun ic_geo_vec_sum (v1 v2 )
  (format
   t
   "ic_geo_vec_sum ~A ~A~%"
   v1 v2 ))

(defun ic_geo_crv_length (crvs &optional (t_min 0) (t_max 1) )

  (format
   t
   "ic_geo_crv_length ~A ~A ~A~%"
   crvs t_min t_max ))

(defun ic_geo_cre_srf_rev (family name gen base zaxis srtang endang
                           &optional (dxn "a") (bld_topo 0) )
  (format
   t
   "ic_geo_cre_srf_rev ~A ~A ~A ~A ~A ~A ~A ~A ~A~%"
   family name gen base zaxis srtang endang dxn bld_topo))

(defun ic_geo_cre_crv_iso_crv (family name srfs par sel
                               &optional (do_split 0) (coord 0) )
  (format
   t
   "ic_geo_cre_crv_iso_crv ~A ~A ~A ~A ~A ~A ~A~%"
   family name srfs par sel do_split coord ))

(defun ic_geo_cre_srf_pln_3pnts (family name p1 p2 p3 rad )
  (format
   t
   "ic_geo_cre_srf_pln_3pnts ~A ~A ~A ~A ~A ~A~%"
   family name p1 p2 p3 rad ))

(defun ic_geo_cre_srf_pln_nrm_pnt (family name pnt nrm rad )
  (format
   t
   "ic_geo_cre_srf_pln_nrm_pnt ~A ~A ~A ~A ~A~%"
   family name pnt nrm rad ))

(defun ic_geo_cre_srf_pln_nrm_dist (family name nrm dist rad )
  (format
   t
   "ic_geo_cre_srf_pln_nrm_dist ~A ~A ~A ~A ~A~%"
   family name nrm dist rad ))

(defun ic_geo_cre_arc_from_pnts (family name p1 p2 p3)
  (format
   t
   "ic_geo_cre_arc_from_pnts ~A ~A {~{~A~^ ~}} {~{~A~^ ~}} {~{~A~^ ~}}~%"
   family name p1 p2 p3))

(defun ic_geo_cre_bsp_crv_n_pnts (family name pnts &optional (tol 0.0001) (deg 3))
  (format
   t
   "ic_geo_cre_bsp_crv_n_pnts ~A ~A ~A ~A ~A~%"
   family name pnts tol deg))

(defun ic_geo_cre_bsp_crv_n_pnts_cons (family name pnts fixPnts tanCons tanIndx &optional (tol 0.001))
  (format
   t
   "ic_geo_cre_bsp_crv_n_pnts_cons ~A ~A ~A ~A ~A ~A ~A~%"
   family name pnts fixPnts tanCons tanIndx tol))

(defun ic_geo_cre_crv_arc_ctr_rad (family name center x_ax normal radius srtang endang )
  (format
   t
   "ic_geo_cre_crv_arc_ctr_rad ~A ~A ~A ~A ~A ~A ~A ~A~%"
   family name center x_ax normal radius srtang endang ))

(defun ic_geo_cre_srf_cyl (family name center x_ax z_ax radius srtang endang length)
  (format
   t
   "ic_geo_cre_srf_cyl ~A ~A {~{~A~^ ~}} {~{~A~^ ~}} {~{~A~^ ~}} ~A ~A ~A ~A~%"
   family name center x_ax z_ax radius srtang endang length))

(defun ic_geo_cre_line (family name p1 p2)
  (format t "ic_geo_cre_line ~A ~A {~{~A~^ ~}} {~{~A~^ ~}}~%"
          family name p1 p2))

(defun ic_geo_cre_pnt (family name pnt &optional (in_lcs 1))
  (format
   t
   "ic_geo_cre_pnt ~A ~A {~{~A~^ ~}} ~A~%" family name pnt in_lcs)
  name)

(defun ic_geo_cre_mat (fam name pt &optional (in_lcs 1))
  (format
   t
   "ic_geo_cre_mat ~A ~A {~{~A~^ ~}} ~A~%"
   fam name pt in_lcs)
  name)

(defun ic_geo_get_srf_nrm (upar vpar srf )

  (format
   t
   "ic_geo_get_srf_nrm ~A ~A ~A~%"
   upar vpar srf ))

(defun ic_geo_get_srf_pos (upar vpar srf )
  (format
   t
   "ic_geo_get_srf_pos ~A ~A ~A~%"
   upar vpar srf ))

(defun ic_geo_cre_pnt_on_srf_at_par (family name upar vpar srf )
  (format
   t
   "ic_geo_cre_pnt_on_srf_at_par ~A ~A ~A ~A ~A~%"
   family name upar vpar srf ))

(defun ic_geo_cre_pnt_on_crv_at_par (family name par crv )
  (format
   t
   "ic_geo_cre_pnt_on_crv_at_par ~A ~A ~A ~A~%"
   family name par crv ))

(defun ic_geo_cre_crv_concat (family name tol crvs )
  (format
   t
   "ic_geo_cre_crv_concat ~A ~A ~A ~A~%"
   family name tol crvs ))

(defun ic_geo_create_curve_concat (family name tol crvs )
  (format
   t
   "ic_geo_create_curve_concat ~A ~A ~A ~A~%"
   family name tol crvs ))

(defun ic_geo_cre_srf_from_contour (family name tol crvs )
  (format
   t
   "ic_geo_cre_srf_from_contour ~A ~A ~A ~A~%"
   family name tol crvs ))

(defun ic_geo_create_surface_from_curves (family name tol crvs &optional (bld_topo 0) )
  (format
   t
   "ic_geo_create_surface_from_curves ~A ~A ~A ~A ~A~%"
   family name tol crvs bld_topo ))

(defun ic_geo_create_param_surface (family name nu nv ord_u ord_v rational u_knots v_knots control_pts loops )
  (format
   t
   "ic_geo_create_param_surface ~A ~A ~A ~A ~A ~A ~A ~A ~A ~A ~A~%"
   family name nu nv ord_u ord_v rational u_knots v_knots control_pts loops ))

(defun ic_geo_list_crv_data (file format crvs )
  (format
   t
   "ic_geo_list_crv_data ~A ~A ~A~%"
   file format crvs ))

(defun ic_geo_list_srf_data (file format srfs )
  (format
   t
   "ic_geo_list_srf_data ~A ~A ~A~%"
   file format srfs ))

(defun ic_geo_make_conn_regions (type entities
                                 &optional (surf_angle 180) (surf_curvature 360) )
  (format
   t
   "ic_geo_make_conn_regions ~A ~A ~A ~A~%"
   type entities surf_angle surf_curvature ))

(defun ic_geo_get_attached_entities (attach_type orig_type entities )
  (format
   t
   "ic_geo_get_attached_entities ~A ~A ~A~%"
   attach_type orig_type entities ))

(defun ic_geo_get_entities_by_attach_num (type num &optional (entities ""))
  (format
   t
   "ic_geo_get_entities_by_attach_num ~A~A~A~%"
   type num entities ))

(defun ic_geo_get_internal_surface_boundary (surf &optional (not_single 0) )
  (format
   t
   "ic_geo_get_internal_surface_boundary ~A ~A~%"
   surf not_single))

(defun ic_geo_find_internal_outer_loops (surfs &optional (not_single 0) (all_boundary 0) )
  (format
   t
   "ic_geo_find_internal_outer_loops ~A ~A ~A~%"
   surfs not_single all_boundary ))

(defun ic_geo_find_internal_surfaces (loop surrounding_surfs
                                           &optional (outer_curves "")
                                                     (exclusion_surfs ""))
  (format
   t
   "ic_geo_find_internal_surfaces ~A ~A ~A ~A~%"
   loop surrounding_surfs outer_curves exclusion_surfs ))

(defun ic_geo_make_conn_buttons (loop &optional (exclusion_surfs "") )
  (format
   t
   "ic_geo_make_conn_buttons ~A ~A~%"
   loop exclusion_surfs ))

(defun ic_geo_split_surfaces_at_thin_regions (srfs tolerance min_res_curve_len )
  (format
   t
   "ic_geo_split_surfaces_at_thin_regions ~A ~A ~A~%"
   srfs tolerance min_res_curve_len ))

(defun ic_geo_surface_create_smart_nodes (srfs tolerance min_res_curve_len )
  (format
   t
   "ic_geo_surface_create_smart_nodes ~A ~A ~A~%"
   srfs tolerance min_res_curve_len ))

(defun ic_geo_surface_topological_corners (surfs )
  (format
   t
   "ic_geo_surface_topological_corners ~A~%"
   surfs ))

(defun ic_geo_flanges_notch_critical_points (surfs )
  (format
   t
   "ic_geo_flanges_notch_critical_points ~A~%"
   surfs ))

(defun ic_geo_trm_srf_at_par (srf par sel )
  (format
   t
   "ic_geo_trm_srf_at_par ~A ~A ~A~%"
   srf par sel ))

(defun ic_geo_trm_srfs_by_curvature (srfs ang )
  (format
   t
   "ic_geo_trm_srfs_by_curvature ~A ~A~%"
   srfs ang ))

(defun ic_surface_curvature (surf &optional (tol 100) (debug 0) )
  (format
   t
   "ic_surface_curvature ~A ~A ~A~%"
   surf tol debug ))

(defun ic_hull_2d (entities
                   &optional (tol 0) (four 1) (type "srface") (shrink 0) (debug 0) )
  (format
   t
   "ic_hull_2d ~A ~A ~A ~A ~A ~A~%"
   entities tol four type shrink debug ))

(defun ic_surface_from_points (points &optional
                                        (part "")
                                        (name ""))
  (format
   t
   "ic_surface_from_points ~A ~A ~A~%"
   points part name ))

(defun ic_geo_surface_extend (curve surfaces
                              &optional
                                (toler 0) (bld_topo 1) (perpendicular 1)
                                (connect 0) (concat_crvs 1) (db 0) )
  (format
   t
   "ic_geo_surface_extend ~A ~A ~A ~A ~A ~A ~A ~A~%"
   curve surfaces toler bld_topo perpendicular connect concat_crvs db ))

(defun ic_geo_cre_srf_crv_drv_srf (family name gencrv ctrcrv
                                   &optional (bld_topo 0) )
  (format
   t
   "ic_geo_cre_srf_crv_drv_srf ~A ~A ~A ~A ~A~%"
   family name gencrv ctrcrv bld_topo  ))

(defun ic_geo_get_types (&optional (which "all"))
  (format
   t
   "ic_geo_get_types ~A~%"
   which  ))

(defun ic_flood_fill_surface_angle (surf curve angle )
  (format
   t
   "ic_flood_fill_surface_angle "
   surf curve angle ))

(defun ic_geo_flood_fill (what ents
                          &optional
                            (all 1)
                            (feat_angle 0)
                            (bound_mode "all")
                            (nedges 0))
  (format
   t
   "ic_geo_flood_fill ~A ~A ~A ~A ~A ~A~%"
   what ents all feat_angle bound_mode nedges ))

(defun ic_geo_get_triangulation_tolerance ()
  (format
   t
   "ic_geo_get_triangulation_tolerance~%"
   ))

(defun ic_geo_convex_hull (entities name fam )
  (format
   t
   "ic_geo_convex_hull ~A ~A ~A~%"
   entities name fam ))

(defun ic_geo_remove_triangles_on_plane (surf plane tol )
  (format
   t
   "ic_geo_remove_triangles_on_plane ~A ~A ~A~%"
   surf plane tol ))

(defun ic_geo_bbox_of_entities (ents )
  (format
   t
   "ic_geo_bbox_of_entities ~A~%"
   ents ))

(defun ic_geo_classify_by_regions (planes entities how )
  (format
   t
   "ic_geo_classify_by_regions ~A ~A ~A~%"
   planes entities how ))

(defun ic_geo_split_surfaces (surfs planes )
  (format
   t
   "ic_geo_split_surfaces ~A ~A~%"
   surfs planes ))

(defun ic_geo_elem_assoc (domain assoc )
  (format
   t
   "ic_geo_elem_assoc ~A~A~%"
   domain assoc ))

(defun ic_geo_cre_bsp_srf_by_pnt_array (family name n_ptu n_ptv pnts
                                        &optional
                                          (tol 0.0001))
  (format
   t
   "ic_geo_cre_bsp_srf_by_pnt_array ~A ~A ~A ~A ~A ~A~%"
   family name n_ptu n_ptv pnts tol ))

(defun ic_geo_cre_geom_input (in_file
                              &optional
                                (fit_tol 0.0001)
                                (mode "input")
                                (pnt_fam "PNT")
                                (pnt_prefix "pnt" )
                                (crv_fam "CRV")
                                (crv_prefix "crv")
                                (srf_fam "SRF")
                                (srf_prefix "srf"))
  (format
   t
   "ic_geo_cre_geom_input ~A ~A ~A ~A ~A ~A ~A ~A ~A~%"
   in_file fit_tol mode pnt_fam pnt_prefix crv_fam crv_prefix srf_fam srf_prefix))

(defun ic_geo_import_str_to_cad (doms &optional
                                        (srf_fam "SRFS")
                                        (crv_fam "")
                                        (pnt_fam ""))
  (format
   t
   "ic_geo_import_str_to_cad ~A ~A ~A ~A~%"
   doms srf_fam crv_fam pnt_fam  ))

(defun ic_geo_crv_data (crvs datums )
  (format
   t
   "ic_geo_crv_data ~A ~A~%"
   crvs datums ))

(defun ic_geo_srf_data (srfs datums )
  (format
   t
   "ic_geo_srf_data ~A ~A~%"
   srfs datums ))

(defun ic_geo_cre_srf_loft_crvs (family name tol crvs
                                 &optional
                                   (sec_ord 4) (form 0) (bld_topo 0) )
  (format
   t
   "ic_geo_cre_srf_loft_crvs ~A ~A ~A ~A ~A ~A ~A~%"
   family name tol crvs sec_ord form bld_topo ))

(defun ic_geo_cre_crv_test_project_surface (family name surface curve dir )
  (format
   t
   "ic_geo_cre_crv_test_project_surface ~A ~A ~A ~A ~A~%"
   family name surface curve dir ))

(defun ic_geo_cre_surface_section (family name surface mode P0 P1
                                   &optional
                                     (P2 "")
                                     (trim 0) )
  (format
   t
   "ic_geo_cre_surface_section ~A ~A ~A ~A ~A ~A ~A~%"
   family name surface mode P0 P1 P2 trim ))

(defun ic_geo_offset (family name surface_to_offset offset
                      &optional
                        (max_factor 3) )
  (format
   t
   "ic_geo_offset ~A ~A ~A ~A ~A~%"
   family name surface_to_offset offset max_factor ))

(defun ic_geo_cre_crv_datred (family name crvs
                              &optional (tol 0.001) )
  (format
   t
   "ic_geo_cre_crv_datred ~A ~A ~A ~A~%"
   family name crvs tol ))

(defun ic_geo_cre_srf_datred (family name srfs &optional (tol 0.001) )
  (format
   t
   "ic_geo_cre_srf_datred ~A ~A ~A ~A~%"
   family name srfs tol ))

(defun ic_geo_cre_srf_sweep (family name gen drv &optional (bld_topo 0) )
  (format
   t
   "ic_geo_cre_srf_sweep ~A ~A ~A ~A ~A~%"
   family name gen drv bld_topo  ))

(defun ic_geo_crv_is_opposite (crv1 crv2 )
  (format
   t
   "ic_geo_crv_is_opposite ~A ~A~%"
   crv1 crv2 ))

(defun ic_geo_crv_is_edge (crv )
  (format
   t
   "ic_geo_crv_is_edge ~A~%"
   crv ))

(defun ic_geo_fix_degen_geom (&optional (switch 0) )
  (format
   t
   "ic_geo_fix_degen_geom ~A~%"
   switch ))

(defun ic_geo_find_nearest_srf_pnt (srf pnt &optional (want_ext 0) )
  (format
   t
   "ic_geo_find_nearest_srf_pnt ~A~A~A~%"
   srf pnt want_ext))

(defun ic_geo_find_nearest_crv_pnt (crv pnt )
  (format
   t
   "ic_geo_find_nearest_crv_pnt ~A ~A~%"
   crv pnt ))

(defun ic_geo_distance_from_surfaces (surfs coords )
  (format
   t
   "ic_geo_distance_from_surfaces ~A ~A~%"
   surfs coords ))

(defun ic_geo_nearest_surface_list (coords surfaces )
  (format
   t
   "ic_geo_nearest_surface_list ~A ~A~%"
   coords surfaces ))

(defun ic_geo_get_crv_nrm (par crv )
  (format
   t
   "ic_geo_get_crv_nrm ~A ~A~%"
   par crv ))

(defun ic_geo_get_crv_pos (par crv )
  (format
   t
   "ic_geo_get_crv_pos ~A ~A~%"
   par crv ))

(defun ic_geo_get_crv_binrm (par crv )
  (format
   t
   "ic_geo_get_crv_binrm ~A ~A~%"
   par crv ))

(defun ic_geo_cvt_uns_to_bsc (family base uns )
  (format
   t
   "ic_geo_cvt_uns_to_bsc ~A ~A ~A~%"
   family base uns ))

(defun ic_geo_srf_area (srfs )
  (format
   t
   "ic_geo_srf_area ~A~%"
   srfs ))

(defun ic_geo_sort_by_srf_area (surf_list &optional (args "") )
  (format
   t
   "ic_geo_sort_by_srf_area ~A ~A~%"
   surf_list args ))

(defun ic_geo_reduce_face (srfs )
  (format
   t
   "ic_geo_reduce_face ~A~%"
   srfs ))

(defun ic_geo_get_crv_tan (par crv )
  (format
   t
   "ic_geo_get_crv_tan ~A ~A~%"
   par crv ))

(defun ic_geo_mod_crv_tanext (crvs dist srtend )
  (format
   t
   "ic_geo_mod_crv_tanext ~A ~A ~A~%"
   crvs dist srtend ))

(defun ic_geo_mod_srf_tanext (srfs dist srtend &optional (bld_topo 0) )

  (format
   t
   "ic_geo_mod_srf_tanext ~A ~A ~A ~A~%"
   srfs dist srtend bld_topo ))

(defun ic_geo_mod_srf_ext (srfs dist edge &optional (bld_topo 0) )
  (format
   t
   "ic_geo_mod_srf_ext ~A ~A ~A ~A~%"
   srfs dist edge bld_topo ))

(defun ic_geo_mod_crv_match_crv (crv1 crv2 &optional (crv1end 0) (crv2end 0) (modes "") )

  (format
   t
   "ic_geo_mod_crv_match_crv ~A ~A ~A ~A ~A~%"
   crv1 crv2 crv1end crv2end modes ))

(defun ic_geo_mod_crv_match_pnt (crv pnt &optional (crvend 0) (modes "") )
  (format
   t
   "ic_geo_mod_crv_match_pnt ~A ~A ~A ~A~%"
   crv pnt crvend modes ))

(defun ic_geo_cre_srf_offset (family name base offset
                              &optional
                                (all_conn 0) (stitch 0) )
  (format
   t
   "ic_geo_cre_srf_offset ~A ~A ~A ~A ~A ~A~%"
   family name base offset all_conn  stitch  ))

(defun ic_geo_build_bodies (&optional
                              (fam "LIVE") (buildtopo 0) (tol 0.01)
                              (multi 0) (newm 0) (surf "")
                              (assem 0) (from_solids 0) )
  (format
   t
   "ic_geo_build_bodies ~A ~A ~A ~A ~A ~A ~A ~A~%"
   fam buildtopo tol multi newm surf assem from_solids ))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun ic_geo_create_volume (matlpt &optional (name "") (fam "LIVE"))

  (format
   t
   "ic_geo_create_volume ~A ~A ~A~%"
   matlpt name fam ))

(defun ic_geo_reset_bodies ()

  (format
   t
   "ic_geo_reset_bodies~%"
   ))

(defun ic_geo_create_body (surfs &optional (name "") (fam "") (quiet 0) )
  (format
   t
   "ic_geo_create_body ~A ~A ~A ~A~%"
   surfs name fam quiet ))

(defun ic_geo_get_body_matlpnt (bdy )
  (format
   t
   "ic_geo_get_body_matlpnt ~A~%"
   bdy ))

(defun ic_geo_srf_radius (srfs )
  (format
   t
   "ic_geo_srf_radius ~A~%"
   srfs ))

(defun ic_geo_cre_srf_offset_edge (family name crv offset )
  (format
   t
   "ic_geo_cre_srf_offset_edge ~A~A~A~A~%"
   family name crv offset ))

(defun ic_geo_body_lower_entities (bdy )
  (format
   t
   "ic_geo_body_lower_entities ~A~%"
   bdy ))

(defun ic_geo_cre_geom_plot3d (in_file
                               &optional
                                 (fit_tol 0.0001)
                                 (pnt_fam "PNT") (pnt_prefix "pnt")
                                         (crv_fam "CRV") (crv_prefix "crv")
                                         (srf_fam "SRF") (srf_prefix "srf"))

  (format
   t
   "ic_geo_cre_geom_plot3d ~A ~A ~A ~A ~A ~A ~A ~A~%"
   in_file fit_tol pnt_fam pnt_prefix crv_fam crv_prefix srf_fam srf_prefix ))

(defun ic_geo_cre_srf_db_pnts (srfs )
  (format
   t
   "ic_geo_cre_srf_db_pnts ~A~%"
   srfs ))

(defun ic_geo_cre_crv_db_pnts (crvs )
  (format
   t
   "ic_geo_cre_crv_db_pnts ~A~%"
   crvs ))

(defun ic_geo_read_off_file (fam name in_file )
  (format
   t
   "ic_geo_read_off_file ~A ~A ~A~%"
   fam name in_file ))

(defun ic_geo_read_xyz_file (fam name in_file off_file &optional (mode "") )
  (format
   t
   "ic_geo_read_xyz_file ~A ~A ~A ~A ~A~%"
   fam name in_file off_file mode ))

(defun ic_geo_crv_is_arc (crvs &optional (tol -1) )
  (format
   t
   "ic_geo_crv_is_arc ~A ~A~%"
   crvs tol ))

(defun ic_geo_get_keypoints (dir border &optional (bb ""))
  (format
   t
   "ic_geo_get_keypoints ~A ~A ~A~%"
   dir border bb ))

(defun ic_geo_reverse_crv (crvs )
  (format
   t
   "ic_geo_reverse_crv ~A~%"
   crvs ))

(defun ic_geo_cre_edge_concat (crvs &optional (require_topo 0) )
  (format
   t
   "ic_geo_cre_edge_concat ~A ~A~%"
   crvs require_topo ))

(defun ic_geo_create_histogram_box (min max lblList )
  (format
   t
   "ic_geo_create_histogram_box ~A ~A ~A~%"
   min max lblList ))

(defun ic_geo_build_topo_on_srfs (srfs
                                  &optional
                                    (crvs "") (tol -1) (trim_srfs 0)
                                    (concat_crvs 0) (quiet 0) )
  (format
   t
   "ic_geo_build_topo_on_srfs ~A ~A ~A ~A ~A ~A~%"
   srfs crvs tol trim_srfs concat_crvs quiet ))

(defun ic_geo_contact_surfaces (surfaces &optional (distance 0) (family "") (debug 0) )
  (format
   t
   "ic_geo_contact_surfaces ~A ~A ~A ~A~%"
   surfaces distance family debug ))

(defun ic_geo_map_tetin_sizes (tetin &optional (what 0) )
  (format
   t
   "ic_geo_map_tetin_sizes ~A ~A~%"
   tetin what ))

(defun ic_geo_surface_thickness (surfaces order &optional (thickness "") )
  (format
   t
   "ic_geo_surface_thickness ~A ~A ~A~%"
   surfaces order thickness ))

(defun ic_geo_srf_in_srf_fam_set (srf fams )
  (format
   t
   "ic_geo_srf_in_srf_fam_set ~A ~A~%"
   srf fams ))

(defun ic_geo_cre_srf_over_holes (fam srfs )
  (format
   t
   "ic_geo_cre_srf_over_holes ~A ~A~%"
   fam srfs ))

(defun ic_geo_subset_exists (name )
  (format
   t
   "ic_geo_subset_exists ~A~%"
   name ))

(defun ic_geo_subset_copy (oldname newname )
  (format
   t
   "ic_geo_subset_copy ~A ~A~%"
   oldname newname ))

(defun ic_geo_subset_clear (name )

  (format
   t
   "ic_geo_subset_clear ~A~%"
   name ))

(defun ic_geo_subset_unused_name (&optional (pref "subset") )
  (format
   t
   "ic_geo_subset_unused_name ~A~%"
   pref ))

(defun ic_geo_subset_delete (name )
  (format
   t
   "ic_geo_subset_delete ~A~%"
   name ))

(defun ic_geo_subset_visible (name vis )
  (format
   t
   "ic_geo_subset_visible ~A ~A~%"
   name vis ))

(defun ic_geo_subset_list_families (name )
  (format
   t
   "ic_geo_subset_list_families ~A~%"
   name ))

(defun ic_geo_subset_list (&optional (pat "*" ))
  (format
   t
   "ic_geo_subset_list ~A~%"
   pat ))

(defun ic_geo_subset_add_items (name items )
  (format
   t
   "ic_geo_subset_add_items ~A ~A~%"
   name items ))

(defun ic_geo_subset_remove_items (name items )
  (format
   t
   "ic_geo_subset_remove_items ~A ~A~%"
   name items ))

(defun ic_geo_subset_handle_bc_changes (items subset add )
  (format
   t
   "ic_geo_subset_handle_bc_changes ~A ~A ~A~%"
   items subset add))

(defun ic_geo_subset_get_items (name )
  (format
   t
   "ic_geo_subset_get_items ~A~%"
   name ))

(defun ic_geo_subset_bbox (name )
  (format
   t
   "ic_geo_subset_bbox ~A~%"
   name ))

(defun ic_geo_subset_add_layer (name all feat_angle bound_mode )
  (format
   t
   "ic_geo_subset_add_layer ~A ~A ~A ~A~%"
   name all feat_angle bound_mode ))

(defun ic_geo_subset_remove_layer (name )
  (format
   t
   "ic_geo_subset_remove_layer ~A"
   name ))

(defun ic_geo_subset_names_to_parts (name )
  (format
   t
   "ic_geo_subset_names_to_parts ~A~%"
   name ))

(defun ic_geo_get_srf_edges (srf )
  (format
   t
   "ic_geo_get_srf_edges ~A~%"
   srf ))

(defun ic_geo_get_vert_edges (pnt )
  (format
   t
   "ic_geo_get_vert_edges ~A~%"
   pnt ))

(defun ic_geo_calc_bisector_pnt (pnt1 pnt2 pnt3 len inverse )
  (format
   t
   "ic_geo_calc_bisector_pnt ~A ~A ~A ~A ~A~%"
   pnt1 pnt2 pnt3 len inverse ))

(defun ic_geo_cre_srf_simple_trim (families names srf crvs )
  (format
   t
   "ic_geo_cre_srf_simple_trim "
   families names srf crvs ))

(defun ic_geo_set_simplification_level (pixels )
  (format
   t
   "ic_geo_set_simplification_level ~A~%"
   pixels ))

(defun ic_surface_thickness_check (names &optional (newfam "") (return_unassigned 0) )
  (format
   t
   "ic_surface_thickness_check ~A ~A ~A~%"
   names newfam return_unassigned ))

(defun ic_geo_close_contour (crvs srf )
  (format
   t
   "ic_geo_close_contour ~A ~A~%"
   crvs srf ))

(defun ic_geo_find_srf_prc_pnt (srf pnt vec )
  (format
   t
   "ic_geo_find_srf_prc_pnt ~A ~A ~A~%"
   srf pnt vec ))

(defun ic_geo_get_dormant (type &optional (only_if_visible "") )
  (format
   t
   "ic_geo_get_dormant ~A ~A~%"
   type only_if_visible ))

(defun ic_geo_get_dormant_entity (type name )
  (format
   t
   "ic_geo_get_dormant_entity ~A ~A~%"
   type name ))

(defun ic_get_facets (type list )
  (format
   t
   "ic_get_facets ~A ~A~%"
   type list ))

(defun ic_geo_filter_curves (angle fams )
  (format
   t
   "ic_geo_filter_curves ~A ~A~%"
   angle fams ))

(defun ic_geo_cre_bridge_crv (fam name crv1 crv2
                              &optional (end1 0) (end2 0)
                                (mag1 0.3) (mag2 0.3) )
  (format
   t
   "ic_geo_cre_bridge_crv ~A ~A ~A ~A ~A ~A ~A ~A~%"
   fam name crv1 crv2 end1 end2 mag1 mag2 ))

(defun ic_geo_cre_pln_crv (fam name crv base nrm )
  (format
   t
   "ic_geo_cre_pln_crv ~A ~A ~A ~A ~A~%"
   fam name crv base nrm ))

(defun ic_geo_pln_n_pnts (pnts )
  (format
   t
   "ic_geo_pln_n_pnts ~A~%"
   pnts ))

(defun ic_geo_sub_get_numbers_by_names (type ent_names )
  (format
   t
   "ic_geo_sub_get_numbers_by_names ~A ~A~%"
   type ent_names ))

(defun ic_geo_get_pnt_marked (name )
  (format
   t
   "ic_geo_get_pnt_marked ~A~%"
   name ))

(defun ic_geo_set_pnt_marked (name set_to )
  (format
   t
   "ic_geo_set_pnt_marked ~A ~A~%"
   name set_to ))

(defun ic_geo_get_all_marked_pnts ()
  (format
   t
   "ic_geo_get_all_marked_pnts~%"
   ))

(defun ic_geo_add_embedded_crv (srf crvs )
  (format
   t
   "ic_geo_add_embedded_crv ~A ~A~%"
   srf crvs ))

(defun ic_geo_add_embedded_pnt (srf pnts )
  (format
   t
   "ic_geo_add_embedded_pnt ~A ~A~%"
   srf pnts ))

(defun ic_geo_is_crv_on_srf (crv srf &optional (tol -1) )
  (format
   t
   "ic_geo_is_crv_on_srf ~A ~A ~A~%"
   crv srf tol ))

(defun ic_geo_register_crv (crv_name new_fam )
  (format
   t
   "ic_geo_register_crv ~A ~A~%"
   crv_name new_fam ))

(defun ic_geo_cre_midline_crv (&optional (crvs "") (toldebug 0) (crvs2 "") (fam "") )
  (format
   t
   "ic_geo_cre_midline_crv ~A ~A ~A ~A~%"
   crvs toldebug crvs2 fam ))

(defun ic_geo_get_points_from_curves (curves )
  (format
   t
   "ic_geo_get_points_from_curves ~A~%"
   curves ))

(defun ic_geo_test_cmd (vec pnt crvs srfs )
  (format
   t
   "ic_geo_test_cmd ~A ~A ~A ~A~%"
   vec pnt crvs srfs ))

(defun ic_geo_cre_crv_ell (family name center srt_pnt next_pnt
                           &optional (srtang 0) (endang 360) )

  (format
   t
   "ic_geo_cre_crv_ell ~A ~A ~A ~A ~A ~A ~A~%"
   family name center srt_pnt next_pnt srtang endang ))

(defun ic_geo_improve_edge (crvs )
  (format
   t
   "ic_geo_improve_edge ~A~%"
   crvs ))

(defun ic_geo_just_do_it (srfs )
  (format
   t
   "ic_geo_just_do_it ~A~%"
   srfs ))

(defun ic_geo_get_prism_families ()
  (format
   t
   "ic_geo_get_prism_families~%"
   ))

(defun ic_geo_set_prism_families (prism_fams &optional (excl 1) )
  (format
   t
   "ic_geo_set_prism_families ~A ~A~%"
   prism_fams excl ))

(defun ic_geo_get_prism_family_params (fam )
  (format
   t
   "ic_geo_get_prism_family_params ~A"
   fam ))

(defun ic_geo_set_prism_family_params (fam args )
  (format
   t
   "ic_geo_set_prism_family_params ~A ~A~%"
   fam args ))

(defun ic_geo_create_tglib_sfbgrid (args )
  (format
   t
   "ic_geo_create_tglib_sfbgrid ~A~%"
   args ))

(defun ic_vcalc (&optional (op "") args )
  (format
   t
   "ic_vcalc ~A ~A~%"
   op args ))

(defun ic_highlight (args )
  (format
   t
   "ic_highlight ~A~%"
   args ))

(defun ic_vset (args )
  (format
   t
   "ic_vset ~A~%"
   args ))

(defun ic_curve (method part name def args )
  (format
   t
   "ic_curve ~A ~A ~A ~A ~A~%"
   method part name def args ))
  
(defun ic_geo_get_crv_data_at_par (par crv)
  (format
   t
   "ic_geo_get_crv_data_at_par ~A ~A~%"
   par crv))
