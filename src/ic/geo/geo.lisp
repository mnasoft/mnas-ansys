;;;; ./src/icem/geometry.lisp

(defpackage #:ic/geo
  (:use #:cl)
  (:export  load-tetin
            empty-tetin
            save-tetin
            unload-tetin
            ic_geo_import_mesh
            update-surface-display
            ic_geo_export_to_mesh
            ic_ddn_app
            ic_geo_summary
            ic_geo_lookup_family_pid
            ic_geo_is_loaded
            ic_geo_is_modified
            ic_geo_valid_name
            ic_geo_set_modified
            ic_geo_check_family
            ic_geo_check_part
            ic_geo_new_family
            ic_geo_new_name
            ic_geo_get_unused_part
            ic_geo_delete_family
            ic_geo_params_blank_done
            ic_geo_match_name
            ic_geo_update_visibility
            ic_geo_get_visibility
            ic_geo_set_visible_override
            ic_geo_temporary_visible
            ic_geo_get_temporary_invisible
            ic_geo_set_visible_override_families_and_types
            ic_redraw_geometry
            ic_geo_incident
            ic_geo_surface_get_objects
            ic_geo_loop_get_objects
            ic_geo_surface_edges_incident_to_curve
            ic_geo_surface_normals_orient
            ic_geo_get_side_surfaces
            ic_geo_boundary
            ic_geo_object_visible
            ic_geo_configure_objects
            ic_geo_configure_one_attribute
            ic_geo_configure_one_object
            list-families
            ic_geo_list_parts
            ic_geo_check_part
            ic_geo_list_families_in_part
            ic_geo_list_families_with_group
            ic_geo_list_parts_with_group
            ic_geo_family_is_empty
            ic_geo_family_is_empty_except_dormant
            ic_geo_non_empty_families
            ic_geo_non_empty_families_except_dormant
            ic_geo_num_objects
            ic_geo_list_visible_objects
            ic_geo_num_visible_objects
            ic_geo_num_segments
            ic_geo_set_family
            ic_geo_set_part
            ic_geo_set_name
            ic_geo_rename_family
            ic_geo_replace_entity
            ic_geo_get_ref_size
            ic_set_meshing_params
            ic_get_mesh_growth_ratio
            ic_get_meshing_params
            ic_geo_scale_meshing_params
            ic_geo_set_curve_bunching
            ic_geo_get_curve_bunching
            ic_geo_create_surface_segment
            ic_geo_create_curve_segment
            ic_geo_split_curve
            ic_geo_split_curve_at_point
            ic_geo_create_loop
            ic_geo_modify_loop
            ic_geo_pick_location
            ic_geo_get_object_type
            ic_geo_trim_surface
            ic_geo_intersect_surfaces
            ic_geo_intersect_surfs_by_groups
            ic_geo_create_unstruct_curve_from_points
            ic_geo_create_unstruct_surface_from_points
            ic_geo_create_empty_unstruct_surface
            ic_geo_create_empty_unstruct_curve
            ic_geo_create_curve_ends
            ic_geo_mod_crv_set_end
            ic_geo_crv_get_end
            ic_geo_create_points_curveinter
            ic_geo_create_point_location
            ic_geo_create_material_location
            ic_geo_create_density
            ic_geo_extract_points
            ic_geo_extract_curves
            ic_geo_create_surface_edges
            ic_geo_get_srf_edges
            ic_geo_stats
            ic_geo_get_point_location
            ic_geo_get_material_location
            ic_set_point_location
            ic_set_material_location
            ic_delete_material
            ic_geo_check_objects_exist
            ic_geo_get_objects
            ic_geo_count_in_family
            ic_geo_objects_in_family
            ic_geo_objects_in_parts
            ic_geo_get_internal_object
            ic_geo_get_name_of_internal_object
            ic_geo_get_text_point
            ic_geo_get_centroid
            ic_geo_num_segments
            ic_geo_num_nodes
            ic_geo_get_node
            ic_geo_drag_nodes
            ic_geo_drag_point
            ic_geo_drag_material
            ic_geo_drag_body
            ic_geo_project_point
            ic_geo_project_and_move_point
            ic_geo_project_coords
            ic_geo_nearest_object
            ic_geo_project_curve_to_surface
            ic_geo_create_surface_curves
            ic_geo_create_surface_curtain
            ic_geo_set_node
            ic_geo_get_family
            ic_geo_get_part
            ic_build_topo
            ic_geo_default_topo_tolerance_old
            ic_delete_geometry
            ic_geo_pnt_mrg_inc_crv
            ic_facetize_geometry
            ic_move_geometry
            ic_geo_duplicate
            ic_geo_fixup
            ic_geo_min_edge_length
            ic_geo_coarsen
            ic_geo_gap_repair
            ic_geo_midsurface
            ic_geo_lookup
            ic_geo_get_entity_types
            ic_geo_memory_used
            ic_geo_project_mode
            ic_csystem_get_current
            ic_csystem_set_current
            ic_csystem_list
            ic_csystem_get
            ic_csystem_delete
            ic_csystem_create
            ic_coords_into_global
            ic_coords_dir_into_global
            ic_coords_into_local
            ic_csystem_display
            ic_geo_untrim_surface
            ic_geo_get_thincuts
            ic_geo_set_thincuts
            ic_geo_get_periodic_data
            ic_geo_set_periodic_data
            ic_geo_get_family_param
            set-family-params
            ic_geo_reset_family_params
            ic_geo_delete_unattached
            ic_geo_remove_feature
            ic_geo_merge_curves
            ic_geo_modify_curve_reappr
            ic_geo_modify_surface_reappr
            ic_geo_reset_data_structures
            ic_geo_params_update_show_size
            ic_geo_stlrepair_holes
            ic_geo_stlrepair_edges
            ic_show_geo_selected
            ic_reset_geo_selected
            ic_get_geo_selected
            ic_set_geo_selected
            ic_select_geometry_option
            ic_geo_add_segment
            ic_geo_delete_segments
            ic_geo_restrict_segments
            ic_geo_split_segments
            ic_geo_split_edges
            ic_geo_split_one_edge
            ic_geo_swap_edges
            ic_geo_move_segments
            ic_geo_move_node
            ic_geo_merge_nodes
            ic_geo_merge_nodes_tol
            ic_geo_merge_surfaces
            ic_geo_merge_objects
            ic_geo_merge_points_tol
            ic_geo_finish_edit
            ic_geo_delete_if_empty
            ic_geo_smallest_segment
            ic_geo_get_config_param
            ic_geo_set_config_param
            ic_geo_set_tag
            ic_geo_highlight_segments
            ic_geo_bounding_box
            ic_geo_bounding_box2
            ic_geo_model_bounding_box
            ic_geo_feature_size
            ic_geo_replace_surface_mesh
            ic_geo_replace_curve_mesh
            ic_geo_vec_diff
            ic_geo_vec_dot
            ic_geo_vec_mult
            ic_geo_vec_nrm
            ic_geo_vec_len
            ic_geo_pnt_dist
            ic_geo_vec_smult
            ic_geo_vec_sum
            ic_geo_crv_length
            ic_geo_cre_srf_rev
            ic_geo_cre_crv_iso_crv
            ic_geo_cre_srf_pln_3pnts
            ic_geo_cre_srf_pln_nrm_pnt
            ic_geo_cre_srf_pln_nrm_dist
            ic_geo_cre_arc_from_pnts
            ic_geo_cre_bsp_crv_n_pnts
            ic_geo_cre_bsp_crv_n_pnts_cons
            ic_geo_cre_crv_arc_ctr_rad
            ic_geo_cre_srf_cyl
            ic_geo_cre_line
            ic_geo_cre_pnt
            cre-mat
            ic_geo_get_srf_nrm
            ic_geo_get_srf_pos
            ic_geo_cre_pnt_on_srf_at_par
            ic_geo_cre_pnt_on_crv_at_par
            ic_geo_cre_crv_concat
            ic_geo_create_curve_concat
            ic_geo_cre_srf_from_contour
            ic_geo_create_surface_from_curves
            ic_geo_create_param_surface
            ic_geo_list_crv_data
            ic_geo_list_srf_data
            ic_geo_make_conn_regions
            ic_geo_get_attached_entities
            ic_geo_get_entities_by_attach_num
            ic_geo_get_internal_surface_boundary
            ic_geo_find_internal_outer_loops
            ic_geo_find_internal_surfaces
            ic_geo_make_conn_buttons
            ic_geo_split_surfaces_at_thin_regions
            ic_geo_surface_create_smart_nodes
            ic_geo_surface_topological_corners
            ic_geo_flanges_notch_critical_points
            ic_geo_trm_srf_at_par
            ic_geo_trm_srfs_by_curvature
            ic_surface_curvature
            ic_hull_2d
            ic_surface_from_points
            ic_geo_surface_extend
            ic_geo_cre_srf_crv_drv_srf
            ic_geo_get_types
            ic_flood_fill_surface_angle
            ic_geo_flood_fill
            ic_geo_get_triangulation_tolerance
            ic_geo_convex_hull
            ic_geo_remove_triangles_on_plane
            ic_geo_bbox_of_entities
            ic_geo_classify_by_regions
            ic_geo_split_surfaces
            ic_geo_elem_assoc
            ic_geo_cre_bsp_srf_by_pnt_array
            ic_geo_cre_geom_input
            ic_geo_import_str_to_cad
            ic_geo_crv_data
            ic_geo_srf_data
            ic_geo_cre_srf_loft_crvs
            ic_geo_cre_crv_test_project_surface
            ic_geo_cre_surface_section
            ic_geo_offset
            ic_geo_cre_crv_datred
            ic_geo_cre_srf_datred
            ic_geo_cre_srf_sweep
            ic_geo_crv_is_opposite
            ic_geo_crv_is_edge
            ic_geo_fix_degen_geom
            ic_geo_find_nearest_srf_pnt
            ic_geo_find_nearest_crv_pnt
            ic_geo_distance_from_surfaces
            ic_geo_nearest_surface_list
            ic_geo_get_crv_nrm
            ic_geo_get_crv_pos
            ic_geo_get_crv_binrm
            ic_geo_cvt_uns_to_bsc
            ic_geo_srf_area
            ic_geo_sort_by_srf_area
            ic_geo_reduce_face
            ic_geo_get_crv_tan
            ic_geo_mod_crv_tanext
            ic_geo_mod_srf_tanext
            ic_geo_mod_srf_ext
            ic_geo_mod_crv_match_crv
            ic_geo_mod_crv_match_pnt
            ic_geo_cre_srf_offset
            ic_geo_build_bodies
            ic_geo_create_volume
            ic_geo_reset_bodies
            ic_geo_create_body
            ic_geo_get_body_matlpnt
            ic_geo_srf_radius
            ic_geo_cre_srf_offset_edge
            ic_geo_body_lower_entities
            ic_geo_cre_geom_plot3d
            ic_geo_cre_srf_db_pnts
            ic_geo_cre_crv_db_pnts
            ic_geo_read_off_file
            ic_geo_read_xyz_file
            ic_geo_crv_is_arc
            ic_geo_get_keypoints
            ic_geo_reverse_crv
            ic_geo_cre_edge_concat
            ic_geo_create_histogram_box
            ic_geo_build_topo_on_srfs
            ic_geo_contact_surfaces
            ic_geo_map_tetin_sizes
            ic_geo_surface_thickness
            ic_geo_srf_in_srf_fam_set
            ic_geo_cre_srf_over_holes
            ic_geo_subset_exists
            ic_geo_subset_copy
            ic_geo_subset_clear
            ic_geo_subset_unused_name
            ic_geo_subset_delete
            ic_geo_subset_visible
            ic_geo_subset_list_families
            ic_geo_subset_list
            ic_geo_subset_add_items
            ic_geo_subset_remove_items
            ic_geo_subset_handle_bc_changes
            ic_geo_subset_get_items
            ic_geo_subset_bbox
            ic_geo_subset_add_layer
            ic_geo_subset_remove_layer
            ic_geo_subset_names_to_parts
            ic_geo_get_srf_edges
            ic_geo_get_vert_edges
            ic_geo_calc_bisector_pnt
            ic_geo_cre_srf_simple_trim
            ic_geo_set_simplification_level
            ic_surface_thickness_check
            ic_geo_close_contour
            ic_geo_find_srf_prc_pnt
            ic_geo_get_dormant
            ic_geo_get_dormant_entity
            ic_get_facets
            ic_geo_filter_curves
            ic_geo_cre_bridge_crv
            ic_geo_cre_pln_crv
            ic_geo_pln_n_pnts
            ic_geo_sub_get_numbers_by_names
            ic_geo_get_pnt_marked
            ic_geo_set_pnt_marked
            ic_geo_get_all_marked_pnts
            ic_geo_add_embedded_crv
            ic_geo_add_embedded_pnt
            ic_geo_is_crv_on_srf
            ic_geo_register_crv
            ic_geo_cre_midline_crv
            ic_geo_get_points_from_curves
            ic_geo_test_cmd
            ic_geo_cre_crv_ell
            ic_geo_improve_edge
            ic_geo_just_do_it
            ic_geo_get_prism_families
            ic_geo_set_prism_families
            ic_geo_get_prism_family_params
            ic_geo_set_prism_family_params
            ic_geo_create_tglib_sfbgrid
            ic_vcalc
            ic_highlight
            ic_vset
            ic_curve
            ic_geo_get_crv_data_at_par
            )
  (:documentation
   " Пакет предназначен для создания геометрии через API системы ANSYS ICEM CFD."
   ))

(in-package #:ic/geo)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun load-tetin (filenames &optional (tri_tolerance 0) (keep_model_params 1) (blanks 0) (quiet 0))
 "ic_load_tetin

 These functions manipulate the geometric data which is loaded in
from the tetin file. Geometric entities are referenced by type and
name. For every entity of a given type there is a unique name, and
every entity is in a given family which is generally transferred to
the mesh that is created from the geometry. The types are:

    surface: surfaces, which may be either trimmed NURBS surfaces or
    faceted (from STL or other triangular formats). Surfaces
    correspond to regions of triangles or quads in the mesh, and nodes
    in the mesh that fall on a surface have a dimension of 2.

    curve: either NURBS curves or piecewise linear paths. Curves
    correspond to bar elements and nodes with dimension 1.

    point: prescribed points. These correspond to NODE elements in the
    mesh and nodes with dimension 0.

    material: material points. These define connected regions, where
    all volume elements are assigned the family of the material point.

    loop: a list of curves which defines a closed loop, which is used
    by the Quad surface mesher.

    density: a density polygon is a set of points that define a convex
    hull, in which the size of the tetra elements must be no greater
    than a specified value.

Load the specified tetin files. The full path names must be given. If
the tri_tolerance is specified, that becomes the new triangulation
tolerance for the file, overriding what is specified.

Notes:

    The tetin file will be merged with any existing geometry already
    loaded. See also ic_unload_tetin.

    On Windows use the \"/\" character as the path delimiter instead
    of the backslash \"\\\" character. For example:

    ic_load_tetin c:/speed_racer/mach5.tin

ic_empty_tetin

Creates an empty geometry database.
"  
  (format
   t
   "ic_load_tetin ~A ~A ~A ~A ~A~%"
   filenames tri_tolerance keep_model_params blanks quiet))

(defun empty-tetin ()
 "ic_empty_tetin

 Creates an empty geometry database."  
  (format
   t
   "ic_empty_tetin~%"))

(defun save-tetin (file &optional (only_visible 0) (v4 0) (only_fams "") (only_ents "") (v10 0) (quiet 0) (clear_undo 1))
" 
Saves the current geometry data to the given file name. The full
path name must be specified. If only_visible is 1 then only the
visible data will be saved. If v4 is 1 then the tetin file will be
saved in Ansys ICEM CFD 4.x compatibility mode.

Note: On Windows use the \"/\" character as the path delimiter instead
of the backslash \"\\\" character. For example:

ic_save_tetin c:/speed_racer/mach5.tin"  
  (format
   t
   "ic_save_tetin ~A ~A ~A ~A ~A ~A ~A ~A~%"
   file only_visible v4 only_fams only_ents v10 quiet clear_undo))

(defun unload-tetin (&optional (quiet 0))
 "
Unloads the current geometry data."  
  (format
   t
   "ic_unload_tetin ~A~%"
   quiet))


(defun ic_geo_import_mesh (&optional  (domains "") (do_seg 1) (no_orfn 1) (do_merge 1))
 "
Imports a mesh file and creates a tetin database. Surface elements are
turned into surfaces (by family), bar elements to curves, node
elements to prescribed points, and one volume element per family to
material points. If domains is \"\" then it will be imported from the
loaded unstructured mesh. If do_seg is 1, then the curves and surfaces
will be segmented by connectivity, else they will be kept as one
object per family. If no_orfn is 1, then any elements that were in the
ORFN (0) family will be moved to a new family called MOVED_ORFN."  
    (format
     t
     "ic_geo_import_mesh ~A ~A ~A ~A ~%"
     domains do_seg no_orfn do_merge))

(defun update-surface-display (obj)
  "update_surface_display

Utility to update display of surface and related edges, vertices."  
  (format
   t
   "update_surface_display ~A~%"
   obj))

(defun ic_geo_export_to_mesh (merge &optional (fams "") (quiet 0))
 "
Copies the current geometry
into the mesh database. 

This is the opposite of ic_geo_import_mesh. 
Surfaces will be turned into families of triangles, etc. 
If merge is 1, then all surfaces, etc will keep their families, and if 0, 
then the geometric objects will each be mapped
 to a separate family in the 
mesh."  
  (format
   t
   "ic_geo_export_to_mesh ~A ~A ~A~%"
   merge fams quiet))

(defun ic_ddn_app (type partname partdir extra_cmds &optional (batch 1))
 " ic_ddn_app type partname partdir extra_cmds batch [1]

Runs either DDN or a DDN GPL application.

    type:

    type may be ddn, mif, input, or frontal.

    partname and partdir:

    The partname and partdir arguments map to the DDN pn and db command line arguments.

    extra_cmds:

    extra_cmds is a list of lines that will go into the input file after the commands to start up the GPL application.

    batch

    If batch is 1 (the default) then DDN will be run without graphics.

Note:  This command is currently broken in MED 4.2 08/16/01"  
"
Runs either DDN or a DDN GPL application.

    type:

    type may be ddn, mif, input, or frontal.

    partname and partdir:

    The partname and partdir arguments map to the DDN pn and db command line arguments.

    extra_cmds:

    extra_cmds is a list of lines that will go into the input file after the commands to start up the GPL application.

    batch

    If batch is 1 (the default) then DDN will be run without graphics.

Note:  This command is currently broken in MED 4.2 08/16/01



 ic_list_ddn_parts dir update

Updates the DDDN directory file.
dir 	name of parts directory
update 	1 = update the directory
return	List of DDN parts
"  
  (format
   t
   "ic_ddn_app ~A ~A ~A ~A ~A~%"
   type partname partdir extra_cmds batch))

(defun ic_geo_summary ()
 "Prints"  
  (format
   t
   "ic_geo_summary~%"
   ))

(defun ic_geo_lookup_family_pid (fam)
"
Returns the internal numeric id (pid) of the family. This is not a safe function to use in general because the pid is not guaranteed to stay the same between one invocation of the program and the next, and no scripting commands use it as an argument.
"  
  (format
   t
   "ic_geo_lookup_family_pid ~A~%"
   fam))

(defun ic_geo_is_loaded ()
 " Reports "  
  (format
   t
   "ic_geo_is_loaded~%"
   ))

(defun ic_geo_is_modified ()
"
Reports if the current geometry has been modified since the last save.
"  
  (format
   t
   "ic_geo_is_modified~%"
   ))

(defun ic_geo_valid_name (name no_colon )
"
Changes a name into a valid family/entity name.
"  
  (format
   t
   "ic_geo_valid_name ~A ~A~%"
   name no_colon ))

(defun ic_geo_set_modified (on )
"
Sets the modified flag for the current geometry. This should not be used for most operations since they set this flag themselves.
"  
  (format
   t
   "ic_geo_set_modified ~A~%"
   on ))

(defun ic_geo_check_family (name )
"
Checks whether a family exists.
"  
  (format
   t
   "ic_geo_check_family ~A~%"
   name))

(defun ic_geo_check_part (name )
"
Checks if a part exists.
"  
  (format
   t
   "ic_geo_check_part ~A~%"
   name ))

(defun ic_geo_new_family (name &optional (do_update 1) )
"
Creates a new family if it is not already there. Returns 1 if a new family was created, or 0 if it already existed.

Note:   The newly created family will not appear in the interactive family list unless you issue the update_family_display command interactively.
"  

  (format
   t
   "ic_geo_new_family ~A ~A~%"
   name do_update))

(defun ic_geo_new_name (type prefix )
"
Creates a new, unused name for an entity in a family.
"  

  (format
   t
   "ic_geo_new_name "
   type prefix ))

(defun ic_geo_get_unused_part (prefix &optional (no_first_num 0))
"
Creates a new unused part or family name.
"  
  (format
   t
   "ic_geo_get_unused_part ~A ~A~%"
   prefix no_first_num ))

(defun ic_geo_delete_family (names )
"
Deletes a family, or a list of families.
"  
  (format
   t
   "ic_geo_delete_family ~A~%"
   names ))

(defun ic_geo_params_blank_done (type &optional (reset 0) )
"
Blanks those entities that have some meshing parameters already defined. If reset == 1, then the entities blanked entities are unblanked.
"  
  (format
   t
   "ic_geo_params_blank_done ~A ~A~%"
   type reset))

(defun ic_geo_match_name (type pat )
"
Returns the names of the objects that match a given pattern.
"  
  (format
   t
   "ic_geo_match_name ~A ~A~%"
   type pat ))

(defun ic_geo_update_visibility (type vis_fams visible )
"
Changes the visibility so that only objects with the given families and type are visible or not, depending on the visible option. If vis_fams is *skip* then they are retained and the type is checked. If a family is not listed in the family list then it is ignored.
"  
  (format
   t
   "ic_geo_update_visibility ~A ~A ~A~%"
   type vis_fams visible ))

(defun ic_geo_get_visibility (type name)
"
Returns whether an object is visible or not.
"  
  (format
   t
   "ic_geo_get_visibility ~A ~A~%"
   type name))

(defun ic_geo_set_visible_override (type name val )
"
Sets or unsets the visible_override flag. If this flag is set for an object then it is always visible no matter what types and families are enabled. This is needed for geometry subsets.
"  
  (format
   t
   "ic_geo_set_visible_override ~A ~A ~A~%"
   type name val ))

(defun ic_geo_temporary_visible (type objects vis &optional (force 0) )
"
Temporarily blanks or unblanks an object. This will not go away when you change anything larger scale. If objects is set to all then all will be blanked or unblanked.
"  
  (format
   t
   "ic_geo_temporary_visible ~A ~A ~A ~A~%"
   type objects vis force ))

(defun ic_geo_get_temporary_invisible (type &optional (entity ""))
"
Gets the temporarily blanked entities. Returns a list of “type name”, or an empty list if no entity was blanked. Type can be entity (for all types), point, curve, or surface.

Example usage: ic_geo_get_temporary_invisible [type]
"  
  (format
   t
   "ic_geo_get_temporary_invisible ~A ~A~%"
   type entity))

(defun ic_geo_set_visible_override_families_and_types (fams types )
"
This is a helper function that sets the visible_override flag for all objects in some families and types, and clears it for all others. Note that after calling this function all the visible flags on the non-override families will be off.
"  
  (format
   t
   "ic_geo_set_visible_override_families_and_types ~A ~A~%"
   fams types ))

(defun ic_redraw_geometry (type name )
"
This redraws the geometry in case something changes.
"  
  (format
   t
   "ic_redraw_geometry ~A ~A~%"
   type name ))

(defun ic_geo_incident (type names &optional (even_if_dormant 0))
"
Returns what objects of higher dimensionality are incident to this one. Surfaces are incident to curves and curves are incident to points.
"  

  (format
   t
   "ic_geo_incident ~A ~A~%"
   type names even_if_dormant))

(defun ic_geo_surface_get_objects (surface type &optional (embedded_points "") )
"
Returns a list of objects associated to a surface.
"  

  (format
   t
   "ic_geo_surface_get_objects ~A ~A ~A~%"
   surface type embedded_points))

(defun ic_geo_loop_get_objects (loop type &optional (surface ""))
"
Returns a list of objects associated to a loop.
"  
  (format
   t
   "ic_geo_loop_get_objects ~A ~A ~A~%"
   loop type surface ))

(defun ic_geo_surface_edges_incident_to_curve (surfname curvename )
"
Returns the edges in a triangulated surface which are incident to a given curve.
"  
  (format
   t
   "ic_geo_surface_edges_incident_to_curve ~A ~A~%"
   surfname curvename ))

(defun ic_geo_surface_normals_orient (&optional (refsurfname "") (outward 1) )
"
Reorients the normals of surfaces in a model with respect to the given reference surface refsurfname in direction given outward [0|1]. If there is no material point, outward means reverse reference surface before reorienting with respect to it.
"  

  (format
   t
   "ic_geo_surface_normals_orient ~A ~A~%"
   refsurfname outward))

(defun ic_geo_get_side_surfaces (tol how &optional (list "") )
"
Returns a list of surfaces whose normal of magnitude tol does not intersect another surface.
"  
  (format
   t
   "ic_geo_get_side_surfaces ~A ~A ~A~%"
   tol how list))

(defun ic_geo_boundary (type &optional (names "") (outer 0) (even_if_dormant 0) (embedded 0))
" Returns the objects of lower dimensionality which are the boundary
of the one specified. Points are the boundary of curves and curves are
the boundary of surfaces and loops. The list returned has a sublist
for each element in names such that {{c00 c01} {c10 c11} ...}, unless
names is one element, in which case the returned list goes as: \"c00
c01\".. names may be one name, or a list of names. outer may be 0 or
1, indicating what kind of boundaries. even_if_dormant may be 0 or 1,
indicating which additional boundaries. embedded may be 0 or 1,
indicating which additional boundaries.
"  
  (format
   t
   "ic_geo_boundary ~A ~A ~A ~A ~A~%"
   type names outer even_if_dormant embedded))

(defun ic_geo_object_visible (type names visible )
"
Changes the visibility of a specific object or objects. The visible argument is 0 or 1.
"  
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
"
Configures the attributes of all the visible objects of a given type. The arguments are:

    simp : the level of simplification. 0 shows the full detail of the object, and higher values simplify them more: 5 is very simple. In the case of faceted geometry, this value is 1/20 of the angle that is used to extract internal curves

    shade : how to draw the objects: one of wire, solid, solid/wire, or hidden.

    st : if 1 show sizes appropriate for Tetra.

    sp : if 1 show sizes appropriate for Prism.

    sh : if 1 show sizes appropriate for Hexa.

    sq : if 1 show sizes appropriate for Quad.

    names : if 1 show the names of the objects.

    wide : draw wide lines. This value plus 1 is the line thickness.

    dnodes : if 1 display the nodes of the object.

    count : if 1 show curves in different colors:

        green: no surfaces are adjacent to this curve

        yellow: just one surface is adjacent to this curve

        red: two surfaces are adjacent to this curve

        blue: more than two surfaces are adjacent to this curve

    nnum : draw node numbers (internal to the surface or curve, useful for debugging)

    tnum : draw triangle or segment numbers (internal to the surface or curve, useful for debugging)

    norms : draw normals of non-mesh surfaces

    comp : show composite curves

    grey_scale : show all grey scaled

    transparent : show all transparent

    count_quad : show curve element count

    dormant : show dormant elements (points/curves)

    protect : show protected elements (points/curves)

    hardsize : show hard sized curves
"  
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
"
Configure one attribute of a whole type.
"  
  (format
   t
   "ic_geo_configure_one_attribute ~A ~A ~A~%"
   type what val ))

(defun ic_geo_configure_one_object (type name what &optional (val "-"))
"
Configure the attributes of one object.
"  
  (format
   t
   "ic_geo_configure_one_object ~A ~A ~A ~A~%"
   type name what val))

(defun list-families (&optional (only_material 0) (non_empty 0))
" Lists the current families used by geometry objects. If
only_material is 1 then limit the listing to families used by
materials. If non_empty is 1 then list only families which are non
empty.
"  
  (format
   t
   "ic_geo_list_families ~A ~A~%"
   only_material non_empty ))

(defun ic_geo_list_parts (&optional (prefix "") (non_empty 0))
"
Lists the current parts.
"  
  (format
   t
   "ic_geo_list_parts ~A ~A~%"
   prefix non_empty ))

(defun ic_geo_check_part (name )
"
Checks whether a part exists.
"  
  (format
   t
   "ic_geo_check_part ~A~%"
   name ))

(defun ic_geo_list_families_in_part (part )
"
Lists the current families in a part.
"  

  (format
   t
   "ic_geo_list_families_in_part ~A~%"
   part ))

(defun ic_geo_list_families_with_group (gname )
"
Lists the families in a group.
"  
  (format
   t
   "ic_geo_list_families_with_group ~A~%"
   gname ))

(defun ic_geo_list_parts_with_group (gname )
"
Lists the parts that have some family in a group.
"  
  (format
   t
   "ic_geo_list_parts_with_group ~A~%"
   gname ))

(defun ic_geo_family_is_empty (fam )
"
Returns whether or not the family is empty of entities.
"  
  (format
   t
   "ic_geo_family_is_empty ~A~%"
   fam ))

(defun ic_geo_family_is_empty_except_dormant (fam )
"
Returns whether or not the family contains only dormant entities.
"  

  (format
   t
   "ic_geo_family_is_empty_except_dormant ~A~%"
   fam ))

(defun ic_geo_non_empty_families ()
"
Lists all the non-empty families.

Note:  This does not check whether there are directives.
"  
  (format
   t
   "ic_geo_non_empty_families~%"
   ))

(defun ic_geo_non_empty_families_except_dormant ()
"
Lists all the families containing only dormant entities.

Note:  This does not check whether there are directives.
"  
  (format
   t
   "ic_geo_non_empty_families_except_dormant~%"
   ))

(defun ic_geo_num_objects (type )
"
Returns the number of objects of the given type.
"  
  (format
   t
   "ic_geo_num_objects ~A~%"
   type ))

(defun ic_geo_list_visible_objects (type &optional (even_if_dormant 1))
"
Returns the number of visible objects of the given type.
"  
  (format
   t
   "ic_geo_list_visible_objects ~A ~A~%"
   type even_if_dormant ))

(defun ic_geo_num_visible_objects (type &optional (any 0) )
"
Returns the number of visible objects of the given type. If any is 1, specify whether that number is more than 0.
"  
  (format
   t
   "ic_geo_num_visible_objects ~A ~A~%"
   type any))

(defun ic_geo_num_segments (type name )
"
Returns the number of segments or triangles in the object. This returns 2 numbers - the number of segments and the number of nodes.
"  
  (format
   t
   "ic_geo_num_segments ~A ~A~%"
   type name ))

(defun ic_geo_set_family (type newfam how objs &optional (rename 1) )
"
Changes the geometry with the given type and name to family newfam. The first argument tells the type of geometry objects: surface, curve, material, point, density, or loop. The second argument is the new family name to be set. The third argument tells how to select the objects and the fourth is the list of object specifiers. how can be one of the following:

    names: a list of the names of the objects

    numbers: a list of the internal numbers (not for general consumption)

    patterns: a list of glob-patterns that match the names of the objects

    families: a list of the families to select

    all: all objects of that type (the objects list is ignored)

    visible: all visible objects of that type (the objects list is ignored)

    rename: if 1, change the name of the object to match the new family, if appropriate. Note that if this function is called as part of a larger script, the renaming might break things if other parts of the code think they know the names of the objects they are dealing with and those names change beneath them.
"  
  (format
   t
   "ic_geo_set_family ~A ~A ~A ~A ~A~%"
   type newfam how objs rename ))

(defun ic_geo_set_part (type names newpart &optional (rename_part 1) )
"
Moves geometry from one part to a new one. This has to create the new part name and copy the boundary conditions if necessary so that the other groups in the family are not disturbed.
"  
  (format
   t
   "ic_geo_set_part ~A ~A ~A ~A~%"
   type names newpart rename_part ))

(defun ic_geo_set_name (type name newname &optional (make_new 0) (warn 1))
"
Change the geometry with the given type and name to name newname. If make_new is 1 then an unused name that starts with newname is used and this value is returned from the function. If possible newname is used without modification. If make_new is 0 then any objects of that same type and name that already exist will be deleted first.
"  
  (format
   t
   "ic_geo_set_name ~A ~A ~A ~A ~A~%"
   type name newname make_new warn))

(defun ic_geo_rename_family (fam newfam &optional (rename_ents 1) )
"
Rename the family. All objects in fam will now be in nfam. If rename_ents is set, family entities will be renamed.
"  
  (format
   t
   "ic_geo_rename_family ~A ~A ~A~%"
   fam newfam rename_ents ))

(defun ic_geo_replace_entity (type e1name e2name )
"
For two geometry entities of type, the first, of name e1name, will be replaced by the second, of name e2name, as well as being put into the family of the first entity and having the meshing parameters copied from the first to the second. The name of the first entity is appended with _OLD and put into the family ORFN.
"  
  (format
   t
   "ic_geo_replace_entity ~A ~A ~A~%"
   type e1name e2name ))

(defun ic_geo_get_ref_size ()
"
Returns the reference mesh size. This is used to scale all meshing parameter values for display to the user.
"  
  (format
   t
   "ic_geo_get_ref_size ~%"
   ))

(defun ic_set_meshing_params (type num args )
" Set or get the meshing parameters associated with the model or the
geometry. The type and num arguments define what the parameters are
being defined for. The remaining arguments are name/value pairs, so
that the function call might look like

ic_set_meshing_params surface 2 emax 10 erat 13

The num argument can also be a name. Any or all of the meshing
parameters can be specified, and the ones not given are not
modified. Note that all the sizes are in absolute units, not factors
of the reference size. This is different from what you see in the
GUI. The type can be one of the following:

    global: set or get the global parameters like natural size,
    etc. The num argument is ignored. The parameters that are accepted
    are:

        gref: the reference size for the model

        gmax: the maximum size of any element in the mesh

        gnat: the natural size value

        gnatref: the natural size refinement factor

        gedgec: the edge criterion

        gcgap: the number of cells allowed in a gap

        gttol: the triangularization tolerance

        gfast: if the value is 1 then set fast transition

        igwall: if the value is 1 then ignore wall thickness

        grat: the growth ratio value

    curve: set or get the parameters on curve num The parameters that are accepted are:

        emax: the maximum element size

        ehgt: the maximum height

        erat: the size expansion ratio

        ewid: the number of layers of tetrahedra of the same size that should surround a surface

        nlay: the number of quad offset layers

        emin: the minimum size

        edev: the deviation value

    surface: set or get the parameters on surface num The parameters
    that are accepted are:

        emax: the maximum element size

        ehgt: the maximum height

        erat: the size expansion ratio

        hrat: the height expansion ratio

        ewid: the number of layers of tetrahedra of the same size that should surround a surface

        nlay: the number of prism layers

        emin: the minimum size

        edev: the deviation value

    point: set or get the parameters on prescribed point num The
    parameters that are accepted are:

        ehgt: the maximum height

        erat: the size expansion ratio

        hrat: the height expansion ratio

    density: set or get the parameters on density volume num The parameters that are accepted are:

        emax: the maximum element size

    loop: set or get the parameters on loop num The parameters that are accepted are:

        etyp: the element type

    curve_fam, surface_fam, point_fam: set or get the parameters on all objects of the family num (in this case num is not a number but a family name). The accepted parameters are the same as the ones listed for individual objects.

The return value of this function is a list of names and values in the
same format as the arguments, which are the values after the
modification. Therefore to get the current values you can use
ic_set_meshing_paramstypenum with no other arguments.

Note: If you give a family instead of a number then you will get the
parameters only for one of the objects in that family.
"  

  (format
   t
   "ic_set_meshing_params ~A ~A ~A~%"
   type num args ))

(defun ic_get_mesh_growth_ratio ()
"
Returns mesh growth ratio.
"  
  (format
   t
   "ic_get_mesh_growth_ratio~%"
   ))

(defun ic_get_meshing_params (type num )
"
Returns the meshing parameters. This has the advantage over ic_set_meshing_params that it is not recorded in the replay file.
"  
  (format
   t
   "ic_get_meshing_params ~A ~A~%"
   type num ))

(defun ic_geo_scale_meshing_params (types factor )
" Scales the meshing parameters on geometric entities of types by a
factor. If types is all then rescales entities of types \"surface
curve point material density loop\".
"  
  (format
   t
   "ic_geo_scale_meshing_params ~A ~A~%"
   types factor ))

(defun ic_geo_set_curve_bunching (curves args )
"
Sets curve bunching.
"  
  (format
   t
   "ic_geo_set_curve_bunching ~A ~A~%"
   curves args ))

(defun ic_geo_get_curve_bunching (name )
"
Gets curve bunching.
"  
  (format
   t
   "ic_geo_get_curve_bunching ~A~%"
   name ))

(defun ic_geo_create_surface_segment (name how args )
"
Creates new surfaces by segmenting an existing one. The name argument is the name of the existing surface. The how argument describes how to do the segmentation:

    angle: split the surface where the angle exceeds the given value (see below)

    curve: split the surface at the named curves (see below)

    plane: split the surface at the given plane (see below)

    connect: split the surface by connectivity

The remaining optional arguments are:

    angle: the angle to use for splitting

    mintri: the smallest number of triangles to allow in a surface

    curves: a list of curve names to use for splitting

    plane_p: the point to define the plane (in the current LCS)

    plane_n: the normal to define the plane

    keep_old: if 1 then keep the old surface after segmentation. The default is 0

The return value is a list of numbers which are the newly created surfaces.
"  
  (format
   t
   "ic_geo_create_surface_segment ~A ~A ~A~%"
   name how args ))

(defun ic_geo_create_curve_segment (name how args )
"
Creates new curves by segmenting an existing one. The name argument is the name of the existing curve. The how argument describes how to do the segmentation:

    angle: split the curve where the angle exceeds the given value (see below)

    plane: split the curve at the given plane (see below)

    connect: split the curve by connectivity

The remaining optional arguments are:

    angle: the angle to use for splitting

    minedge: the smallest number of edges to allow in a curve

    point: point for splitting

    plane_p: the point to define the plane

    plane_n: the normal to define the plane

    keep_old: if 1 then keep the old curve after segmentation. The default is 0

The return value is a list of numbers which are the newly created curves.
"  
  (format
   t
   "ic_geo_create_curve_segment ~A ~A ~A~%"
   name how args ))

(defun ic_geo_split_curve (curve points )
"curve 	name of the curve
points 	list of points
return	names of curve segments

Note:   This splits the curve in the specified order of the points
"  
  (format
   t
   "ic_geo_split_curve ~A ~A~%"
   curve points ))

(defun ic_geo_split_curve_at_point (curve point &optional (tol 0) )
"
Splits a curve at a point.
curve	name of the curve
point	may be a prescribed point name or {xyz} coordinates
tol	(optional) on curve tolerance
return	names of curve segments (usually 2)

Notes:

    If the trim operation does not segment the curve (e.g. trim at curve endpoint), the result string will be empty.

    If the function returns with the error status set, the result string will contain an error message.

    For example usage, refer to ic_geo_split_curve_at_point.tcl in the Ansys installation directory under v221/icemcfd/Samples/ProgrammersGuide/med_test.
"  
  (format
   t
   "ic_geo_split_curve_at_point ~A ~A ~A~%"
   curve point tol ))

(defun ic_geo_create_loop (name fam how curves all_separate surfs
                           &optional (fams "") (pts "") (crs ""))
"
Creates a loop with the given name and family using the specified curves. If how is names then curves is a list of the names of the curves to use, and if it is families then it is a list of family names. If all_separate is 1 then all the curves are considered individually and if it is 0 then they are all taken together to create the loop. Surfaces are associated to the loop if a list surfs of names of surfaces is given. Optionally the loops can be set to the families in the list fams in order, in the case of all_separate is 1. Points can be added to a loop if a list points of names of points is given.
"  
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
"
Modify 1 loop with the given name using the specified curves, points and surfaces. A list of names of curves must be given. Surfaces are associated to the loop if a list surfs of names of surfaces is given. Points/corners can be added to a loop if a list points of names of points/corners is given.
"  
  (format
   t
   "ic_geo_modify_loop ~A ~A ~A ~A ~A~%"
   name curves surfs pts crs ))

(defun ic_geo_pick_location (args )
"
Selects a geometric entity on the screen. Arguments are:

    line{{x y z} {x y z}}: the line in model space

    typetype: one of: entity, surface, curve, point, material, loop, or density

The return value is a list that contains the type, name, and location on the object.
"  

  (format
   t
   "ic_geo_pick_location ~A~%"
   args ))

(defun ic_geo_get_object_type (type names )
"
Determines whether an object is type param (a trimmed NURBS curve or surface) or mesh (a faceted surface or piecewise linear curve). If both types are present in the list of names mixed is returned.
"  

  (format
   t
   "ic_geo_get_object_type ~A ~A~%"
   type names ))

(defun ic_geo_trim_surface (surf curves &optional (build_topo 1) )
"
Trims the surface by the curves. This creates a new surface with the name of the old surface followed by .cut.$n.
"  
  (format
   t
   "ic_geo_trim_surface ~A ~A ~A~%"
   surf curves build_topo))

(defun ic_geo_intersect_surfaces (fam surfs
                                  &optional
                                    (bsp_flag "")
                                    (multi_flag ""))
"
Intersects the surfaces and creates new intersection curves in the given family.
family	family containing surface
surfs	list of surfaces
bsp_flag 	== \"use_bsp\" - create curves as b-spline
multi_flag	== \"multi_crv\" - create multiple curves
return	names of created curves

Notes:

    When multi_flag is set to \"multi_crv\", the function will produce 1 curve for each connected component of the intersection. When multi_flag is set to \"\", the function will produce 1 unstructured curve.

    Setting the bsp_flag to \"use_bsp\" implies setting the multi_flag

    For example usage, refer to ic_geo_intersect_surfaces.tcl in the Ansys installation directory under v221/icemcfd/Samples/ProgrammersGuide/med_test.
"  
  (format
   t
   "ic_geo_intersect_surfaces ~A ~A ~A ~A~%"
   fam surfs bsp_flag  multi_flag ))

(defun ic_geo_intersect_surfs_by_groups (groups &optional
                                                  (fam "")
                                                  (bsp_flag "")
                                                  (multi_flag ""))
"
Intersects surface groups.

groups can be a list of two forms:

    {srf1 srf2 srf3 ...}

    {{srf1 srf2 srf3 ...} {srf4 srf5 srf6 ...} {srf7 srf8 srf9 ...} ...}

In the first form, every surface is intersected with each other, but curves created from each surface pair intersection will be separate. In the second form, each set is intersected with every other set. Surfaces within each set will not be intersected with each other. Separate curves are still generated from each surface pair intersection.
"  
  (format
   t
   "ic_geo_intersect_surfs_by_groups ~A ~A ~A ~A~%"
   groups fam bsp_flag multi_flag ))

(defun ic_geo_create_unstruct_curve_from_points (name fam pts)
 "
Creates a piecewise linear curve from the points. This curve is
given the specified name and family. pts is a list of triples of
floating point numbers or list of prescribed point names and they are
connected in order. The points are in the current local coordinate
system.
"  
"
Creates a piecewise linear curve from the points. This curve is given the specified name and family. pts is a list of triples of floating point numbers or list of prescribed point names and they are connected in order. The points are in the current local coordinate system.
"  
  (format t "ic_geo_create_unstruct_curve_from_points ~A ~A {~{ {~{~A~^ ~}} ~}}~%"
          name fam pts)
  (format
   t
   "ic_geo_create_unstruct_curve_from_points "
   name fam pts))

(defun ic_geo_create_unstruct_surface_from_points (name fam pts )
"
Creates a surface from 4 points, with the given name and family. pts is a list of 4 triples of floating point numbers or list prescribed point names and 2 triangles are created to make a rectangular surface. The points are in the current local coordinate system.
"  
  (format
   t
   "ic_geo_create_unstruct_surface_from_points ~A ~A ~A~%"
   name fam pts ))

(defun ic_geo_create_empty_unstruct_surface (name fam )
"
Creates an empty surface, with the given name and family.
"  
  (format
   t
   "ic_geo_create_empty_unstruct_surface ~A ~A ~%"
   name fam ))

(defun ic_geo_create_empty_unstruct_curve (name fam )
"
Creates an empty curve, with the given name and family.
"  
  (format
   t
   "ic_geo_create_empty_unstruct_curve ~A ~A~%"
   name fam ))

(defun ic_geo_create_curve_ends (names )
"
Creates points at the ends of the named curve.
names	names of curve
return	names of created points

Note:   This function creates new points at curve endpoints as needed. See also ic_geo_mod_crv_set_end.
"  
  (format
   t
   "ic_geo_create_curve_ends {~{~A~^ ~}}~%"
   names ))

(defun ic_geo_mod_crv_set_end (crv pnt crvend &optional (tol -1)] )
"
Sets the curve end.
crv	name of curve
pnt	name of prescribed point
crvend	curve end indicator
tol	merge tolerance
return	name of curve vertex

Notes:

    The curve end parameter, crv1end, takes the values:

    start point 0 
    end point 1

    If the curve end is already associated, the function will take no action. The name of the curve end will be returned in any case.

    If the merge tolerance is set negative, the tolerance will default to the triangulation tolerance.

    If the function returns with the error status set, the result string will contain an error message.

    For example usage, refer to ic_geo_mod_crv_set_end.tcl in the Ansys installation directory under v221/icemcfd/Samples/ProgrammersGuide/med_test.
"  
  (format
   t
   "ic_geo_mod_crv_set_end ~A ~A ~A ~A~%"
   crv pnt crvend tol))

