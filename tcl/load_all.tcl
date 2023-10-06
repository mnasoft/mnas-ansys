# source d:/home/_namatv/PRG/msys64/home/namatv/quicklisp/local-projects/ANSYS/mnas-ansys/tcl/load_all.tcl
# source d:/PRG/msys64/home/mnaso/quicklisp/local-projects/ANSYS/mnas-ansys/tcl/load_all.tcl
mess "source load_all.tcl START... \n"

global mnas_ansys_tcl_dir
if { [string compare [info hostname] N142013] == 0 } then {
    set mnas_ansys_tcl_dir "d:/home/_namatv/PRG/msys64/home/namatv/quicklisp/local-projects/ANSYS/mnas-ansys/tcl" }
if {[string compare [info hostname] uakazi-note] == 0 } then {
    set mnas_ansys_tcl_dir "d:/PRG/msys64/home/mnaso/quicklisp/local-projects/ANSYS/mnas-ansys/tcl" }

proc load_dir_tcl {directiry {extension *.tcl}} {
    global mnas_ansys_tcl_dir
    foreach file [glob  -nocomplain -type f ${mnas_ansys_tcl_dir}/${directiry}/$extension] {
        source $file } }

global load_all
proc load_all {} {
    set dirs {ic ic/dia ic/help}
    mess "MESSAGEEEEE \n"
    foreach dir $dirs {
        mess "$dir \n"
        load_dir_tcl $dir } }

load_all

mess "source load_all.tcl FINISH. \n"

