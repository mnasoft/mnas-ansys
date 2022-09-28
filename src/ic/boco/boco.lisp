;;;; ./src/icem/boundary.lisp

(defpackage #:ic/boco
  (:use #:cl)
  (:export load
           load-atr
           save
           save-atr
           is-loaded
           is-modified
           set_modified
           unload
           empty-boco
           solver
           get
           get-boco
           set
           append
           modify
           delete-bctypes
           set-boco
           delete-all-bctype
           bctypes-used-by-families
           list-with-bctype
           classify-by-bctype
           unused-groups-with-bctype
           list-bcargs-for-bctypes
           unused-get-with-matching-name
           unused-get-unused-bcarg
           get-unused-group
           unused-replace-with-matching-name
           replace-in-part
           replace-in-group
           add
           replace
           get-for-tetin
           reload
           list-families
           list-families-only
           fam-dim
           parts-dim
           reset-fam-dim
           clear-icons
           rename-family
           add-icon
           apply-attr-symbol
           set-attr-symbol-group-visible
           add-attr-symbol
           delete-attr-symbol
           list-attr-symbols
           modify-attr-symbol-params
           modify-attr-symbol-label
           modify-attr-symbol-visible
           apply-solver-icon-to-group
           apply-solver-icon-to-part
           delete-icons-for-bctypes
           set-family-visible
           remove-objects-from-groups
           add-parts-and-subsets-to-group
           what-groups-go-with-part-or-subset
           change-part
           change-subset
           add-or-remove-bc-icons
           replace-arg
           delete-group-with-bcs
           list-icons
           delete-group
           clear-family
           set-part-color
           nastran-csystem
           delete-unused
           list-unused
           get-fams-of-part
           get-part-of-fam
           solver-mesh-info
           )
  (:documentation
   " Пакет содержит функции для редактирования и изменения граничных
   условий (Boundary Condition Editing and Modification Functions)."))

(in-package #:ic/boco)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun load (file)
  "
Loads in the boundary condition data from the file.
"
  (format
   t
   "ic_boco_load ~S~%"
   file))

(defun load-atr (file)
  "
Loads in the attribute data from the file.
"
  (format
   t
   "ic_boco_load_atr ~S~%" file))

(defun save (file)
  "
Saves the current boundary condition data to the given file name.
"
  (format
   t
   "ic_boco_save ~S~%" file))

(defun save-atr (file &optional (ss ""))
  "
Saves a new format bc (.atr) file.
"
  (format
   t
   "ic_boco_save_atr ~S ~A~%" file ss))

(defun is-loaded ()
  "
Checks if a family boco file has been loaded.
"
  (format
   t
   "ic_boco_is_loaded~%"))

(defun is-modified ()
  "
Checks if the current boco data has been modified since the last save.
"
  (format
   t
   "ic_boco_is_modified~%"))

(defun set-modified ()
  "
Forces the current boco data to be dirty.
"
  (format
   t
   "ic_boco_set_modified~%"))

(defun unload ()
  "
Unloads the current family boco data.
"
  (format
   t
   "ic_boco_unload~%"))

(defun empty-boco ()
  "
Creates an empty boco database.
"
  (format
   t
   "ic_empty_boco~%"))

(defun solver (&optional (solver ""))
  " Sets the default solver for an existing boco database. If no solver
is given, then it returns the current solver setting.
"
  (format
   t
   "ic_boco_solver ~S~%" solver))

(defun get (&optional (fambctypes "") (not_bctypes ""))
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
  
(defun get-boco (fam)
  "
This is the same as ic_boco_get (for backward compatibility only).
"
  (format
   t
   "ic_get_boco ~S~%" fam))

(defun set (fam bocos)
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

(defun append (fam nbcs)
  "
Appends some boundary conditions.
"
  (format
   t
   "ic_boco_append ~S ~S~%" fam nbcs))

(defun modify (fam obc nbc)
  "
Changes one boundary condition.
"
  (format
   t
   "ic_boco_modify ~S ~S ~S~%" fam obc nbc))

(defun delete-bctypes (fam bctypes)
  "
Deletes boundary conditions with a given set of types from a family.
"
  (format
   t
   "ic_boco_delete_bctypes ~S ~S~%" fam bctypes))

(defun set-boco (fam bocos)
  "
This is the same as ic_boco_get (for backward compatibility only).
"
  (format
   t
   "ic_set_boco (fam bocos)"))

(defun delete-all-bctype (bctype)
  "
Deletes all boundary conditions on all families of a given type.
"
  (format
   t
   "ic_boco_delete_all_bctype ~S~%" bctype))

(defun bctypes-used-by-families (&optional (which ""))
  " Returns a list of bctype famlist bctype famlist ... pairs If which
is \"\" then all BCs are returned, otherwise only those that show up in
the list. A family could possibly appear twice in the famlist if it
has the BC twice.
"
  (format
   t
   "ic_boco_bctypes_used_by_families ~S~%" which))


(defun list-with-bctype (bcargs &optional (exclude_fam_pattern ""))
  " Lists all families and BCs that have a BC of a given type. If
bctype is a list then it will match the second, etc argument. Glob
characters are allowed here. If exclude_fam_pattern is non-\"\" skip
families that match that pattern. Generally this will be *:* .
"
  (format
   t
   "ic_boco_list_with_bctype ~S ~S~%" bcargs exclude_fam_pattern))

(defun classify-by-bctype (bctype &optional (exclude_fam_pattern ""))
  "
Lists the families by bctype.
"
  (format
   t
   "ic_boco_classify_by_bctype ~S ~S~%" bctype exclude_fam_pattern))

(defun unused-groups-with-bctype (bcargs &optional (exclude "*:*"))
  " A convenience function that just returns the group names with a
specific set of bc args For example ic_boco_groups_with_bctype [list
FORCE_NAME ff1]
"
  (format
   t
   "unused__ic_boco_groups_with_bctype ~S ~S~%" bcargs exclude))

(defun list-bcargs-for-bctypes (types pos)
  " Gets all the possible values for an argument at a specific
position for a list of bctypes. This is used to get a list of load
sets.
"
  (format
   t
   "ic_boco_list_bcargs_for_bctypes ~S ~S~%" types pos))

(defun unused-get-with-matching-name (t1s t2 v2)
  " Returns the BCs of the types t1s, which are in families whose BC of
type t2 has value v2. (e.g.,. t1s might be {BR BT}, t2 might be
CONSTRAINT_NAME, and v2 might be \"foo 123\". Used for ai*env. Note that
this automatically *excludes* families with : in them.
"
  (format
   t
   "unused__ic_boco_get_with_matching_name (t1s t2 v2)"))

(defun unused-get-unused-bcarg (bctype prefix)
  "
Gets an unused name for a given BC type.
"
  (format
   t
   "unused__ic_boco_get_unused_bcarg ~S ~S~%" bctype prefix))

(defun get-unused-group (prefix &optional (avoid ""))
  " Gets an unused name with a given prefix. Avoid the ones given in the
second argument
"
  (format
   t
   "ic_boco_get_unused_group ~S ~S~%" prefix avoid))

(defun unused-replace-with-matching-name (newbcs t2 v2 &optional (replace_these ""))
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

(defun replace-in-part (newbcs part &optional (replace_these ""))
  "
Same as above but does it for all families in a part.
"
  (format
   t
   "ic_boco_replace_in_part ~S ~S ~S~%" newbcs part replace_these))

(defun replace-in-group (newbcs group &optional (replace_these ""))
  "
Same as above but does it for all families in a group.
"
  (format
   t
   "ic_boco_replace_in_group ~S ~S ~S~%" newbcs group replace_these))

(defun add (fam bocos)
  "
Adds some BCs to a family.
"
  (format
   t
   "ic_boco_add ~S ~S~%" fam bocos))

(defun replace (fam bcarg newbcs)
  "
Replaces some BCs for a family.
"
  (format
   t
   "ic_boco_replace ~S ~S ~S~%" fam bcarg newbcs))

(defun get-for-tetin ()
  "
Returns the current default family_boco file which was loaded (if any).
"
  (format
   t
   "ic_boco_get_for_tetin~%"))

(defun reload ()
  "
Reloads the family boco file which has already been loaded (if any).
"
  (format
   t
   "ic_boco_reload~%"))

(defun list-families (&optional (pat ""))
  " Lists the current families which have boundary conditions associated
with them. A pattern may be given that limits the families to those
matching the pattern, as part of a :-separated list. pat may also be
!: which means no : characters.
"
  (format
   t
   "ic_boco_list_families ~S~%" pat))
  
(defun list_families_only ()
  "
Changes the family_boco file that is associated with the tetin file.
"
  (format
   t
   "ic_boco_list_families_only~%"))

(defun fam-dim (fam &optional (all_dim 0))
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

(defun parts-dim (parts)
  "
Returns the dimensions of the part.
"
  (format
   t
   "ic_boco_parts_dim ~S~%" parts))

(defun reset-fam-dim ()
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

(defun clear-icons ()
  "
Deletes all the BC icons that currently exist.
"
  (format
   t
   "ic_boco_clear_icons~%"))

(defun rename-family (old new)
  "
Renames a family - this has to move all the icons
"
  (format
   t
   "ic_boco_rename_family ~S ~S~%" old new))

(defun add-icon (type fam icontype locations scale maxnum color label params vis only_dims)
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

(defun apply-attr-symbol (group bctype setname icontype parsed params labels vis lvis)
  "
Smarter wrapper around the below functions.
"
  (format
   t
   "ic_boco_apply_attr_symbol ~S ~S ~S ~S ~S ~S ~S ~S ~S~%" group bctype setname icontype parsed params labels vis lvis))

(defun set-attr-symbol-group-visible (group bctype vis lvis)
  "
Easier way to set visibility by group and bctype
"
  (format
   t
   "ic_boco_set_attr_symbol_group_visible ~S ~S ~S ~S~%" group bctype vis lvis))

(defun add-attr-symbol (bctype group icontype set params label vis lvis)
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

(defun delete-attr-symbol (id)
  "
Deletes a symbol.
"
  (format
   t
   "ic_boco_delete_attr_symbol ~S~%" id))

(defun list-attr-symbols (&optional (bctype "") (group "") (set ""))
  "
Lists symbols.
"
  (format
   t
   "ic_boco_list_attr_symbols ~S ~S ~S~%" bctype group set))

(defun modify-attr-symbol-params (id params)
  "
Modifies params.
"
  (format
   t
   "ic_boco_modify_attr_symbol_params ~S ~S~%" id params))

(defun modify-attr-symbol-label (id label)
  "
Modifies labels.
"
  (format
   t
   "ic_boco_modify_attr_symbol_label ~S ~S~%" id label))

(defun modify-attr-symbol-visible (id vis lvis)
  "
Modifies visibility.
"
  (format
   t
   "ic_boco_modify_attr_symbol_visible ~S ~S ~S~%" id vis lvis))

(defun apply-solver-icon-to-group (group bctype icontype iconparams vis &optional (bcargs ""))
  "
Applies a solver specific icon to a particular group.
"
  (format
   t
   "ic_boco_apply_solver_icon_to_group ~S ~S ~S ~S ~S ~S~%" group bctype icontype iconparams vis bcargs))

(defun apply-solver-icon-to-part (part bctype icontype iconparams vis &optional (bcargs ""))
  "
Applies a solver specific icon to a particular part.

unused__ic_boco_set_visible bcargs bctypes on

Sets the icon visibility. bcargs are something like FORCE_NAME F1
"
  (format
   t
   "ic_boco_apply_solver_icon_to_part ~S ~S ~S ~S ~S ~S~%" part bctype icontype iconparams vis bcargs))

(defun delete-icons-for-bctypes (fam bctypes)
  " Removes the icons for a particular family/bctype combination.
"
  (format
   t
   "ic_boco_delete_icons_for_bctypes ~S ~S~%" fam bctypes))

(defun set-family-visible (fams bctypes on)
  " Sets the icon visibility by family. If fams is empty then this
implies all families.
"
  (format
   t
   "ic_boco_set_family_visible ~S ~S ~S~%" fams bctypes on))

(defun remove-objects-from-groups (objlist bcargs)
  "
Removes the given objects from all groups that have a BC with a specified name.
"
  (format
   t
   "ic_boco_remove_objects_from_groups ~S ~S~%" objlist bcargs))

(defun add-parts-and-subsets-to-group (name parts_or_subsets)
  " Adds the parts and subsets to the APPLY_TO_PARTS and
APPLY_TO_SUBSETS pseudo-BC's on the named group.
"
  (format
   t
   "ic_boco_add_parts_and_subsets_to_group ~S ~S~%" name parts_or_subsets))

(defun what-groups-go-with-part-or-subset (type name)
  "
This routine is called when objects are moved into and out of parts and subsets.
"
  (format
   t
   "ic_boco_what_groups_go_with_part_or_subset ~S ~S~%" type name))

(defun change-part (oldfam newpart)
  "
Utility function to move stuff from one part to another.
"
  (format
   t
   "ic_boco_change_part ~S ~S~%" oldfam newpart))

(defun change-subset (oldfam subset add)
  " For a given family, if you move something in that family into or
out of a subset, this returns the new family.
"
  (format
   t
   "ic_boco_change_subset ~S ~S ~S~%" oldfam subset add))

(defun add_or_remove_bc_icons (on_fam add objects)
  " For every icon on family oldfam, remove the locations of the
objects. For every icon on newfam, add the locations.
"
  (format
   t
   "ic_boco_add_or_remove_bc_icons ~S ~S ~S~%" on_fam add objects))

(defun replace-arg (fams replace_types replace_pos replace_val)
  " Replaces a certain argument in the BCs for a given set of families
with a different value.
"
  (format
   t
   "ic_boco_replace_arg ~S ~S ~S ~S~%" fams replace_types replace_pos replace_val))

(defun delete-group-with-bcs (bcargs)
  " Removes everything from groups that have a specific bctype and set
of arguments, and delete those groups. Note that this will never get
called with part groups.
"
  (format
   t
   "ic_boco_delete_group_with_bcs ~S~%" bcargs))

(defun list-icons (&optional (fam "") (type ""))
  "
Lists all the BC icons.
"
  (format
   t
   "ic_boco_list_icons ~S ~S~%" fam type))

(defun delete-group (group)
  "
Removes everything from groups and delete those groups.
"
  (format
   t
   "ic_boco_delete_group ~S~%" group))

(defun clear-family (fam)
  "
Clears the BCs and icons from one family.
"
  (format
   t
   "ic_boco_clear_family ~S~%" fam))

(defun set_part_color (famname &optional (update_uns 1))
  " Looks for a group inside this family that is a part name, and define
the color of the family based on the value of the name. Note that it
takes only the last component of the part name so that things don't
shift around when you put them in assemblies.
"
  (format
   t
   "ic_boco_set_part_color ~S ~S~%" famname update_uns))

(defun nastran-csystem (what args)
  "
Sets Nastran-type coordinate systems.
"
  (format
   t
   "ic_boco_nastran_csystem ~S ~S~%" what args))

(defun delete-unused (keep_groups)
  "
Cleans up the set of BCs a bit. Keeps the singleton groups if keep_groups is 1.
"
  (format
   t
   "ic_boco_delete_unused ~S~%" keep_groups))

(defun list-unused ()
  "
Lists the families that have no mesh or geometry in them.
"
  (format
   t
   "ic_boco_list_unused~%"))

(defun get-fams-of-part (partname)
  "
Returns the list of families belonging to the given partname.
"
  (format
   t
   "ic_boco_get_fams_of_part ~S~%" partname))

(defun get-part-of-fam (famname)
  "
Returns the part to which the given family famname belongs.
"
  (format
   t
   "ic_boco_get_part_of_fam ~S~%" famname))

(defun solver-mesh-info (solver)
  ""
  (format
   t
   "ic_solver_mesh_info ~S~%" solver))