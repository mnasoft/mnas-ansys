;;;; ./src/icem/boundary.lisp

(defpackage #:mnas-ansys/icem/boundary
  (:use #:cl)
  (:export ic_boco_load
           ic_boco_load_atr
           ic_boco_save
           ic_boco_save_atr
           ic_boco_is_loaded
           ic_boco_is_modified
           ic_boco_set_modified
           ic_boco_unload
           ic_empty_boco
           ic_boco_solver
           ic_boco_get
           ic_get_boco
           ic_boco_set
           ic_boco_append
           ic_boco_modify
           ic_boco_delete_bctypes
           ic_set_boco
           ic_boco_delete_all_bctype
           ic_boco_bctypes_used_by_families
           ic_boco_list_with_bctype
           ic_boco_classify_by_bctype
           unused__ic_boco_groups_with_bctype
           ic_boco_list_bcargs_for_bctypes
           unused__ic_boco_get_with_matching_name
           unused__ic_boco_get_unused_bcarg
           ic_boco_get_unused_group
           unused__ic_boco_replace_with_matching_name
           ic_boco_replace_in_part
           ic_boco_replace_in_group
           ic_boco_add
           ic_boco_replace
           ic_boco_get_for_tetin
           ic_boco_reload
           ic_boco_list_families
           ic_boco_list_families_only
           ic_boco_fam_dim
           ic_boco_parts_dim
           ic_boco_reset_fam_dim
           ic_boco_clear_icons
           ic_boco_rename_family
           ic_boco_add_icon
           ic_boco_apply_attr_symbol
           ic_boco_set_attr_symbol_group_visible
           ic_boco_add_attr_symbol
           ic_boco_delete_attr_symbol
           ic_boco_list_attr_symbols
           ic_boco_modify_attr_symbol_params
           ic_boco_modify_attr_symbol_label
           ic_boco_modify_attr_symbol_visible
           ic_boco_apply_solver_icon_to_group
           ic_boco_apply_solver_icon_to_part
           ic_boco_delete_icons_for_bctypes
           ic_boco_set_family_visible
           ic_boco_remove_objects_from_groups
           ic_boco_add_parts_and_subsets_to_group
           ic_boco_what_groups_go_with_part_or_subset
           ic_boco_change_part
           ic_boco_change_subset
           ic_boco_add_or_remove_bc_icons
           ic_boco_replace_arg
           ic_boco_delete_group_with_bcs
           ic_boco_list_icons
           ic_boco_delete_group
           ic_boco_clear_family
           ic_boco_set_part_color
           ic_boco_nastran_csystem
           ic_boco_delete_unused
           ic_boco_list_unused
           ic_boco_get_fams_of_part
           ic_boco_get_part_of_fam
           ic_solver_mesh_info
           )
  (:documentation
   " Пакет содержит функции для редактирования и изменения граничных условий."
   ))

(in-package #:mnas-ansys/icem/boundary)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun ic_boco_load (file)
  "
Loads in the boundary condition data from the file.
"
  (format
   t
   "ic_boco_load ~S~%"
   file))

(defun ic_boco_load_atr (file)
  "
Loads in the attribute data from the file.
"
  (format
   t
   "ic_boco_load_atr ~S~%" file))

(defun ic_boco_save (file)
  "
Saves the current boundary condition data to the given file name.
"
  (format
   t
   "ic_boco_save ~S~%" file))

(defun ic_boco_save_atr (file &optional (ss ""))
  "
Saves a new format bc (.atr) file.
"
  (format
   t
   "ic_boco_save_atr ~S ~A~%" file ss))

(defun ic_boco_is_loaded ()
  "
Checks if a family boco file has been loaded.
"
  (format
   t
   "ic_boco_is_loaded~%"))

(defun ic_boco_is_modified ()
  "
Checks if the current boco data has been modified since the last save.
"
  (format
   t
   "ic_boco_is_modified~%"))

(defun ic_boco_set_modified ()
  "
Forces the current boco data to be dirty.
"
  (format
   t
   "ic_boco_set_modified~%"))

(defun ic_boco_unload ()
  "
Unloads the current family boco data.
"
  (format
   t
   "ic_boco_unload~%"))

(defun ic_empty_boco ()
  "
Creates an empty boco database.
"
  (format
   t
   "ic_empty_boco~%"))

(defun ic_boco_solver (&optional (solver ""))
  " Sets the default solver for an existing boco database. If no solver
is given, then it returns the current solver setting.
"
  (format
   t
   "ic_boco_solver ~S~%" solver))

(defun ic_boco_get (&optional (fambctypes "") (not_bctypes ""))
  " Gets the boundary conditions associated with the given family. They
are returned as a list, each element is one boco. Each boco element is
a list where the first element is 0 or 1 whether the data is active or
not, the second is the type, such as WALL or INT, and the rest are the
parameters. For information about what the available types and
parameters are, see the Solver Parameters and Boundary Condition Data
section for the solver you are interested in. If the bctypes argument
is given then only the matching boundary conditions are returned.
"
  (format
   t
   "ic_boco_get ~S ~S~%" fambctypes not_bctypes))
  
(defun ic_get_boco (fam)
  "
This is the same as ic_boco_get (for backward compatibility only).
"
  (format
   t
   "ic_get_boco ~S~%" fam))

(defun ic_boco_set (fam bocos)
  " Sets the boundary conditions associated with the given
family. They must be given as a list, each element is one boco. Each
boco element is a list where the first element is 0 or 1 whether the
data is active or not, the second is the type, such as WALL or INT,
and the rest are the parameters. For information about what the
available types and parameters are, see the Solver Parameters and
Boundary Condition Data section for the solver you are interested in.
"
  (format
   t
   "ic_boco_set ~S ~S~%" fam bocos))

(defun ic_boco_append (fam nbcs)
  "
Appends some boundary conditions.
"
  (format
   t
   "ic_boco_append ~S ~S~%" fam nbcs))

(defun ic_boco_modify (fam obc nbc)
  "
Changes one boundary condition.
"
  (format
   t
   "ic_boco_modify ~S ~S ~S~%" fam obc nbc))

(defun ic_boco_delete_bctypes (fam bctypes)
  "
Deletes boundary conditions with a given set of types from a family.
"
  (format
   t
   "ic_boco_delete_bctypes ~S ~S~%" fam bctypes))

(defun ic_set_boco (fam bocos)
  "
This is the same as ic_boco_get (for backward compatibility only).
"
  (format
   t
   "ic_set_boco (fam bocos)"))

(defun ic_boco_delete_all_bctype (bctype)
  "
Deletes all boundary conditions on all families of a given type.
"
  (format
   t
   "ic_boco_delete_all_bctype ~S~%" bctype))

(defun ic_boco_bctypes_used_by_families (&optional (which ""))
  " Returns a list of bctype famlist bctype famlist ... pairs If which
is \"\" then all BCs are returned, otherwise only those that show up in
the list. A family could possibly appear twice in the famlist if it
has the BC twice.
"
  (format
   t
   "ic_boco_bctypes_used_by_families ~S~%" which))


(defun ic_boco_list_with_bctype (bcargs &optional (exclude_fam_pattern ""))
  " Lists all families and BCs that have a BC of a given type. If
bctype is a list then it will match the second, etc argument. Glob
characters are allowed here. If exclude_fam_pattern is non-\"\" skip
families that match that pattern. Generally this will be *:* .
"
  (format
   t
   "ic_boco_list_with_bctype ~S ~S~%" bcargs exclude_fam_pattern))

(defun ic_boco_classify_by_bctype (bctype &optional (exclude_fam_pattern ""))
  "
Lists the families by bctype.
"
  (format
   t
   "ic_boco_classify_by_bctype ~S ~S~%" bctype exclude_fam_pattern))

(defun unused__ic_boco_groups_with_bctype (bcargs &optional (exclude "*:*"))
  " A convenience function that just returns the group names with a
specific set of bc args For example ic_boco_groups_with_bctype [list
FORCE_NAME ff1]
"
  (format
   t
   "unused__ic_boco_groups_with_bctype ~S ~S~%" bcargs exclude))

(defun ic_boco_list_bcargs_for_bctypes (types pos)
  " Gets all the possible values for an argument at a specific
position for a list of bctypes. This is used to get a list of load
sets.
"
  (format
   t
   "ic_boco_list_bcargs_for_bctypes ~S ~S~%" types pos))

(defun unused__ic_boco_get_with_matching_name (t1s t2 v2)
  " Returns the BCs of the types t1s, which are in families whose BC of
type t2 has value v2. (e.g.,. t1s might be {BR BT}, t2 might be
CONSTRAINT_NAME, and v2 might be \"foo 123\". Used for ai*env. Note that
this automatically *excludes* families with : in them.
"
  (format
   t
   "unused__ic_boco_get_with_matching_name (t1s t2 v2)"))

(defun unused__ic_boco_get_unused_bcarg (bctype prefix)
  "
Gets an unused name for a given BC type.
"
  (format
   t
   "unused__ic_boco_get_unused_bcarg ~S ~S~%" bctype prefix))

(defun ic_boco_get_unused_group (prefix &optional (avoid ""))
  " Gets an unused name with a given prefix. Avoid the ones given in the
second argument
"
  (format
   t
   "ic_boco_get_unused_group ~S ~S~%" prefix avoid))

(defun unused__ic_boco_replace_with_matching_name (newbcs t2 v2 &optional (replace_these ""))
  " Finds all families that have a bctype named t2 with a value v2 and
replaces the existing BCs that have types in newbcs with the new
ones. (Ie.g.,. t1s might be {{1 BR 1 2 3} ...}, t2 might be
CONSTRAINT_NAME, and v2 might be \"foo 123\". Used for ai*env. Note that
this automatically *includes* families with : in them. If a value is
given for replace_these it should be a list of bctypes to get rid of,
else the types are taken from newbcs. Returns the families that were
so modified.
"
  (format
   t
   "unused__ic_boco_replace_with_matching_name ~S ~S ~S ~S~%" newbcs t2 v2 replace_these))

(defun ic_boco_replace_in_part (newbcs part &optional (replace_these ""))
  "
Same as above but does it for all families in a part.
"
  (format
   t
   "ic_boco_replace_in_part ~S ~S ~S~%" newbcs part replace_these))

(defun ic_boco_replace_in_group (newbcs group &optional (replace_these ""))
  "
Same as above but does it for all families in a group.
"
  (format
   t
   "ic_boco_replace_in_group ~S ~S ~S~%" newbcs group replace_these))

(defun ic_boco_add (fam bocos)
  "
Adds some BCs to a family.
"
  (format
   t
   "ic_boco_add ~S ~S~%" fam bocos))

(defun ic_boco_replace (fam bcarg newbcs)
  "
Replaces some BCs for a family.
"
  (format
   t
   "ic_boco_replace ~S ~S ~S~%" fam bcarg newbcs))

(defun ic_boco_get_for_tetin ()
  "
Returns the current default family_boco file which was loaded (if any).
"
  (format
   t
   "ic_boco_get_for_tetin~%"))

(defun ic_boco_reload ()
  "
Reloads the family boco file which has already been loaded (if any).
"
  (format
   t
   "ic_boco_reload~%"))

(defun ic_boco_list_families (&optional (pat ""))
  " Lists the current families which have boundary conditions associated
with them. A pattern may be given that limits the families to those
matching the pattern, as part of a :-separated list. pat may also be
!: which means no : characters.
"
  (format
   t
   "ic_boco_list_families ~S~%" pat))
  
(defun ic_boco_list_families_only ()
  "
Changes the family_boco file that is associated with the tetin file.
"
  (format
   t
   "ic_boco_list_families_only~%"))

(defun ic_boco_fam_dim (fam &optional (all_dim 0))
  "
Returns the dimension of the family. 

--------------------------------------------------------------------------------
Note: See the next function. If there is more than one type of element
in the family then the return value will be mixed unless the all_dim
parameter is set to 1
--------------------------------------------------------------------------------
"
  (format
   t
   "ic_boco_fam_dim ~S ~S~%" fam all_dim))

(defun ic_boco_parts_dim (parts)
  "
Returns the dimensions of the part.
"
  (format
   t
   "ic_boco_parts_dim ~S~%" parts))

(defun ic_boco_reset_fam_dim ()
  "
Warning: hack ...

If you call ic_boco_fam_dim, then you change something, and then you
call it again, you will get the old data. This is because the
list_families_and_dimensions_and_sides function is too slow so the
results have to be cached. As a temporary workaround, call
ic_boco_reset_fam_dim to clear out the old data.
"
  (format
   t
   "ic_boco_reset_fam_dim~%"))

(defun ic_boco_clear_icons ()
  "
Deletes all the BC icons that currently exist.
"
  (format
   t
   "ic_boco_clear_icons~%"))

(defun ic_boco_rename_family (old new)
  "
Renames a family - this has to move all the icons
"
  (format
   t
   "ic_boco_rename_family ~S ~S~%" old new))

(defun ic_boco_add_icon (type fam icontype locations scale maxnum color label params vis only_dims)
  "
Creates a new BC icon for a given family. The arguments are: 

type : the kind of BC, such as \"temperature\", \"pressure\", etc. If
another icon of the same type and family is already there it will be
deleted. In general this could be the bctype of the BC that this icon
represents.

fam: the family name.


icontype: the shape of the icon to draw. These are listed below.

locations: the XYZ locations of where the icons should be drawn. If
this list is empty then they will be automatically computed. This list
can also be a geometry type, \"geometry\" or \"unsmap\". That
restricts the automatic computation to that object.

scale: a size scale for the icons. Default is 1.0

maxnum: the maximum number of icons to draw. If there are more nodes
or elements than this value then just one icon will be drawn at the
centroid of the family. 0 means no limits.

color: the color to use for the icon.

params: depends on the icontype value as described below.

The different icon shape types are as follows:

arrow: draw an arrow. The params are: 

direction: an XYZ triple that gives the arrow's direction

nheads_end: how many heads to draw at the end. If this value is 0 then
no head will be drawn. If it's -1 then a X will be drawn.

open_end: should the heads be open, if arrows are drawn, and if nheads
is -1 then this is the linewidth to use when drawing the X

nheads_start (optional) : how many heads to draw at the start

open_start (optional) : should the heads be open at the start.

circle: draw a circle. The params are: 

pixels: the size of the circle

open: if 0 the circle is filled, if 1 it is wireframe

triangle: draw a triangle (like a constraint). The params are: 

pixels: the size of the triangle

open: if 0 the triangle is filled, if 1 it is wireframe

tail: draw a tail on it

helix: draw a spring-like helix. The params are: 

ntwists: the number of twists

radius: the radius as a factor of the length
"
  (format
   t
   "ic_boco_add_icon ~S ~S ~S ~S ~S ~S ~S ~S ~S ~S ~S~%" type fam icontype locations scale maxnum color label params vis only_dims))

(defun ic_boco_apply_attr_symbol (group bctype setname icontype parsed params labels vis lvis)
  "
Smarter wrapper around the below functions.
"
  (format
   t
   "ic_boco_apply_attr_symbol ~S ~S ~S ~S ~S ~S ~S ~S ~S~%" group bctype setname icontype parsed params labels vis lvis))

(defun ic_boco_set_attr_symbol_group_visible (group bctype vis lvis)
  "
Easier way to set visibility by group and bctype
"
  (format
   t
   "ic_boco_set_attr_symbol_group_visible ~S ~S ~S ~S~%" group bctype vis lvis))

(defun ic_boco_add_attr_symbol (bctype group icontype set params label vis lvis)
  " The new version which can pull out distributed values from nodes and
elements. type is the bctype this corresponds to. group is the group
or part this attaches to. icontype is arrow, helix, etc. set controls
how new symbols replace old ones. params is a list of {name value
expr} tuples. expr is a list of bcfield names that get multiplied
together. label is a list of text, paramname, text, paramname .. that
gets concatenated. vis is a flag saying whether it should be initially
visible or not. lvis is 1 if the label should be drawn once, 0 not, 2
on all points Return value is a symbol id that can be used in the
functions below.
"
  (format
   t
   "ic_boco_add_attr_symbol ~S ~S ~S ~S ~S ~S ~S ~S~%" bctype group icontype set params label vis lvis))

(defun ic_boco_delete_attr_symbol (id)
  "
Deletes a symbol.
"
  (format
   t
   "ic_boco_delete_attr_symbol ~S~%" id))

(defun ic_boco_list_attr_symbols (&optional (bctype "") (group "") (set ""))
  "
Lists symbols.
"
  (format
   t
   "ic_boco_list_attr_symbols ~S ~S ~S~%" bctype group set))

(defun ic_boco_modify_attr_symbol_params (id params)
  "
Modifies params.
"
  (format
   t
   "ic_boco_modify_attr_symbol_params ~S ~S~%" id params))

(defun ic_boco_modify_attr_symbol_label (id label)
  "
Modifies labels.
"
  (format
   t
   "ic_boco_modify_attr_symbol_label ~S ~S~%" id label))

(defun ic_boco_modify_attr_symbol_visible (id vis lvis)
  "
Modifies visibility.
"
  (format
   t
   "ic_boco_modify_attr_symbol_visible ~S ~S ~S~%" id vis lvis))

(defun ic_boco_apply_solver_icon_to_group (group bctype icontype iconparams vis &optional (bcargs ""))
  "
Applies a solver specific icon to a particular group.
"
  (format
   t
   "ic_boco_apply_solver_icon_to_group ~S ~S ~S ~S ~S ~S~%" group bctype icontype iconparams vis bcargs))

(defun ic_boco_apply_solver_icon_to_part (part bctype icontype iconparams vis &optional (bcargs ""))
  "
Applies a solver specific icon to a particular part.

unused__ic_boco_set_visible bcargs bctypes on

Sets the icon visibility. bcargs are something like FORCE_NAME F1
"
  (format
   t
   "ic_boco_apply_solver_icon_to_part ~S ~S ~S ~S ~S ~S~%" part bctype icontype iconparams vis bcargs))

(defun ic_boco_delete_icons_for_bctypes (fam bctypes)
  " Removes the icons for a particular family/bctype combination.
"
  (format
   t
   "ic_boco_delete_icons_for_bctypes ~S ~S~%" fam bctypes))

(defun ic_boco_set_family_visible (fams bctypes on)
  " Sets the icon visibility by family. If fams is empty then this
implies all families.
"
  (format
   t
   "ic_boco_set_family_visible ~S ~S ~S~%" fams bctypes on))

(defun ic_boco_remove_objects_from_groups (objlist bcargs)
  "
Removes the given objects from all groups that have a BC with a specified name.
"
  (format
   t
   "ic_boco_remove_objects_from_groups ~S ~S~%" objlist bcargs))

(defun ic_boco_add_parts_and_subsets_to_group (name parts_or_subsets)
  " Adds the parts and subsets to the APPLY_TO_PARTS and
APPLY_TO_SUBSETS pseudo-BC's on the named group.
"
  (format
   t
   "ic_boco_add_parts_and_subsets_to_group ~S ~S~%" name parts_or_subsets))

(defun ic_boco_what_groups_go_with_part_or_subset (type name)
  "
This routine is called when objects are moved into and out of parts and subsets.
"
  (format
   t
   "ic_boco_what_groups_go_with_part_or_subset ~S ~S~%" type name))

(defun ic_boco_change_part (oldfam newpart)
  "
Utility function to move stuff from one part to another.
"
  (format
   t
   "ic_boco_change_part ~S ~S~%" oldfam newpart))

(defun ic_boco_change_subset (oldfam subset add)
  " For a given family, if you move something in that family into or
out of a subset, this returns the new family.
"
  (format
   t
   "ic_boco_change_subset ~S ~S ~S~%" oldfam subset add))

(defun ic_boco_add_or_remove_bc_icons (on_fam add objects)
  " For every icon on family oldfam, remove the locations of the
objects. For every icon on newfam, add the locations.
"
  (format
   t
   "ic_boco_add_or_remove_bc_icons ~S ~S ~S~%" on_fam add objects))

(defun ic_boco_replace_arg (fams replace_types replace_pos replace_val)
  " Replaces a certain argument in the BCs for a given set of families
with a different value.
"
  (format
   t
   "ic_boco_replace_arg ~S ~S ~S ~S~%" fams replace_types replace_pos replace_val))

(defun ic_boco_delete_group_with_bcs (bcargs)
  " Removes everything from groups that have a specific bctype and set
of arguments, and delete those groups. Note that this will never get
called with part groups.
"
  (format
   t
   "ic_boco_delete_group_with_bcs ~S~%" bcargs))

(defun ic_boco_list_icons (&optional (fam "") (type ""))
  "
Lists all the BC icons.
"
  (format
   t
   "ic_boco_list_icons ~S ~S~%" fam type))

(defun ic_boco_delete_group (group)
  "
Removes everything from groups and delete those groups.
"
  (format
   t
   "ic_boco_delete_group ~S~%" group))

(defun ic_boco_clear_family (fam)
  "
Clears the BCs and icons from one family.
"
  (format
   t
   "ic_boco_clear_family ~S~%" fam))

(defun ic_boco_set_part_color (famname &optional (update_uns 1))
  " Looks for a group inside this family that is a part name, and define
the color of the family based on the value of the name. Note that it
takes only the last component of the part name so that things don't
shift around when you put them in assemblies.
"
  (format
   t
   "ic_boco_set_part_color ~S ~S~%" famname update_uns))

(defun ic_boco_nastran_csystem (what args)
  "
Sets Nastran-type coordinate systems.
"
  (format
   t
   "ic_boco_nastran_csystem ~S ~S~%" what args))

(defun ic_boco_delete_unused (keep_groups)
  "
Cleans up the set of BCs a bit. Keeps the singleton groups if keep_groups is 1.
"
  (format
   t
   "ic_boco_delete_unused ~S~%" keep_groups))

(defun ic_boco_list_unused ()
  "
Lists the families that have no mesh or geometry in them.
"
  (format
   t
   "ic_boco_list_unused~%"))

(defun ic_boco_get_fams_of_part (partname)
  "
Returns the list of families belonging to the given partname.
"
  (format
   t
   "ic_boco_get_fams_of_part ~S~%" partname))

(defun ic_boco_get_part_of_fam (famname)
  "
Returns the part to which the given family famname belongs.
"
  (format
   t
   "ic_boco_get_part_of_fam ~S~%" famname))

(defun ic_solver_mesh_info (solver)
  ""
  (format
   t
   "ic_solver_mesh_info ~S~%" solver))
