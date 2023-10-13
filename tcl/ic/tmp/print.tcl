# source d:/PRG/msys64/home/mnaso/quicklisp/local-projects/ANSYS/mnas-ansys/tcl/ic/tmp/print.tcl

# TCLLIBPATH
# auto_path

proc mess {var} {
    puts stdout $var }

proc print_by_line {var} {
    foreach v $var {
        puts stdout $v}}

print_by_line $auto_path
print_by_line $TCLLIBPATH




lappend auto_path D:/PRG/msys64/home/mnaso/quicklisp/local-projects/ANSYS/mnas-ansys/tcl/ic/lib

foreach p $auto_path {
    puts stdout $p }

package require foo_bar_baz 1.0
package forget foo_bar_baz 1.0


auto_mkindex D:/PRG/msys64/home/mnaso/quicklisp/local-projects/ANSYS/mnas-ansys/tcl/ic/lib

pkg_mkIndex D:/PRG/msys64/home/mnaso/quicklisp/local-projects/ANSYS/mnas-ansys/tcl/ic/lib *.tcl

####################################################################################################
