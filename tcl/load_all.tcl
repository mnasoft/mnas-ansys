# source d:/home/_namatv/PRG/msys64/home/namatv/quicklisp/local-projects/ANSYS/mnas-ansys/tcl/load_all.tcl
# source d:/PRG/msys64/home/mnaso/quicklisp/local-projects/ANSYS/mnas-ansys/tcl/load_all.tcl
mess "source load_all.tcl START... \n"

global mnas_ansys_tcl_dir
if { [string compare [info hostname] N142013] == 0 } then {
    set mnas_ansys_tcl_dir "d:/home/_namatv/PRG/msys64/home/namatv/quicklisp/local-projects/ANSYS/mnas-ansys/tcl" }
if {[string compare [info hostname] uakazi-note] == 0 } then {
    set mnas_ansys_tcl_dir "d:/PRG/msys64/home/mnaso/quicklisp/local-projects/ANSYS/mnas-ansys/tcl" }

if { [lsearch $auto_path ${mnas_ansys_tcl_dir}/ic] == -1 } {
    lappend auto_path ${mnas_ansys_tcl_dir}/ic}

foreach path $auto_path {
    puts $path}

pkg_mkIndex ${mnas_ansys_tcl_dir}/ic *.tcl

proc load_dir_tcl {directiry {extension *.tcl}} {
    global mnas_ansys_tcl_dir
    foreach file [glob  -nocomplain -type f ${mnas_ansys_tcl_dir}/${directiry}/$extension] {
        source $file } }

proc load_all {} {
    set dirs { ic }
    foreach dir $dirs {
        load_dir_tcl $dir } }

proc reload_all {} {
    package forget  mnas_icem_utils 1.0
    package require mnas_icem_utils 1.0}

mess "source load_all.tcl FINISH. \n"
mess "package require mnas_icem_utils 1.0 \n"
mess "package forget  mnas_icem_utils 1.0 \n"