(defun ic_geo_crv_get_end (crv crvend )
"
Returns the curve end.
crv	name of curve
crvend	curve end indicator
return	name of curve vertex

Notes:

    The curve end parameter, crv1end, takes the values:

    start point 0
    end point 1

    If the curve end is not already associated, the function will return an error which must be caught.
"  

  (format
   t
   "ic_geo_crv_get_end ~A ~A~%"
   crv crvend ))

(defun ic_geo_create_points_curveinter (curves tol fam &optional (name) )
"
Creates points at the intersection of curves. curves is a list of curves to intersect.
"  
  (format
   t
   "ic_geo_create_points_curveinter ~A ~A ~A ~A~%"
   curves tol fam name))

(defun ic_geo_create_point_location (fam pt &optional (in_lcs 1) )
"
This function has been replaced by ic_geo_cre_pnt
"  
  (format
   t
   "ic_geo_create_point_location ~A ~A ~A~%"
   fam pt in_lcs))

(defun ic_geo_create_material_location (fam pt )
"
This function has been replaced by ic_geo_cre_mat
"  
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
"
Creates a density polygon from a set of points. It is given the specified name and tetra size. Stretch factor with direction may be specified optionally.
name	name of polygon
size	tetra size (must be > 0)
pts	list of points (must have 4 or more)
width	size of constant spacing layer
ratio	expansion rate
strfac	stretch factor
strvec	stretch direction

Note:   Points may be passed either as 3-tuples or as names of prescribed points.
"  

  (format
   t
   "ic_geo_create_density ~A ~A ~A ~A ~A ~A ~A~%"
   name size pts width ratio strfac strvec  ))

