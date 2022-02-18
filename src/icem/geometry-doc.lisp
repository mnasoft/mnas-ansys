;;;; ./src/icem/geometry-doc.lisp

(in-package #:mnas-ansys/icem/geometry)

(defmacro mk-doc-func (func str)
  `(setf (documentation ,func 'function) ,str))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(mk-doc-func
 #'ic_load_tetin
" These functions manipulate the geometric data which is loaded in
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
")

(mk-doc-func
 #'ic_empty_tetin
 "
Creates an empty geometry database.")

(mk-doc-func
 #'ic_save_tetin
" 
Saves the current geometry data to the given file name. The full
path name must be specified. If only_visible is 1 then only the
visible data will be saved. If v4 is 1 then the tetin file will be
saved in Ansys ICEM CFD 4.x compatibility mode.

Note: On Windows use the \"/\" character as the path delimiter instead
of the backslash \"\\\" character. For example:

ic_save_tetin c:/speed_racer/mach5.tin")

(mk-doc-func
 #'ic_unload_tetin
 "
Unloads the current geometry data.")

(mk-doc-func
 #'ic_geo_import_mesh
 "
Imports a mesh file and creates a tetin database. Surface elements are
turned into surfaces (by family), bar elements to curves, node
elements to prescribed points, and one volume element per family to
material points. If domains is \"\" then it will be imported from the
loaded unstructured mesh. If do_seg is 1, then the curves and surfaces
will be segmented by connectivity, else they will be kept as one
object per family. If no_orfn is 1, then any elements that were in the
ORFN (0) family will be moved to a new family called MOVED_ORFN.")


(mk-doc-func
 #'update_surface_display
 "Utility to update display of surface and related edges, vertices.")

(mk-doc-func
 #'ic_geo_export_to_mesh
 "
Copies the current geometry
into the mesh database. 

This is the opposite of ic_geo_import_mesh. 
Surfaces will be turned into families of triangles, etc. 
If merge is 1, then all surfaces, etc will keep their families, and if 0, 
then the geometric objects will each be mapped
 to a separate family in the 
mesh.")

(mk-doc-func
 #'ic_ddn_app 
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
")

(mk-doc-func
 #'ic_geo_summary
 "Prints")

(mk-doc-func
 #'ic_geo_lookup_family_pid 
"
Returns the internal numeric id (pid) of the family. This is not a safe function to use in general because the pid is not guaranteed to stay the same between one invocation of the program and the next, and no scripting commands use it as an argument.
")

(mk-doc-func
 #'ic_geo_is_loaded
 " Reports ")

(mk-doc-func
 #'ic_geo_is_modified
"
Reports if the current geometry has been modified since the last save.
")

(mk-doc-func
 #'ic_geo_valid_name
"
Changes a name into a valid family/entity name.
")

(mk-doc-func
 #'ic_ddn_app
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

Note:  This command is currently broken in MED 4.2 08/16/01")

(mk-doc-func
 #'ic_geo_set_modified 
"
Sets the modified flag for the current geometry. This should not be used for most operations since they set this flag themselves.
")

(mk-doc-func
 #'ic_geo_check_family 
"
Checks whether a family exists.
")


(mk-doc-func
 #'ic_geo_check_part 
"
Checks whether a part exists.
")


(mk-doc-func
 #'ic_geo_new_family 
"
Creates a new family if it is not already there. Returns 1 if a new family was created, or 0 if it already existed.

Note:   The newly created family will not appear in the interactive family list unless you issue the update_family_display command interactively.
")


(mk-doc-func
 #'ic_geo_new_name 
"
Creates a new, unused name for an entity in a family.
")


(mk-doc-func
 #'ic_geo_get_unused_part 
"
Creates a new unused part or family name.
")


(mk-doc-func
 #'ic_geo_delete_family 
"
Deletes a family, or a list of families.
")


(mk-doc-func
 #'ic_geo_params_blank_done 
"
Blanks those entities that have some meshing parameters already defined. If reset == 1, then the entities blanked entities are unblanked.
")


(mk-doc-func
 #'ic_geo_match_name 
"
Returns the names of the objects that match a given pattern.
")


(mk-doc-func
 #'ic_geo_update_visibility 
"
Changes the visibility so that only objects with the given families and type are visible or not, depending on the visible option. If vis_fams is *skip* then they are retained and the type is checked. If a family is not listed in the family list then it is ignored.
")


(mk-doc-func
 #'ic_geo_get_visibility 
"
Returns whether an object is visible or not.
")


(mk-doc-func
 #'ic_geo_set_visible_override 
"
Sets or unsets the visible_override flag. If this flag is set for an object then it is always visible no matter what types and families are enabled. This is needed for geometry subsets.
")


(mk-doc-func
 #'ic_geo_temporary_visible 
"
Temporarily blanks or unblanks an object. This will not go away when you change anything larger scale. If objects is set to all then all will be blanked or unblanked.
")


(mk-doc-func
 #'ic_geo_get_temporary_invisible 
"
Gets the temporarily blanked entities. Returns a list of “type name”, or an empty list if no entity was blanked. Type can be entity (for all types), point, curve, or surface.

Example usage: ic_geo_get_temporary_invisible [type]
")


(mk-doc-func
 #'ic_geo_set_visible_override_families_and_types 
"
This is a helper function that sets the visible_override flag for all objects in some families and types, and clears it for all others. Note that after calling this function all the visible flags on the non-override families will be off.
")


(mk-doc-func
 #'ic_redraw_geometry 
"
This redraws the geometry in case something changes.
")


(mk-doc-func
 #'ic_geo_incident 
"
Returns what objects of higher dimensionality are incident to this one. Surfaces are incident to curves and curves are incident to points.
")


(mk-doc-func
 #'ic_geo_surface_get_objects 
"
Returns a list of objects associated to a surface.
")


(mk-doc-func
 #'ic_geo_loop_get_objects 
"
Returns a list of objects associated to a loop.
")


(mk-doc-func
 #'ic_geo_surface_edges_incident_to_curve 
"
Returns the edges in a triangulated surface which are incident to a given curve.
")


(mk-doc-func
 #'ic_geo_surface_normals_orient 
"
Reorients the normals of surfaces in a model with respect to the given reference surface refsurfname in direction given outward [0|1]. If there is no material point, outward means reverse reference surface before reorienting with respect to it.
")


(mk-doc-func
 #'ic_geo_get_side_surfaces 
"
Returns a list of surfaces whose normal of magnitude tol does not intersect another surface.
")


(mk-doc-func
 #'ic_geo_boundary 
" Returns the objects of lower dimensionality which are the boundary
of the one specified. Points are the boundary of curves and curves are
the boundary of surfaces and loops. The list returned has a sublist
for each element in names such that {{c00 c01} {c10 c11} ...}, unless
names is one element, in which case the returned list goes as: \"c00
c01\".. names may be one name, or a list of names. outer may be 0 or
1, indicating what kind of boundaries. even_if_dormant may be 0 or 1,
indicating which additional boundaries. embedded may be 0 or 1,
indicating which additional boundaries.
")


(mk-doc-func
 #'ic_geo_object_visible 
"
Changes the visibility of a specific object or objects. The visible argument is 0 or 1.
")


(mk-doc-func
 #'ic_geo_configure_objects 
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
")


(mk-doc-func
 #'ic_geo_configure_one_attribute 
"
Configure one attribute of a whole type.
")


(mk-doc-func
 #'ic_geo_configure_one_object 
"
Configure the attributes of one object.
")


(mk-doc-func
 #'ic_geo_list_families 
"
Lists the current families used by geometry objects. If only_material is 1 then limit the listing to families used by materials. If non_empty is 1 then list only families which are non empty.
")


(mk-doc-func
 #'ic_geo_list_parts 
"
Lists the current parts.
")


(mk-doc-func
 #'ic_geo_check_part 
"
Checks if a part exists.
")


(mk-doc-func
 #'ic_geo_list_families_in_part 
"
Lists the current families in a part.
")


(mk-doc-func
 #'ic_geo_list_families_with_group 
"
Lists the families in a group.
")


(mk-doc-func
 #'ic_geo_list_parts_with_group 
"
Lists the parts that have some family in a group.
")


(mk-doc-func
 #'ic_geo_family_is_empty 
"
Returns whether or not the family is empty of entities.
")


(mk-doc-func
 #'ic_geo_family_is_empty_except_dormant 
"
Returns whether or not the family contains only dormant entities.
")


(mk-doc-func
 #'ic_geo_non_empty_families 
"
Lists all the non-empty families.

Note:  This does not check whether there are directives.
")


(mk-doc-func
 #'ic_geo_non_empty_families_except_dormant 
"
Lists all the families containing only dormant entities.

Note:  This does not check whether there are directives.
")


(mk-doc-func
 #'ic_geo_num_objects 
"
Returns the number of objects of the given type.
")


(mk-doc-func
 #'ic_geo_list_visible_objects 
"
Returns the number of visible objects of the given type.
")


(mk-doc-func
 #'ic_geo_num_visible_objects 
"
Returns the number of visible objects of the given type. If any is 1, specify whether that number is more than 0.
")


(mk-doc-func
 #'ic_geo_num_segments 
"
Returns the number of triangles or bars, and nodes in this object.
")


(mk-doc-func
 #'ic_geo_set_family 
"
Changes the geometry with the given type and name to family newfam. The first argument tells the type of geometry objects: surface, curve, material, point, density, or loop. The second argument is the new family name to be set. The third argument tells how to select the objects and the fourth is the list of object specifiers. how can be one of the following:

    names: a list of the names of the objects

    numbers: a list of the internal numbers (not for general consumption)

    patterns: a list of glob-patterns that match the names of the objects

    families: a list of the families to select

    all: all objects of that type (the objects list is ignored)

    visible: all visible objects of that type (the objects list is ignored)

    rename: if 1, change the name of the object to match the new family, if appropriate. Note that if this function is called as part of a larger script, the renaming might break things if other parts of the code think they know the names of the objects they are dealing with and those names change beneath them.
")


(mk-doc-func
 #'ic_geo_set_part 
"
Moves geometry from one part to a new one. This has to create the new part name and copy the boundary conditions if necessary so that the other groups in the family are not disturbed.
")


(mk-doc-func
 #'ic_geo_set_name 
"
Change the geometry with the given type and name to name newname. If make_new is 1 then an unused name that starts with newname is used and this value is returned from the function. If possible newname is used without modification. If make_new is 0 then any objects of that same type and name that already exist will be deleted first.
")


(mk-doc-func
 #'ic_geo_rename_family 
"
Rename the family. All objects in fam will now be in nfam. If rename_ents is set, family entities will be renamed.
")


(mk-doc-func
 #'ic_geo_replace_entity 
"
For two geometry entities of type, the first, of name e1name, will be replaced by the second, of name e2name, as well as being put into the family of the first entity and having the meshing parameters copied from the first to the second. The name of the first entity is appended with _OLD and put into the family ORFN.
")


(mk-doc-func
 #'ic_geo_get_ref_size 
"
Returns the reference mesh size. This is used to scale all meshing parameter values for display to the user.
")


(mk-doc-func
 #'ic_set_meshing_params 
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
")


(mk-doc-func
 #'ic_get_mesh_growth_ratio 
"
Returns mesh growth ratio.
")


(mk-doc-func
 #'ic_get_meshing_params 
"
Returns the meshing parameters. This has the advantage over ic_set_meshing_params that it is not recorded in the replay file.
")


(mk-doc-func
 #'ic_geo_scale_meshing_params 
" Scales the meshing parameters on geometric entities of types by a
factor. If types is all then rescales entities of types \"surface
curve point material density loop\".
")


(mk-doc-func
 #'ic_geo_set_curve_bunching 
"
Sets curve bunching.
")


(mk-doc-func
 #'ic_geo_get_curve_bunching 
"
Gets curve bunching.
")


(mk-doc-func
 #'ic_geo_create_surface_segment 
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
")


(mk-doc-func
 #'ic_geo_create_curve_segment 
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
")


(mk-doc-func
 #'ic_geo_split_curve 
"curve 	name of the curve
points 	list of points
return	names of curve segments

Note:   This splits the curve in the specified order of the points
")


(mk-doc-func
 #'ic_geo_split_curve_at_point 
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
")


(mk-doc-func
 #'ic_geo_create_loop 
"
Creates a loop with the given name and family using the specified curves. If how is names then curves is a list of the names of the curves to use, and if it is families then it is a list of family names. If all_separate is 1 then all the curves are considered individually and if it is 0 then they are all taken together to create the loop. Surfaces are associated to the loop if a list surfs of names of surfaces is given. Optionally the loops can be set to the families in the list fams in order, in the case of all_separate is 1. Points can be added to a loop if a list points of names of points is given.
")


(mk-doc-func
 #'ic_geo_modify_loop 
"
Modify 1 loop with the given name using the specified curves, points and surfaces. A list of names of curves must be given. Surfaces are associated to the loop if a list surfs of names of surfaces is given. Points/corners can be added to a loop if a list points of names of points/corners is given.
")


(mk-doc-func
 #'ic_geo_pick_location 
"
Selects a geometric entity on the screen. Arguments are:

    line{{x y z} {x y z}}: the line in model space

    typetype: one of: entity, surface, curve, point, material, loop, or density

The return value is a list that contains the type, name, and location on the object.
")


(mk-doc-func
 #'ic_geo_get_object_type 
"
Determines whether an object is type param (a trimmed NURBS curve or surface) or mesh (a faceted surface or piecewise linear curve). If both types are present in the list of names mixed is returned.
")


(mk-doc-func
 #'ic_geo_trim_surface 
"
Trims the surface by the curves. This creates a new surface with the name of the old surface followed by .cut.$n.
")


(mk-doc-func
 #'ic_geo_intersect_surfaces 
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
")


(mk-doc-func
 #'ic_geo_intersect_surfs_by_groups 
"
Intersects surface groups.

groups can be a list of two forms:

    {srf1 srf2 srf3 ...}

    {{srf1 srf2 srf3 ...} {srf4 srf5 srf6 ...} {srf7 srf8 srf9 ...} ...}

In the first form, every surface is intersected with each other, but curves created from each surface pair intersection will be separate. In the second form, each set is intersected with every other set. Surfaces within each set will not be intersected with each other. Separate curves are still generated from each surface pair intersection.
")


(mk-doc-func
 #'ic_geo_create_unstruct_curve_from_points 
"
Creates a piecewise linear curve from the points. This curve is given the specified name and family. pts is a list of triples of floating point numbers or list of prescribed point names and they are connected in order. The points are in the current local coordinate system.
")


(mk-doc-func
 #'ic_geo_create_unstruct_surface_from_points 
"
Creates a surface from 4 points, with the given name and family. pts is a list of 4 triples of floating point numbers or list prescribed point names and 2 triangles are created to make a rectangular surface. The points are in the current local coordinate system.
")


(mk-doc-func
 #'ic_geo_create_empty_unstruct_surface 
"
Creates an empty surface, with the given name and family.
")


(mk-doc-func
 #'ic_geo_create_empty_unstruct_curve 
"
Creates an empty curve, with the given name and family.
")


(mk-doc-func
 #'ic_geo_create_curve_ends 
"
Creates points at the ends of the named curve.
names	names of curve
return	names of created points

Note:   This function creates new points at curve endpoints as needed. See also ic_geo_mod_crv_set_end.
")


(mk-doc-func
 #'ic_geo_mod_crv_set_end 
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
")


(mk-doc-func
 #'ic_geo_crv_get_end 
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
")


(mk-doc-func
 #'ic_geo_create_points_curveinter 
"
Creates points at the intersection of curves. curves is a list of curves to intersect.
")


(mk-doc-func
 #'ic_geo_create_point_location 
"
This function has been replaced by ic_geo_cre_pnt
")


(mk-doc-func
 #'ic_geo_create_material_location 
"
This function has been replaced by ic_geo_cre_mat
")


(mk-doc-func
 #'ic_geo_create_density 
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
")


(mk-doc-func
 #'ic_geo_extract_points 
"
Extracts points from curves based on the angle between adjacent segments in degrees.
")


(mk-doc-func
 #'ic_geo_extract_curves 
"
Extracts curves from mesh surfaces. If bound is 1 then only the boundary of the surface is extracted. If it is 0 then the angle is used to determine feature lines. The minedge argument determines what the smallest curve that will be extracted is.
")


(mk-doc-func
 #'ic_geo_create_surface_edges 
"
Creates curves based on the edges of a surface.
")


(mk-doc-func
 #'ic_geo_get_srf_edges 
"
Returns any curves associated as edges to a surface.
")


(mk-doc-func
 #'ic_geo_stats 
"
Returns some statistics about the object. This is a readable string that says what the type is, how many triangles, nodes, etc.
")


(mk-doc-func
 #'ic_geo_get_point_location 
"
Given the name of a point, returns its location.
")


(mk-doc-func
 #'ic_geo_get_material_location 
"
Given the name of a material point, returns its location.
")


(mk-doc-func
 #'ic_set_point_location 
"
Sets the location of a point or points. The names and locations must come in pairs.
")


(mk-doc-func
 #'ic_set_material_location 
"
Sets the location of one or more material points. The names and locations must come in pairs.
")


(mk-doc-func
 #'ic_delete_material 
"
Deletes a material.
")


(mk-doc-func
 #'ic_geo_check_objects_exist 
"
This function checks to make sure the objects exist - it returns the list of names that were found. If no objects with the given type and names were found it returns an empty list.
")


(mk-doc-func
 #'ic_geo_get_objects 
" This function returns all the objects of the given type and
family. If the family does not exist it returns an empty list, and if
it is \"\" then it returns all objects of all families.
")


(mk-doc-func
 #'ic_geo_count_in_family 
"
Returns the number of objects of the given type in the given family.
")


(mk-doc-func
 #'ic_geo_objects_in_family 
"
Returns a list of objects in the given family name.
")


(mk-doc-func
 #'ic_geo_objects_in_parts 
"
Returns a list of objects (type/name pairs) in the given parts.
")


(mk-doc-func
 #'ic_geo_get_internal_object 
"
Returns the internal object associated with a name. This is a bit of a back door.
")


(mk-doc-func
 #'ic_geo_get_name_of_internal_object 
"
Returns the name of an internal object. This is a bit of a back door.
")


(mk-doc-func
 #'ic_geo_get_text_point 
"
Returns the text point list for an object, specified by type and name. The list is: \"{xloc yloc zloc} {xdir ydir zdir}\"
")


(mk-doc-func
 #'ic_geo_get_centroid 
"
Returns the centroid for an object, specified by type and name. The return is: \"{xloc yloc zloc}\". This function only works for curves at this time.
")


(mk-doc-func
 #'ic_geo_num_segments 
"
Returns the number of segments or triangles in the object. This returns 2 numbers - the number of segments and the number of nodes.
")


(mk-doc-func
 #'ic_geo_num_nodes 
"
Returns number of nodes in the object.
")


(mk-doc-func
 #'ic_geo_get_node 
"
Returns a node in a mesh curve, surface or density polygon.
")


(mk-doc-func
 #'ic_geo_drag_nodes 
"
Allows you to interactively drag nodes in surfaces and curves.
")


(mk-doc-func
 #'ic_geo_drag_point 
"
Allows you to interactively drag prescribed points.
")


(mk-doc-func
 #'ic_geo_drag_material 
"
Allows you to interactively drag material points.
")


(mk-doc-func
 #'ic_geo_drag_body 
"
Allows you to interactively drag body points.
")


(mk-doc-func
 #'ic_geo_project_point 
"
Project a point to a set of objects. dir is the vector along which to project, or 0 0 0 if the nearest point is desired. dir is used only in the case of surfaces.
type	point, curve, surface
names	list of entity names
pt	point -- either entity name or 3-tuple
dir	projection vector, {0, 0, 0} for nearest point
tan_ext 	project to tangential extension (curves only)
")


(mk-doc-func
 #'ic_geo_project_and_move_point 
"
Project and move a point to a set of objects. dir is the vector along which to project, or 0 0 0 if the nearest point is desired. dir is used only in the case of surfaces.
type 	point, curve, surface
names 	list of entity names
pt 	point -- either entity name or 3-tuple
dir 	projection vector, {0, 0, 0} for nearest point
tan_ext 	project to tangential extension (curves only)
fam 	part name (if blank, use the part name of the point)
")


(mk-doc-func
 #'ic_geo_project_coords 
"
Project coordinates to a set of objects. dir is the vector along which to project, or 0 0 0 if the nearest point is desired. dir is used only in the case of surfaces.
")


(mk-doc-func
 #'ic_geo_nearest_object 
"
Projects a point to a set of objects, and return the name of the best one and the location. dir is the vector along which to project, or 0 0 0 if the nearest point is desired. pt may either be an XYZ location or the name of a prescribed point. The tol argument is used for intersecting a line with curves.

Note:  Curve projection is not yet implemented.
")


(mk-doc-func
 #'ic_geo_project_curve_to_surface 
"
Projects one or more curves to one or more surfaces.
crvs	list of curve names
surfs	list of surface names
name	base name of created curve
fam	family of created curves
new_name	do not reuse existing names
bld_topo	trim surfaces by projected curves
return	name(s) of created curve(s)
")


(mk-doc-func
 #'ic_geo_create_surface_curves 
"
Creates a faceted surface from crv1 and crv2. If the curves are not connected, the new surface will connect straight across the gaps.

name is the name of the new surface.
")


(mk-doc-func
 #'ic_geo_create_surface_curtain 
"
Creates a curtain surface between one or more curves and a surface.
crvs	list of defining curves
surfs	surface(s) to project to
name	base name of created surfaces
fam	family of created surfaces
bld_topo	run the topology builder
quiet	suppress diagnostic messages
")


(mk-doc-func
 #'ic_geo_set_node 
"
Moves a node on an object.
")


(mk-doc-func
 #'ic_geo_get_family 
"
Returns the family for an object.
")


(mk-doc-func
 #'ic_geo_get_part 
"
Returns the part for an object (just the family with stuff after the first : removed)
")


(mk-doc-func
 #'ic_build_topo 
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
")


(mk-doc-func
 #'ic_geo_default_topo_tolerance_old 
"
Get a good tolerance for the current geometry.
")


(mk-doc-func
 #'ic_delete_geometry 
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
")


(mk-doc-func
 #'ic_geo_pnt_mrg_inc_crv 
"
Deletes a point and joins incident curves.

    how - defines how points are selected. See ic_delete_geometry.

    objects - the internal handles for the objects
")


(mk-doc-func
 #'ic_facetize_geometry 
"
Makes a new geometric entity that is the faceted or piecewise linear equivalent of the old one. Optional arguments are:

    noisyon : if 1 print status information

    replaceon : if 1 replace the old object, otherwise make a new one.
")


(mk-doc-func
 #'ic_move_geometry 
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
")


(mk-doc-func
 #'ic_geo_duplicate 
"
Duplicates an existing geometrical entity. If the newname is given then that is used, otherwise a name is generated automatically. If facetize is specified then bspline surfaces are turned into facets.
")


(mk-doc-func
 #'ic_geo_fixup 
"
Fix problems in surfaces and curves like duplicate triangles, unused nodes, etc.
")


(mk-doc-func
 #'ic_geo_min_edge_length 
"
Returns the minimum edge length on a list of surfaces or curves. Arguments are:

    surfaceval: list of surface names

    curveval: list of curve names

Example usage: set surfaces \"surf1 surf2 surf3\" set curves \"curv1\" ic_geo_min_edge_length surface $surfaces curve $curves
")


(mk-doc-func
 #'ic_geo_coarsen 
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
")


(mk-doc-func
 #'ic_geo_gap_repair 
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
")


(mk-doc-func
 #'ic_geo_midsurface 
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
")


(mk-doc-func
 #'ic_geo_lookup 
"
Looks up geometry objects based on certain criteria. type may be one of the geometry type names or all. This always returns a list of type/name pairs. Useful values for how and args are:

    namesnames: return objects with the given names

    familiesnames: return objects with the given families

    all: return all objects of the specified types

    patternspats: looks up objects based on glob-style name matching (for example, FAM*)

    visible: all visible objects

    blanked: all non-visible objects
")


(mk-doc-func
 #'ic_geo_get_entity_types 
"
For the given list of entities, return a *flat* list of \"type entname\" pairs, i.e. {type_1 ent_1 type_2 ent_2 ... type_n ent_n}
")


(mk-doc-func
 #'ic_geo_memory_used 
"
Specifies how much memory is used for the geometry data.
")


(mk-doc-func
 #'ic_geo_project_mode 
"
Sets the projection mode.
")


(mk-doc-func
 #'ic_csystem_get_current 
"
Specifies the current coordinate system.
")


(mk-doc-func
 #'ic_csystem_set_current 
"
Sets the current coordinate system.
")


(mk-doc-func
 #'ic_csystem_list 
"
Lists the existing coordinate systems.
")


(mk-doc-func
 #'ic_csystem_get 
"
Returns information on the named coordinate system. This returns a list of 4 items: the type of the coordinate system, the origin, and the 3 vectors that define coordinate system. The type can be one of:

    cartesian

    cylindrical

    spherical

    toroidal
")


(mk-doc-func
 #'ic_csystem_delete 
"
Deletes the named coordinate system.
")


(mk-doc-func
 #'ic_csystem_create 
"
Creates a new coordinate system with the given parameters.

    name: the name of the system to create.

    type: the type which can be one of cartesian, cylindrical, spherical, or toroidal (as yet unsupported).

    center: the center point in 3-D coordinates.

    axis0: the first axis vector.

    axis1: the second axis vector.

    axis2: the third axis vector.
")


(mk-doc-func
 #'ic_coords_into_global 
"
Translates coordinates from the current or given system into the global system.
")


(mk-doc-func
 #'ic_coords_dir_into_global 
"
Translates a vector from the current or given system into the global system.
")


(mk-doc-func
 #'ic_coords_into_local 
"
Translates coordinates from the global system into the current or given local system.
")


(mk-doc-func
 #'ic_csystem_display 
"
Displays the specified coordinate system. If name is all and on is 0 then erase all coordinate systems.
")


(mk-doc-func
 #'ic_geo_untrim_surface 
"
Untrims a surface.
")


(mk-doc-func
 #'ic_geo_get_thincuts 
"
Returns the thincut data.
")


(mk-doc-func
 #'ic_geo_set_thincuts 
"
Sets the thincut data.
")


(mk-doc-func
 #'ic_geo_get_periodic_data 
"
Returns the periodic data.
")


(mk-doc-func
 #'ic_geo_set_periodic_data 
"
Sets the periodic data.
")


(mk-doc-func
 #'ic_geo_get_family_param 
"
Returns the family parameters.
")


(mk-doc-func
 #'ic_geo_set_family_params 
"
Sets the family parameters. If there is no such family, nothing will be done.
")


(mk-doc-func
 #'ic_geo_reset_family_params 
"
Reset family parameters on families fams for parameters params.
")


(mk-doc-func
 #'ic_geo_delete_unattached 
"
Deletes unattached geometry.
")


(mk-doc-func
 #'ic_geo_remove_feature 
"
Removes features.
")


(mk-doc-func
 #'ic_geo_merge_curves 
"
Merges curves.
")


(mk-doc-func
 #'ic_geo_modify_curve_reappr 
"
Reapproximates curves.
curves	list of curve names
tol	re-approximation tolerance
ask	prompt to accept result
quiet	suppresses messages
return	list of new curve names

Note:   In interactive mode, if the ask parameter is 1 (default), the application prompts you to confirm whether the result is okay for each curve. Parameter is ignored in batch mode.
")


(mk-doc-func
 #'ic_geo_modify_surface_reappr 
"
Reapproximates surfaces.
surfaces	list of surface names
tol	re-approximation tolerance
ask	prompt to accept result if set
each	re-approximate each surface separately if set
curves	list of curve names
return	list of new surface names

Note:   In interactive mode, if the ask parameter is 1 (default), the application prompts you to confirm whether the result is okay for each surface. Parameter is ignored in batch mode.
")


(mk-doc-func
 #'ic_geo_reset_data_structures 
"
Resets the Tcl data structures after making big changes to the proj database.
")


(mk-doc-func
 #'ic_geo_params_update_show_size 
"
Modifies the display of the size icons for ref, natural, and max size. Can also be used for per-object parameters like tetra_size.
")


(mk-doc-func
 #'ic_geo_stlrepair_holes 
"
Repairs holes using the stlrepair functionality. type indicates the entity type by which segments are specified, e.g. surface.
")


(mk-doc-func
 #'ic_geo_stlrepair_edges 
"
Repairs edges using the stlrepair functionality. type indicates the entity type by which segments are specified, e.g. surface.
")


(mk-doc-func
 #'ic_show_geo_selected 
"
Displays some geometry selected or not.
")


(mk-doc-func
 #'ic_reset_geo_selected 
"
Resets all selection display.
")


(mk-doc-func
 #'ic_get_geo_selected 
"
Returns all current geometry selections.
")


(mk-doc-func
 #'ic_set_geo_selected 
"
Sets all previous geometry selections.
")


(mk-doc-func
 #'ic_select_geometry_option 
"
Returns the previously used selection option.
")


(mk-doc-func
 #'ic_geo_add_segment 
"
Adds segments or triangles to a surface or curve.
")


(mk-doc-func
 #'ic_geo_delete_segments 
"
Deletes segments or triangles from a curve or surface.
")


(mk-doc-func
 #'ic_geo_restrict_segments 
"
Restrict to segments or triangles from a surface or curve.
")


(mk-doc-func
 #'ic_geo_split_segments 
"
Splits some segments in a surface or curve.
")


(mk-doc-func
 #'ic_geo_split_edges 
"
Splits some edges in a surface.
")


(mk-doc-func
 #'ic_geo_split_one_edge 
"
Splits one edge in a surface.
")


(mk-doc-func
 #'ic_geo_swap_edges 
"
Swaps some edges in a surface.
")


(mk-doc-func
 #'ic_geo_move_segments 
"
Moves some segments from one surface to another.
")


(mk-doc-func
 #'ic_geo_move_node 
"
Moves a node in a surface or curve. nodes is a list of the node numbers. After this, specify either one or more positions. If one, then all nodes are moved to that position. If more, then the nodes are moved to their corresponding positions.
")


(mk-doc-func
 #'ic_geo_merge_nodes 
"
Merges nodes in a surface or curve.
")


(mk-doc-func
 #'ic_geo_merge_nodes_tol 
"
Merges nodes in a surface or curve by tolerance.
")


(mk-doc-func
 #'ic_geo_merge_surfaces 
"
Merges multiple surfaces.
")


(mk-doc-func
 #'ic_geo_merge_objects 
"
Merges multiple curves, or surfaces.
")


(mk-doc-func
 #'ic_geo_merge_points_tol 
"
Merges multiple points using a tolerance.
")


(mk-doc-func
 #'ic_geo_finish_edit 
"
Cleans up a surface or curve after editing operations.
")


(mk-doc-func
 #'ic_geo_delete_if_empty 
"
Deletes a surface or curve if it is empty.
")


(mk-doc-func
 #'ic_geo_smallest_segment 
"
Returns the smallest triangle in a surface.
")


(mk-doc-func
 #'ic_geo_get_config_param 
"
This is kind of an escape.
")


(mk-doc-func
 #'ic_geo_set_config_param 
"
This is kind of an escape.
")


(mk-doc-func
 #'ic_geo_set_tag 
"
Sets the given tag on the objects, or removes it. If the tagname is pickable this affects the geometry selection code. If the type is clear then the tag is removed from all objects and the name and on parameters are ignored. If name is an empty string then all the objects of that type will be modified.
")


(mk-doc-func
 #'ic_geo_highlight_segments 
"
Highlights some segments of an image.
")


(mk-doc-func
 #'ic_geo_bounding_box 
"
Returns the bounding box of a set of objects. objlist is a list of type names pairs, e.g. { { curve {C1 C2 C2} point {C2 C3}} } It can also be all which will give the bounding box of all the geometry.
")


(mk-doc-func
 #'ic_geo_bounding_box2 
"
This is the more rigorous version of the boundary box calculation.
")


(mk-doc-func
 #'ic_geo_model_bounding_box 
"
This gives the bounding box of all objects in projlib.
")


(mk-doc-func
 #'ic_geo_feature_size 
"
Returns the feature size of an object.
")


(mk-doc-func
 #'ic_geo_replace_surface_mesh 
"
Replaces a surface mesh. pts is a list of x y z triples. tris is a list of 3 point numbers. e.g., ic_geo_replace_surface_mesh SURF.1 {{0 0 0} {1 1 1} ...} {{0 1 2} ...}
")


(mk-doc-func
 #'ic_geo_replace_curve_mesh 
"
Replaces a curve mesh. pts is a list of x y z triples. bars is a list of 2 point numbers. e.g., ic_geo_replace_curve_mesh CRV.1 {{0 0 0} {1 1 1} ...} {{0 1} {2 3} ...}
")


(mk-doc-func
 #'ic_geo_vec_diff 
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
      
")


(mk-doc-func
 #'ic_geo_vec_dot 
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
      
")


(mk-doc-func
 #'ic_geo_vec_mult 
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

      
")


(mk-doc-func
 #'ic_geo_vec_nrm 
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

      
")


(mk-doc-func
 #'ic_geo_vec_len 
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

      
")


(mk-doc-func
 #'ic_geo_pnt_dist 
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
      
")


(mk-doc-func
 #'ic_geo_vec_smult 
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

")


(mk-doc-func
 #'ic_geo_vec_sum 
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

      
")


(mk-doc-func
 #'ic_geo_crv_length 
"
Computes the arc length of a curve segment.
crvs	list of one or more curves
t_min	lower limit of segment (unitized
t_max 	upper limit of segment (unitized
return	list of computed arc lengths

Notes:

    t_min and t _max default to 0 and 1 respectively

    For example usage, refer to ic_geo_crv_length.tcl in the Ansys installation directory under v221/icemcfd/Samples/ProgrammersGuide/med_test.
")


(mk-doc-func
 #'ic_geo_cre_srf_rev 
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
")


(mk-doc-func
 #'ic_geo_cre_crv_iso_crv 
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
")


(mk-doc-func
 #'ic_geo_cre_srf_pln_3pnts 
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
")


(mk-doc-func
 #'ic_geo_cre_srf_pln_nrm_pnt 
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
")


(mk-doc-func
 #'ic_geo_cre_srf_pln_nrm_dist 
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

      
")


(mk-doc-func
 #'ic_geo_cre_arc_from_pnts 
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
")


(mk-doc-func
 #'ic_geo_cre_bsp_crv_n_pnts 
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
")


(mk-doc-func
 #'ic_geo_cre_bsp_crv_n_pnts_cons 
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
")


(mk-doc-func
 #'ic_geo_cre_crv_arc_ctr_rad 
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
")


(mk-doc-func
 #'ic_geo_cre_srf_cyl 
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
")


(mk-doc-func
 #'ic_geo_cre_line 
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
")


(mk-doc-func
 #'ic_geo_cre_pnt 
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

")


(mk-doc-func
 #'ic_geo_cre_mat 
"
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

      
")


(mk-doc-func
 #'ic_geo_get_srf_nrm 
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
")


(mk-doc-func
 #'ic_geo_get_srf_pos 
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
")


(mk-doc-func
 #'ic_geo_cre_pnt_on_srf_at_par 
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
")


(mk-doc-func
 #'ic_geo_cre_pnt_on_crv_at_par 
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
")


(mk-doc-func
 #'ic_geo_cre_crv_concat 
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
")


(mk-doc-func
 #'ic_geo_create_curve_concat 
"
Deprecated version of ic_geo_cre_crv_concat. This function has been replaced by ic_geo_cre_crv_concat.
")


(mk-doc-func
 #'ic_geo_cre_srf_from_contour 
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
")


(mk-doc-func
 #'ic_geo_create_surface_from_curves 
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
")


(mk-doc-func
 #'ic_geo_create_param_surface 
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
")


(mk-doc-func
 #'ic_geo_list_crv_data 
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
      
")


(mk-doc-func
 #'ic_geo_list_srf_data 
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
")


(mk-doc-func
 #'ic_geo_make_conn_regions 
"
Makes connected regions of type: surface or curve entities are a list of the type, surfaces or curves. If type is surface, surf_angle limits connectivity based on curves over the feature angle; default is 180, 0 would make each surface separate. If type is surface, surf_curvature limits connectivity to surfaces with curvature over value; default is 360, 0 would make each surface separate. The return is a separated list based on connectivity.
")


(mk-doc-func
 #'ic_geo_get_attached_entities 
"
Gets all attached entities based on attach_type and orig_type to a list of entities. attach_type could be boundary or incident. orig_type could be surface curve or point. Example: if you want all curves attached to a list of surfaces attach_type is boundary, orig_type is surface, entities is the list of surfaces.
")


(mk-doc-func
 #'ic_geo_get_entities_by_attach_num 
"
Gets all entities of a type: point or curve; that have defined number of entities attached to it. For example a single curve has 1 entity attached. entities is list of type to look for. Default is all entities of this type. If num is multiple, it will find attachments of 3 or more. If num is double, it will find attachments of 2. If num is single, it will find attachments of 1. If num is unattached, it will find attachments of 0.
")


(mk-doc-func
 #'ic_geo_get_internal_surface_boundary 
" This command will take a given \"surf\" and return the curves that
are internal. In other words, it will return all attached curves
except those on outer boundary. Optional argument not_single will
limit the returned curves to only those that are attached to more than
1 surface.
")


(mk-doc-func
 #'ic_geo_find_internal_outer_loops 
"
This procedure returns a list of outer curves and inner curves attached to a set of surfaces, optional argument not_single will limit the list to just curves attached to more than 1 surface.
")


(mk-doc-func
 #'ic_geo_find_internal_surfaces 
"
This function will find a set of surfaces enclosed by a loop of curves.
")


(mk-doc-func
 #'ic_geo_make_conn_buttons 
"
This function will take a curve list (loop), and find all surfaces attached to it excluding any given exclusion_surfs.
")


(mk-doc-func
 #'ic_geo_split_surfaces_at_thin_regions 
"
Splits boundaries of the given surfaces at thin regions, that is, where a surface boundary points is less than tolerance from an other boundary curve. It will not, however, split curves which would result in segments of length less than min_res_curve_len. Returns a list of all new points, if any.
")


(mk-doc-func
 #'ic_geo_surface_create_smart_nodes 
"
Split boundaries of the given surfaces at thin regions, that is, where a surface boundary points is less than tolerance from an other boundary curve. It will not, however, split curves which would result in segments of length less than min_res_curve_len. Returns tcl-error-stat.
")


(mk-doc-func
 #'ic_geo_surface_topological_corners 
" For each surface in the given list surfs returns a list of the four
corners of a rectangular topology of that surface. The points are
ordered around the rectangular either clockwise or
counter-clockwise. The form of the list returned is: \"{surf_name_1
{pt_name_1_1 pt_name_1_2 pt_name_1_3 pt_name_1_4} {surf_name_2
{pt_name_2_1 ...}}\"
")


(mk-doc-func
 #'ic_geo_flanges_notch_critical_points 
"
Returns the critical point of the notch in a given flange surface.
")


(mk-doc-func
 #'ic_geo_trm_srf_at_par 
"
Splits a surface at a parameter.
srf	surface name
par	surface parameter 0 <= par <= 1
sel	== 0 u cons; == 1 v cons

Example


        if [catch {ic_geo_trm_srf_at_par $srf1 0.5 0} err] {
 mess \"$err\n\" red
 }
      
")


(mk-doc-func
 #'ic_geo_trm_srfs_by_curvature 
"
Splits folded surfaces by maximum curvature.
srfs	surface names
ang	maximum total curvature
")


(mk-doc-func
 #'ic_surface_curvature 
"
Calculates curvature of surface.
surf	surface name
btol	relative boundary tolerance (100 -> 1/100 -> 1%)
")


(mk-doc-func
 #'ic_hull_2d 
"
Creates 2D hull of surfaces or curves.
entities	entity names
tol	approximation tolerance
four	split hull at best four corners if set
type	surface or curve
shrink	relative shrink tolerance (0 ... 1)
")


(mk-doc-func
 #'ic_surface_from_points 
"
Creates a faceted surface from points using a 2D Delaunay triangulation.
points	point names
")


(mk-doc-func
 #'ic_geo_surface_extend 
"
Extends surface edge to surface(s).
curve	\"yellow\" edge to extend
surfaces	surfaces to extend surface edge to
toler	geometry tolerance
bld_topo	associate edge curves
perpendicular	extend normal to curve if 1, create a curtain surface if 0, or do a parametric extension if 2
connect	connect extension to target surface(s) if set
concat_crvs	clean points on surface edges if set
")


(mk-doc-func
 #'ic_geo_cre_srf_crv_drv_srf 
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
")


(mk-doc-func
 #'ic_geo_get_types 
"
This function returns a list of all geometric entity types available in the loaded geometry. If no geometry is loaded, it returns all possible types: \"surface curve point material density loop\"
")


(mk-doc-func
 #'ic_flood_fill_surface_angle 
"
Returns the list of incident surfaces at curve whose dihedral angle with surf is less than the feat_angle.
")


(mk-doc-func
 #'ic_geo_flood_fill 
"
Returns the list of entities connected by the lower dimension entities. For example surfaces connected by the curves.

    what - 'curve' or 'surface'

    ents - list of type, name pairs

    all - 0 if only one level is desired

    feat_angle - 0 >= theta <= 90, valid only for $what = surface

    bound_mode - 'outer' if only outer loop is desired, valid only for $what = surface

    nedges - for use with curves - if 0 then all attached curves, else only go with curves that have the specified number of attached surfaces
")


(mk-doc-func
 #'ic_geo_get_triangulation_tolerance 
"
Returns a two-element list containing the triangulation tolerance of the model, such that the first element is the tolerance (real number) and the second element is an integer (0 or 1) indicating whether or not the value is relative to a global setting.
")


(mk-doc-func
 #'ic_geo_convex_hull 
"
Creates the convex hull of the objects. entities is a list of pairs, where the first element is the type and the second is the name.
")


(mk-doc-func
 #'ic_geo_remove_triangles_on_plane 
"
Remove triangles on a plane in the named surface.
")


(mk-doc-func
 #'ic_geo_bbox_of_entities 
"
Return the bounding box of some objects. The ents argument is a list of the form {{type name} {type name} ...}
")


(mk-doc-func
 #'ic_geo_classify_by_regions 
"
Used by convex hull.
")


(mk-doc-func
 #'ic_geo_split_surfaces 
"
Used by convex hull.
")


(mk-doc-func
 #'ic_geo_elem_assoc 
"
Generate mesh geometry associativity for CATIA interface.
domain	domain file
assoc	output associativity file
")


(mk-doc-func
 #'ic_geo_cre_bsp_srf_by_pnt_array 
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
")


(mk-doc-func
 #'ic_geo_cre_geom_input 
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
")


(mk-doc-func
 #'ic_geo_import_str_to_cad 
"
Converts structured surface domains to b-spline geometry. If successful, the current mesh and geometry are unloaded, and the new geometry is loaded. Surfaces, curves, and points are created only if families are provided for each argument type. By default, only surfaces will be created.
")


(mk-doc-func
 #'ic_geo_crv_data 
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
")


(mk-doc-func
 #'ic_geo_srf_data 
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
")


(mk-doc-func
 #'ic_geo_cre_srf_loft_crvs 
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
")


(mk-doc-func
 #'ic_geo_cre_crv_test_project_surface 
"
Project a curve to a surface.
family	family for new curve
name	name for new curve (can be \"\")
surface	name of input surface
curve	name of input curve
dir	direction vector

Return value is the name of the new curve.
")


(mk-doc-func
 #'ic_geo_cre_surface_section 
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
")


(mk-doc-func
 #'ic_geo_offset 
"
Offset surface using mesh representation.
")


(mk-doc-func
 #'ic_geo_cre_crv_datred 
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
")


(mk-doc-func
 #'ic_geo_cre_srf_datred 
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
")


(mk-doc-func
 #'ic_geo_cre_srf_sweep 
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
")


(mk-doc-func
 #'ic_geo_crv_is_opposite 
"
Determines whether two curves are oriented in parallel or opposite directions.
crv1	curve 1 name
crv2	curve 2 name
return	1 if opposite, 0 otherwise

Notes:

    Main use of this function is to diagnose failures in some of the surface construction codes.

    For example usage, refer to ic_geo_crv_is_opposite.tcl in the Ansys installation directory under v221/icemcfd/Samples/ProgrammersGuide/med_test.
")


(mk-doc-func
 #'ic_geo_crv_is_edge 
"
Determines whether a curve bounds a surface.
crv	curve name
return	number of surfaces bounded
")


(mk-doc-func
 #'ic_geo_fix_degen_geom 
"
Activates repair function for degenerate bsplines in the tetin reader. For now these functions are disabled by default.
switch	0 for off; 1 for on
")


(mk-doc-func
 #'ic_geo_find_nearest_srf_pnt 
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
")


(mk-doc-func
 #'ic_geo_find_nearest_crv_pnt 
"
Finds parameters of closest point on curve.
crv	name of curve
pnt	test point
return	t parameter

Notes:

    If the function returns with the error status set, the result string will contain an error message.

    The t parameter will be unitized.

    For example usage, refer to ic_geo_find_nearest_crv_pnt.tcl in the Ansys installation directory under v221/icemcfd/Samples/ProgrammersGuide/med_test.
")


(mk-doc-func
 #'ic_geo_distance_from_surfaces 
"
Gets the distance of coords from the nearest surface in surface_family
")


(mk-doc-func
 #'ic_geo_nearest_surface_list 
"
Gets nearest surface to coords from a list of surfaces.
")


(mk-doc-func
 #'ic_geo_get_crv_nrm 
"
Gets the normal vector of a curve at a parameter.
par	curve t parameter
crv	list of curves to evaluate
return	list of 3-tuple of doubles

Notes:

    If the function returns with the error status set, the result string will contain an error message.

    The return string will be a list of 3-tuples

    The input uv coordinates should be unitized.
")


(mk-doc-func
 #'ic_geo_get_crv_pos 
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
")


(mk-doc-func
 #'ic_geo_get_crv_binrm 
"
Gets the binormal vector of a curve at a parameter.
par	curve t parameter
crv	list of curves to evaluate
return	list of 3-tuple of doubles

Notes:

    If the function returns with the error status set, the result string will contain an error message.

    The input uv coordinates should be unitized.
")


(mk-doc-func
 #'ic_geo_cvt_uns_to_bsc 
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
")


(mk-doc-func
 #'ic_geo_srf_area 
"
Computes the area of one or more surfaces.
srfs	list of one or more surfaces
return	area of surfaces

Notes:

    Surface area is computed from projlib's facetization of the geometry; the results will be influenced by the value of the triangulation tolerance when the part was read.

    For example usage, refer to ic_geo_srf_area.tcl in the Ansys installation directory under v221/icemcfd/Samples/ProgrammersGuide/med_test.
")


(mk-doc-func
 #'ic_geo_sort_by_srf_area 
"
Sorts surfaces by their surface area. args is arguments for the sort.
")


(mk-doc-func
 #'ic_geo_reduce_face 
"
Trims a surface back to its active area.
srfs	list of one or more surfaces

Notes:

    A form of data reduction; trims the undisplayed portion of a b-spline away.

    Unless the underlying surface is reduced by at least 5% in the u or v coordinate, the surface will be left unmodified.

    For example usage, refer to ic_geo_reduce_face.tcl in the Ansys installation directory under v221/icemcfd/Samples/ProgrammersGuide/med_test.
")


(mk-doc-func
 #'ic_geo_get_crv_tan 
"
Gets the tangent vector of a curve at a parameter.
par	curve t parameter
crv	list of curves to evaluate
return	list of 3-tuple of doubles

Notes:

    The tangent vector will be the un-normalized derivative vector with respect to the unitized parameterization

    If the function returns with the error status set, the result string will contain an error message.

    The input uv coordinates should be unitized.
")


(mk-doc-func
 #'ic_geo_mod_crv_tanext 
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
")


(mk-doc-func
 #'ic_geo_mod_srf_tanext 
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
")


(mk-doc-func
 #'ic_geo_mod_srf_ext 
"
Extend a surface.
srfs	list of surfaces to extend
dist	distance of extension
edge	curve at edge to extend
return	names of modified surfaces
")


(mk-doc-func
 #'ic_geo_mod_crv_match_crv 
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
")


(mk-doc-func
 #'ic_geo_mod_crv_match_pnt 
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
")


(mk-doc-func
 #'ic_geo_cre_srf_offset 
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
")


(mk-doc-func
 #'ic_geo_build_bodies 
"
Automatically creates a body for each closed volume of surfaces as determined by the connectivity produced from build topology.
fam	Family for bodies
buildtopo	Build topology if non-zero
tol	Tolerance for the optional build topology function
multi	Old style assembly naming if non-zero
newm	Use the new schema if non-zero
surf	Initial surface
")


(mk-doc-func
 #'ic_geo_create_volume 
"
Creates volume from material point name, matlpt.
")


(mk-doc-func
 #'ic_geo_reset_bodies 
"
Updates the current defined bodies in the model, by removing nonexistent ones and adding any new ones to the display.
")


(mk-doc-func
 #'ic_geo_create_body 
"
Creates a body from the collection of surfaces, surfs. The new body will be given the name, name, in the family, fam.
")


(mk-doc-func
 #'ic_geo_get_body_matlpnt 
"
Returns the material point name associated with the body, bdy.
")


(mk-doc-func
 #'ic_geo_srf_radius 
"
Computes the radius of a b-spline surface.
srfs	list of one or more surfaces
return	list of computed surface radii

Notes:

    The radius is the maximum chord length of the control point rows.

    For example usage, refer to ic_geo_cre_srf_offset.tcl in the Ansys installation directory under v221/icemcfd/Samples/ProgrammersGuide/med_test.
")


(mk-doc-func
 #'ic_geo_cre_srf_offset_edge 
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
")


(mk-doc-func
 #'ic_geo_body_lower_entities 
"
Given a body name, bdy, it returns the names of the surfaces, curves, and points belonging to the body. These are returned in the form of argument pairs where the first name is the entity type and the second name is the entity name.
")


(mk-doc-func
 #'ic_geo_cre_geom_plot3d 
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
")


(mk-doc-func
 #'ic_geo_cre_srf_db_pnts 
"
Create the deboor points of a bspline surface.
srfs	list of surfaces
return	names of created points
")


(mk-doc-func
 #'ic_geo_cre_crv_db_pnts 
"
Creates the deboor points of a bspline curve.
crvs	list of curves
return	names of created points
")


(mk-doc-func
 #'ic_geo_read_off_file 
"
Read an OFF file (native format for Geomview).
fam	family for new geometry
name	root name for new surfaces
in_file 	input file

Notes:

    This function reads triangulated surfaces from the input file and creates unstructured surfaces in MED.

    Only minimal coverage of the OFF format has been implemented.

    For example usage, refer to ic_geo_read_off_file.tcl in the Ansys installation directory under v221/icemcfd/Samples/ProgrammersGuide/med_test.
")


(mk-doc-func
 #'ic_geo_read_xyz_file 
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
")


(mk-doc-func
 #'ic_geo_crv_is_arc 
"
Determine whether one or more curves are circular.
crvs	list of one or more curves
tol	approximation tolerance
return	list of true/false flags

Notes:

    The tolerance defaults to 0.001*arc_length

    For example usage, refer to ic_geo_crv_is_arc.tcl in the Ansys installation directory under v221/icemcfd/Samples/ProgrammersGuide/med_test.
")


(mk-doc-func
 #'ic_geo_get_keypoints 
"
Gets keypoints for the current geometry. dir is 0, 1, or 2. If border is non zero, then add some slack.
")


(mk-doc-func
 #'ic_geo_reverse_crv 
"
Reverses the orientation of one or more curves.
crvs	list of one or more curves
return	error message on failure

For example usage, refer to ic_geo_reverse_crv.tcl in the Ansys installation directory under v221/icemcfd/Samples/ProgrammersGuide/med_test.
")


(mk-doc-func
 #'ic_geo_cre_edge_concat 
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
")


(mk-doc-func
 #'ic_geo_create_histogram_box 
"
Make a histogram box.
min	min pt of the box
max	max pt of the box
lblList	list of labels

Notes:

    Each label in lblList is a list of {lbl_text, lbl_pt, ispt}.

    If $ispt==1, a point will be drawn as well as the label.
")


(mk-doc-func
 #'ic_geo_build_topo_on_srfs 
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
")


(mk-doc-func
 #'ic_geo_contact_surfaces 
"
Search for contact surfaces.
surfaces	list of surface names
distance	maximum distance
family	family name for contact surfaces
return	list of surface pairs
")


(mk-doc-func
 #'ic_geo_map_tetin_sizes 
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
")


(mk-doc-func
 #'ic_geo_surface_thickness 
"
Set (or get) the thickness of surfaces.
surfaces	list of surface names
order	order of thickness approximation
thickness	order * order thickness values
")


(mk-doc-func
 #'ic_geo_srf_in_srf_fam_set 
"
Determines whether a surface is within a volume bounded by one or more surface families.
srf	test surface
fams	list of families
")


(mk-doc-func
 #'ic_geo_cre_srf_over_holes 
"
Closes planar holes in a collection of surfaces.
srf	test surface
fams	list of families
")


(mk-doc-func
 #'ic_geo_subset_exists 
"
Checks if a geometry subset exists.
")


(mk-doc-func
 #'ic_geo_subset_copy 
"
Copies the geometry from one subset to another.
")


(mk-doc-func
 #'ic_geo_subset_clear 
"
Clears out everything from a subset.
")


(mk-doc-func
 #'ic_geo_subset_unused_name 
"
Returns an unused geometry subset name with the given prefix Note that this gives names unique for both geometry and mesh.
")


(mk-doc-func
 #'ic_geo_subset_delete 
"
Deletes a geometry subset.
")


(mk-doc-func
 #'ic_geo_subset_visible 
"
Makes a geometry subset visible (or not).
")


(mk-doc-func
 #'ic_geo_subset_list_families 
"
Lists all the families that are represented in the named subset.
")


(mk-doc-func
 #'ic_geo_subset_list 
"
Lists all existing geometry subset names.
")


(mk-doc-func
 #'ic_geo_subset_add_items 
"
Adds items to a geometry subset. If the subset does not exist, it will be created. The items argument is a list of type/name pairs. The types can be one of point, curve, surface, material, density, loop, body, shell, lump, solid, and the names specify the desired object of that type.
")


(mk-doc-func
 #'ic_geo_subset_remove_items 
"
Removes items from a geometry subset. The items list is the same as for ic_geo_subset_add_items.
")


(mk-doc-func
 #'ic_geo_subset_handle_bc_changes 
"
Adds or removes bc icons and groups based on addition or removal of objects in subsets.
")


(mk-doc-func
 #'ic_geo_subset_get_items 
"
Gets items in a geometry subset. This returns a list of type/name pairs.
")


(mk-doc-func
 #'ic_geo_subset_bbox 
"
Returns the bounding box of all geometry in a named subset.
")


(mk-doc-func
 #'ic_geo_subset_add_layer 
"
Adds one or more layers to a geom subset. Arguments are the same as ic_geo_flood_fill.
")


(mk-doc-func
 #'ic_geo_subset_remove_layer 
"
Removes one or more layers from a geometry subset.
")


(mk-doc-func
 #'ic_geo_subset_names_to_parts 
"
Move the contents of all subsets to a part (name of subset)
")


(mk-doc-func
 #'ic_geo_get_srf_edges 
"
Get any curves associated as edges to a surface.
")


(mk-doc-func
 #'ic_geo_get_vert_edges 
"
Get any curves associated as edges to a vertex.
")


(mk-doc-func
 #'ic_geo_calc_bisector_pnt 
"
Calculates node lying on the bisector of the angle formed by nodes pnt1, pnt2, pnt3 in distance delta. If inverse: calculate the reverse bisector.
")


(mk-doc-func
 #'ic_geo_cre_srf_simple_trim 
"
Trims a surface using a simple contour.
families	list of 2 family names
names	list of 2 surface names
srf	surface to trim
crvs	list of trim curves

Notes:

    The specified surface names may be modified to resolve name collisions.

    If the function returns with the error status set, the result string will contain an error message.
")


(mk-doc-func
 #'ic_geo_set_simplification_level 
"
Sets the simplification level in pixels (surfaces smaller than this size will be drawn as a box. 0 disables simplification. A value of -1 just returns the level.
")


(mk-doc-func
 #'ic_surface_thickness_check 
"
Checks for zero thickness surfaces and assigns to new family. newfam is family name for surfaces with no thickness. return_unassigned is option to return unassigned surfaces without changing family. Default (0) is disabled.
")


(mk-doc-func
 #'ic_geo_close_contour 
"
Closes up a contour prior to trimming.
crvs	list of curves
srf	surface to trim

Notes:

    The specified surface names may be modified to resolve name collisions.

    If the function returns with the error status set, the result string will contain an error message.
")


(mk-doc-func
 #'ic_geo_find_srf_prc_pnt 
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
")


(mk-doc-func
 #'ic_geo_get_dormant 
"
Returns list of dormant points or curves.
")


(mk-doc-func
 #'ic_geo_get_dormant_entity 
"
Determines whether an entity is dormant Only points and curves can be dormant synchronized pickable and visible. Used in bounding box.
")


(mk-doc-func
 #'ic_get_facets 
"
Returns list of faceted surfaces.
")


(mk-doc-func
 #'ic_geo_filter_curves 
"
Returns a list of essential curves. A curve is \"essential\" when it bounds two surfaces which meet at an angle (measured by surface normals) exceeding a threshold angle. The function identifies the essential curves in the specified families.
angle	threshold angle in degrees
fams	names of families to search
")


(mk-doc-func
 #'ic_geo_cre_bridge_crv 
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
")


(mk-doc-func
 #'ic_geo_cre_pln_crv 
"
Creates the projection of a curve onto a plane.
fam	family of created curve
name	name of created curve
crv1	curve name
return	name of created curve
")


(mk-doc-func
 #'ic_geo_pln_n_pnts 
"
Finds the least square plane through three or more points.
pnts	list of 3 or more points
return	{base} {normal} of plane
")


(mk-doc-func
 #'ic_geo_sub_get_numbers_by_names 
"
Returns each entity number (recognized in the batch interpreter) associated with each entity name in ent_names. ent_names can be a list but they must all be the same type defined by type. In this case, the return is a list of numbers in the same order as the entity names were given.
")


(mk-doc-func
 #'ic_geo_get_pnt_marked 
"
Determines whether a point is marked.
")


(mk-doc-func
 #'ic_geo_set_pnt_marked 
"
Sets the marked flag on a point.
")


(mk-doc-func
 #'ic_geo_get_all_marked_pnts 
"
Returns a list of all marked points.
")


(mk-doc-func
 #'ic_geo_add_embedded_crv 
"
Embeds a curve into a surface.
srf	surface
crvs	list of curves

Note:   No checks are performed to determine whether the curves are on the surface.
")


(mk-doc-func
 #'ic_geo_add_embedded_pnt 
"
Embeds a point into a surface.
srf	surface
pnts	list of points

Note:   No checks are performed to determine whether the points are on the surface.
")


(mk-doc-func
 #'ic_geo_is_crv_on_srf 
"
Checks if a curve is on a surface.
crv	curve
srf	surface
tol	tolerance

Note:   If a negative value is passed for the tolerance, the utility will use an internally computed tolerance.
")


(mk-doc-func
 #'ic_geo_register_crv 
"
Register a curve (this is used by Ansys TurboGrid)
crv_name	name of created curve
")


(mk-doc-func
 #'ic_geo_cre_midline_crv 
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
")


(mk-doc-func
 #'ic_geo_get_points_from_curves 
"
This finds all the points attached to a list of curves.
")


(mk-doc-func
 #'ic_geo_test_cmd 
"
Test routine.
")


(mk-doc-func
 #'ic_geo_cre_crv_ell 
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
")


(mk-doc-func
 #'ic_geo_improve_edge 
"
Improves one or more edges.
crvs	list of one or more curves
")


(mk-doc-func
 #'ic_geo_just_do_it 
"
Surface test routine.
srfs	list of one or more surfaces
")


(mk-doc-func
 #'ic_geo_get_prism_families 
"
Returns the list of families for prism meshing.
")


(mk-doc-func
 #'ic_geo_set_prism_families 
"
Sets the list of families for prism meshing. If excl==1, then any previous prism families are reset.
")


(mk-doc-func
 #'ic_geo_get_prism_family_params 
"
Returns the prism meshing parameters for a family.
")


(mk-doc-func
 #'ic_geo_set_prism_family_params 
"
Sets the prism meshing parameters for a family.
")


(mk-doc-func
 #'ic_geo_create_tglib_sfbgrid 
"
Reads a TGLib size function background grid.

Usage: ic_hex_create_tglib_size_functions-tglib_sfbgrid_filefname-remove_existing-create_callbacks

e.g.,: eval ic_hex_create_tglib_size_functions -tglib_sfbgrid_file ./example.sf -remove_existing

Argument Descriptions:
-tglib_sfbgrid_file	full path to a tglib size function background grid file

Optional arguments:
-remove_existing	An existing size function background grid will be removed
-create_callbacks	Callback functions will be set for the usage of the size functions in e.g. the paver
")


(mk-doc-func
 #'ic_vcalc 
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
")


(mk-doc-func
 #'ic_highlight 
"
Temporary change color and/or \"width\" of points, curves, surfaces

    color white or red or green. Default color: family color.

    width 1 or 2 or 3. Default width: 1.

    names list of names. If list is empty, default settings will be restored
")


(mk-doc-func
 #'ic_vset
 "
ic_vset options/parameters : return ic_vset -names : all names* ic_vset -names type : names of that type ic_vset -method : all methods ic_vset -method type : methods for that type ic_vset -method type method : format of the method of the type ic_vset -method name : method for that name (if not default) ic_vset -database : all names of databases with items number ic_vset -database dname : make selected database current ic_vset name : empty line if not defined**, or value (if any) ic_vset name def : for variable set new definition ic_vset -type name : type of entity ic_vset -def name : definition of entity ic_vset -info name : detailed info on entity ic_vset -settings debug : return current debug level ic_vset -settings debug value : set current debug level ic_vset -settings med_pts : current med points usage option ic_vset -settings med_pts value : set current med points usage option ic_vset -settings interrupt value : set 0/1 interrupt design creation (ic_vcreate) ic_vset -vec - vec.expr. : calculate ï¿½anonymousï¿½ vector expression ic_vset -con - con.expr. : calculate ï¿½anonymousï¿½ constraint expression ic_vset - expression : calculate expression without database modification ic_vset -delete name : delete entity ic_vset -delete all : delete all entities in active database ic_vset : (without parameters) return last result or last reason for error** * options may be abbreviated to 3 or more characters: -nam, -met, -dat, -setï¿½ ** most commands return empty line on invalid input

ic_vdefine name type method_name* definition

ic_vfile read filename : read Vid file into current database ic_vfile write filename : write current database into Vid file

## if {$npts == 2} {set pts [list $pts]}
")

(mk-doc-func
 #'ic_curve 
 "
Create a bspline arc.

Usage: From a center point and two points: ic_curvearc_ctr_rad PART_NAME NEW_CURVE_NAME {CENTER_POINT POINT_1 POINT_2 0.0 \"\" \"\" 0}

From a center point and two points and radius: ic_curvearc_ctr_rad PART_NAME NEW_CURVE_NAME {CENTER_POINT POINT_1 POINT_2 RADIUS \"\" \"\" 0} Note: in case of a radius of 0.0, the arc radius will be calculated from the distance between CENTER_POINT and POINT_1

From start/end points: ic_curvearc_ctr_rad PART_NAME NEW_CURVE_NAME {POINT_1 POINT_2 POINT_3 0.0 \"\" \"\" 1}

From start/end points and radius: ic_curvearc_ctr_rad PART_NAME NEW_CURVE_NAME {POINT_1 POINT_2 POINT_3 RADIUS \"\" \"\" 1}
")
  

(mk-doc-func
    #'ic_geo_get_crv_data_at_par 
"
Returns the curve data at a parameter.
par	curve parameter
crv	curve name
return	list of 4 triplets: location, and 3 normalized vectors — tangent, direction to curve center, direction normal to curve plane
return	empty line if curve does not exist

Notes:

    For faceted curves result is parametric approximation of the curve.

    Direction to center and normal plane may be {0 0 0} if not defined, e.g. for line.


")

(mk-doc-func
 #'ic_geo_cre_pnt 
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
")

(mk-doc-func
 #'ic_geo_create_unstruct_curve_from_points
 "
Creates a piecewise linear curve from the points. This curve is
given the specified name and family. pts is a list of triples of
floating point numbers or list of prescribed point names and they are
connected in order. The points are in the current local coordinate
system.
")

(mk-doc-func
 #'ic_geo_cre_line 
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
")

(mk-doc-func
 #'ic_geo_cre_arc_from_pnts
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
")

(mk-doc-func
 #'ic_geo_cre_bsp_crv_n_pnts
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
")

(mk-doc-func
 #'ic_geo_cre_bsp_crv_n_pnts_cons
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
 )

(mk-doc-func
 #'ic_geo_cre_srf_cyl
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
")

(mk-doc-func
 #'ic_geo_cre_mat
  "    
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
")
