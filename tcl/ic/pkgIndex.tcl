# Tcl package index file, version 1.1
# This file is generated by the "pkg_mkIndex" command
# and sourced either when an application starts up or
# by a "package unknown" script.  It invokes the
# "package ifneeded" command to set up package-related
# information so that packages will be loaded automatically
# in response to "package require" commands.  When this
# script is sourced, the variable $dir must contain the
# full path name of this file's directory.

package ifneeded mnas_icem_utils 1.0 [list source [file join $dir change.tcl]]\n[list source [file join $dir delete_family.tcl]]\n[list source [file join $dir dlg_msh.tcl]]\n[list source [file join $dir fv.tcl]]\n[list source [file join $dir mesh_curve.tcl]]\n[list source [file join $dir mesh_setup.tcl]]\n[list source [file join $dir obj.tcl]]\n[list source [file join $dir suface.tcl]]