(defun ic_geo_extract_points (names angle )
"
Extracts points from curves based on the angle between adjacent segments in degrees.
"  

  (format
   t
   "ic_geo_extract_points "
   names angle ))

(defun ic_geo_extract_curves (names bound angle minedge )
"
Extracts curves from mesh surfaces. If bound is 1 then only the boundary of the surface is extracted. If it is 0 then the angle is used to determine feature lines. The minedge argument determines what the smallest curve that will be extracted is.
"  
  (format
   t
   "ic_geo_extract_curves ~A ~A ~A ~A~%"
   names bound angle minedge ))

(defun ic_geo_create_surface_edges (names )
"
Creates curves based on the edges of a surface.
"  
  (format
   t
   "ic_geo_create_surface_edges ~A~%"
   names ))

(defun ic_geo_get_srf_edges (srf )
"
Get any curves associated as edges to a surface.
"  
  (format
   t
   "ic_geo_get_srf_edges ~A~%"
   srf ))

(defun ic_geo_stats (type name )
"
Returns some statistics about the object. This is a readable string that says what the type is, how many triangles, nodes, etc.
"  
  (format
   t
   "ic_geo_stats ~A ~A~%"
   type name ))

(defun ic_geo_get_point_location (name )
"
Given the name of a point, returns its location.
"  
  (format
   t
   "ic_geo_get_point_location ~A~%"
   name ))

(defun ic_geo_get_material_location (name )
"
Given the name of a material point, returns its location.
"  
  (format
   t
   "ic_geo_get_material_location ~A~%"
   name ))

(defun ic_set_point_location (args )
"
Sets the location of a point or points. The names and locations must come in pairs.
"  
  (format
   t
   "ic_set_point_location ~A~%"
   args ))

(defun ic_set_material_location (args )
"
Sets the location of one or more material points. The names and locations must come in pairs.
"  
  (format
   t
   "ic_set_material_location ~A~%"
   args ))

(defun ic_delete_material (names )
"
Deletes a material.
"  
  (format
   t
   "ic_delete_material ~A~%"
   names ))

(defun ic_geo_check_objects_exist (type args )
"
This function checks to make sure the objects exist - it returns the list of names that were found. If no objects with the given type and names were found it returns an empty list.
"  
  (format
   t
   "ic_geo_check_objects_exist ~A ~A~%"
   type args ))

(defun ic_geo_get_objects (types
                           &optional
                             (fams "")
                             (even_if_dormant 0))
" This function returns all the objects of the given type and
family. If the family does not exist it returns an empty list, and if
it is \"\" then it returns all objects of all families.
"  
  (format
   t
   "ic_geo_get_objects ~A ~A ~A~%"
   types fams even_if_dormant))

(defun ic_geo_count_in_family (types fams )
"
Returns the number of objects of the given type in the given family.
"  
  (format
   t
   "ic_geo_count_in_family ~A ~A~%"
   types fams ))

(defun ic_geo_objects_in_family (types fams )
"
Returns a list of objects in the given family name.
"  
  (format
   t
   "ic_geo_objects_in_family ~A ~A~%"
   types fams ))

(defun ic_geo_objects_in_parts (types parts )
"
Returns a list of objects (type/name pairs) in the given parts.
"  
  (format
   t
   "ic_geo_objects_in_parts ~A ~A~%"
   types parts ))

(defun ic_geo_get_internal_object (type name )
"
Returns the internal object associated with a name. This is a bit of a back door.
"  
  (format
   t
   "ic_geo_get_internal_object ~A ~A~%"
   type name ))

(defun ic_geo_get_name_of_internal_object (obj )
"
Returns the name of an internal object. This is a bit of a back door.
"  
  (format
   t
   "ic_geo_get_name_of_internal_object ~A~%"
   obj ))

(defun ic_geo_get_text_point (type name )
"
Returns the text point list for an object, specified by type and name. The list is: \"{xloc yloc zloc} {xdir ydir zdir}\"
"  
  (format
   t
   "ic_geo_get_text_point ~A ~A~~%"
   type name ))

(defun ic_geo_get_centroid (type name )
"
Returns the centroid for an object, specified by type and name. The return is: \"{xloc yloc zloc}\". This function only works for curves at this time.
"  

  (format
   t
   "ic_geo_get_centroid "
   type name ))

(defun ic_geo_num_segments (type name )
"
Returns the number of triangles or bars, and nodes in this object.
"  

  (format
   t
   "ic_geo_num_segments ~A ~A~%"
   type name ))

(defun ic_geo_num_nodes (type name )
"
Returns number of nodes in the object.
"  
  (format
   t
   "ic_geo_num_nodes ~A ~A~%"
   type name ))

(defun ic_geo_get_node (type name num )
"
Returns a node in a mesh curve, surface or density polygon.
"  
  (format
   t
   "ic_geo_get_node ~A ~A ~A~%"
   type name num ))

(defun ic_geo_drag_nodes (type name ptnums startpts startmouse spos svec how )
"
Allows you to interactively drag nodes in surfaces and curves.
"  
  (format
   t
   "ic_geo_drag_nodes ~A ~A ~A ~A ~A ~A ~A ~A~%"
   type name ptnums startpts startmouse spos svec how ))

(defun ic_geo_drag_point (name startpt startmouse spos svec )
"
Allows you to interactively drag prescribed points.
"  

  (format
   t
   "ic_geo_drag_point "
   name startpt startmouse spos svec ))

(defun ic_geo_drag_material (name startpt startmouse spos svec )
"
Allows you to interactively drag material points.
"  
  (format
   t
   "ic_geo_drag_material ~A ~A~%"
   name startpt startmouse spos svec ))

(defun ic_geo_drag_body (name startpt startmouse spos svec )
"
Allows you to interactively drag body points.
"  
  (format
   t
   "ic_geo_drag_body ~A ~A ~A ~A ~A~%"
   name startpt startmouse spos svec ))

