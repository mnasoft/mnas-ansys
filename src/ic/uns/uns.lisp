;;;; ./src/icem/boundary.lisp

(defpackage :mnas-ansys/ic/uns
  (:documentation
   " Пакет содержит функции для редактирования и изменения неструктурированных сеток.

Programmers Guide | Meshing Directives | Unstructured Mesh Editing and Modification Functions
")
  (:use #:cl)
  (:nicknames "IC/UNS" "UNS")
  (:export 
           
           )
  )

(in-package :mnas-ansys/ic/uns)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defparameter *data*
  '(
    "
ic_uns_is_loaded

Checks if a mesh exists.
"

    "
ic_uns_is_modified

Checks if the mesh has been modified.
"
    "
ic_uns_set_modified mod

Sets the mesh modified flag. This should not be used for most operations since they set this flag themselves.
"

    "
ic_uns_load files maxdim [3] quiet [0] reset_family_prefix [\"\"] check_orient [1]

Loads the given unstructured domain files. This must be a full pathname. If maxdim is given this will be the maximum dimension of elements that will be loaded. For example, a value of 2 means to load only surface and bar elements. If check_orient is 0 then no orientation check will be done. If it is 1 then the code will try to pick a good family for the new surface elements. If it is 2 then the name will be CREATED_FACES.
"
    "
ic_uns_readexternal backend nfiles files create [1] prec [1] tstep [0] args

Imports a number (nfiles) of unstructured mesh files (files) into a mesh object using the specified backend. The optional argument create (default: 1) allows one to overwrite the current mesh object, while prec (default: 1 [single]) allows one to specify the real-number precision. One can also specify the time step tstep (default: 0) and any additional arguments (args) necessary for the import.
"
    "
ic_uns_create_empty

Creates an empty mesh if there is not already one available. Returns 1 if it created a new one and 0 if there was an existing one.
"
    "
ic_save_unstruct file inc_subs [1] resnames [\"\"] only_types [\"\"] only_fams [\"\"] only_subs [\"\"] near_vols [0]

Saves the current unstructured mesh to the given file. If the inc_subs argument is 1 (the default) then the current subsets are also saved. resnames is an optional list of result names to save with the domain (assuming they have been defined in the mesh). If only_subs is non-empty it is a list of names of maps that will be the only ones saved.
"

    "
ic_uns_print_info what name [\"\"] opt [0] subset_name1 [max_edge_sides] subset_name2 [min_edge_sides]

Prints some information. The argument what is one of summary, element, node, or domain. For summary and domain, the name argument is ignored. For summary the argument opt will be used to print min/max edge sides if set
"
    "
ic_uns_check_duplicate_numbers skip_0 [1]

Checks for duplicate element and node numbers. Returns a list with two numbers - the number of dup elements and the number of dup nodes. Note that 0-numbered nodes and elements are not counted if skip_0 is 1 (the default).
"
    "
ic_uns_lookup_family_pid fam

Returns the numeric ID for this family.
"
    "
ic_uns_rename_family old new

Renames a family. Note that this doesn't need to be called any more if you call ic_geo_rename_family first.
"
    "
ic_uns_count_in_families fams total [0]

Counts the number of elements in each family.
"
    "
ic_uns_non_empty_families

Lists all the non-empty families.
"
    "
ic_uns_count_family_neighbors fams

Returns a list of the number of 0-sided, 1-sided, and 2-sided elements in the given families.
"
    "
ic_uns_family_has_quadratic fam

Checks if the family has quadratic elements.
"
    "
ic_uns_subset_add_by_neighbors fams to nsides

Adds to a subset by neighbors.
"
    "
ic_uns_families_changed

Indicates something has changed with the families - color, etc.
"
    "
ic_uns_check_family name

Checks whether a family exists.
"
    "
ic_uns_move_family_elements old_fam_name new_fam_name

Moves elements from one family (old_fam_name) to another (new_fam_name).
"
    "
ic_uns_new_family name vis [1]

Creates a new family if it is not already there. Return 1 if a new family was created.
"
    "
ic_uns_delete_family fams

Deletes a family, or list of families.
"
    "
ic_uns_list_types 

Returns the types in the current mesh.
"
    "
ic_uns_list_possible_types 

Returns a list of the possible types in the current mesh.
"
    "
ic_uns_num_verts_in_type type

Returns the number of verts in this type.
"
    "
ic_uns_dimension

Returns the dimension of the mesh.
"
    "
ic_uns_list_families with_dim [\"\"]

Returns the families in the current mesh.
"
    "
ic_count_elements type [MIXED]

Counts the number of elements in the given type. If the type is MIXED, which is the default, then all elements will be counted. The type may be one of: 0d 1d 2d 3d node line tri quad tetra hexa penta pyra in which case those types of elements will be listed.
"
    "
ic_count_nodes

Counts the number of nodes in the mesh.
"
    "
ic_uns_num_couplings

Counts the number of couplings.
"
    "
ic_uns_project_to_geometry mapn type

Returns the names of the surfaces or curves that the elements in the map are closest to. 2D elements get projected to surfaces, 1D to curves. type is either surface or curve.
"
    "
ic_uns_create_element type fam nodes make_consistent cmapname [visible] grab_existing [0] reset_dim [1] update [1] automatic [1]

Creates a new element, or in the case of NODE elements, as many NODE elements as there are vertices given. 

type : the type of the element (NODE, BAR_2, TRI_3, etc)

fam : the family for the new element

nodes : the name of a subset that contains the necessary nodes

make_consistent : if 1, modify the volume mesh to make it consistent with the new element (if it's a surface element)

cmapname : the name of the subset to add the new elements to

grab_existing : if this is 1 and there are already elements like this available then add them to the map

reset_dim : if this is 1, nodes projection will be reset
"
    "
ic_uns_create_hexa_from_faces name faces inherit_part [1] part [\"\"]

Creates hexa from opposite faces.
"
    "
ic_uns_create_node_element_near_point pname fam

Creates a point element at a particular node, which is closest to the named prescribed point.
"
    "
ic_uns_change_family name fam

Sets the elements in a subset to a family.
"
    "
ic_uns_set_part name newpart

Moves entities from one part to another.
"
    "
ic_uns_set_projected_family mapname

Sets the family of elements to that of geometry entities they are projected to.
"
    "
ic_uns_change_family_if_project mapname ofam nfam geotype geoname

Changes the elements in a family to a new family, *if* when they are projected to surfaces, curves, etc. they are nearest to a specific one. Returns the number of elements changed.

Example: ic_uns_change_family_if_project all OWALL NWALL surface NWALL.1

This works for surfaces, curves, and points.
"
    "
ic_uns_get_attached_elements geotype geoname mapname [\"\"] 

Finds the elements attached to a geometry entity *if* when they are projected to surfaces, curves, etc. they are nearest to a specific one. Returns subset of attached elements.

This works for bodies, surfaces, curves, and points.
"
    "
ic_uns_list_material_numbers

Gets material numbers.
"
    "
ic_uns_list_material_families

Gets material families.
"
    "
ic_uns_split_elements name

Splits elements.
"
    "
ic_uns_split_spanning_edges name args [\"\"]

Splits spanning elements.
"
    "
ic_uns_split_edges name propagate [0] project [1] check [0]

Splits edges. If propagate is specified, the split edge will propagate through elements, creating no new element types; if propagate==0, then it may, for example, split QUADs into TRIs. project can be set to 0 to disable projection. check: if 1, then check if split of any neighbor element is not supported
"
    "
ic_uns_swap_edges name try_harder

Swaps edges.
"
    "
ic_uns_swap_edges_node_numbers node_numbers try_harder

Swaps the edges in a given TCL list node_numbers arranged thus: {edge1v1 edge1v2 edge2v1 edge2v2 ...}
"
    "
ic_uns_swap_edges_auto name minasp numiter maxdev [-1.0]

Swaps edges automatically.
"
    "
ic_uns_change_type name from to proj cons [0] normal [0]

Changes element types.
"
    "
ic_uns_change_shell_solid name thickness adjust hext

Changes element types shell to solid.
"
    "
ic_uns_change_type_by_quality fams from to metric quality_limit [0.2]

Changes all elements in family fams of type from to type to if below scalar quality_limit according to metric metric. Only supports QUAD_4 and TRI_3 so far.
"
    "
ic_smooth_elements args

Smooths the current unstructured mesh. One or more arguments may be given. These arguments are: 

smooth type : Smooth all vertices attached to elements of the named type.

freeze type : Freeze all vertices attached to elements of the named type.

float type : Allow all vertices attached to elements of the named type to float - that is, they will move only if they are attached to an element type marked smooth, but not if they are also attached to an element type marked freeze. This is the default state for all types except NODE elements which are frozen.

family famname : smooth elements of this family. This argument can be given more than once for multiple families. If no family is given then all families are selected.

metric val : The quality metric to optimize. The default is \"Determinant\".

upto val : The highest quality element it will try to improve. The default is 0.5.

iterations val : The number of iterations. The default is 5.

prism_warp_weight val : The prism warp weight. The default is 0.5.

laplace on : Smooth using the Laplace algorithm. The default is 0.

no_collapse on : Disallow nodes to be merged. The default is 0.

sfit on : Enable surface fitting when smoothing QUAD_4 and HEXA_8 elements. The default is 0.

ignore_pp on : Ignore prescribed points when smoothing QUAD_4 and HEXA_8 elements. The default is 0.

group_bad_elem on : Group bad elements 0/1. The default is 1.

only_triangles on : Only smooth triangles. The default is 0. Obsolete option - use float, freeze, or smooth.

smooth_prisms on : Smooth prisms. The default is 0. Obsolete option - use float, freeze, or smooth.

fix_prisms on : Don't smooth prisms. The default is 1. Obsolete option - use float, freeze, or smooth.

refine on : Use refinement. The default is 0. Obsolete option - use float, freeze, or smooth.

fix_triangles on : Don't move triangles. The default is 0. Obsolete option - use float, freeze, or smooth.

smooth_tets val : Smooth tetrahedra. The default is 1. Obsolete option - use float, freeze, or smooth.

fix_tets val : Don't smooth tetrahedra. The default is 0. Obsolete option - use float, freeze, or smooth.

ic_uns_smooth_by_quality fams types metric quality_limit [0.5] additional_args [\"\"]

Smooths all elements in family fams of types types if below scalar quality_limit according to metric.
"
    "
ic_delete_elements args

Deletes selected elements from the currently loaded unstructured mesh. The arguments come in keyword value pairs. The possible options are: 

type typename : delete elements of this type where typename is TETRA_4 or HEXA_8 or another standard name. If no type name is given then all types are selected.

family famname : delete elements of this family. If no family is given then all families are selected.

If multiple types are given then all types selected are deleted, and likewise for families.
"
    "
ic_move_nodes args

Moves nodes in the selected elements to the given location. The arguments come in keyword value pairs. The possible options are: 

type typename : delete elements of this type where typename is TETRA_4 or HEXA_8 or another standard name. If no type name is given then all types are selected.

family famname : delete elements of this family. If no family is given then all families are selected.

how mode : can be either set or delta.

x x : the x value to set or increment.

y y : the y value to set or increment.

z z : the z value to set or increment.

If multiple types are given then all types selected are moved, and likewise for families. If any of the X Y or Z values are not given then that coordinate is not changed.
"
    "
ic_uns_project_nodes_to_line pt1 pt2 unset_dim name

Projects all the nodes in a map to the line defined by the two points. This also sets the type to volume so they are no longer associated with any geometry (if unset_dim != 0)
"
    "
ic_uns_project_nodes_to_plane pt norm name

Projects all the nodes in a map to the plane defined by a pt and norm.
"
    "
ic_change_family_elements args

Changes the family of selected elements from the currently loaded unstructured mesh. The arguments come in keyword value pairs. The possible options are: 

type typename : select elements of this type where typename is a standard element type such as TETRA_4 or HEXA_8. If no type name is given then all types are selected.

family famname : select elements of this family. If no family is given then all families are selected.

newfam famname : the family to switch to. This option must be given.

If multiple types are given then all types selected are selected, and likewise for families.
"
    "
ic_change_linear_quadratic args

Changes the selected elements from linear to quadratic.
"
    "
ic_change_quadratic_linear name refine keep_interf [0]

Changes the selected elements from quadratic to linear.
"
    "
ic_change_tri_quad args

Converts all TRI_3 elements into QUAD_4 elements.
"
    "
ic_extrude args

Extrudes selected elements from the currently loaded unstructured mesh. The arguments come in keyword value pairs. The possible options are: 

type typename : extrude elements of this type, which can be TRI_3 or QUAD_4. If no type name is given then all types are selected.

family famname : extrude elements of this family. This argument can be given more than once for multiple families. If no family is given then all families are selected.

dir direction : elements should grow in this direction. It can take any one of the following strings: normal - Normal to the elements, curve_axial - Along curve dir axially, curve_normal - Along curve dir normal to the curve tangent, \"X Y Z\" - Arbitrary Direction

curve curvename : extrude along the curve

curvedir [0,1] : direction = 1 if the elements to be extruded in the reverse direction of the curve.

twist twist : twist angle per layer.

space spacing : spacing between adjacent layers.

numlayers> numlayers : number of layers to extrude.

volf volume_family : family for the new volume elements.

sidef> side_family : family for the exposed sides.

topf top_family : family for the top of the extrusion.

del_orig on : if on is 1 delete the original surface

save_verts on : if on is 1 then save temporary data so that another extrusion can be done in the same area.

save_node_map name : if given this is the name of an UnsMap object that will contain the list of new nodes that are created (and the bottom layer which already exists).
"
    "
ic_uncouple_main args

This is the old \"standalone\" program of uncouple which can be launched from the classic ICEM CFD Manager (\"icemcfd -3\").
"
    "
ic_test_mesh id [\"\"] min [0] tol [0]

Regression testing for unstructured meshes using a \"unique\" ID string.
"
    "
ic_test_mesh_quality min [0] tol [0]

Tests the quality of unstructured meshes.
"
    "
ic_test_premesh id [n_hexa-n_quad-0-0-n_bar-n_coupling-n_vertex-quality] fam [\"\"] tmp_file [ic_test_premesh_tmp.uns]

Regression testing for premeshes using a \"unique\" ID string.
"
    "
ic_test_premesh_quality min [0] tol [0] fam [\"\"] tmp_file [ic_test_premesh_tmp.uns]

Tests the quality for premeshes.
"
    "
ic_uns_length name [visible]

Calculates the length of the given mesh. name: name of map of the selected elements.
"
    "
ic_uns_area name [visible]

Calculates the area of the given mesh. name: name of map of the selected elements.
"
    "
ic_uns_volume name [visible]

Calculates the volume of the given mesh. name: name of map of the selected elements.
"
    "
ic_worst_angle

Find worst angle in surface mesh. Returns maximum corner error or warpage.
"
    "
ic_merge_meshes merge_fams fixed_fams remove_interface [0]

Merges the mesh elements. The two lists are the family names for the surfaces to be merged and the family names for the volume families (if any) to be kept fixed.
"
    "
ic_struct_to_unstruct which dims all_elems

Converts a structured mesh to unstructured. 

which is a list of domain numbers - blank if all

dims is the max dimension to convert - 3 means everything

all_elems means to convert internal subfaces, edges, and vertices which aren't projected to families into unstructured elements also (which will be in the ORFN family)
"
    "
ic_uns_move_mesh origin axis trans theta mm_cmd surfs fsurfs vols

Moving meshes.
"
    "
ic_uns_uncouple which proj [0] three [0] db [0]

Uncouples hanging nodes of hexahedra. Users have to take care that the ratio of refinement parameters of adjacent faces/blocks has to be 1, 3, 9, 27, 81 ... The refinement scheme is stable, i.e. the minimum angle does not depend on the subdivision level. Concave regions are filled with a fine mesh. 3-1-1 refinement is not supported. 3-3-1 works for 2.5D cases, 3-3-3 is fine in general. 

proj: Do surface projection if not 0.

three: Pure 3-3-3 refinement if > 0; allow unstable patterns if < 0.

db: Do some checking and printing if > 0. Default is 0.
"
    "
ic_uns_redistribute_prism_edge height fix_height [1] ratio [0.0] local [0] end_aspect [0.3] ignore [0]

Redistributes prisms.
"
    "
ic_uns_split_prisms which layers ratio layer_number [\"\"] height [\"\"] fams [\"\"] fams_srf [\"\"] skip_pyras [\"\"]

Splits prisms.
"
    "
ic_uns_dissolve_prisms which height_ratio prism_qual triangle_qual clear_tops

Dissolves prisms.
"
    "
ic_uns_convert_to_hexas min_aspect [1] volfams [\"\"] use_active_lcs [0]

Converts tetras to hexas. It will not be done if the hexas have aspect ratio worse than min_aspect.
"
    "
ic_uns_convert_to_hexas_in_batch infile outfile min_aspect [1] volfams [\"\"] use_active_lcs [0]

Converts tetras to hexas in batch mode from input file. It will not be done if the hexas have aspect ratio worse than min_aspect.

not yet implemented append argv \" \"convert_to_hexas min_aspect $min_aspect $volfams $use_active_lcs\"\"
"
    "
ic_uns_coupling what args

Creates or deletes couplings
"
    "
ic_uns_thickness what name [all] val [0] strict [1] from_solid [0] surfs [\"\"]

Creates or deletes thickness for surface mesh. from_solid = 1 = nearest point projection, from _solid = 2 = piercing
"
    "
ic_uns_thickness_at_node name val

Applies thickness on specific nodes.
"
    "
ic_uns_bar_orientation what name [all] x1 [0] x2 [0] x3 [0] wa1 [0] wa2 [0] wa3 [0] wb1 [0] wb2 [0] wb3 [0]

Creates or deletes bar orientations for line elements.
"
    "
ic_uns_list_strings 

Lists the strings in the domain file.
"
    "
ic_uns_set_string name val

Sets a string in the domain file.
"
    "
ic_uns_split_double_wall which

Splits double walls.
"
    "
ic_uns_split_internal_faces which fam new_fam_suffix [\"\"] splitfam [0] volfam [\"\"]

Splits internal faces.
"
    "
ic_uns_make_consistent which count_open [\"\"] flood_fill [1]

Makes consistent.
"
    "
ic_uns_check_edges which

Checks edges.
"
    "
ic_uns_split_pyras which

Splits pyramids.
"
    "
ic_uns_check_orientation which [All] err_name [\"\"] do_fix [0]

Checks orientation of the subset which which is, by default, All. Returns 1 for OK. err_name is the name of a subset which will be created if there are errors
"
    "
ic_uns_orient dir

Changes orientation.
"
    "
ic_uns_reorient name how args

Changes orientation.
"
    "
ic_uns_reorder nme how args

Reorders elements.
"
    "
ic_uns_max_vertex_degree which

Returns the max vertex degree.
"
    "
ic_uns_coarsen which aspect fixfams tol n_iter surface size_check max_size 

Coarsens the mesh.
"
    "
ic_uns_coarsen_quad name [visible] dev [0.1] edge_len [-1] steps [1]

Coarsens quad dominant mesh
"
    "
ic_uns_merge_nodes name tol pos [0 0 0] norm [0 0 0] propagate [0] force [0] merge_blindly [0] merge_average [0] only_unconnected_single_edges [0]

Merges nodes by tolerance. name is the map to merge, tol is the tolerance below which to merge. If pos and norm are non-null triples, they define a plane to limit the node merging to. That is, only nodes on the plane are considered for merging. If propagate is selected set, then the merging will continue through the mesh. If force is set, then the nodes will be merged regardless of their dimension. If merge_average is selected set, then the nodes will be merged by the average.
"
    "
ic_uns_merge_node_numbers nums tol pos [0 0 0] norm [0 0 0] propagate [0]

Tries to merge the list of nodes given in a flat TCL list nums, returns the number of nodes merged. For the remaining arguments, see ic_uns_merge_nodes above.
"
    "
ic_uns_min_tri_size name

Reports the min triangle size.
"
    "
ic_uns_move_nodes_exact name set pos dir csys_name [\"\"]

Moves nodes.
"
    "
ic_uns_delete_nodes name fix_uncovered [1]

Deletes elements adjacent to nodes in the given map
"
    "
ic_uns_refine_surface name dev steps proj tri_only [0] edge [-1] asp [-1] nobound [0]

Refines triangular/quad/tetra surface mesh. 

dev: maximum surface deviation or -1

steps: maximum number of refinement steps

proj: do surface projection if not 0

tri_only: refine triangles only if not 0

edge: maximum edge length or -1

asp : maximum aspect ratio or -1
"
    "
ic_uns_refine_by_midside_nodes name all project calc_projection calc_projection_tol

Refines the mesh using mid-side nodes.

e.g., ic_uns_refine_by_midside_nodes name all project 1 calc_projection 1 calc_projection_tol 0.01

name all. The only option currently available is name all, to refine the mesh globally.

project (0 or 1), specifies whether to project the new nodes to the geometry.

calc_projection (0 or 1), when 1, the projection of the node to the marked curves or surfaces of its linear neighbors, and the minimum projection will be calculated.

calc_projection_tol specifies the projection tolerance. The actual node projection will be compared to the minimum projection to see if it is within this specified tolerance. If not, the minimum projection will be used.
"
    "
ic_uns_insert_tetra name [all] mid [0]

Inserts tetras.
"
    "
ic_uns_delete_contents name

Deletes the contents of a subset.
"
    "
ic_uns_set_node_dimension name how add_bars [0] fam_active [\"\"] proj_mth [0] normal_flag [0] dir_vec [\"\"]

Projects nodes.
"
    "
ic_uns_get_node_positions name

Gets node positions.
"
    "
ic_uns_set_node_positions name pos_list

Sets node positions.
"
    "
ic_uns_get_element_vertex_positions name allow_dups

Gets all the node positions for the elements in this map. This returns a list of {x y z} values, for each node in each element. If allow_dups is 1 duplicates are allowed, otherwise the duplicates are filtered out and no guarantee is made about the ordering of the vertex positions.
"
    "
ic_uns_add_adjacent_tetras dest src

Adds adjacent tetras from one map to another.
"
    "
ic_uns_add_near_node dest src

Adds all elements to a map near the nodes in another map
"
    "
ic_uns_update_family_type name fams [__all__] types [__all__] what [update] force [1]

Restricts what is in a subset to a set of families and types. 

name is the name of the subset

fams is a list of families to enable, or if preceded by a ! then to disable (if a family isn't listed then it is not touched, __all__ means all families, and __same__ means don't touch any)

types is a list of types to enable, or if preceded by a ! then to disable (if a type isn't listed then it is not touched, __all__ means all types, and __same__ means don't touch any)

what is update, restrict_to, add, or remove

force is 0 if this command should not touch non-family-type maps.

ic_uns_split_node_non_man sel_map move_map

Splits a node non-manifold.
"
    "
ic_uns_fix_non_man name

Fixes some non-manifold vertices.
"
    "
ic_uns_fix_missing_internal name fam proj

Fixes missing internal faces.
"
    "
ic_uns_fix_uncovered_faces name fam

Fixes uncovered faces.
"
    "
ic_uns_fix_triangle_boxes name fam

Fixes triangle boxes.
"
    "
ic_uns_fix_volume_orientation name

Fixes incorrectly oriented volume elements
"
    "
ic_uns_fix_subset_by_remeshing mapname

Fixes problematic elements (plus two layers) by remeshing the map of given name
"
    "
ic_uns_scan_plane mapname what args

Creates a \"scan plane\" based on one element. This only works for hexas and prisms ssname set n1 n2 n3 size1 size2 size3 ssname advance n1 n2 n3
"
    "
ic_uns_duplicate_elements src dest

Duplicates elements and their nodes.
"
    "
ic_uns_move_elements name args

Moves an existing mesh subset. The name argument gives the subset to operate on. 

cent : a list of X Y Z giving the center for rotation, scaling, and mirroring, which could be \"centroid\"

translate : the X Y Z values for translating the entity

rotate : the number of degrees to rotate the object about the axis given by rotate_axis

rotate_axis : the vector giving the axis to rotate about

scale : a scale value, or 3 values giving the factor to scale in X Y and Z

mirror : the axis about which to mirror

cent, translate, rotate_axis and mirror are defined in the active LCS
"
    "
ic_uns_subset_create name [\"\"] vis [0] copy_from [\"\"] pid_colors [1] editable [1]

Creates a subset. The options are: 

name : the name to use - default is a uniquely generated one

vis : 1 if the map should be visible

copy_from : if not blank, the name of a map to copy the initial contents of this one from

pid_colors : if 1, display the elements colored by family, otherwise the color parameter of the map is used

editable : 1 if this map should be modifiable

The return value is the name of the map.
"
    "
ic_uns_subset_create_family_type fams types empty_ok [0] make_visible [1] make_explicit [0]

Creates a temporary subset with a given set of types and families. Either may be __all__. Returns \"\" if the thing is empty unless empty_ok is 1, in which case it returns the empty map. If make_visible is 1 then it will make this subset visible. If make_explicit then it will be promoted to EXPLICIT_LIST 
"
    "
ic_uns_subset_exists name

Checks if there is a subset with the given name.
"
    "
ic_uns_subset_rename old new

Renames a subset.
"
    "
ic_uns_subset_unused_name pref [\"\"]

Returns an unused subset name with the given prefix . Note that this gives names unique for both geometry and mesh.
"
    "
ic_uns_subset_color name color

Changes the color on a subset. Disable pid colors.
"
    "
ic_uns_subset_copy dest src etype [\"\"]

Copies from one subset to another. If etype is 0, 1, 2, 3, or a list of those, then copy only elements of that dimension. Also etype can be node or edge which will pick nodes or bars.
"
    "
ic_uns_subset_copy_verts dest src

Copies vertices from one subset to another.
"
    "
ic_uns_subset_copy_if_not_explicit name

If this map is not explicit, make a copy of it and make sure that it is.
"
    "
ic_uns_invert_subset name refmap [all]

Inverts the contents of a subset.
"
    "
ic_uns_subset_into_connected_regions which

Decomposes the given subset which into a set of subsets, each being a region of connected elements. The given subset is unmodified. The return value is a list of names of the new subsets.
"
    "
ic_uns_subset_surface_boundary sname

Returns the name of a subset containing the surface boundary elements of the given surface name sname. Returns a nullstring in case of an error.
"
    "
ic_uns_subset_get_vertices_on_curves curve_names

Returns the name of a subset containing the ordered vertices of the bars along the given set of curves curve_names. Returns a null-string in case of an error. 
"
    "
ic_uns_subset_get_current 

Returns the name of the current visible map - maybe a subset and maybe selected.
"
    "
ic_uns_subset_set_current name

Sets the current visible map.
"
    "
ic_uns_subset_delete name

Deletes a subset.
"
    "
ic_uns_subset_configure name args

Configures a subset
"
    "
ic_uns_subset_configure_toggle name args

Configures a subset by toggling the given arguments.
"
    "
ic_uns_subset_configure_get name param

Gets the value for a subset's given configuration parameters. 
"
    "
ic_uns_subset_visible name vis

Makes a subset visible (or not).
"
    "
ic_uns_subset_list_visible except [\"\"]

Lists the names of the visible subsets.
"
    "
ic_uns_subset_is_cut name

Checks to see if a subset has the cut flag enabled.
"
    "
ic_uns_subset_count_elements name type [MIXED]

Counts the number of elements in a subset.
"
    "
ic_uns_subset_count_nodes name

Counts the number of nodes in a subset.
"
    "
ic_uns_subset_average_edge_length name

Gets the average edge length in a subset.
"
    "
ic_uns_subset_average_surface_deviation name

Gets the average surface deviation in a subset.
"
    "
ic_uns_subset_list_families name

Lists the families that appear in a subset. Each family appears only once.
"
    "
ic_uns_subset_list_volume_families name

Lists the volume families that appear in a subset. Each family appears only once.
"
    "
ic_uns_subset_families_used name parts

Returns the families or parts that are used in this subset. If there are nodes in the subset then the elements attached to those nodes will also be included.
"
    "
ic_uns_subset_copy_only_families from fam ispart

Copies only the elements in a specified family or part into a new subset.
"
    "
ic_uns_subset_list_elements name

Lists all the element data for a subset in the following format: {{eltype elnum ext_elnum {elnode1 elnode2 ...} fam_name} {eltype elnum ext_elnum {elnode1 elnode2 ...} fam_name} ... {VERTEX vnum {x y z} dimension extvnum} {VERTEX vnum {x y z} dimension extvnum} ...} where element vertices specified explicitly in the subset (not elements of type NODE) are at the end of the list.
"
    "
ic_uns_subset_nodes_are_periodic name

Checks if any nodes in this subset are periodic.
"
    "
ic_uns_subset_list_types name

Lists the element types that appear in a subset. Each type appears only once.
"
    "
ic_uns_subset_list only_user [0]

Lists all the subsets that are editable. If only_user is 1 then skip the ones that begin with uns_sel_ or CONTACT.
"
    "
ic_uns_map_list only_vis pat [*]

Lists all the maps (optionally just the visible ones). If pat is given then return those whose names match.
"
    "
ic_uns_subset_clear name

Removes all entities from a subset.
"
    "
ic_uns_subset_add_from dest src

Adds entities from one subset to another.
"
    "
ic_uns_subset_subtract_from dest src

Removes entities in one subset from another.
"
    "
ic_uns_subset_add_number name nums rel type

Adds a list of elements by numbers. rel = 0 : internal within the given type, rel = 1 : internal within all types, rel = 2 : external. Note that the nums can also be ranges of the form N1-N2.
"
    "
ic_uns_subset_add_node_numbers name nums extern [0]

Adds a list of nodes by numbers. If extern is 1 use external numbers otherwise internal. Note that the nums can also be ranges of the form N1-N2.
"
    "
ic_uns_subset_list_node_numbers name extern [0]

Lists the unique internal (external) node numbers of the subset. If extern is 1 use external numbers otherwise internal.
"
    "
ic_uns_subset_add_region name p1 p2 part dims [0 1 2 3]

Adds elements in a region.
"
    "
ic_uns_subset_add_near_pos name pos dims [0 1 2 3] 

Adds elements near a position.
"
    "
ic_uns_subset_add_near_nodes name nodes ext [0]

Adds elements near a set of nodes.
"
    "
ic_uns_subset_add_layer name nlayers fams types

Adds a layer. If fams = active then it means active families, all means all families. types = active means active types, all means all types, surf means all surface types.
"
    "
ic_uns_subset_remove_layer name nlayers types

Removes a layer. If fams = active then it means active families, all means all families. types = active means active types, all means all types, surf means all surface types.
"
    "
ic_uns_subset_add_attached name src how angle [0]

Adds attached elements.
"
    "
ic_uns_subset_get_elements_attached_to_subset src_map des_families [\"\"] des_types [\"\"]

Gets a map of those elements of type des_types in des_families that are attached to the subset with name src_map.
"
    "
ic_uns_subset_remove_normal name norm

Removes elements with a specific normal.
"
    "
ic_uns_subset_remove_manifold_elements name

Removes all surface elements that are connected to one other surface on all sides.
"
    "
ic_uns_subset_get_cutspeed name

Restricts a subset to its cut. Note that the point and normal given here are in the global coordinate system. This returns the number of elements displayed in the cut. 
"
    "
ic_uns_subset_bbox name no_cut [0]

Returns the bounding box of a subset. If no_cut is 1 then it will be the bounding box with no plane cut taken into account.
"
    "
ic_uns_subset_normal name

Returns the average normal of a subset. This skips any non-2D elements.
"
    "
ic_uns_subset_is_editable name

Checks if this subset is editable (i.e. not selected or all).
"
    "
ic_uns_min_metric crit [Quality] parts [\"\"] types [\"\"]

Returns the min value of a quality metric (and \"\" in case of an error).
"
    "
For example, set worst [ic_uns_min_metric \"SPECIFIED_METRIC\" \"SPECIFIED_PARTS\" \"SPECIFIED_TYPES\"]

Default for SPECIFIED_METRIC is \"Quality\". Default for SPECIFIED_PARTS is all existing parts. Default for SPECIFIED_TYPES is all existing types (but skips NODE, LINE and BAR elements). Each of them can be empty.
"
    "
ic_uns_create_selection_subset color_first_different color [\"\"]

Creates a temporary subset for selection. This one will not show up in the subset list. If color_first_different is 1 then the first node will get a special color. All the other nodes and elements are drawn in the specified color.
"
    "
ic_uns_create_selection_edgelist on

Creates or deletes a temporary edge list for selection (depending on whether on is 1 or 0).
"
    "
ic_uns_subset_add_pick_polygon what name poly vect from_names partial convex etype [\"\"]

Adds elements in a screen polygon area to the subset, what can be one of edge, node, element, or a list of one or more of 0d, 1d, 2d, 3d.
"
    "
ic_uns_subset_add_pick_circle what name vect cent radp from_names partial etype [\"\"] 

Adds elements in a screen circular area to the subset, what can be one of edge, node, element, or a list of one or more of 0d, 1d, 2d, 3d.
"
    "
ic_uns_subset_add_pick_single what name pt vec from_names

Adds a picked element or whatever to the subset, what can be one of edge, node, element, or a list of one or more of 0d, 1d, 2d, 3d. Returns the element number that was picked, or \"\" if none was picked.
"
    "
ic_uns_subset_add_flood what name from

Adds connected boundary edges to the subset.
"
    "
ic_uns_subset_add_remove_last name

Removes the last bunch of entities added.
"
    "
ic_uns_create_vertex name pt dim

Creates a new vertex.
"
    "
ic_uns_subset_make_all name

Makes the current subset an all-subset.
"
    "
ic_uns_subset_make_families name fams

Makes the current subset a family subset.
"
    "
ic_uns_subset_add_families_and_types name fams types

Makes the current subset have a certain set of families and types.

ic_unstruct_make_families_exist fams

Makes new unstruct families, returning the number of those which are new.
"
    "
ic_uns_uniqify name

Makes sure that the entities in this subset are unique.
"
    "
ic_uns_node_position_stack name what

Pushes, pops, or clears node positions on the stack for undo in interactive move.
"
    "
ic_uns_node_position_drag name startpt pt vec spl curvis allow_invert fam_active

Drags nodes interactively. This projects to the surfaces, curves, etc. as appropriate for the nodes, if fam_active is a list of families. The strings all or none can also be given for fam_active.
"
    "
ic_uns_bandwidth name iters type

Bandwidth and profile reduction by the reverse Cuthill-McKee (RCM) algorithm. 

iters: maximum number of renumbering steps

type: reduce profile if 0, reduce bandwidth if 1
"
    "
ic_uns_renumber_nodes which start skip_0 [0] dir [0 0 0]

Resets external node numbers, starting with start
"
    "
ic_uns_renumber_elements which start skip_0 [0] dir [0 0 0]

Resets external element numbers, starting with start
"
    "
ic_uns_renumber_all_nodes start skip_0 [0]
"
    "
Resets external node numbers for all elements, starting with start, less memory usage compared to ic_uns_renumber_nodes all.
"
    "
ic_uns_renumber_all_elements start skip_0 [0]
"
    "
Resets external element numbers for all elements, starting with start, less memory usage compared to ic_uns_renumber_elements all.
"
    "
ic_uns_subset_elements_range name

Lists external start and end node/element numbers
"
    "
ic_uns_subset_move_part_elements name oldpart newpart

Moves elements in a subset from one part (oldpart) to another (newpart) Note that old part must exist, new part will be created if not existing
"
    "
ic_uns_create_diagnostic_subset vis [1]

Creates a temporary subset for diagnostics.
"
    "
ic_uns_create_diagnostic_edgelist on

Creates a temporary edge list for diagnostics.
"
    "
ic_uns_convert_edgelist_to_bars name family

Converts the current diagnostic edgelist to bar elements and put them in the named map. They are given the specified family.
"
    "
ic_uns_diagnostic args

Runs diagnostics on the currently loaded unstructured mesh. The arguments come in keyword value pairs. The possible options are: 

diag_type what : the type of diagnostic. This can be one or more of the following: 

duplicate : check for duplicate elements

single : check for single-element edges

single_2 : check for 2-single-edged elements

multiple : check for multiple-element edges

single_multiple : check for single/multiple edged elements

uncovered : check for uncovered volume faces

missing_internal : check for missing internal faces

triangle_box : check for triangle boxes

nmanvert : check for nonmanifold vertices

vol_orient : check for mis-oriented volume elements

surf_orient : check for mis-oriented surface elements

disconnected_vert : check for disconnected vertices

3_surface_node_internal_faces : check for spanning edges

periodic_problem : check for problems with periodicity

overlap : check for overlapping elements in the mesh

delaunay : check for Delaunay violations in the mesh

standalone : check for shells not connected to any volume

metric : apply one of the quality metrics

all : do all of the above

type typename : look at elements of this type, which can be TRI_3 or QUAD_4. If no type name is given then all types are selected.

family famname : check elements of this family. This argument can be given more than once for multiple families. If no family is given then all families are selected.

fams famnames : check elements of the named families. This is just like the family argument except you can give multiple families. If no family is given then all families are selected.

fix on : fix the elements that fail the check, if possible (default is 0)

fix_fam family : if fix is selected and new elements have to be created, put them in this family

fix_project on : if fix is selected and new nodes are created, project them to the geometry. This is applicable only for for the missing_internal diagnostic type.

minval val : the minimum acceptable value for a quality check (default is 0)

maxval val : the maximum acceptable value for a quality check (default is to not check this)

metric what : which quality metric to use (default is Quality)

disp_elems on : if on is 1 then display the problem elements and wait for user confirmation before proceeding. If it is 2 then the elements will remain displayed until cleared using ic_clear_diag_display. If fix was given then only those elements that could not be fixed will be displayed. The default is 0.
"
    "
ic_uns_get_diagnotic_info diagnostic param

Gets the value for a particular param for a particular diagnostic
"
    "
ic_uns_metric name [all] type [Quality] args [\"\"]

Runs diagnostics on the currently loaded unstructured mesh. There may be additional optional arguments: 

prism_warp_weight value : a value between 0 and 1 that controls the relative weighting of warp and aspect ratio for prism quality

Returns a list in the following order: number of elements with this diagnostic, number of elements for which this diagnostic is undefined, not used, worst element quality with this diagnostic, best element quality with this diagnostic, used to calculate the mean quality
"
    "
ic_uns_n_els_in_metric_range fams types diag from to

Gets the number of elements in the given fams of the given types which fall between to and from when evaluated by the given metric diag
"
    "
ic_uns_subset_n_els_in_metric_range map diag from to 

Gets the number of elements in the given map which fall between to and from when evaluated by the given metric diag.
"
    "
ic_uns_set_metric_weight metric eltype args

Sets weights (min, ideal, max) for a given metric for eltype
"
    "
ic_uns_set_metric_weights list reset [1]
"
    "
Sets weights for a list of metrics such that each element of the list matches the arguments to ic_uns_set_metric_weight, i.e. {{metric eltype weights} ...}
"
    "
ic_uns_get_metric_names

Gets a list of the metric names that are understood
"
    "
ic_uns_get_metric_weights metric

Returns a list of the current custom metric defs, e.g: { {{Skew} TRI_3 acc_min 0 des_min 0 ideal 0 des_max 45 acc_max 60} \ {{Skew} QUAD_4 acc_min 0 des_min 0 ideal 0 des_max 45 acc_max 60} \ ... \ }
"
    "
ic_uns_print_diagnostic_quality_key metric_name

Prints the key used for the coloring of elements in the display. 
"
    "
ic_uns_histogram name min max nbars

Uses the diagnostic data for a histogram
"
    "
ic_uns_set_with_diagnostic name from intervals

Sets the elements in a subset via histogram intervals.
"
    "
ic_uns_diagnostics_update 

Updates the diagnostic values on the mesh, and return the number of elements on which the diagnostic was updated. If no diagnostic has been run, this procedure will return 0.

ic_clear_diag_display
"
    "
If any diagnostic graphics are left on the screen after an ic_uns_diagnostic call with disp_elems set to 2, erase them.
"
    "
ic_uns_mesh_distribution p1 p2 what [0]

Gets the mesh distribution along a line in the mesh
"
    "
ic_uns_show_selected type names on color [\"\"] force_all_types [0]

Displays some unstructured elements selected or not
"
    "
ic_uns_reset_selected

Resets all selection display.
"
    "
ic_uns_make_periodic name

Makes the nodes in a subset periodic.
"
    "
ic_uns_make_auto_periodic src dest

Makes the elements in a subset periodic
"
    "
ic_uns_remove_periodic name

Makes the nodes in a subset non periodic.

ic_flood_fill args [\"\"] keep_orfn [0]

Performs the flood-fill operation of cutter

med crashes if no proj model - Bruce

This clashes with geom undo - Ganesan

If periodic with pentas or pyras, the surface mesh may be lost - Bruce

ic_flood_fill_mesh keep_orfn [0] only_mat [0]

Flood fills a mesh. Volumes need to be enclosed by surface elements. 

ic_auto_orphan

Automatically creates orphan regions.
"
    "
ic_uns_quad_remesh map args

Runs the quad mesher to fix holes, etc.
"
    "
ic_uns_force_node_loc ubset_name location method [move]

Makes a node exist at location in the subset subset_name by one of these methods: move. 

ic_get_disconnected_vertices

Returns a list such that the first element is the number of disconnected nodes found in the current unstructured mesh, and the second element is the subset containing those nodes.

ic_delete_disconnected_vertices

Deletes the disconnected vertices in the given subset, or if the map is not given, in the current mesh, and returns the number of disconnected vertices deleted.
"
    "
ic_uns_build_mesh_topo which args
"
    "
Builds the topology information from the mesh subset given which. It is fairly analogous to ic_geo_build_topo. It will also do call: ic_uns_set_node_dimension all reset after running. Arguments args are: 

-angle angle : the angle for extraction (degrees)

-smart : according to angle, choose options which seem best

-new_element_family family_name : family name for new elements

-uncovered_element_family family_name : family name for any uncovered faces

-save_old : put removed elements in ORFN (else delete)

options:

-remove_points (or -filter_points) : try removing points at curve intersections, the difference between tangents of which is below specified angle

-remove_bars (or -filter_bars) : try removing bars

-create_points : try add points at bar intersections, the difference between tangeents of which is below specified angle

-create_bars_single_edges : create bars on single edges in mesh

-create_bars_multiple_edges : create bars on multiple edges in mesh

-create_bars_double_edges : create bars on double edges in mesh (using -angle)
"
    "
ic_uns_offset_mesh args

Offsets the mesh by distance. Right now it only works on the whole mesh. 

dir direction : elements should be offset in this direction. It can take any one of the following strings: normal - Normal to the current element normals \"$x $y $z\" - Arbitrary direction [+|-][x|y|z] - e.g. +x: offset with respect to the current element normal in the given +x direction.
"
    "
dist distance : elements should grow in this direction. Example: ic_uns_offset_mesh map All dir +x dist 2
"
    "
ic_uns_internal_wall_families_get

Returns a list of families with internal walls.
"
    "
ic_uns_internal_wall_families_reorient fams

Reorients the internal walls of given families to have consistent normals. Returns the number of element orientations changed.
"
    "
ic_uns_spectral_elements name file order law

Calculates spectral edges.

ic_validate_families 

Validates the match between pids in proj and uns. For debugging.
"
    "
ic_uns_load_temporary file params [-color white]

Creates a temporary mesh.
"
    "
ic_uns_unload_temporary name

Deletes a temporary mesh.
"
    "
ic_uns_get_thickness name

Gets the thickness associated with an element. This returns a list of lists, for each element: num thick1 thick2 thick3 [thick4] 
"
    "
ic_uns_contact_sets dist contactpartlist [\"\"] debug [0]

Calculates target families based on proximity factor Returns a list of maps for the contact locations.
"
    "
ic_uns_immutable name what

Sets an element(s) as immutable
"
    "
ic_uns_isimmutable name

Checks if element(s) is/are immutable

ic_unstruct_grad_smooth iter_sf iter_vl alpha_sf alpha_vl crit_avr_cha_sf [0.0001] crit_avr_cha_vl [0.0001] n_fix_layer [0] sfit [0] fams_attr [\"\"] rebunch_edges [0] family_edges [\"\"] edges [\"\"] families [all] update_mesh_step [0]

Gradient smoothing

ic_unstruct_elliptical_smooth iter_sf iter_vl gexpr_sf gexpr_vl stabilize_sf stabilize_vl ortho_distance_sf ortho_distance_vl stype fix n_fix_layer fams_attr rebunch_edges sfit family_edges edges [\"\"] families [all] treat_unstruct [0] kpg [0]

Elliptical smoothing.
"
    "
ic_uns_thickness_exists_mesh

Checks if thickness is stored in the mesh.
"
    "
ic_uns_get_thickness_node name

Gets the thickness associated with an element-node. This returns a list of lists, for each element-node: num thick
"
    "
ic_uns_surface_volume name

Volume of surface elements for a part, sum of surface area of element * averaged thickness
"
    "
ic_uns_bcfield_define name def

Defines a new bcfield, or change the default value for the field. 
"
    "
ic_uns_bcfield_exists name

Checks if a bcfield exists.
"
    "
ic_uns_bcfield_list

Lists the available bcfields.
"
    "
ic_uns_bcfield_get name mapn def_ok 

Gets bcfield values.
"
    "
ic_uns_bcfield_default name val [\"\"]

Gets or sets bcfield default value.
"
    "
ic_uns_bcfield_set name mapn val

Sets bcfield values.
"
    "
ic_uns_bcfield_rename name newname

Renames a bcfield.
"
    "
ic_uns_subset_update_bcfield_color_map bcfield subset

Sets up a color map for this subset that is appropriate to the given bcfield Actually there has to be just one of these visible at a time.
"
    "
ic_uns_set_part_bar_orientations parts args

Sets bar orientations on a given set of parts.
"
    "
ic_uns_enforce_bar_direction name

Makes sure the bars in a specific map are all oriented such that no node has more than one bar pointing into it, if possible. Return value is the number of nodes that are still violating the constraint.
"
    "
ic_uns_mesher_license get

Checks out or gives back a mesher license appropriate to the current mesh. Returns an error string if there was a problem.
"
    "
ic_uns_associate_geometry 

Para mesh.
"
    "
ic_uns_split_edges_propagate which par [0.5]

Splits edges in subset and propagates.
"
    "
ic_uns_split p0 p1 args [.5]

Splits an edge in the mesh
"
    "
ic_uns_convert_tet2_hexcore fams [\"\"] fill_holes [0] refinement [1] bbox [\"\"] csys [global] conformal [0]

Converts tetra volume mesh to Hexa-core mesh.
"
    "
ic_uns_write_node_list map file scale [1]

Writes out the nodes of a subset in a simple format.
"
    "
ic_uns_write_elem_list map file

Writes out the elements of a subset in a simple format.
"
    "
ic_uns_import_bcfield name file on_nodes colnum defval

Reads in per-element or per-node result domain data. The file contains 2 or more columns. The first is the element or node number, and colnum selects which of the following ones is loaded, starting with 1. The name is something like Nastran:OR:X1 and will be available as a distributed attribute in MED. If the attribute did not already exist it will be created and given the specified default value. If on_nodes is 1 then the numbers in the file are external vertex numbers and the bc values will be attached to the NODE elements on those vertices. If a vertex is referenced that does not have a NODE element it will be skipped (for now)
"
    "
ic_uns_export_bcfield name file on_nodes 

Exports BC values in the same format. If on_nodes is given then the nodes of the given elements are written out with the values for those elements, and duplicated nodes are written more than once (possibly with different values). 
"
    "
ic_uns_count_nodes_in_families fams

Counts the number of nodes in each family.
"
    "
ic_uns_mark_enclosed_elements name surfs matlpnts only_vol [0]

Marks elements enclosed by surfaces with the material points.
"
    ))
