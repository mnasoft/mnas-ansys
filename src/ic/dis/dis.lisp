;;;; ./src/icem/display.lisp

(defpackage #:mnas-ansys/ic/dis
  (:use #:cl)
  (:nicknames "IC/DIS" "DIS")
  (:export  view
            visible
            visible-family
            set-family-color-for-name
            display-update
            )
  (:documentation
   "@b(Описание:) пакет @b(ic/dis) содержит функции отображения (Display
 Functions)."))

(in-package #:mnas-ansys/ic/dis)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun view (what)
"
Sets the current viewing position. what may be home, which sets the home position.
"
   (format
   t
   "ic_view ~S~%" what))

(defun visible (type what on)
" Enable/disable visibility for different objects. The on argument
should be 0 or 1. type is one of geometry, unstruct, or family. In the
case of geometry, what should be one of surface, curve, point,
material, density, or loop. In the case of unstruct, it should be one
of the element type names like TETRA_4. In the case of family, it
should be a family name.
"
  (format t
          "ic_visible ~S ~S ~S~%" type what on))

(defun visible-family (family-name on)
" Enable/disable visibility for different objects. The on argument
should be 0 or 1. type is one of geometry, unstruct, or family. In the
case of geometry, what should be one of surface, curve, point,
material, density, or loop. In the case of unstruct, it should be one
of the element type names like TETRA_4. In the case of family, it
should be a family name.
"
  (format t
          "ic_visible family ~S ~S;" family-name on))

(defun set-family-color-for-name (name color)
" Sets the color to use for drawing objects in the named family. This
applies to geometry and mesh.
"
  (format t
          "ic_set_family_color_for_name ~S ~S~%" name color))

(defun display-update (&optional (mode "") (new_fams 1) (types ""))
" 
Updates the display in the GUI. mode is one of: all, unstruct,
struct, geom, \"\" implies all. new_fams determines whether or not to
update the family list in the GUI. types allows you to make visible
entity types appropriate to the mode (e.g.: {TRI_3} for unstruct).
"
  (format t
          "ic_display_update ~S ~S ~S;~2%" mode new_fams types))

