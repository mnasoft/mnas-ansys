;;;; ./src/icem/display.lisp

(defpackage #:mnas-ansys/icem/display
  (:use #:cl)
  (:export  ic_view
            ic_visible
            ic_set_family_color_for_name
            ic_display_update
            )
  (:documentation
   " Пакет содержит функции отображения."
   ))

(in-package #:mnas-ansys/icem/display)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun ic_view (what)
"
Sets the current viewing position. what may be home, which sets the home position.
"
   (format
   t
   "ic_view ~S~%" what))

(defun ic_visible (type what on)
" Enable/disable visibility for different objects. The on argument
should be 0 or 1. type is one of geometry, unstruct, or family. In the
case of geometry, what should be one of surface, curve, point,
material, density, or loop. In the case of unstruct, it should be one
of the element type names like TETRA_4. In the case of family, it
should be a family name.
"
  (format t
          "ic_visible ~S ~S ~S~%" type what on))

(defun ic_set_family_color_for_name (name color)
" Sets the color to use for drawing objects in the named family. This
applies to geometry and mesh.
"
  (format t
          "ic_set_family_color_for_name ~S ~S~%" name color))

(defun ic_display_update (&optional (mode "") (new_fams 1) (types ""))
" 
Updates the display in the GUI. mode is one of: all, unstruct,
struct, geom, \"\" implies all. new_fams determines whether or not to
update the family list in the GUI. types allows you to make visible
entity types appropriate to the mode (e.g.: {TRI_3} for unstruct).
"
  (format t
          "ic_display_update ~S ~S ~S~%" mode new_fams types))