(defun ic_geo_project_point (type names pt &optional
                                             (dir '(0 0 0))
                                             (tan_ext 0))
"
Project a point to a set of objects. dir is the vector along which to project, or 0 0 0 if the nearest point is desired. dir is used only in the case of surfaces.
type	point, curve, surface
names	list of entity names
pt	point -- either entity name or 3-tuple
dir	projection vector, {0, 0, 0} for nearest point
tan_ext 	project to tangential extension (curves only)
"  
  (format
   t
   "ic_geo_project_point ~A ~A ~A ~A ~A~%"
   type names pt dir tan_ext ))

(defun ic_geo_project_and_move_point (type names pt
                                      &optional
                                        (dir '(0 0 0))
                                        (tan_ext 0)
                                        (fam ""))
"
Project and move a point to a set of objects. dir is the vector along which to project, or 0 0 0 if the nearest point is desired. dir is used only in the case of surfaces.
type 	point, curve, surface
names 	list of entity names
pt 	point -- either entity name or 3-tuple
dir 	projection vector, {0, 0, 0} for nearest point
tan_ext 	project to tangential extension (curves only)
fam 	part name (if blank, use the part name of the point)
"  
  (format
   t
   "ic_geo_project_and_move_point ~A ~A ~A ~A ~A ~A~%"
   type names pt dir tan_ext fam ))

(defun ic_geo_project_coords (type names ptloc
                              &optional
                                (dir '(0 0 0))
                                (tan_ext 0))
"
Project coordinates to a set of objects. dir is the vector along which to project, or 0 0 0 if the nearest point is desired. dir is used only in the case of surfaces.
"  
  (format
   t
   "ic_geo_project_coords ~A ~A ~A ~A ~A~%"
   type names ptloc dir tan_ext))

(defun ic_geo_nearest_object (type pt
                              &optional
                                (dir '(0 0 0))
                                (tol 0) )
"
Projects a point to a set of objects, and return the name of the best one and the location. dir is the vector along which to project, or 0 0 0 if the nearest point is desired. pt may either be an XYZ location or the name of a prescribed point. The tol argument is used for intersecting a line with curves.

Note:  Curve projection is not yet implemented.
"  
  (format
   t
   "ic_geo_nearest_object ~A~A~A~A~%"
   type pt dir tol))

(defun ic_geo_project_curve_to_surface (crvs surfs name
                                        &optional
                                          (fam "")
                                          (new_name 0)
                                          (bld_topo 0))
"
Projects one or more curves to one or more surfaces.
crvs	list of curve names
surfs	list of surface names
name	base name of created curve
fam	family of created curves
new_name	do not reuse existing names
bld_topo	trim surfaces by projected curves
return	name(s) of created curve(s)
"  
  (format
   t
   "ic_geo_project_curve_to_surface ~A ~A ~A ~A ~A ~A~%"
   crvs surfs name fam new_name bld_topo))

(defun ic_geo_create_surface_curves (crv1 crv2 name )
"
Creates a faceted surface from crv1 and crv2. If the curves are not connected, the new surface will connect straight across the gaps.

name is the name of the new surface.
"  

  (format
   t
   "ic_geo_create_surface_curves "
   crv1 crv2 name ))

(defun ic_geo_create_surface_curtain (crvs surfs name fam
                                      &optional
                                        (bld_topo 0)
                                        (quiet 0) )
"
Creates a curtain surface between one or more curves and a surface.
crvs	list of defining curves
surfs	surface(s) to project to
name	base name of created surfaces
fam	family of created surfaces
bld_topo	run the topology builder
quiet	suppress diagnostic messages
"  
  (format
   t
   "ic_geo_create_surface_curtain ~A ~A ~A ~A ~A ~A~%"
   crvs surfs name fam bld_topo quiet ))

(defun ic_geo_set_node (type name num pt )
"
Moves a node on an object.
"  

  (format
   t
   "ic_geo_set_node ~A ~A ~A ~A~%"
   type name num pt ))

(defun ic_geo_get_family (type name )
"
Returns the family for an object.
"  
  (format
   t
   "ic_geo_get_family ~A ~A~%"
   type name ))

(defun ic_geo_get_part (type name )
"
Returns the part for an object (just the family with stuff after the first : removed)
"  
  (format
   t
   "ic_geo_get_part ~A ~A~%"
   type name ))

(defun ic_build_topo (args)
"
Builds the topology information from the geometry data. Arguments are:

    tolerance: the gap tolerance

    -angleangle: the angle for extraction

    -filter_points: extract the cad points

    -filter_curves: extract the cad curves

    -delete_degenerate: delete degenerate surfaces

    -save_old: do not delete existing entities.

    -quiet: suppress diagnostic messages

    -no_reg_surf: do not trim/regularize surfaces

    -no_concat: do join edge curves

    -create_interior: create interior curves on mesh surfaces

    family_name: name(s) of family(ies) to operate on.
"  
  (format
   t
   "ic_build_topo ~A~%"
   args ))

(defun ic_geo_default_topo_tolerance_old ()
"
Get a good tolerance for the current geometry.
"  
  (format
   t
   "ic_geo_default_topo_tolerance_old~%"
   ))

(defun ic_delete_geometry (type how &optional
                                      (objects "")
                                      (report_err 1)
                                      (even_if_dormant 0))
"
Deletes geometry objects. The first argument tells what kind of objects to delete: surface, curve, material, point, density, or loop. The second argument tells how to select the objects and the third is the list of object specifiers. how can be one of the following:

    names: a list of the names of the objects

    numbers: a list of the numbers of the objects

    patterns: a list of glob-patterns that match the names of the objects

    families: a list of the families to select

    all: all objects of that type (the objects list is ignored)

    visible: all visible objects of that type (the objects list is ignored and can be left out)

    blanked: all blanked objects of that type (the objects list is ignored and can be left out)

    objects: the internal handles for the objects

    report_err: optional argument - if 0 then do not report errors if objects do not exist
"  
  (format
   t
   "ic_delete_geometry ~A ~A ~A ~A ~A~%"
   type how objects report_err even_if_dormant))

(defun ic_geo_pnt_mrg_inc_crv (how objects )
"
Deletes a point and joins incident curves.

    how - defines how points are selected. See ic_delete_geometry.

    objects - the internal handles for the objects
"  

  (format
   t
   "ic_geo_pnt_mrg_inc_crv ~A ~A~%"
   how objects ))

(defun ic_facetize_geometry (type name args )
"
Makes a new geometric entity that is the faceted or piecewise linear equivalent of the old one. Optional arguments are:

    noisyon : if 1 print status information

    replaceon : if 1 replace the old object, otherwise make a new one.
"  

  (format
   t
   "ic_facetize_geometry ~A ~A ~A~%"
   type name args ))

(defun ic_move_geometry (type args )
"
Moves an existing geometry entity. The type argument gives the type: point, curve, surface, material, density, loop, or all. The other arguments are:

    names: a list of the names of the objects

    type_names: a list of pairs with the types and names of the objects

    numbers: a list of the numbers of the objects

    patterns: a list of glob-patterns that match the names of the objects (* = all objects)

    families: a list of the families to select

    objects: the internal handles for the objects

    cent: a list of X Y Z giving the center for rotation, scaling, and mirroring, which could be \"centroid\"

    translate: the X Y Z values for translating the entity

    rotate: the number of degrees to rotate the object about the axis given by rotate_axis

    rotate_axis: the vector giving the axis to rotate about

    scale: a scale value, or 3 values giving the factor to scale in X Y and Z

    mirror: the axis about which to mirror

The translation vector, center of rotation, and rotate axis should be specified in the current local Cartesian coordinate system.
"  

  (format
   t
   "ic_move_geometry ~A ~A~%"
   type args ))

(defun ic_geo_duplicate (type name &optional
                                     (newname "")
                                     (facetize 0))
"
Duplicates an existing geometrical entity. If the newname is given then that is used, otherwise a name is generated automatically. If facetize is specified then bspline surfaces are turned into facets.
"  
  (format
   t
   "ic_geo_duplicate "
   type name newname facetize))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun ic_geo_fixup (&optional
                       (mesh))
"
Fix problems in surfaces and curves like duplicate triangles, unused nodes, etc.
"  
  (format
   t
   "ic_geo_fixup ~A~%"
   mesh))

(defun ic_geo_min_edge_length (args )
"
Returns the minimum edge length on a list of surfaces or curves. Arguments are:

    surfaceval: list of surface names

    curveval: list of curve names

Example usage: set surfaces \"surf1 surf2 surf3\" set curves \"curv1\" ic_geo_min_edge_length surface $surfaces curve $curves
"  
  (format
   t
   "ic_geo_min_edge_length ~A~%"
   args ))

(defun ic_geo_coarsen (args )
"
Simplify surfaces or curves by coarsening them. The arguments are:

    tolval: the tolerance to use for coarsening, which determines how far from the original surface the new nodes can move (default 0)

    surfacesnamelist: the surfaces to coarsen.

    curvesnamelist: the curves that define prescribed nodes that should not be coarsened (default none)

    pointsnamelist: the points that should not be coarsened away (default none)

    auto_curveson : UNIMPLEMENTED - automatically determine what curves to preserve

    auto_pointson : UNIMPLEMENTED - automatically determine what points to preserve

    n_iternum: how many iterations of coarsening to try (default 16)

    noisyon : print status information
"  
  (format
   t
   "ic_geo_coarsen ~A~%"
   args ))

(defun ic_geo_gap_repair (args )
"
Perform geometry repair. Arguments are:

    tolerval: the geometry tolerance

    toler_maxval: the maximum gap tolerance

    partialval: allow partial repairing if set, default is 0

    yellowval: yellow curves only if set, default is 1

    doval: Close gaps if value is 1, match surfaces if 2, close one hole if 3, and close multiple holes if 4.

    build_topoval : build topology if set, default is 1 (for do = 1 only)

    new_familyname : the family name for new geometry

    new_namename: the entity name for new geometry

    quietval : Quiet operation if set. Default is 0. For do = 1 it selects re-intersection, if 1, fill, if 2, blend, if 3, and Y-closure if 4.

    dbval: Do some checking and printing if > 0, print less messages if < 0. Default is 0.

    curvesnames : the names of the curves to do

Return value is 0 if there was an error and 1 if it was OK.
"  
  (format
   t
   "ic_geo_gap_repair ~A~%"
   args ))

(defun ic_geo_midsurface (args )
"
Creates midsurfaces. Arguments are:

    max_distval: the maximum distance between surface pairs

    familyval: the family name for midsurfaces

    surfacesnames: the names of the surfaces to compress

    surfaces2names: the names of the second set of surfaces to compress

    save_oldval : save compressed surfaces if set

    partialval: create partial midsurface if set

    similarval: do similar pairs only if set

    alternateval: do alternate order of surfaces if set

    prefer_connectedval: prefer connected surface pairs if set

    precisionval: precision value for midsurface if set

    offsetval: just offset side 1 half distance to side 2

    toleranceval : the midsurface tolerance if set

    askval : quiet operation, if not set, ask yes/no if 1, present the candidates and ask yes/no if 2, just count and return number of candidates if 3

Return value is 0 if there was an error and 1 if it was OK.
"  
  (format
   t
   "ic_geo_midsurface ~A~%"
   args ))

(defun ic_geo_lookup (types how spec)
"
Looks up geometry objects based on certain criteria. type may be one of the geometry type names or all. This always returns a list of type/name pairs. Useful values for how and args are:

    namesnames: return objects with the given names

    familiesnames: return objects with the given families

    all: return all objects of the specified types

    patternspats: looks up objects based on glob-style name matching (for example, FAM*)

    visible: all visible objects

    blanked: all non-visible objects
"  
  (format
   t
   "ic_geo_lookup ~A ~A ~A~%"
   types how spec))

(defun ic_geo_get_entity_types (entnames)
"
For the given list of entities, return a *flat* list of \"type entname\" pairs, i.e. {type_1 ent_1 type_2 ent_2 ... type_n ent_n}
"  
  (format
   t
   "ic_geo_get_entity_types ~A~%"
   entnames ))

(defun ic_geo_memory_used ()
"
Specifies how much memory is used for the geometry data.
"  
  (format
   t
   "ic_geo_memory_used~%"
   ))

(defun ic_geo_project_mode (which )
"
Sets the projection mode.
"  
  (format
   t
   "ic_geo_project_mode ~A~%"
   which ))

(defun ic_csystem_get_current ()
"
Specifies the current coordinate system.
"  
  (format
   t
   "ic_csystem_get_current~%"
   ))

(defun ic_csystem_set_current (what )
"
Sets the current coordinate system.
"  
  (format
   t
   "ic_csystem_set_current ~A~%"
   what ))

(defun ic_csystem_list ()
"
Lists the existing coordinate systems.
"  
  (format
   t
   "ic_csystem_list~%"
   ))

(defun ic_csystem_get (name )
"
Returns information on the named coordinate system. This returns a list of 4 items: the type of the coordinate system, the origin, and the 3 vectors that define coordinate system. The type can be one of:

    cartesian

    cylindrical

    spherical

    toroidal
"  
  (format
   t
   "ic_csystem_get ~A~%"
   name ))

(defun ic_csystem_delete (name )
"
Deletes the named coordinate system.
"  
  (format
   t
   "ic_csystem_delete ~A~%"
   name ))

(defun ic_csystem_create (name type center axis0 axis1 axis2 )
"
Creates a new coordinate system with the given parameters.

    name: the name of the system to create.

    type: the type which can be one of cartesian, cylindrical, spherical, or toroidal (as yet unsupported).

    center: the center point in 3-D coordinates.

    axis0: the first axis vector.

    axis1: the second axis vector.

    axis2: the third axis vector.
"  
  (format
   t
   "ic_csystem_create ~A ~A ~A ~A ~A ~A~%"
   name type center axis0 axis1 axis2 ))

(defun ic_coords_into_global (pt &optional (system "") )
"
Translates coordinates from the current or given system into the global system.
"  
  (format
   t
   "ic_coords_into_global ~A ~A~%"
   pt system ))

(defun ic_coords_dir_into_global (pt
                                  &optional
                                    (system ""))
"
Translates a vector from the current or given system into the global system.
"  
  (format
   t
   "ic_coords_dir_into_global ~A ~A~%"
   pt system ))

(defun ic_coords_into_local (pt &optional (system ""))
"
Translates coordinates from the global system into the current or given local system.
"  
  (format
   t
   "ic_coords_into_local ~A ~A~%"
   pt system ))

(defun ic_csystem_display (name on )
"
Displays the specified coordinate system. If name is all and on is 0 then erase all coordinate systems.
"  

  (format
   t
   "ic_csystem_display ~A ~A~%"
   name on ))

(defun ic_geo_untrim_surface (surf )
"
Untrims a surface.
"  
  (format
   t
   "ic_geo_untrim_surface ~A"
   surf ))

(defun ic_geo_get_thincuts ()
"
Returns the thincut data.
"  
  (format
   t
   "ic_geo_get_thincuts~%"))

(defun ic_geo_set_thincuts (data )
"
Sets the thincut data.
"  
  (format
   t
   "ic_geo_set_thincuts ~A~%"
   data ))

(defun ic_geo_get_periodic_data ()
"
Returns the periodic data.
"  
  (format
   t
   "ic_geo_get_periodic_data~%"
   ))

(defun ic_geo_set_periodic_data (data )
"
Sets the periodic data.
"  
  (format
   t
   "ic_geo_set_periodic_data ~A~%"
   data ))

(defun ic_geo_get_family_param (fam name )
"
Returns the family parameters.
"  
  (format
   t
   "ic_geo_get_family_param ~A ~A~%"
   fam name ))

(defun set-family-params (fam &key
                                no_crv_inf
                                (prism 0)
                                (emax 2.0)
                                (ehgt 0.0)
                                (hrat 0)
                                (nlay 0)
                                (erat 1.5)
                                (ewid 0)
                                (emin 0.0)
                                (edev 0.0)
                                (split_wall 0)
                                (internal_wall 0))
  "ic_geo_set_family_params

 Sets the family parameters. If there is no such family, nothing will be done.

ic_undo_group_begin 
ic_geo_set_family_params B/AIR_RL_OUT/N2/D_10.000 no_crv_inf prism 0 emax 2.0 ehgt 0.0 hrat 0 nlay 0 erat 1.5 ewid 0 emin 0.0 edev 0.0 split_wall 0 internal_wall 0
ic_undo_group_end 
"
  (format
   t
   "ic_geo_set_family_params ~A ~A~%"
   fam args ))

(defun ic_geo_reset_family_params (fams params )
"
Reset family parameters on families fams for parameters params.
"  
  (format
   t
   "ic_geo_reset_family_params ~A ~A~%"
   fams params ))

(defun ic_geo_delete_unattached (&optional
                                   (fams "")
                                   (quiet 0)
                                   (only_if_dormant 0))
"
Deletes unattached geometry.
"  
  (format
   t
   "ic_geo_delete_unattached ~A ~A ~A~%"
   fams quiet only_if_dormant))

(defun ic_geo_remove_feature (curves )
"
Removes features.
"  
  (format
   t
   "ic_geo_remove_feature ~A~%"
   curves ))

(defun ic_geo_merge_curves (curves )
"
Merges curves.
"  
  (format
   t
   "ic_geo_merge_curves ~A~%"
   curves ))

(defun ic_geo_modify_curve_reappr (curves tol
                                   &optional
                                     (ask 1)
                                     (quiet 0))
"
Reapproximates curves.
curves	list of curve names
tol	re-approximation tolerance
ask	prompt to accept result
quiet	suppresses messages
return	list of new curve names

Note:   In interactive mode, if the ask parameter is 1 (default), the application prompts you to confirm whether the result is okay for each curve. Parameter is ignored in batch mode.
"  
  (format
   t
   "ic_geo_modify_curve_reappr ~A ~A ~A ~A~%"
   curves tol ask quiet ))

(defun ic_geo_modify_surface_reappr (surfaces tol
                                     &optional (ask 1) (each 0) (curves "") )
"
Reapproximates surfaces.
surfaces	list of surface names
tol	re-approximation tolerance
ask	prompt to accept result if set
each	re-approximate each surface separately if set
curves	list of curve names
return	list of new surface names

Note:   In interactive mode, if the ask parameter is 1 (default), the application prompts you to confirm whether the result is okay for each surface. Parameter is ignored in batch mode.
"  
  (format
   t
   "ic_geo_modify_surface_reappr ~A ~A ~A ~A~%"
   surfaces tol ask  each  curves ))

(defun ic_geo_reset_data_structures ()
"
Resets the Tcl data structures after making big changes to the proj database.
"  
  (format
   t
   "ic_geo_reset_data_structures~%"
   ))

(defun ic_geo_params_update_show_size (type size )
"
Modifies the display of the size icons for ref, natural, and max size. Can also be used for per-object parameters like tetra_size.
"  

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
"
Repairs holes using the stlrepair functionality. type indicates the entity type by which segments are specified, e.g. surface.
"  
  (format
   t
   "ic_geo_stlrepair_holes ~A ~A ~A ~A ~A ~A ~A ~A~%"
   type segs add_nodes int_surf complete_edges dcurves toler part ))

(defun ic_geo_stlrepair_edges (type segs merge_tol &optional (merge_ends -1))
"
Repairs edges using the stlrepair functionality. type indicates the entity type by which segments are specified, e.g. surface.
"  
  (format
   t
   "ic_geo_stlrepair_edges ~A ~A ~A ~A~%"
   type segs merge_tol merge_ends))

(defun ic_show_geo_selected (type names on
                             &optional
                               (color "")
                               (force_visible 0))
"
Displays some geometry selected or not.
"  
  (format
   t
   "ic_show_geo_selected ~A ~A ~A ~A ~A~%"
   type names on color force_visible))

(defun ic_reset_geo_selected ()
"
Resets all selection display.
"  
  (format
   t
   "ic_reset_geo_selected~%"
   ))

(defun ic_get_geo_selected ()
"
Returns all current geometry selections.
"  

  (format
   t
   "ic_get_geo_selected~%"
   ))

(defun ic_set_geo_selected (selected on )
"
Sets all previous geometry selections.
"  
  (format
   t
   "ic_set_geo_selected ~A ~A~%"
   selected on ))

(defun ic_select_geometry_option ()
"
Returns the previously used selection option.
"  
  (format
   t
   "ic_select_geometry_option~%"
   ))

(defun ic_geo_add_segment (type name item pts )
"
Adds segments or triangles to a surface or curve.
"  
  (format
   t
   "ic_geo_add_segment ~A ~A ~A ~A~%"
   type name item pts ))

(defun ic_geo_delete_segments (type name item pts )
"
Deletes segments or triangles from a curve or surface.
"  
  (format
   t
   "ic_geo_delete_segments ~A ~A ~A ~A~%"
   type name item pts ))

(defun ic_geo_restrict_segments (type name item pts )
"
Restrict to segments or triangles from a surface or curve.
"  
  (format
   t
   "ic_geo_restrict_segments ~A ~A ~A ~A~%"
   type name item pts))

(defun ic_geo_split_segments (type name item how pts )
"
Splits some segments in a surface or curve.
"  
  (format
   t
   "ic_geo_split_segments ~A ~A ~A ~A ~A~%"
   type name item how pts ))

(defun ic_geo_split_edges (type name pts )
"
Splits some edges in a surface.
"  
  (format
   t
   "ic_geo_split_edges ~A ~A ~A~%"
   type name pts ))

(defun ic_geo_split_one_edge (type name ed )
"
Splits one edge in a surface.
"  
  (format
   t
   "ic_geo_split_one_edge ~A ~A ~A~%"
   type name ed ))

(defun ic_geo_swap_edges (type name pts )
"
Swaps some edges in a surface.
"  

  (format
   t
   "ic_geo_swap_edges ~A ~A ~A~%"
   type name pts ))

(defun ic_geo_move_segments (type name1 name2 item pts )
"
Moves some segments from one surface to another.
"  

  (format
   t
   "ic_geo_move_segments ~A ~A ~A ~A ~A~%"
   type name1 name2 item pts ))

(defun ic_geo_move_node (type name nodes args )
"
Moves a node in a surface or curve. nodes is a list of the node numbers. After this, specify either one or more positions. If one, then all nodes are moved to that position. If more, then the nodes are moved to their corresponding positions.
"  
  (format
   t
   "ic_geo_move_node ~A ~A ~A ~A~%"
   type name nodes args ))

(defun ic_geo_merge_nodes (type name nodes )
"
Merges nodes in a surface or curve.
"  
  (format
   t
   "ic_geo_merge_nodes ~A ~A ~A~%"
   type name nodes ))

(defun ic_geo_merge_nodes_tol (type name tol )
"
Merges nodes in a surface or curve by tolerance.
"  
  (format
   t
   "ic_geo_merge_nodes_tol ~A ~A ~A~%"
   type name tol ))

(defun ic_geo_merge_surfaces (to from )
"
Merges multiple surfaces.
"  
  (format
   t
   "ic_geo_merge_surfaces ~A ~A~%"
   to from))

(defun ic_geo_merge_objects (type dest objs )
"
Merges multiple curves, or surfaces.
"  
  (format
   t
   "ic_geo_merge_objects ~A ~A ~A~%"
   type dest objs ))

(defun ic_geo_merge_points_tol (pts tol )
"
Merges multiple points using a tolerance.
"  
  (format
   t
   "ic_geo_merge_points_tol ~A ~A~%"
   pts tol ))

(defun ic_geo_finish_edit (type name )
"
Cleans up a surface or curve after editing operations.
"  
  (format
   t
   "ic_geo_finish_edit ~A ~A~%"
   type name ))

(defun ic_geo_delete_if_empty (type name )
"
Deletes a surface or curve if it is empty.
"  
  (format
   t
   "ic_geo_delete_if_empty ~A ~A~%"
   type name ))

(defun ic_geo_smallest_segment (type name )
"
Returns the smallest triangle in a surface.
"  
  (format
   t
   "ic_geo_smallest_segment ~A ~A~%"
   type name ))

(defun ic_geo_get_config_param (type name param )
"
This is kind of an escape.
"  
  (format
   t
   "ic_geo_get_config_param ~A ~A ~A~%"
   type name param ))

(defun ic_geo_set_config_param (type name param val )
"
This is kind of an escape.
"  

  (format
   t
   "ic_geo_set_config_param ~A ~A ~A ~A~%"
   type name param val ))

(defun ic_geo_set_tag (type names tagname on )
"
Sets the given tag on the objects, or removes it. If the tagname is pickable this affects the geometry selection code. If the type is clear then the tag is removed from all objects and the name and on parameters are ignored. If name is an empty string then all the objects of that type will be modified.
"  

  (format
   t
   "ic_geo_set_tag "
   type names tagname on ))

(defun ic_geo_highlight_segments (type name add hsmode segs )
"
Highlights some segments of an image.
"  
  (format
   t
   "ic_geo_highlight_segments ~A ~A ~A ~A ~A~%"
   type name add hsmode segs ))

(defun ic_geo_bounding_box (objlist )
"
Returns the bounding box of a set of objects. objlist is a list of type names pairs, e.g. { { curve {C1 C2 C2} point {C2 C3}} } It can also be all which will give the bounding box of all the geometry.
"  
  (format
   t
   "ic_geo_bounding_box ~A~%"
   objlist ))

(defun ic_geo_bounding_box2 (objlist )
"
This is the more rigorous version of the boundary box calculation.
"  
  (format
   t
   "ic_geo_bounding_box2 ~A~%"
   objlist ))

(defun ic_geo_model_bounding_box ()
"
This gives the bounding box of all objects in projlib.
"  
  (format
   t
   "ic_geo_model_bounding_box~%"
   ))

(defun ic_geo_feature_size (type name )
"
Returns the feature size of an object.
"  
  (format
   t
   "ic_geo_feature_size ~A ~A~%"
   type name ))

(defun ic_geo_replace_surface_mesh (name pts tris )
"
Replaces a surface mesh. pts is a list of x y z triples. tris is a list of 3 point numbers. e.g., ic_geo_replace_surface_mesh SURF.1 {{0 0 0} {1 1 1} ...} {{0 1 2} ...}
"  
  (format
   t
   "ic_geo_replace_surface_mesh ~A ~A ~A~%"
   name pts tris ))

(defun ic_geo_replace_curve_mesh (name pts bars )
"
Replaces a curve mesh. pts is a list of x y z triples. bars is a list of 2 point numbers. e.g., ic_geo_replace_curve_mesh CRV.1 {{0 0 0} {1 1 1} ...} {{0 1} {2 3} ...}
"  
  (format
   t
   "ic_geo_replace_curve_mesh ~A ~A ~A~%"
   name pts bars ))

(defun ic_geo_vec_diff (p1 p2 )
"
Computes the displacement vector between two points.
p1	point -- e.g. {1 2 3}
p2	point -- e.g. {3 4 3}
return	3-tuple containing difference

Example


        # Compute the dot product between two vectors
 #
 if [catch {ic_geo_vec_diff {1 2 3} {3 4 3} } crv1] {
 mess \"$crv1\n\" red
 } else {
 mess \"vec diff, $crv1\n\"
 }
      
"  
  (format
   t
   "ic_geo_vec_diff ~A ~A~%"
   p1 p2 ))

(defun ic_geo_vec_dot (v1 v2 )
"
Computes the dot product between two vectors.
v1	vector -- e.g. {1 2 3}
v2	vector -- e.g. {3 4 3}
return	dot product

Example


        # Compute the dot product between two vectors
 #
 if [catch {ic_geo_vec_dot {1 2 3} {3 4 3} } crv1] {
 mess \"$crv1\n\" red
 } else {
 mess \"vec dot, $crv1\n\"
 }
      
"  
  (format
   t
   "ic_geo_vec_dot ~A ~A~%"
   v1 v2 ))

(defun ic_geo_vec_mult (v1 v2 )
"
Computes the cross product between two vectors.
v1	vector -- e.g. {1 2 3}
v2	vector -- e.g. {3 4 3}
return	cross product

Example


        # Compute the cross product between two vectors
 #
 if [catch {ic_geo_vec_mult {2 0 1} {1 3 0} } crv1] {
 mess \"$crv1\n\" red
 } else {
 mess \"vec mult, $crv1\n\"
 }

      
"  
  (format
   t
   "ic_geo_vec_mult ~A ~A~%"
   v1 v2 ))

(defun ic_geo_vec_nrm (vec )
"
Normalizes a vector.
vec	vector -- e.g. {1 2 3}
return	normalized vector

Example


        # Normalize a vector
 #
 if [catch {ic_geo_vec_nrm {2 2 4} } crv1] {
 mess \"$crv1\n\" red
 } else {
 mess \"vec normalize, $crv1\n\"
 }

      
"  
  (format
   t
   "ic_geo_vec_nrm ~A~%"
   vec ))

(defun ic_geo_vec_len (vec )
"
Computes the length of a vector.
vec	vector -- e.g. {1 2 3}
return	length

Example


        if [catch {ic_geo_vec_len {3 4 0} } len] {
 mess \"$len\n\" red
 } else {
 mess \"vec length should be 5: $len\n\"
 }

      
"  
  (format
   t
   "ic_geo_vec_len ~A~%"
   vec ))

(defun ic_geo_pnt_dist (pnt1 pnt2 )
"
Computes the distance between two points.
pnt1	point -- e.g. {1 2 3} or point name
pnt2	point -- e.g. {1 2 3} or point name
return	distance between points

Example


        #
 if [catch {ic_geo_pnt_dist {2 2 4} {3 2 1}} len] {
 mess \"Error: $len\n\" red
 } else {
 mess \"Distance = $len\n\"
 }
      
"  
  (format
   t
   "ic_geo_pnt_dist ~A ~A~%"
   pnt1 pnt2 ))

(defun ic_geo_vec_smult (vec scal )
"
Multiplies a vector by a scalar.
vec	vector -- e.g. {1 2 3}
scal	scalar -- e.g. 42
return	scalar product vector

Example


        # Multiply a vector by a scalar
 #
 if [catch {ic_geo_vec_smult {1 2 3} 42 } crv1] {
 mess \"$crv1\n\" red
 } else {
 mess \"vec smult, $crv1\n\"
 }

"  
  (format
   t
   "ic_geo_vec_smult ~A ~A~%"
   vec scal ))

(defun ic_geo_vec_sum (v1 v2 )
"
Computes the sum of two vectors.
v1	vector -- e.g. {1 2 3}
v2	vector -- e.g. {3 4 3}
return	cross product

Example


        # Compute the sum of two vectors
 #
 if [catch {ic_geo_vec_sum {1 2 3} {4 5 6}} crv1] {
 mess \"$crv1\n\" red
 } else {
 mess \"vec sum, $crv1\n\"
 }

      
"  
  (format
   t
   "ic_geo_vec_sum ~A ~A~%"
   v1 v2 ))

(defun ic_geo_crv_length (crvs &optional (t_min 0) (t_max 1) )
"
Computes the arc length of a curve segment.
crvs	list of one or more curves
t_min	lower limit of segment (unitized
t_max 	upper limit of segment (unitized
return	list of computed arc lengths

Notes:

    t_min and t _max default to 0 and 1 respectively

    For example usage, refer to ic_geo_crv_length.tcl in the Ansys installation directory under v221/icemcfd/Samples/ProgrammersGuide/med_test.
"  

  (format
   t
   "ic_geo_crv_length ~A ~A ~A~%"
   crvs t_min t_max ))

(defun ic_geo_cre_srf_rev (family name gen base zaxis srtang endang
                           &optional (dxn "a") (bld_topo 0) )
"
Creates a revolution surface from a generator curve and axis.
family	family containing surface
name	name of created surface
gen	generator curve(s)
base	axis base point
zaxis	axis direction vector
srtang	start angle (degrees)
endang	end angle (degrees)
dxn	c-clockwise, a-anticlockwise
bld_topo	associate edge curves
return	name of created surface

Notes:

    The specified surface name may be modified to resolve name collisions.

    If the function returns with the error status set, the result string will contain an error message.

    Positions may be specified explicitly or using names of prescribed points

    The dxn flag determines whether the curve is swept clockwise or anti-clockwise (counter clockwise) about the rev axis.

    For example usage, refer to ic_geo_cre_srf_rev.tcl in the Ansys installation directory under v221/icemcfd/Samples/ProgrammersGuide/med_test.
"  
  (format
   t
   "ic_geo_cre_srf_rev ~A ~A ~A ~A ~A ~A ~A ~A ~A~%"
   family name gen base zaxis srtang endang dxn bld_topo))

(defun ic_geo_cre_crv_iso_crv (family name srfs par sel
                               &optional (do_split 0) (coord 0) )
"
Creates isoparametric curve segments on a surface.
family	family containing curves
name	name of created curves
srfs	list of surface names list of surface names
par	surface parameter 0 <= par <= 1
sel	== 0 u cons; == 1 v cons
do_split	== 1 split the surface
coord	== 0 use restricted coordinates; == 1 use natural coordinates
return	list of created curves/surfaces

Notes:

    The defining parameter is assumed to be unitized

    When applied to trimmed surfaces

        The feature may produce multiple result curves

        Restricted coordinates are taken with respect to the active region of the trimmed surface, not the domain of the underlying surface.

        Natural coordinates are taken with respect to the underlying surface. This alternative is consistent with the output of ic_geo_find_nearest_srf_pnt in that while the coordinates are still unitized, they run through the full extent of the underlying surface.

    The specified curve name may be modified to resolve name collisions

    If the function returns with the error status set, the result string will contain an error message.

    The surface parameter is unitized.

    The return value is a list containing two elements, names of created curves and names of created surfaces

    For example usage, refer to ic_geo_cre_crv_iso_crv.tcl in the Ansys installation directory under v221/icemcfd/Samples/ProgrammersGuide/med_test.
"  
  (format
   t
   "ic_geo_cre_crv_iso_crv ~A ~A ~A ~A ~A ~A ~A~%"
   family name srfs par sel do_split coord ))

(defun ic_geo_cre_srf_pln_3pnts (family name p1 p2 p3 rad )
"
Creates a bspline plane from 3 points.
family	family containing plane
name	name of created plane
p1	point data, e.g. {1 2 3}
p2	point data, e.g. {1 2 3}
p3	point data, e.g. {1 2 3}
scale	scales surface extents

Notes:

    The specified surface name may be modified to resolve name collisions.

    If the function returns with the error status set, the result string will contain an error message.

    For an annotated example of usage, refer to ic_geo_cre_srf_pln_3pnts.tcl in the Ansys installation directory under v221/icemcfd/Samples/ProgrammersGuide/med_test.
"  
  (format
   t
   "ic_geo_cre_srf_pln_3pnts ~A ~A ~A ~A ~A ~A~%"
   family name p1 p2 p3 rad ))

(defun ic_geo_cre_srf_pln_nrm_pnt (family name pnt nrm rad )
"
Creates a bspline plane from a point and normal vector.
family	family containing plane
name	name of created plane
pnt	point data, e.g. {1 2 3}
nrm	plane normal, e.g. {1 1 1}
rad	radius of created surface

Notes:

    The specified surface name may be modified to resolve name collisions.

    If the function returns with the error status set, the result string will contain an error message.

    For an annotated example of usage, refer to ic_geo_cre_srf_pln_nrm_pnt.tcl in the Ansys installation directory under v221/icemcfd/Samples/ProgrammersGuide/med_test.
"  
  (format
   t
   "ic_geo_cre_srf_pln_nrm_pnt ~A ~A ~A ~A ~A~%"
   family name pnt nrm rad ))

(defun ic_geo_cre_srf_pln_nrm_dist (family name nrm dist rad )
"
Creates a bspline plane from normal vector at a distance from origin.
family	family containing plane
name	name of created plane
nrm	plane normal, e.g. {1 1 1}
dist	signed distance between origin and plane
rad	radius of created surface

Notes:

    The specified surface name may be modified to resolve name collisions.

    If the function returns with the error status set, the result string will contain an error message.

    This variant replaces plane definition by coefficients from older API's. The plane equation can be written in terms of the input variables as:

    DOT(nrm, X) = LENGTH(nrm)*dist 

Example


        if [catch {ic_geo_cre_srf_pln_nrm_dist duck dewey \
 {1 2 3} {1 0 0} 10 42} pln1] {
 mess \"$pln1\n\" red
 } else {
 mess \"created a plane, $pln1\n\"
 }

      
"  
  (format
   t
   "ic_geo_cre_srf_pln_nrm_dist ~A ~A ~A ~A ~A~%"
   family name nrm dist rad ))

(defun ic_geo_cre_arc_from_pnts (family name p1 p2 p3)
 "
ic_geo_cre_arc_from_pnts family name p1 p2 p3

Create a bspline arc from 3 points.

family family containing curve 
name name of created curve 
p1 point data, e.g. {1 2 3}  
p2 point data, e.g. {1 2 3}  
p3 point data, e.g. {1 2 3} 

Notes: 

The specified curve name may be modified to resolve name collisions.

Positions may be specified explicitly or using names of prescribed points.

If the function returns with the error status set, the result string will contain an error message.

For an annotated example of usage, refer to ic_geo_cre_arc_from_pnts.tcl in the ANSYS installation directory under v145/icemcfd/Samples/ProgrammersGuide/med_test.
"  
"
Create a bspline arc from 3 points.
family	family containing curve
name	name of created curve
p1	point data, e.g. {1 2 3}
p2	point data, e.g. {1 2 3}
p3	point data, e.g. {1 2 3}

Notes:

    The specified curve name may be modified to resolve name collisions.

    Positions may be specified explicitly or using names of prescribed points.

    If the function returns with the error status set, the result string will contain an error message.

    For an annotated example of usage, refer to ic_geo_cre_arc_from_pnts.tcl in the Ansys installation directory under v221/icemcfd/Samples/ProgrammersGuide/med_test.
"  
  (format
   t
   "ic_geo_cre_arc_from_pnts ~A ~A {~{~A~^ ~}} {~{~A~^ ~}} {~{~A~^ ~}}~%"
   family name p1 p2 p3))

(defun ic_geo_cre_bsp_crv_n_pnts (family name pnts &optional (tol 0.0001) (deg 3))
 "ic_geo_cre_bsp_crv_n_pnts family name pnts tol [0.0001] deg [3]

Creates a bspline curve from n points.

family family containing curve 
name name of created curve 
pnts point data 
tol approximation tolerance 
deg curve degree = 1 (linear) or 3 (cubic)  

Notes: 

The specified curve name may be modified to resolve name collisions.

If the function returns with the error status set, the result string will contain an error message.

Positions may be specified explicitly or using names of prescribed points.

The approximation tolerance is relative. It will be scaled by the pointset chordlength to form an absolute tolerance. It has a default value of 0.0001.

For example usage, refer to ic_geo_cre_bsp_crv_n_pnts.tcl in the ANSYS installation directory under v145/icemcfd/Samples/ProgrammersGuide/med_test.
"  
"
Creates a bspline curve from n points.
family	family containing curve
name	name of created curve
pnts	point data
tol	approximation tolerance
deg	curve degree = 1 (linear) or 3 (cubic)

Notes:

    The specified curve name may be modified to resolve name collisions.

    If the function returns with the error status set, the result string will contain an error message.

    Positions may be specified explicitly or using names of prescribed points.

    The approximation tolerance is relative. It will be scaled by the pointset chordlength to form an absolute tolerance. It has a default value of 0.0001.

    For example usage, refer to ic_geo_cre_bsp_crv_n_pnts.tcl in the Ansys installation directory under v221/icemcfd/Samples/ProgrammersGuide/med_test.
"  
  (format
   t
   "ic_geo_cre_bsp_crv_n_pnts ~A ~A ~A ~A ~A~%"
   family name pnts tol deg))

(defun ic_geo_cre_bsp_crv_n_pnts_cons (family name pnts fixPnts tanCons tanIndx &optional (tol 0.001))
 "  
ic_geo_cre_bsp_crv_n_pnts_cons family name pnts fixPnts tanCons tanIndx tol [0.001]

Creates a bspline curve from n points with constraints.

family family containing curve 
name name of created curve 
pnts point data 
fixPnts fixed points 
tanCons specified tangents 
tanIndx indices of points in pnts associated to tangent vectors 
tol approximation tolerance 

Notes: 

The specified curve name may be modified to resolve name collisions.

If the function returns with the error status set, the result string will contain an error message.

Positions may be specified explicitly or using names of prescribed points

Point array is indexed as 0, 1, 2, . . .

The approximation tolerance is relative. It will be scaled by the pointset chordlength to form an absolute tolerance. It has a default value of 0.0001.

For example usage, refer to ic_geo_cre_bsp_crv_n_pnts_cons.tcl in the ANSYS installation directory under v145/icemcfd/Samples/ProgrammersGuide/med_test.

ic_geo_cre_crv_arc_ctr_rad family name center x_ax normal radius srtang endang

Creates a bspline arc from center, radius information.

family family containing curve 
name name of created curve 
center arc center 
x_ax vector aligned along angle == 0 
normal arc normal 
radius arc radius 
srtang start angle (degrees) 
endang end angle (degrees) 
return name of created curve 

Notes: 

The specified curve name may be modified to resolve name collisions.

If the function returns with the error status set, the result string
will contain an error message.

If endang < srtang or (endang - srtang) > 360, the angle will be
adjusted by adding 360 increments.

Positions may be specified explicitly or using names of prescribed
points.

For annotated examples of usage, refer to
ic_geo_cre_crv_arc_ctr_rad.tcl and
ic_geo_create_surface_from_curves.tcl in the ANSYS installation
directory under v145/icemcfd/Samples/ProgrammersGuide/med_test.
"
   
"
Creates a bspline curve from n points with constraints.
family	family containing curve
name	name of created curve
pnts	point data
fixPnts	fixed points
tanCons	specified tangents
tanIndx	indices of points in pnts associated to tangent vectors
tol	approximation tolerance

Notes:

    The specified curve name may be modified to resolve name collisions.

    If the function returns with the error status set, the result string will contain an error message.

    Positions may be specified explicitly or using names of prescribed points

    Point array is indexed as 0, 1, 2, . . .

    The approximation tolerance is relative. It will be scaled by the pointset chordlength to form an absolute tolerance. It has a default value of 0.0001.

    For example usage, refer to ic_geo_cre_bsp_crv_n_pnts_cons.tcl in the Ansys installation directory under v221/icemcfd/Samples/ProgrammersGuide/med_test.
"  
  (format
   t
   "ic_geo_cre_bsp_crv_n_pnts_cons ~A ~A ~A ~A ~A ~A ~A~%"
   family name pnts fixPnts tanCons tanIndx tol))

(defun ic_geo_cre_crv_arc_ctr_rad (family name center x_ax normal radius srtang endang )
"
Creates a bspline arc from center, radius information.
family	family containing curve
name	name of created curve
center	arc center
x_ax	vector aligned along angle == 0
normal	arc normal
radius	arc radius
srtang	start angle (degrees)
endang	end angle (degrees)
return	name of created curve

Notes:

    The specified curve name may be modified to resolve name collisions.

    If the function returns with the error status set, the result string will contain an error message.

    If endang < srtang or (endang - srtang) > 360, the angle will be adjusted by adding 360 increments.

    Positions may be specified explicitly or using names of prescribed points.

    For annotated examples of usage, refer to ic_geo_cre_crv_arc_ctr_rad.tcl and ic_geo_create_surface_from_curves.tcl in the Ansys installation directory under v221/icemcfd/Samples/ProgrammersGuide/med_test.
"  
  (format
   t
   "ic_geo_cre_crv_arc_ctr_rad ~A ~A {~{~A~^ ~}} {~{~A~^ ~}} {~{~A~^ ~}} ~A ~A ~A~%"
   family name center x_ax normal radius srtang endang ))

(defun ic_geo_cre_srf_cyl (family name center x_ax z_ax radius srtang endang length)
 "  
ic_geo_cre_srf_cyl family name center x_ax z_ax radius srtang endang length

Create a bspline cylinder from center, radius information.

family family containing surface 
name name of created surface 
base cylinder base point 
x_ax vector aligned along angle == 0 
z_ax vector aligned along cyl axis 
radius cylinder radius 
srtang start angle (degrees)  
endang end angle (degrees) 
length length 
return name of created surface 

Notes: 

The specified surface name may be modified to resolve name collisions.

If the function returns with the error status set, the result string
will contain an error message.

If endang < srtang or (endang - srtang) > 360, the angle will be
adjusted by adding 360 degree increments.

Positions may be specified explicitly or using names of prescribed
points.

For an annotated example of usage, refer to ic_geo_cre_srf_cyl.tcl in
the ANSYS installation directory under
v145/icemcfd/Samples/ProgrammersGuide/med_test.
"  
"
Create a bspline cylinder from center, radius information.
family	family containing surface
name	name of created surface
base	cylinder base point
x_ax	vector aligned along angle == 0
z_ax	vector aligned along cyl axis
radius	cylinder radius
srtang	start angle (degrees)
endang	end angle (degrees)
length	length
return	name of created surface

Notes:

    The specified surface name may be modified to resolve name collisions.

    If the function returns with the error status set, the result string will contain an error message.

    If endang < srtang or (endang - srtang) > 360, the angle will be adjusted by adding 360 degree increments.

    Positions may be specified explicitly or using names of prescribed points.

    For an annotated example of usage, refer to ic_geo_cre_srf_cyl.tcl in the Ansys installation directory under v221/icemcfd/Samples/ProgrammersGuide/med_test.
"  
  (format
   t
   "ic_geo_cre_srf_cyl ~A ~A {~{~A~^ ~}} {~{~A~^ ~}} {~{~A~^ ~}} ~A ~A ~A ~A~%"
   family name center x_ax z_ax radius srtang endang length))

(defun ic_geo_cre_line (family name p1 p2)
 "
ic_geo_cre_line family name p1 p2

Create a bspline line from 2 points.

family family containing curve 
name name of created curve 
p1 point data, e.g. {1 2 3} 
p2 point data, e.g. {1 2 3} 
return name of created curve 

Notes: 

The specified curve name may be modified to resolve name collisions

If the function returns with the error status set, the result string
will contain an error message.

Positions may be specified explicitly or using names of prescribed
points

For an annotated example of usage, refer to ic_geo_cre_line.tcl in the
ANSYS installation directory under
v145/icemcfd/Samples/ProgrammersGuide/med_test.
"  
"
Create a bspline line from 2 points.
family	family containing curve
name	name of created curve
p1	point data, e.g. {1 2 3}
p2	point data, e.g. {1 2 3}
return	name of created curve

Notes:

    The specified curve name may be modified to resolve name collisions

    If the function returns with the error status set, the result string will contain an error message.

    Positions may be specified explicitly or using names of prescribed points

    For an annotated example of usage, refer to ic_geo_cre_line.tcl in the Ansys installation directory under v221/icemcfd/Samples/ProgrammersGuide/med_test.
"  
  (format t "ic_geo_cre_line ~A ~A {~{~A~^ ~}} {~{~A~^ ~}}~%"
          family name p1 p2))

(defun ic_geo_cre_pnt (family name pnt &optional (in_lcs 1))
 "
ic_geo_cre_pnt family name pnt in_lcs [1]

Creates a prescribed point from coordinates.

family family containing point  
name name of created point 
pnt point data, e.g. {1 2 3} 
in_lcs 1 if the location should be in the current local coordinate system (default)

return name of created point  

Notes: 

The specified point name may be modified to resolve name collisions

If the function returns with the error status set, the result string will contain an error message.

Example 

# Create a prescribed point from coordinates

 if [catch {ic_geo_cre_pnt duck louie {1 2 3} } pnt1] {
 mess \"$pnt1\n\" red
 } else {
 mess \"created a ducky point, $pnt1\n\"
 }
"  
"
Creates a prescribed point from coordinates.
family	family containing point
name	name of created point
pnt	point data, e.g. {1 2 3}
in_lcs	1 if the location should be in the current local coordinate system (default)
return	name of created point

Notes:

    The specified point name may be modified to resolve name collisions

    If the function returns with the error status set, the result string will contain an error message.

Example


        # Create a prescribed point from coordinates

 if [catch {ic_geo_cre_pnt duck louie {1 2 3} } pnt1] {
 mess \"$pnt1\n\" red
 } else {
 mess \"created a ducky point, $pnt1\n\"
 }

"  
  (format
   t
   "ic_geo_cre_pnt ~A ~A {~{~A~^ ~}} ~A~%" family name pnt in_lcs)
  name)

(defun cre-mat (fam name pt &optional (in_lcs 1))
 "ic_geo_cre_mat

 ic_geo_cre_mat fam name pt in_lcs [1]

Create a material point from coordinates.

family family containing material point  
name name of created material point  
pnt point data, e.g. {1 2 3}, or the word outside 
in_lcs 1 if the location should be in the current local coordinate system (default) 
return name of created material point  

Notes: 

The specified point name may be modified to resolve name collisions.

If the function returns with the error status set, the result string will contain an error message.

Example 

# Create a material point from coordinates

 if [catch {ic_geo_cre_mat duck louie {1 2 3} } pnt1] {
 mess \"$pnt1\n\" red
 } else {
 mess \"created a ducky point, $pnt1\n\"
 }
"  
 "ic_geo_cre_mat

 Create a material point from coordinates.
family	family containing material point
name	name of created material point
pnt	point data, e.g. {1 2 3}, or the word outside
in_lcs	1 if the location should be in the current local coordinate system (default)
return	name of created material point

Notes:

    The specified point name may be modified to resolve name collisions.

    If the function returns with the error status set, the result string will contain an error message.

Example

        # Create a material point from coordinates

 if [catch {ic_geo_cre_mat duck louie {1 2 3} } pnt1] {
 mess \"$pnt1\n\" red
 } else {
 mess \"created a ducky point, $pnt1\n\"
 }
"  
  (format
   t
   "ic_geo_cre_mat ~A ~A {~{~A~^ ~}} ~A~%"
   fam name pt in_lcs)
  name)

(defun ic_geo_get_srf_nrm (upar vpar srf )
"
Get the normal vector of a surface at a parameter.
upar	surface u parameter
vpar	surface v parameter
srf	list of surfaces to evaluate
return	list of 3-tuple of doubles

Notes:

    If the function returns with the error status set, the result string will contain an error message.

    The return string will be a list of 3-tuples

    The input uv coordinates should be unitized.

    For example usage, refer to ic_geo_get_srf_nrm.tcl in the Ansys installation directory under v221/icemcfd/Samples/ProgrammersGuide/med_test.
"  

  (format
   t
   "ic_geo_get_srf_nrm ~A ~A ~A~%"
   upar vpar srf ))

(defun ic_geo_get_srf_pos (upar vpar srf )
"
Get a surface position at a parameter.
upar	surface u parameter
vpar	surface v parameter
srf	list of surfaces to evaluate
return	list of 3-tuple of doubles

Notes:

    If the function returns with the error status set, the result string will contain an error message.

    The return string will be a list of 3-tuples

    The input uv coordinates should be unitized.

    For example usage, refer to ic_geo_get_srf_pos.tcl in the Ansys installation directory under v221/icemcfd/Samples/ProgrammersGuide/med_test.
"  
  (format
   t
   "ic_geo_get_srf_pos ~A ~A ~A~%"
   upar vpar srf ))

(defun ic_geo_cre_pnt_on_srf_at_par (family name upar vpar srf )
"
Creates a prescribed point on a surface at a parameter.
family	family containing point
name	name of created point
upar	surface u parameter
vpar	surface v parameter
srf	list of surfaces to evaluate
return	names of created points

Notes:

    The specified point name may be modified to resolve name collisions.

    If the function returns with the error status set, the result string will contain an error message.

    The input uv coordinates should be unitized.

    For example usage, refer to ic_geo_cre_pnt_on_srf_at_par.tcl in the Ansys installation directory under v221/icemcfd/Samples/ProgrammersGuide/med_test.
"  
  (format
   t
   "ic_geo_cre_pnt_on_srf_at_par ~A ~A ~A ~A ~A~%"
   family name upar vpar srf ))

(defun ic_geo_cre_pnt_on_crv_at_par (family name par crv )
"
Creates a prescribed point on a curve at a parameter.
family	family containing point
name	name of created point
par	curve parameter
crv	name of curve to evaluate
return	name of created point

Notes:

    The specified point name may be modified to resolve name collisions.

    If the function returns with the error status set, the result string will contain an error message.

    For example usage, refer to ic_geo_cre_pnt_on_crv_at_par.tcl in the Ansys installation directory under v221/icemcfd/Samples/ProgrammersGuide/med_test.
"  
  (format
   t
   "ic_geo_cre_pnt_on_crv_at_par ~A ~A ~A ~A~%"
   family name par crv ))

(defun ic_geo_cre_crv_concat (family name tol crvs )
"
Create a new curve by concatenating existing curves.
family	family containing curve
name	name of created curve
tol	merge tolerance
crvs	list of curves to be joined
return	name of created curve

Notes:

    The specified curve name may be modified to resolve name collisions.

    If the function returns with the error status set, the result string will contain an error message.

    The list crvs contains curve curve names.

    For example usage, refer to ic_geo_cre_crv_concat.tcl in the Ansys installation directory under v221/icemcfd/Samples/ProgrammersGuide/med_test.
"  
  (format
   t
   "ic_geo_cre_crv_concat ~A ~A ~A ~A~%"
   family name tol crvs ))

(defun ic_geo_create_curve_concat (family name tol crvs )
"
Deprecated version of ic_geo_cre_crv_concat. This function has been replaced by ic_geo_cre_crv_concat.
"  
  (format
   t
   "ic_geo_create_curve_concat ~A ~A ~A ~A~%"
   family name tol crvs ))

(defun ic_geo_cre_srf_from_contour (family name tol crvs )
"
Create a new surface spanning a planar contour.
family	family containing new surface
name	base name of created surface
tol	merge tolerance
crvs	list of curves to span

Notes:

    The specified surface name may be modified to resolve name collisions.

    If the function returns with the error status set, the result string will contain an error message.

    The list crvs contains curve curve names.

    For example usage, refer to ic_geo_cre_srf_from_contour.tcl in the Ansys installation directory under v221/icemcfd/Samples/ProgrammersGuide/med_test.
"  
  (format
   t
   "ic_geo_cre_srf_from_contour ~A ~A ~A ~A~%"
   family name tol crvs ))

(defun ic_geo_create_surface_from_curves (family name tol crvs &optional (bld_topo 0) )
"
Create a new surface spanning two to four curves.
family	family containing new surface
name	name of created surface
tol	merge tolerance
crvs	list of curves to span
bld_topo	associate edge curves

Notes:

    The specified surface name may be modified to resolve name collisions.

    If the function returns with the error status set, the result string will contain an error message.

    The list crvs contains curve curve names.

    For example usage, refer to ic_geo_create_surface_from_curves.tcl in the Ansys installation directory under v221/icemcfd/Samples/ProgrammersGuide/med_test.
"  
  (format
   t
   "ic_geo_create_surface_from_curves ~A ~A ~A ~A ~A~%"
   family name tol crvs bld_topo ))

(defun ic_geo_create_param_surface (family name nu nv ord_u ord_v rational u_knots v_knots control_pts loops )
"
Create a new surface from a u,v set of coordinates.
family	family containing new surface
name	name of created surface
nu	number of u coordinates
nv	number of v coordinates
ord_u	order of u
ord_v	order of v
rational	dimension of polynomial fit above 3
u_knots	for rational=0, list of u coordinates
v_knots	for rational=0, list of v coordinates
control_pts	points the surface should go through
loops	loops to trim

    If the function returns with the error status set, the result string will contain an error message.
"  
  (format
   t
   "ic_geo_create_param_surface ~A ~A ~A ~A ~A ~A ~A ~A ~A ~A ~A~%"
   family name nu nv ord_u ord_v rational u_knots v_knots control_pts loops ))

(defun ic_geo_list_crv_data (file format crvs )
"
Lists the IGES data defining a list of curves.
out_file 	output file
format	output format
crvs	list of curves

Notes:

    Output formats:
    iges	IGES Style
    tetin	TETIN Style

    If the function returns with the error status set, the result string will contain an error message.

    The list crvs contains curve names.

Example


        # List the IGES data defining a list of curves
 #
 if [catch {ic_geo_cre_crv_arc_ctr_rad duck dewey \
 {1 2 3} {1 0 0} {1 1 1} 4.2 0 1.047197} crv1] {
 mess \"$crv1\n\" red
 } else {
 mess \"created a ducky arc, $crv1\n\"
 if [catch {ic_geo_cre_crv_arc_ctr_rad duck louie \
 {1 2 3} {0 1 0} {1 1 1} 4.2 0 1.047197} crv2] {
 mess \"$crv2\n\" red
 } else {
 mess \"created a ducky arc, $crv2\n\"
 if [catch {ic_geo_list_crv_data out.txt iges \
 \"$crv1 $crv2\"} err] {
 mess \"$err\n\" red
 }
 }
      
"  
  (format
   t
   "ic_geo_list_crv_data ~A ~A ~A~%"
   file format crvs ))

(defun ic_geo_list_srf_data (file format srfs )
"
Lists the IGES data defining a list of surfaces
out_file	output file
format	output format
crvs	list of surfaces

Notes:

    Output formats:
    iges	IGES Style
    tetin	TETIN Style

    If the function returns with the error status set, the result string will contain an error message.

    The list srfs contains surface names.
"  
  (format
   t
   "ic_geo_list_srf_data ~A ~A ~A~%"
   file format srfs ))

(defun ic_geo_make_conn_regions (type entities
                                 &optional (surf_angle 180) (surf_curvature 360) )
"
Makes connected regions of type: surface or curve entities are a list of the type, surfaces or curves. If type is surface, surf_angle limits connectivity based on curves over the feature angle; default is 180, 0 would make each surface separate. If type is surface, surf_curvature limits connectivity to surfaces with curvature over value; default is 360, 0 would make each surface separate. The return is a separated list based on connectivity.
"  
  (format
   t
   "ic_geo_make_conn_regions ~A ~A ~A ~A~%"
   type entities surf_angle surf_curvature ))

(defun ic_geo_get_attached_entities (attach_type orig_type entities )
"
Gets all attached entities based on attach_type and orig_type to a list of entities. attach_type could be boundary or incident. orig_type could be surface curve or point. Example: if you want all curves attached to a list of surfaces attach_type is boundary, orig_type is surface, entities is the list of surfaces.
"  
  (format
   t
   "ic_geo_get_attached_entities ~A ~A ~A~%"
   attach_type orig_type entities ))

(defun ic_geo_get_entities_by_attach_num (type num &optional (entities ""))
"
Gets all entities of a type: point or curve; that have defined number of entities attached to it. For example a single curve has 1 entity attached. entities is list of type to look for. Default is all entities of this type. If num is multiple, it will find attachments of 3 or more. If num is double, it will find attachments of 2. If num is single, it will find attachments of 1. If num is unattached, it will find attachments of 0.
"  
  (format
   t
   "ic_geo_get_entities_by_attach_num ~A~A~A~%"
   type num entities ))

(defun ic_geo_get_internal_surface_boundary (surf &optional (not_single 0) )
" This command will take a given \"surf\" and return the curves that
are internal. In other words, it will return all attached curves
except those on outer boundary. Optional argument not_single will
limit the returned curves to only those that are attached to more than
1 surface.
"  
  (format
   t
   "ic_geo_get_internal_surface_boundary ~A ~A~%"
   surf not_single))

(defun ic_geo_find_internal_outer_loops (surfs &optional (not_single 0) (all_boundary 0) )
"
This procedure returns a list of outer curves and inner curves attached to a set of surfaces, optional argument not_single will limit the list to just curves attached to more than 1 surface.
"  
  (format
   t
   "ic_geo_find_internal_outer_loops ~A ~A ~A~%"
   surfs not_single all_boundary ))

(defun ic_geo_find_internal_surfaces (loop surrounding_surfs
                                           &optional (outer_curves "")
                                                     (exclusion_surfs ""))
"
This function will find a set of surfaces enclosed by a loop of curves.
"  
  (format
   t
   "ic_geo_find_internal_surfaces ~A ~A ~A ~A~%"
   loop surrounding_surfs outer_curves exclusion_surfs ))

(defun ic_geo_make_conn_buttons (loop &optional (exclusion_surfs "") )
"
This function will take a curve list (loop), and find all surfaces attached to it excluding any given exclusion_surfs.
"  
  (format
   t
   "ic_geo_make_conn_buttons ~A ~A~%"
   loop exclusion_surfs ))

(defun ic_geo_split_surfaces_at_thin_regions (srfs tolerance min_res_curve_len )
"
Splits boundaries of the given surfaces at thin regions, that is, where a surface boundary points is less than tolerance from an other boundary curve. It will not, however, split curves which would result in segments of length less than min_res_curve_len. Returns a list of all new points, if any.
"  
  (format
   t
   "ic_geo_split_surfaces_at_thin_regions ~A ~A ~A~%"
   srfs tolerance min_res_curve_len ))

(defun ic_geo_surface_create_smart_nodes (srfs tolerance min_res_curve_len )
"
Split boundaries of the given surfaces at thin regions, that is, where a surface boundary points is less than tolerance from an other boundary curve. It will not, however, split curves which would result in segments of length less than min_res_curve_len. Returns tcl-error-stat.
"  
  (format
   t
   "ic_geo_surface_create_smart_nodes ~A ~A ~A~%"
   srfs tolerance min_res_curve_len ))

(defun ic_geo_surface_topological_corners (surfs )
" For each surface in the given list surfs returns a list of the four
corners of a rectangular topology of that surface. The points are
ordered around the rectangular either clockwise or
counter-clockwise. The form of the list returned is: \"{surf_name_1
{pt_name_1_1 pt_name_1_2 pt_name_1_3 pt_name_1_4} {surf_name_2
{pt_name_2_1 ...}}\"
"  
  (format
   t
   "ic_geo_surface_topological_corners ~A~%"
   surfs ))

(defun ic_geo_flanges_notch_critical_points (surfs )
"
Returns the critical point of the notch in a given flange surface.
"  
  (format
   t
   "ic_geo_flanges_notch_critical_points ~A~%"
   surfs ))

(defun ic_geo_trm_srf_at_par (srf par sel )
"
Splits a surface at a parameter.
srf	surface name
par	surface parameter 0 <= par <= 1
sel	== 0 u cons; == 1 v cons

Example


        if [catch {ic_geo_trm_srf_at_par $srf1 0.5 0} err] {
 mess \"$err\n\" red
 }
      
"  
  (format
   t
   "ic_geo_trm_srf_at_par ~A ~A ~A~%"
   srf par sel ))

(defun ic_geo_trm_srfs_by_curvature (srfs ang )
"
Splits folded surfaces by maximum curvature.
srfs	surface names
ang	maximum total curvature
"  
  (format
   t
   "ic_geo_trm_srfs_by_curvature ~A ~A~%"
   srfs ang ))

(defun ic_surface_curvature (surf &optional (tol 100) (debug 0) )
"
Calculates curvature of surface.
surf	surface name
btol	relative boundary tolerance (100 -> 1/100 -> 1%)
"  
  (format
   t
   "ic_surface_curvature ~A ~A ~A~%"
   surf tol debug ))

(defun ic_hull_2d (entities
                   &optional (tol 0) (four 1) (type "srface") (shrink 0) (debug 0) )
"
Creates 2D hull of surfaces or curves.
entities	entity names
tol	approximation tolerance
four	split hull at best four corners if set
type	surface or curve
shrink	relative shrink tolerance (0 ... 1)
"  
  (format
   t
   "ic_hull_2d ~A ~A ~A ~A ~A ~A~%"
   entities tol four type shrink debug ))

(defun ic_surface_from_points (points &optional
                                        (part "")
                                        (name ""))
"
Creates a faceted surface from points using a 2D Delaunay triangulation.
points	point names
"  
  (format
   t
   "ic_surface_from_points ~A ~A ~A~%"
   points part name ))

(defun ic_geo_surface_extend (curve surfaces
                              &optional
                                (toler 0) (bld_topo 1) (perpendicular 1)
                                (connect 0) (concat_crvs 1) (db 0) )
"
Extends surface edge to surface(s).
curve	\"yellow\" edge to extend
surfaces	surfaces to extend surface edge to
toler	geometry tolerance
bld_topo	associate edge curves
perpendicular	extend normal to curve if 1, create a curtain surface if 0, or do a parametric extension if 2
connect	connect extension to target surface(s) if set
concat_crvs	clean points on surface edges if set
"  
  (format
   t
   "ic_geo_surface_extend ~A ~A ~A ~A ~A ~A ~A ~A~%"
   curve surfaces toler bld_topo perpendicular connect concat_crvs db ))

(defun ic_geo_cre_srf_crv_drv_srf (family name gencrv ctrcrv
                                   &optional (bld_topo 0) )
"
Create a curve driven surface.
family	family containing new surface
name	name of created surface
gencrv	name of generator or driven curve
ctrcrv	name of center or driver curve
bld_topo	associate edge curves

Notes:

    The specified surface name may be modified to resolve name collisions.

    If the function returns with the error status set, the result string will contain an error message.
"  
  (format
   t
   "ic_geo_cre_srf_crv_drv_srf ~A ~A ~A ~A ~A~%"
   family name gencrv ctrcrv bld_topo  ))

(defun ic_geo_get_types (&optional (which "all"))
"
This function returns a list of all geometric entity types available in the loaded geometry. If no geometry is loaded, it returns all possible types: \"surface curve point material density loop\"
"  
  (format
   t
   "ic_geo_get_types ~A~%"
   which  ))

(defun ic_flood_fill_surface_angle (surf curve angle )
"
Returns the list of incident surfaces at curve whose dihedral angle with surf is less than the feat_angle.
"  
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
"
Returns the list of entities connected by the lower dimension entities. For example surfaces connected by the curves.

    what - 'curve' or 'surface'

    ents - list of type, name pairs

    all - 0 if only one level is desired

    feat_angle - 0 >= theta <= 90, valid only for $what = surface

    bound_mode - 'outer' if only outer loop is desired, valid only for $what = surface

    nedges - for use with curves - if 0 then all attached curves, else only go with curves that have the specified number of attached surfaces
"  
  (format
   t
   "ic_geo_flood_fill ~A ~A ~A ~A ~A ~A~%"
   what ents all feat_angle bound_mode nedges ))

(defun ic_geo_get_triangulation_tolerance ()
"
Returns a two-element list containing the triangulation tolerance of the model, such that the first element is the tolerance (real number) and the second element is an integer (0 or 1) indicating whether or not the value is relative to a global setting.
"  
  (format
   t
   "ic_geo_get_triangulation_tolerance~%"
   ))

(defun ic_geo_convex_hull (entities name fam )
"
Creates the convex hull of the objects. entities is a list of pairs, where the first element is the type and the second is the name.
"  
  (format
   t
   "ic_geo_convex_hull ~A ~A ~A~%"
   entities name fam ))

(defun ic_geo_remove_triangles_on_plane (surf plane tol )
"
Remove triangles on a plane in the named surface.
"  
  (format
   t
   "ic_geo_remove_triangles_on_plane ~A ~A ~A~%"
   surf plane tol ))

(defun ic_geo_bbox_of_entities (ents )
"
Return the bounding box of some objects. The ents argument is a list of the form {{type name} {type name} ...}
"  
  (format
   t
   "ic_geo_bbox_of_entities ~A~%"
   ents ))

(defun ic_geo_classify_by_regions (planes entities how )
"
Used by convex hull.
"  
  (format
   t
   "ic_geo_classify_by_regions ~A ~A ~A~%"
   planes entities how ))

(defun ic_geo_split_surfaces (surfs planes )
"
Used by convex hull.
"  
  (format
   t
   "ic_geo_split_surfaces ~A ~A~%"
   surfs planes ))

(defun ic_geo_elem_assoc (domain assoc )
"
Generate mesh geometry associativity for CATIA interface.
domain	domain file
assoc	output associativity file
"  
  (format
   t
   "ic_geo_elem_assoc ~A~A~%"
   domain assoc ))

(defun ic_geo_cre_bsp_srf_by_pnt_array (family name n_ptu n_ptv pnts
                                        &optional
                                          (tol 0.0001))
"
Creates a bspline surface from a point array.
family	family containing surface
name	name of created surface
n_ptu 	number of points in u direction
n_ptv 	number of points in v direction
pnts	point data

Notes:

    The specified surface name may be modified to resolve name collisions.

    If the function returns with the error status set, the result string will contain an error message.

    Positions may be specified explicitly or using names of prescribed points

    The approximation tolerance is relative. It will be scaled by the pointset radius to form an absolute tolerance. It has a default value of 0.001.
"  
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
"
Create point and b-spline geometry from an Ansys ICEM CFD Input file.
fit_tol	approximation tolerance
mode	type of ICEM CFD input file
pnt_fam	family for point entities
pnt_prefix 	prefix for point names
crv_fam	family for curve entities
crv_prefix	prefix for curve names
srf_fam	family for surface entities
srf_prefix	prefix for surface names

Notes:

    If the function returns with the error status set, the result string will contain an error message.

    MED must be initialized by loading a tetin file or opening an empty part (see ic_empty_tetin).

    The approximation tolerance is relative. It will be scaled by the pointset radius to form an absolute tolerance. It has a default value of 0.001.

    Supported values for mode are input and plot3d. named for named entities is planned, but not yet supported.

    For example usage, refer to ic_geo_cre_geom_input.tcl in the Ansys installation directory under v221/icemcfd/Samples/ProgrammersGuide/med_test.
"  
  (format
   t
   "ic_geo_cre_geom_input ~A ~A ~A ~A ~A ~A ~A ~A ~A~%"
   in_file fit_tol mode pnt_fam pnt_prefix crv_fam crv_prefix srf_fam srf_prefix))

(defun ic_geo_import_str_to_cad (doms &optional
                                        (srf_fam "SRFS")
                                        (crv_fam "")
                                        (pnt_fam ""))
"
Converts structured surface domains to b-spline geometry. If successful, the current mesh and geometry are unloaded, and the new geometry is loaded. Surfaces, curves, and points are created only if families are provided for each argument type. By default, only surfaces will be created.
"  
  (format
   t
   "ic_geo_import_str_to_cad ~A ~A ~A ~A~%"
   doms srf_fam crv_fam pnt_fam  ))

(defun ic_geo_crv_data (crvs datums )
"
Return the b-spline data associated to a curve.
crvs	list of curve to examine
datums	list of curve properties to return

Notes:

    curve properties may be a list of one or more of the following:

        order — Integer order of spline

        ncp — Number of control points (3-tuples in model space)

        rat — Rational flag -- 1 if rational; 0 if integral

        cps — Return model space control points

        knots — Return knot vector

        weights — Return a list of curve weights

    If the utility is called for multiple curves, the data for each curve will be grouped together

    If weights are requested for an integral spline, the list of weights returned will be null

    For example usage, refer to ic_geo_crv_data.tcl in the Ansys installation directory under v221/icemcfd/Samples/ProgrammersGuide/med_test.
"  
  (format
   t
   "ic_geo_crv_data ~A ~A~%"
   crvs datums ))

(defun ic_geo_srf_data (srfs datums )
"
Return the b-spline data associated to a surface
srfs	list of surface to examine
datums	list of surface properties to return

Notes:

    surface properties may be a list of one or more of the following:

        order — Integer orders (u and v) of spline

        ncp — Control point counts in u and v

        rat — Rational flag -- 1 if rational; 0 if integral

        cps — Return model space control points. Control points are returned in a list arranged in v-major order (see example program for details)

        knots_u — Return u knot vector

        knots_v — Return v knot vector

        weights — Return a list of surface weights. Weights are returned in a list arranged in v-major order

    If the utility is called for multiple surfaces, the data for each surface will be grouped together

    If weights are requested for an integral spline, the list of weights returned will be null

    For example usage, refer to ic_geo_srf_data.tcl in the Ansys installation directory under v221/icemcfd/Samples/ProgrammersGuide/med_test.
"  
  (format
   t
   "ic_geo_srf_data ~A ~A~%"
   srfs datums ))

(defun ic_geo_cre_srf_loft_crvs (family name tol crvs
                                 &optional
                                   (sec_ord 4) (form 0) (bld_topo 0) )
"
Create a new surface by lofting two or more curves
family	family containing new surface
name	name of created surface
tol	approximation tolerance
crvs	list of curves to loft
sec_ord	order in cross direction
form	0 (C1 cubic blend) or 1 (C2 cubic blend)
bld_topo	associate edge curves

Notes:

    The surface order in the cross direction must be 2 (linear) or 4 (cubic).

    The specified surface name may be modified to resolve name collisions.

    If the function returns with the error status set, the result string will contain an error message.

    The approximated surface should lie within tol of the curves.

    The list crvs contains curve curve names.
"  
  (format
   t
   "ic_geo_cre_srf_loft_crvs ~A ~A ~A ~A ~A ~A ~A~%"
   family name tol crvs sec_ord form bld_topo ))

(defun ic_geo_cre_crv_test_project_surface (family name surface curve dir )
"
Project a curve to a surface.
family	family for new curve
name	name for new curve (can be \"\")
surface	name of input surface
curve	name of input curve
dir	direction vector

Return value is the name of the new curve.
"  
  (format
   t
   "ic_geo_cre_crv_test_project_surface ~A ~A ~A ~A ~A~%"
   family name surface curve dir ))

(defun ic_geo_cre_surface_section (family name surface mode P0 P1
                                   &optional
                                     (P2 "")
                                     (trim 0) )
"
Create curve as section of a surface with plane, cylinder or segment.
family	family for new curve
name	name for new curve (can be \"\")
surface	name of input surface
mode	0 - section with plane
1 - section with cylinder
2 - section with segment
P0, P1, P2	define plane, cylinder or segment:
Surface through three given points
Cylinder with axis on P0-P1 line and P2 on the radius
Segment from P0 to P1 projected in direction P0-P2

Return value is the name of the new curve.
"  
  (format
   t
   "ic_geo_cre_surface_section ~A ~A ~A ~A ~A ~A ~A~%"
   family name surface mode P0 P1 P2 trim ))

(defun ic_geo_offset (family name surface_to_offset offset
                      &optional
                        (max_factor 3) )
"
Offset surface using mesh representation.
"  
  (format
   t
   "ic_geo_offset ~A ~A ~A ~A ~A~%"
   family name surface_to_offset offset max_factor ))

(defun ic_geo_cre_crv_datred (family name crvs
                              &optional (tol 0.001) )
"
Creates a reduced b-spline curve
family	family containing curve
name	name of created curve
crvs	list of curves to be joined
tol	approximation tolerance
return	names of created curves

Notes:

    The specified curve name may be modified to resolve name collisions.

    If the function returns with the error status set, the result string will contain an error message.

    The list crvs contains curve curve names.

    For example usage, refer to ic_geo_cre_crv_datred.tcl in the Ansys installation directory under v221/icemcfd/Samples/ProgrammersGuide/med_test.
"  
  (format
   t
   "ic_geo_cre_crv_datred ~A ~A ~A ~A~%"
   family name crvs tol ))

(defun ic_geo_cre_srf_datred (family name srfs &optional (tol 0.001) )
"
Create a reduced b-spline surface.
family	family containing surface
name	name of created surface
srfs	list of surfaces to be joined
tol	approximation tolerance
return	names of created surfaces

Notes:

    The specified surface name may be modified to resolve name collisions.

    If the function returns with the error status set, the result string will contain an error message.

    The list srfs contains surface surface names.

    For example usage, refer to ic_geo_cre_srf_datred.tcl in the Ansys installation directory under v221/icemcfd/Samples/ProgrammersGuide/med_test.
"  
  (format
   t
   "ic_geo_cre_srf_datred ~A ~A ~A ~A~%"
   family name srfs tol ))

(defun ic_geo_cre_srf_sweep (family name gen drv &optional (bld_topo 0) )
"
Creates a swept surface from a generator curve and axis.
family	family containing surface
name	name of created surface
gen	generator curve(s)
drv	drive curve or vector
bld_topo	associate edge curves
return	name of created surface

Notes:

    The specified surface name may be modified to resolve name collisions.

    If the function returns with the error status set, the result string will contain an error message.

    Positions may be specified explicitly or using names of prescribed points.

    For example usage, refer to ic_geo_cre_srf_sweep.tcl in the Ansys installation directory under v221/icemcfd/Samples/ProgrammersGuide/med_test.
"  
  (format
   t
   "ic_geo_cre_srf_sweep ~A ~A ~A ~A ~A~%"
   family name gen drv bld_topo  ))

(defun ic_geo_crv_is_opposite (crv1 crv2 )
"
Determines whether two curves are oriented in parallel or opposite directions.
crv1	curve 1 name
crv2	curve 2 name
return	1 if opposite, 0 otherwise

Notes:

    Main use of this function is to diagnose failures in some of the surface construction codes.

    For example usage, refer to ic_geo_crv_is_opposite.tcl in the Ansys installation directory under v221/icemcfd/Samples/ProgrammersGuide/med_test.
"  
  (format
   t
   "ic_geo_crv_is_opposite ~A ~A~%"
   crv1 crv2 ))

(defun ic_geo_crv_is_edge (crv )
"
Determines whether a curve bounds a surface.
crv	curve name
return	number of surfaces bounded
"  
  (format
   t
   "ic_geo_crv_is_edge ~A~%"
   crv ))

(defun ic_geo_fix_degen_geom (&optional (switch 0) )
"
Activates repair function for degenerate bsplines in the tetin reader. For now these functions are disabled by default.
switch	0 for off; 1 for on
"  
  (format
   t
   "ic_geo_fix_degen_geom ~A~%"
   switch ))

(defun ic_geo_find_nearest_srf_pnt (srf pnt &optional (want_ext 0) )
"
Finds parameters of closest point on surface.
srf 	name of surface
pnt	test point
want_ext	want extended output
return	uv pair

Notes:

    If the function returns with the error status set, the result string will contain an error message.

    The uv coordinates will be unitized.

    For example usage, refer to ic_geo_find_nearest_srf_pnt.tcl in the Ansys installation directory under v221/icemcfd/Samples/ProgrammersGuide/med_test.
"  
  (format
   t
   "ic_geo_find_nearest_srf_pnt ~A~A~A~%"
   srf pnt want_ext))

(defun ic_geo_find_nearest_crv_pnt (crv pnt )
"
Finds parameters of closest point on curve.
crv	name of curve
pnt	test point
return	t parameter

Notes:

    If the function returns with the error status set, the result string will contain an error message.

    The t parameter will be unitized.

    For example usage, refer to ic_geo_find_nearest_crv_pnt.tcl in the Ansys installation directory under v221/icemcfd/Samples/ProgrammersGuide/med_test.
"  
  (format
   t
   "ic_geo_find_nearest_crv_pnt ~A ~A~%"
   crv pnt ))

(defun ic_geo_distance_from_surfaces (surfs coords )
"
Gets the distance of coords from the nearest surface in surface_family
"  
  (format
   t
   "ic_geo_distance_from_surfaces ~A ~A~%"
   surfs coords ))

(defun ic_geo_nearest_surface_list (coords surfaces )
"
Gets nearest surface to coords from a list of surfaces.
"  
  (format
   t
   "ic_geo_nearest_surface_list ~A ~A~%"
   coords surfaces ))

(defun ic_geo_get_crv_nrm (par crv )
"
Gets the normal vector of a curve at a parameter.
par	curve t parameter
crv	list of curves to evaluate
return	list of 3-tuple of doubles

Notes:

    If the function returns with the error status set, the result string will contain an error message.

    The return string will be a list of 3-tuples

    The input uv coordinates should be unitized.
"  
  (format
   t
   "ic_geo_get_crv_nrm ~A ~A~%"
   par crv ))

(defun ic_geo_get_crv_pos (par crv )
"
Gets a position on a curve at a parameter.
par	curve t parameter
crv	list of curves to evaluate
return	list of 3-tuple of doubles

Notes:

    If the function returns with the error status set, the result string will contain an error message.

    The input uv coordinates should be unitized.

    The return string will be a list of 3-tuples

    For example usage, refer to ic_geo_get_crv_pos.tcl in the Ansys installation directory under v221/icemcfd/Samples/ProgrammersGuide/med_test.
"  
  (format
   t
   "ic_geo_get_crv_pos ~A ~A~%"
   par crv ))

(defun ic_geo_get_crv_binrm (par crv )
"
Gets the binormal vector of a curve at a parameter.
par	curve t parameter
crv	list of curves to evaluate
return	list of 3-tuple of doubles

Notes:

    If the function returns with the error status set, the result string will contain an error message.

    The input uv coordinates should be unitized.
"  
  (format
   t
   "ic_geo_get_crv_binrm ~A ~A~%"
   par crv ))

(defun ic_geo_cvt_uns_to_bsc (family base uns )
"
Creates one or more bspline curves from an unstructured curve.
family	family for new curves
base	base name of created curves
uns	name(s) of unstructured curve(s)
return	name of created curves

Notes:

    If the function returns with the error status set, the result string will contain an error message.

    If the input curve is a b-spline curve it will be returned without modification as the output curve

    For example usage, refer to ic_geo_cvt_uns_to_bsc.tcl in the Ansys installation directory under v221/icemcfd/Samples/ProgrammersGuide/med_test.
"  
  (format
   t
   "ic_geo_cvt_uns_to_bsc ~A ~A ~A~%"
   family base uns ))

(defun ic_geo_srf_area (srfs )
"
Computes the area of one or more surfaces.
srfs	list of one or more surfaces
return	area of surfaces

Notes:

    Surface area is computed from projlib's facetization of the geometry; the results will be influenced by the value of the triangulation tolerance when the part was read.

    For example usage, refer to ic_geo_srf_area.tcl in the Ansys installation directory under v221/icemcfd/Samples/ProgrammersGuide/med_test.
"  
  (format
   t
   "ic_geo_srf_area ~A~%"
   srfs ))

(defun ic_geo_sort_by_srf_area (surf_list &optional (args "") )
"
Sorts surfaces by their surface area. args is arguments for the sort.
"  
  (format
   t
   "ic_geo_sort_by_srf_area ~A ~A~%"
   surf_list args ))

(defun ic_geo_reduce_face (srfs )
"
Trims a surface back to its active area.
srfs	list of one or more surfaces

Notes:

    A form of data reduction; trims the undisplayed portion of a b-spline away.

    Unless the underlying surface is reduced by at least 5% in the u or v coordinate, the surface will be left unmodified.

    For example usage, refer to ic_geo_reduce_face.tcl in the Ansys installation directory under v221/icemcfd/Samples/ProgrammersGuide/med_test.
"  
  (format
   t
   "ic_geo_reduce_face ~A~%"
   srfs ))

(defun ic_geo_get_crv_tan (par crv )
"
Gets the tangent vector of a curve at a parameter.
par	curve t parameter
crv	list of curves to evaluate
return	list of 3-tuple of doubles

Notes:

    The tangent vector will be the un-normalized derivative vector with respect to the unitized parameterization

    If the function returns with the error status set, the result string will contain an error message.

    The input uv coordinates should be unitized.
"  
  (format
   t
   "ic_geo_get_crv_tan ~A ~A~%"
   par crv ))

(defun ic_geo_mod_crv_tanext (crvs dist srtend )
"
Tangentially extend a curve.
crvs	list of curves to extend
dist	distance (relative) of ext.
srtend	extend start (0), end(1)
return	names of extended curves

Notes:

    The specified curve name may be modified to resolve name collisions

    The length of the extension will be roughly \"dist*curve length\"

    If the function returns with the error status set, the result string will contain an error message.

    If the curve has topology (i.e. references surfaces or vertices) it will be copied rather than modified.

    The list crvs contains curve curve names.

    For example usage, refer to ic_geo_mod_crv_tanext.tcl in the Ansys installation directory under v221/icemcfd/Samples/ProgrammersGuide/med_test.
"  
  (format
   t
   "ic_geo_mod_crv_tanext ~A ~A ~A~%"
   crvs dist srtend ))

(defun ic_geo_mod_srf_tanext (srfs dist srtend &optional (bld_topo 0) )
"
Tangentially extend a surface.
srfs	list of surfaces to extend
dist	distance (relative) of ext.
edge	index of edge to extend
return	names of modified surfaces

Notes:

    The dist parameter is unitless and will be scaled by the lengths of the u or v constant control point rows.

    If the function returns with the error status set, the result string will contain an error message.

    The edge indicator is set as follows:

        1 V-Min direction

        2 U-Min direction

        3 V-Max direction

        4 U-Max direction

    The list srfs contains surface surface names.

    For example usage, refer to ic_geo_mod_srf_tanext.tcl in the Ansys installation directory under v221/icemcfd/Samples/ProgrammersGuide/med_test.
"  

  (format
   t
   "ic_geo_mod_srf_tanext ~A ~A ~A ~A~%"
   srfs dist srtend bld_topo ))

(defun ic_geo_mod_srf_ext (srfs dist edge &optional (bld_topo 0) )
"
Extend a surface.
srfs	list of surfaces to extend
dist	distance of extension
edge	curve at edge to extend
return	names of modified surfaces
"  
  (format
   t
   "ic_geo_mod_srf_ext ~A ~A ~A ~A~%"
   srfs dist edge bld_topo ))

(defun ic_geo_mod_crv_match_crv (crv1 crv2 &optional (crv1end 0) (crv2end 0) (modes "") )
"
Matches two curves.
crv1	name of first curve
crv2	name of second curve
crv1end	curve1 end indicator
crv2end	curve2 end indicator
modes	5 element list of flags
return	names of modified curves

Notes:

    The curve end parameters, crv1end and crv2end, take the following values:
    closest endpoint	0
    start point 	1
    end point 	2

    The modes argument is an optional 5 element list of flags addressing the following functions:
    mode[0]	0 point only
    1 point and tangent (default)
    2 point, tangent, and curvature
    3 point and curvature
    mode[1]	1 geometric matching (default)
    2 exact matching
    mode[2]	0 do not change order
    1 permit change of order (default)
    mode[3]	0 both splines matched (default)
    1 only first spline changed
    mode[4]	0 3d matching (default)
    1 4d matching

    If the function returns with the error status set, the result string will contain an error message.

    For example usage, refer to ic_geo_mod_crv_match_crv.tcl in the Ansys installation directory under v221/icemcfd/Samples/ProgrammersGuide/med_test.
"  

  (format
   t
   "ic_geo_mod_crv_match_crv ~A ~A ~A ~A ~A~%"
   crv1 crv2 crv1end crv2end modes ))

(defun ic_geo_mod_crv_match_pnt (crv pnt &optional (crvend 0) (modes "") )
"
Match curve and a point.
crv	name of curve
pnt	name of point
crvend	curve end indicator
return	name of modified curve

Notes:

    The curve end parameter, crvend takes the following values:
    closest endpoint	0
    start point	1
    end point	2

    If the function returns with the error status set, the result string will contain an error message.
"  
  (format
   t
   "ic_geo_mod_crv_match_pnt ~A ~A ~A ~A~%"
   crv pnt crvend modes ))

(defun ic_geo_cre_srf_offset (family name base offset
                              &optional
                                (all_conn 0) (stitch 0) )
"
Creates one or more offset surfaces.
family	family containing surface
name	base name of created surface
base	surface(s) to offset
offset	distance to offset
all_conn	offset connected surfs if set
stitch	preserve connected edges if set
return	name(s) of created surface(s)

Notes:

    The specified surface name may be modified to resolve name collisions.

    If the function returns with the error status set, the result string will contain an error message.

    Negative offsets are allowed.

    If more than one surface is given to the routine, offsets will be oriented relative to the first surface if the two surfaces are related by an edge adjacency chain.

    If the all_conn flag is set, all surfaces connected to the first surface by an edge adjacency chain will be offset.

    If the stitch flag is set, the offsets of two surfaces sharing an edge will be extended tangentially so that the offset surfaces also share an edge

    For example usage, refer to ic_geo_cre_srf_offset.tcl in the Ansys installation directory under v221/icemcfd/Samples/ProgrammersGuide/med_test.
"  
  (format
   t
   "ic_geo_cre_srf_offset ~A ~A ~A ~A ~A ~A~%"
   family name base offset all_conn  stitch  ))

(defun ic_geo_build_bodies (&optional
                              (fam "LIVE") (buildtopo 0) (tol 0.01)
                              (multi 0) (newm 0) (surf "")
                              (assem 0) (from_solids 0) )
"
Automatically creates a body for each closed volume of surfaces as determined by the connectivity produced from build topology.
fam	Family for bodies
buildtopo	Build topology if non-zero
tol	Tolerance for the optional build topology function
multi	Old style assembly naming if non-zero
newm	Use the new schema if non-zero
surf	Initial surface
"  
  (format
   t
   "ic_geo_build_bodies ~A ~A ~A ~A ~A ~A ~A ~A~%"
   fam buildtopo tol multi newm surf assem from_solids ))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun ic_geo_create_volume (matlpt &optional (name "") (fam "LIVE"))
"
Creates volume from material point name, matlpt.
"  

  (format
   t
   "ic_geo_create_volume ~A ~A ~A~%"
   matlpt name fam ))

(defun ic_geo_reset_bodies ()
"
Updates the current defined bodies in the model, by removing nonexistent ones and adding any new ones to the display.
"  

  (format
   t
   "ic_geo_reset_bodies~%"
   ))

(defun ic_geo_create_body (surfs &optional (name "") (fam "") (quiet 0) )
"
Creates a body from the collection of surfaces, surfs. The new body will be given the name, name, in the family, fam.
"  
  (format
   t
   "ic_geo_create_body ~A ~A ~A ~A~%"
   surfs name fam quiet ))

(defun ic_geo_get_body_matlpnt (bdy )
"
Returns the material point name associated with the body, bdy.
"  
  (format
   t
   "ic_geo_get_body_matlpnt ~A~%"
   bdy ))

(defun ic_geo_srf_radius (srfs )
"
Computes the radius of a b-spline surface.
srfs	list of one or more surfaces
return	list of computed surface radii

Notes:

    The radius is the maximum chord length of the control point rows.

    For example usage, refer to ic_geo_cre_srf_offset.tcl in the Ansys installation directory under v221/icemcfd/Samples/ProgrammersGuide/med_test.
"  
  (format
   t
   "ic_geo_srf_radius ~A~%"
   srfs ))

(defun ic_geo_cre_srf_offset_edge (family name crv offset )
"
Creates an offset surface from a generator curve and axis.
family	family containing surface
name	name of created surface
gen	generator curve(s)
base	axis base point
zaxis	axis direction vector
srtang	start angle (degrees)
endang	end angle (degrees)
return	name of created surface

Notes:

    The specified surface name may be modified to resolve name collisions.

    If the function returns with the error status set, the result string will contain an error message.

    Positions may be specified explicitly or using names of prescribed points

    For example usage, refer to ic_geo_cre_srf_offset_edge.tcl in the Ansys installation directory under v221/icemcfd/Samples/ProgrammersGuide/med_test.
"  
  (format
   t
   "ic_geo_cre_srf_offset_edge ~A~A~A~A~%"
   family name crv offset ))

(defun ic_geo_body_lower_entities (bdy )
"
Given a body name, bdy, it returns the names of the surfaces, curves, and points belonging to the body. These are returned in the form of argument pairs where the first name is the entity type and the second name is the entity name.
"  
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
"
Creates point and b-spline geometry from a Plot3d file.
fit_tol	approximation tolerance
pnt_fam	family for point entities
pnt_prefix	prefix for point names
crv_fam	family for curve entities
crv_prefix 	prefix for curve names
srf_fam 	family for surface entities
srf_prefix	prefix for surface names

Notes:

    If the function returns with the error status set, the result string will contain an error message.

    MED must be initialized by loading a tetin file or opening an empty part (see ic_empty_tetin).

    The approximation tolerance is relative. It will be scaled by the pointset radius to form an absolute tolerance. It has a default value of 0.001.

    This routine is called by ic_geo_cre_geom_input
"  

  (format
   t
   "ic_geo_cre_geom_plot3d ~A ~A ~A ~A ~A ~A ~A ~A~%"
   in_file fit_tol pnt_fam pnt_prefix crv_fam crv_prefix srf_fam srf_prefix ))

(defun ic_geo_cre_srf_db_pnts (srfs )
"
Create the deboor points of a bspline surface.
srfs	list of surfaces
return	names of created points
"  
  (format
   t
   "ic_geo_cre_srf_db_pnts ~A~%"
   srfs ))

(defun ic_geo_cre_crv_db_pnts (crvs )
"
Creates the deboor points of a bspline curve.
crvs	list of curves
return	names of created points
"  
  (format
   t
   "ic_geo_cre_crv_db_pnts ~A~%"
   crvs ))

(defun ic_geo_read_off_file (fam name in_file )
"
Read an OFF file (native format for Geomview).
fam	family for new geometry
name	root name for new surfaces
in_file 	input file

Notes:

    This function reads triangulated surfaces from the input file and creates unstructured surfaces in MED.

    Only minimal coverage of the OFF format has been implemented.

    For example usage, refer to ic_geo_read_off_file.tcl in the Ansys installation directory under v221/icemcfd/Samples/ProgrammersGuide/med_test.
"  
  (format
   t
   "ic_geo_read_off_file ~A ~A ~A~%"
   fam name in_file ))

(defun ic_geo_read_xyz_file (fam name in_file off_file &optional (mode "") )
"
Reads and triangulate a list of XYZ points.
fam	family for new geometry
name	root name for new surfaces
in_file	input file
off_file 	intermediate OFF file
mode	fast, tight

Notes:

    This function reads triangulated surfaces from the off file and creates unstructured surfaces in MED.

    Only minimal coverage of the OFF format has been implemented.

    For example usage, refer to ic_geo_read_xyz_file.tcl in the Ansys installation directory under v221/icemcfd/Samples/ProgrammersGuide/med_test.

    mode can be used to specify fast execution or watertight model.
"  
  (format
   t
   "ic_geo_read_xyz_file ~A ~A ~A ~A ~A~%"
   fam name in_file off_file mode ))

(defun ic_geo_crv_is_arc (crvs &optional (tol -1) )
"
Determine whether one or more curves are circular.
crvs	list of one or more curves
tol	approximation tolerance
return	list of true/false flags

Notes:

    The tolerance defaults to 0.001*arc_length

    For example usage, refer to ic_geo_crv_is_arc.tcl in the Ansys installation directory under v221/icemcfd/Samples/ProgrammersGuide/med_test.
"  
  (format
   t
   "ic_geo_crv_is_arc ~A ~A~%"
   crvs tol ))

(defun ic_geo_get_keypoints (dir border &optional (bb ""))
"
Gets keypoints for the current geometry. dir is 0, 1, or 2. If border is non zero, then add some slack.
"  
  (format
   t
   "ic_geo_get_keypoints ~A ~A ~A~%"
   dir border bb ))

(defun ic_geo_reverse_crv (crvs )
"
Reverses the orientation of one or more curves.
crvs	list of one or more curves
return	error message on failure

For example usage, refer to ic_geo_reverse_crv.tcl in the Ansys installation directory under v221/icemcfd/Samples/ProgrammersGuide/med_test.
"  
  (format
   t
   "ic_geo_reverse_crv ~A~%"
   crvs ))

(defun ic_geo_cre_edge_concat (crvs &optional (require_topo 0) )
"
Merges one or more curves and associated topology.
crvs	list of curves to be joined
require_topo	fail if topology will not merge
return	name of created curve

Notes:

    The specified curve name may be modified to resolve name collisions.

    If the function returns with the error status set, the result string will contain an error message.

    The list crvs contains curve curve names.

    If require_topo is set, the utility will fail if the associated topology cannot be merged. If require_topo is not set, the utility will create a new curve and preserve the original edges if the associated topology cannot be updated.

    For example usage, refer to ic_geo_cre_edge_concat.tcl in the Ansys installation directory under v221/icemcfd/Samples/ProgrammersGuide/med_test.
"  
  (format
   t
   "ic_geo_cre_edge_concat ~A ~A~%"
   crvs require_topo ))

(defun ic_geo_create_histogram_box (min max lblList )
"
Make a histogram box.
min	min pt of the box
max	max pt of the box
lblList	list of labels

Notes:

    Each label in lblList is a list of {lbl_text, lbl_pt, ispt}.

    If $ispt==1, a point will be drawn as well as the label.
"  
  (format
   t
   "ic_geo_create_histogram_box ~A ~A ~A~%"
   min max lblList ))

(defun ic_geo_build_topo_on_srfs (srfs
                                  &optional
                                    (crvs "") (tol -1) (trim_srfs 0)
                                    (concat_crvs 0) (quiet 0) )
"
Builds topology on a list of surfaces.
srfs	surface(s)
crvs	optional curve(s)
tol	merge tolerance
trim_srfs	1 -- trim surfaces; 0 otherwise
concat_crvs	1 -- concatenate edges that join tangentially; 0 otherwise
quiet	1 -- suppress chatter; 0 otherwise

Notes:

    Merge tolerance will be determined from the bounding box of the surfaces.

    The merge tolerance defaults to 0.0001 * (min surface radius).
"  
  (format
   t
   "ic_geo_build_topo_on_srfs ~A ~A ~A ~A ~A ~A~%"
   srfs crvs tol trim_srfs concat_crvs quiet ))

(defun ic_geo_contact_surfaces (surfaces &optional (distance 0) (family "") (debug 0) )
"
Search for contact surfaces.
surfaces	list of surface names
distance	maximum distance
family	family name for contact surfaces
return	list of surface pairs
"  
  (format
   t
   "ic_geo_contact_surfaces ~A ~A ~A ~A~%"
   surfaces distance family debug ))

(defun ic_geo_map_tetin_sizes (tetin &optional (what 0) )
"
Map parameter data from a tetin file to the current model.
tetin	input tetin file
what	== 0 - map all possible data
bit0 - map global parameters
bit1 - map family parameters
bit2 - map prescribed points data
bit3 - map curve data
bit4 - map surface data

For example usage, refer to ic_geo_map_tetin_sizes.tcl in the Ansys installation directory under v221/icemcfd/Samples/ProgrammersGuide/med_test.
"  
  (format
   t
   "ic_geo_map_tetin_sizes ~A ~A~%"
   tetin what ))

(defun ic_geo_surface_thickness (surfaces order &optional (thickness "") )
"
Set (or get) the thickness of surfaces.
surfaces	list of surface names
order	order of thickness approximation
thickness	order * order thickness values
"  
  (format
   t
   "ic_geo_surface_thickness ~A ~A ~A~%"
   surfaces order thickness ))

(defun ic_geo_srf_in_srf_fam_set (srf fams )
"
Determines whether a surface is within a volume bounded by one or more surface families.
srf	test surface
fams	list of families
"  
  (format
   t
   "ic_geo_srf_in_srf_fam_set ~A ~A~%"
   srf fams ))

(defun ic_geo_cre_srf_over_holes (fam srfs )
"
Closes planar holes in a collection of surfaces.
srf	test surface
fams	list of families
"  
  (format
   t
   "ic_geo_cre_srf_over_holes ~A ~A~%"
   fam srfs ))

(defun ic_geo_subset_exists (name )
"
Checks if a geometry subset exists.
"  
  (format
   t
   "ic_geo_subset_exists ~A~%"
   name ))

(defun ic_geo_subset_copy (oldname newname )
"
Copies the geometry from one subset to another.
"  
  (format
   t
   "ic_geo_subset_copy ~A ~A~%"
   oldname newname ))

(defun ic_geo_subset_clear (name )
"
Clears out everything from a subset.
"  

  (format
   t
   "ic_geo_subset_clear ~A~%"
   name ))

(defun ic_geo_subset_unused_name (&optional (pref "subset") )
"
Returns an unused geometry subset name with the given prefix Note that this gives names unique for both geometry and mesh.
"  
  (format
   t
   "ic_geo_subset_unused_name ~A~%"
   pref ))

(defun ic_geo_subset_delete (name )
"
Deletes a geometry subset.
"  
  (format
   t
   "ic_geo_subset_delete ~A~%"
   name ))

(defun ic_geo_subset_visible (name vis )
"
Makes a geometry subset visible (or not).
"  
  (format
   t
   "ic_geo_subset_visible ~A ~A~%"
   name vis ))

(defun ic_geo_subset_list_families (name )
"
Lists all the families that are represented in the named subset.
"  
  (format
   t
   "ic_geo_subset_list_families ~A~%"
   name ))

(defun ic_geo_subset_list (&optional (pat "*" ))
"
Lists all existing geometry subset names.
"  
  (format
   t
   "ic_geo_subset_list ~A~%"
   pat ))

(defun ic_geo_subset_add_items (name items )
"
Adds items to a geometry subset. If the subset does not exist, it will be created. The items argument is a list of type/name pairs. The types can be one of point, curve, surface, material, density, loop, body, shell, lump, solid, and the names specify the desired object of that type.
"  
  (format
   t
   "ic_geo_subset_add_items ~A ~A~%"
   name items ))

(defun ic_geo_subset_remove_items (name items )
"
Removes items from a geometry subset. The items list is the same as for ic_geo_subset_add_items.
"  
  (format
   t
   "ic_geo_subset_remove_items ~A ~A~%"
   name items ))

(defun ic_geo_subset_handle_bc_changes (items subset add )
"
Adds or removes bc icons and groups based on addition or removal of objects in subsets.
"  
  (format
   t
   "ic_geo_subset_handle_bc_changes ~A ~A ~A~%"
   items subset add))

(defun ic_geo_subset_get_items (name )
"
Gets items in a geometry subset. This returns a list of type/name pairs.
"  
  (format
   t
   "ic_geo_subset_get_items ~A~%"
   name ))

(defun ic_geo_subset_bbox (name )
"
Returns the bounding box of all geometry in a named subset.
"  
  (format
   t
   "ic_geo_subset_bbox ~A~%"
   name ))

(defun ic_geo_subset_add_layer (name all feat_angle bound_mode )
"
Adds one or more layers to a geom subset. Arguments are the same as ic_geo_flood_fill.
"  
  (format
   t
   "ic_geo_subset_add_layer ~A ~A ~A ~A~%"
   name all feat_angle bound_mode ))

(defun ic_geo_subset_remove_layer (name )
"
Removes one or more layers from a geometry subset.
"  
  (format
   t
   "ic_geo_subset_remove_layer ~A"
   name ))

(defun ic_geo_subset_names_to_parts (name )
"
Move the contents of all subsets to a part (name of subset)
"  
  (format
   t
   "ic_geo_subset_names_to_parts ~A~%"
   name ))

(defun ic_geo_get_srf_edges (srf )
"
Returns any curves associated as edges to a surface.
"  
  (format
   t
   "ic_geo_get_srf_edges ~A~%"
   srf ))

(defun ic_geo_get_vert_edges (pnt )
"
Get any curves associated as edges to a vertex.
"  
  (format
   t
   "ic_geo_get_vert_edges ~A~%"
   pnt ))

(defun ic_geo_calc_bisector_pnt (pnt1 pnt2 pnt3 len inverse )
"
Calculates node lying on the bisector of the angle formed by nodes pnt1, pnt2, pnt3 in distance delta. If inverse: calculate the reverse bisector.
"  
  (format
   t
   "ic_geo_calc_bisector_pnt ~A ~A ~A ~A ~A~%"
   pnt1 pnt2 pnt3 len inverse ))

(defun ic_geo_cre_srf_simple_trim (families names srf crvs )
"
Trims a surface using a simple contour.
families	list of 2 family names
names	list of 2 surface names
srf	surface to trim
crvs	list of trim curves

Notes:

    The specified surface names may be modified to resolve name collisions.

    If the function returns with the error status set, the result string will contain an error message.
"  
  (format
   t
   "ic_geo_cre_srf_simple_trim "
   families names srf crvs ))

(defun ic_geo_set_simplification_level (pixels )
"
Sets the simplification level in pixels (surfaces smaller than this size will be drawn as a box. 0 disables simplification. A value of -1 just returns the level.
"  
  (format
   t
   "ic_geo_set_simplification_level ~A~%"
   pixels ))

(defun ic_surface_thickness_check (names &optional (newfam "") (return_unassigned 0) )
"
Checks for zero thickness surfaces and assigns to new family. newfam is family name for surfaces with no thickness. return_unassigned is option to return unassigned surfaces without changing family. Default (0) is disabled.
"  
  (format
   t
   "ic_surface_thickness_check ~A ~A ~A~%"
   names newfam return_unassigned ))

(defun ic_geo_close_contour (crvs srf )
"
Closes up a contour prior to trimming.
crvs	list of curves
srf	surface to trim

Notes:

    The specified surface names may be modified to resolve name collisions.

    If the function returns with the error status set, the result string will contain an error message.
"  
  (format
   t
   "ic_geo_close_contour ~A ~A~%"
   crvs srf ))

(defun ic_geo_find_srf_prc_pnt (srf pnt vec )
"
Finds parameter of pierce point on surface.
srf	name of surface
pnt	test point
vec	pierce direction
return	uv pair

Notes:

    If the function returns with the error status set, the result string will contain an error message.

    The uv coordinates will be unitized.

    For example usage, refer to ic_geo_find_srf_prc_pnt.tcl in the Ansys installation directory under v221/icemcfd/Samples/ProgrammersGuide/med_test.
"  
  (format
   t
   "ic_geo_find_srf_prc_pnt ~A ~A ~A~%"
   srf pnt vec ))

(defun ic_geo_get_dormant (type &optional (only_if_visible "") )
"
Returns list of dormant points or curves.
"  
  (format
   t
   "ic_geo_get_dormant ~A ~A~%"
   type only_if_visible ))

(defun ic_geo_get_dormant_entity (type name )
"
Determines whether an entity is dormant Only points and curves can be dormant synchronized pickable and visible. Used in bounding box.
"  
  (format
   t
   "ic_geo_get_dormant_entity ~A ~A~%"
   type name ))

(defun ic_get_facets (type list )
"
Returns list of faceted surfaces.
"  
  (format
   t
   "ic_get_facets ~A ~A~%"
   type list ))

(defun ic_geo_filter_curves (angle fams )
"
Returns a list of essential curves. A curve is \"essential\" when it bounds two surfaces which meet at an angle (measured by surface normals) exceeding a threshold angle. The function identifies the essential curves in the specified families.
angle	threshold angle in degrees
fams	names of families to search
"  
  (format
   t
   "ic_geo_filter_curves ~A ~A~%"
   angle fams ))

(defun ic_geo_cre_bridge_crv (fam name crv1 crv2
                              &optional (end1 0) (end2 0)
                                (mag1 0.3) (mag2 0.3) )
"
Creates a bridge curve between two curves.
fam	family of created curve
name	name of created curve
crv1	curve 1 name
crv2	curve 2 name
end1	curve 1 end indicator
end2	curve 2 end indicator
mag1	magnitude of start vector
mag2	magnitude of end vector
return	name of curve vertex

Notes:

    The curve end parameters, end1, end2, take the following values:
    point closest to other crv	0
    start point	1
    end point	2

    0 < mag1, mag2 < 1
"  
  (format
   t
   "ic_geo_cre_bridge_crv ~A ~A ~A ~A ~A ~A ~A ~A~%"
   fam name crv1 crv2 end1 end2 mag1 mag2 ))

(defun ic_geo_cre_pln_crv (fam name crv base nrm )
"
Creates the projection of a curve onto a plane.
fam	family of created curve
name	name of created curve
crv1	curve name
return	name of created curve
"  
  (format
   t
   "ic_geo_cre_pln_crv ~A ~A ~A ~A ~A~%"
   fam name crv base nrm ))

(defun ic_geo_pln_n_pnts (pnts )
"
Finds the least square plane through three or more points.
pnts	list of 3 or more points
return	{base} {normal} of plane
"  
  (format
   t
   "ic_geo_pln_n_pnts ~A~%"
   pnts ))

(defun ic_geo_sub_get_numbers_by_names (type ent_names )
"
Returns each entity number (recognized in the batch interpreter) associated with each entity name in ent_names. ent_names can be a list but they must all be the same type defined by type. In this case, the return is a list of numbers in the same order as the entity names were given.
"  
  (format
   t
   "ic_geo_sub_get_numbers_by_names ~A ~A~%"
   type ent_names ))

(defun ic_geo_get_pnt_marked (name )
"
Determines whether a point is marked.
"  
  (format
   t
   "ic_geo_get_pnt_marked ~A~%"
   name ))

(defun ic_geo_set_pnt_marked (name set_to )
"
Sets the marked flag on a point.
"  
  (format
   t
   "ic_geo_set_pnt_marked ~A ~A~%"
   name set_to ))

(defun ic_geo_get_all_marked_pnts ()
"
Returns a list of all marked points.
"  
  (format
   t
   "ic_geo_get_all_marked_pnts~%"
   ))

(defun ic_geo_add_embedded_crv (srf crvs )
"
Embeds a curve into a surface.
srf	surface
crvs	list of curves

Note:   No checks are performed to determine whether the curves are on the surface.
"  
  (format
   t
   "ic_geo_add_embedded_crv ~A ~A~%"
   srf crvs ))

(defun ic_geo_add_embedded_pnt (srf pnts )
"
Embeds a point into a surface.
srf	surface
pnts	list of points

Note:   No checks are performed to determine whether the points are on the surface.
"  
  (format
   t
   "ic_geo_add_embedded_pnt ~A ~A~%"
   srf pnts ))

(defun ic_geo_is_crv_on_srf (crv srf &optional (tol -1) )
"
Checks if a curve is on a surface.
crv	curve
srf	surface
tol	tolerance

Note:   If a negative value is passed for the tolerance, the utility will use an internally computed tolerance.
"  
  (format
   t
   "ic_geo_is_crv_on_srf ~A ~A ~A~%"
   crv srf tol ))

(defun ic_geo_register_crv (crv_name new_fam )
"
Register a curve (this is used by Ansys TurboGrid)
crv_name	name of created curve
"  
  (format
   t
   "ic_geo_register_crv ~A ~A~%"
   crv_name new_fam ))

(defun ic_geo_cre_midline_crv (&optional (crvs "") (toldebug 0) (crvs2 "") (fam "") )
"
Creates a new curve by midlining two existing curves.
crvs	list of 2 curves
tol	tolerance
family	family containing curve
return	name of created midline curve

Notes:

    The specified curve name may be modified to resolve name collisions.

    If the function returns with the error status set, the result string will contain an error message.

    The list crvs contains 2 curves or curves of first set curve names.

    The list crvs2 contains curves of second set curve names.
"  
  (format
   t
   "ic_geo_cre_midline_crv ~A ~A ~A ~A~%"
   crvs toldebug crvs2 fam ))

(defun ic_geo_get_points_from_curves (curves )
"
This finds all the points attached to a list of curves.
"  
  (format
   t
   "ic_geo_get_points_from_curves ~A~%"
   curves ))

(defun ic_geo_test_cmd (vec pnt crvs srfs )
"
Test routine.
"  
  (format
   t
   "ic_geo_test_cmd ~A ~A ~A ~A~%"
   vec pnt crvs srfs ))

(defun ic_geo_cre_crv_ell (family name center srt_pnt next_pnt
                           &optional (srtang 0) (endang 360) )
"
Creates a bspline ellipse from center, start point, second point.
family	family containing curve
name	name of created curve
center	ellipse center
srt_pnt	crv point on ellipse major axis
next_pnt	crv point not on major axis
srtang	start angle (degrees)
endang	end angle (degrees)
return	name of created curve

Notes:

 The specified curve name may be modified to resolve name collisions.

 If the function returns with the error status set, the result string
 will contain an error message.

 If endang < srtang or (endang - srtang) > 360, the angle will be
 adjusted by adding 360 increments.

 Positions may be specified explicitly or using names of prescribed
 points
"  
  (format
   t
   "ic_geo_cre_crv_ell ~A ~A {~{~A~^ ~}} {~{~A~^ ~}} {~{~A~^ ~}} ~A ~A~%"
   family name center srt_pnt next_pnt srtang endang ))

(defun ic_geo_improve_edge (crvs )
"
Improves one or more edges.
crvs	list of one or more curves
"  
  (format
   t
   "ic_geo_improve_edge ~A~%"
   crvs ))

(defun ic_geo_just_do_it (srfs )
"
Surface test routine.
srfs	list of one or more surfaces
"  
  (format
   t
   "ic_geo_just_do_it ~A~%"
   srfs ))

(defun ic_geo_get_prism_families ()
"
Returns the list of families for prism meshing.
"  
  (format
   t
   "ic_geo_get_prism_families~%"
   ))

(defun ic_geo_set_prism_families (prism_fams &optional (excl 1) )
"
Sets the list of families for prism meshing. If excl==1, then any previous prism families are reset.
"  
  (format
   t
   "ic_geo_set_prism_families ~A ~A~%"
   prism_fams excl ))

(defun ic_geo_get_prism_family_params (fam )
"
Returns the prism meshing parameters for a family.
"  
  (format
   t
   "ic_geo_get_prism_family_params ~A"
   fam ))

(defun ic_geo_set_prism_family_params (fam args )
"
Sets the prism meshing parameters for a family.
"  
  (format
   t
   "ic_geo_set_prism_family_params ~A ~A~%"
   fam args ))

(defun ic_geo_create_tglib_sfbgrid (args )
"
Reads a TGLib size function background grid.

Usage: ic_hex_create_tglib_size_functions-tglib_sfbgrid_filefname-remove_existing-create_callbacks

e.g.,: eval ic_hex_create_tglib_size_functions -tglib_sfbgrid_file ./example.sf -remove_existing

Argument Descriptions:
-tglib_sfbgrid_file	full path to a tglib size function background grid file

Optional arguments:
-remove_existing	An existing size function background grid will be removed
-create_callbacks	Callback functions will be set for the usage of the size functions in e.g. the paver
"  
  (format
   t
   "ic_geo_create_tglib_sfbgrid ~A~%"
   args ))

(defun ic_vcalc (&optional (op "") args )
" Calculates basic \"vector\" functions using triplets and/or point
name. Returns empty string if not able to calculate result. The
function (op) followed by one or more args (p1, p2, p3 or const),
where p1, p2, p3 are triplets or point names const is integer or float
scalar is shown:

nrm p1	normalized vector
dir p1 p2	normalized vector from p1 to p2
len p1	length of vector
distance p1 p2	distance between p1 and p2
sum p1 p2	vector sum
diff p1 p2	vector diff
smult p2 const 	vector scaled
sum_smult p1 p2 const	vector sum scaled
dot p1 p2 	dot product p1*p2
mult p1 p2	cross product p1×p2
product p1 p2 	cross product p1×p2
angle p1 p2 p3 	angle between p1-p2 and p1-p3 lines
angle p1 p2	angle between 000-p1 and 000-p2
vec_norm p1 	some vector normal to p1
"  
  (format
   t
   "ic_vcalc ~A ~A~%"
   op args ))

(defun ic_highlight (args )
"
Temporary change color and/or \"width\" of points, curves, surfaces

    color white or red or green. Default color: family color.

    width 1 or 2 or 3. Default width: 1.

    names list of names. If list is empty, default settings will be restored
"  
  (format
   t
   "ic_highlight ~A~%"
   args ))

(defun ic_vset (args )
 "
ic_vset options/parameters : return ic_vset -names : all names* ic_vset -names type : names of that type ic_vset -method : all methods ic_vset -method type : methods for that type ic_vset -method type method : format of the method of the type ic_vset -method name : method for that name (if not default) ic_vset -database : all names of databases with items number ic_vset -database dname : make selected database current ic_vset name : empty line if not defined**, or value (if any) ic_vset name def : for variable set new definition ic_vset -type name : type of entity ic_vset -def name : definition of entity ic_vset -info name : detailed info on entity ic_vset -settings debug : return current debug level ic_vset -settings debug value : set current debug level ic_vset -settings med_pts : current med points usage option ic_vset -settings med_pts value : set current med points usage option ic_vset -settings interrupt value : set 0/1 interrupt design creation (ic_vcreate) ic_vset -vec - vec.expr. : calculate ï¿½anonymousï¿½ vector expression ic_vset -con - con.expr. : calculate ï¿½anonymousï¿½ constraint expression ic_vset - expression : calculate expression without database modification ic_vset -delete name : delete entity ic_vset -delete all : delete all entities in active database ic_vset : (without parameters) return last result or last reason for error** * options may be abbreviated to 3 or more characters: -nam, -met, -dat, -setï¿½ ** most commands return empty line on invalid input

ic_vdefine name type method_name* definition

ic_vfile read filename : read Vid file into current database ic_vfile write filename : write current database into Vid file

## if {$npts == 2} {set pts [list $pts]}
"  
  (format
   t
   "ic_vset ~A~%"
   args ))

(defun ic_curve (method part name def args )
 "
Create a bspline arc.

Usage: From a center point and two points: ic_curvearc_ctr_rad PART_NAME NEW_CURVE_NAME {CENTER_POINT POINT_1 POINT_2 0.0 \"\" \"\" 0}

From a center point and two points and radius: ic_curvearc_ctr_rad PART_NAME NEW_CURVE_NAME {CENTER_POINT POINT_1 POINT_2 RADIUS \"\" \"\" 0} Note: in case of a radius of 0.0, the arc radius will be calculated from the distance between CENTER_POINT and POINT_1

From start/end points: ic_curvearc_ctr_rad PART_NAME NEW_CURVE_NAME {POINT_1 POINT_2 POINT_3 0.0 \"\" \"\" 1}

From start/end points and radius: ic_curvearc_ctr_rad PART_NAME NEW_CURVE_NAME {POINT_1 POINT_2 POINT_3 RADIUS \"\" \"\" 1}
"  
  (format
   t
   "ic_curve ~A ~A ~A ~A ~A~%"
   method part name def args ))
  
(defun ic_geo_get_crv_data_at_par (par crv)
"
Returns the curve data at a parameter.
par	curve parameter
crv	curve name
return	list of 4 triplets: location, and 3 normalized vectors — tangent, direction to curve center, direction normal to curve plane
return	empty line if curve does not exist

Notes:

    For faceted curves result is parametric approximation of the curve.

    Direction to center and normal plane may be {0 0 0} if not defined, e.g. for line.


"  
  (format
   t
   "ic_geo_get_crv_data_at_par ~A ~A~%"
   par crv))
