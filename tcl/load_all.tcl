# source d:/home/_namatv/PRG/msys64/home/namatv/quicklisp/local-projects/ANSYS/mnas-ansys/tcl/load_all.tcl
# source d:/PRG/msys64/home/mnaso/quicklisp/local-projects/ANSYS/mnas-ansys/tcl/load_all.tcl

global mnas_ansys_tcl_dir
if { [string compare [info hostname] N142013] == 0 } then {
    set mnas_ansys_tcl_dir "d:/home/_namatv/PRG/msys64/home/namatv/quicklisp/local-projects/ANSYS/mnas-ansys/tcl" }
if {[string compare [info hostname] uakazi-note] == 0 } then {
    set mnas_ansys_tcl_dir "d:/PRG/msys64/home/mnaso/quicklisp/local-projects/ANSYS/mnas-ansys/tcl" }

# Определяет подкаталоги для включения в auto_path
global SubDirs
set SubDirs { {} ic }

# Функция выполняет загрузку для всех файлов с расширением extension
# из каталога directory.
proc load_dir_tcl {directiry {extension *.tcl}} {
    global mnas_ansys_tcl_dir
    foreach file [glob  -nocomplain -type f ${mnas_ansys_tcl_dir}/${directiry}/$extension] {
        source $file } }

proc add_auto_path {dirs} {
    global auto_path mnas_ansys_tcl_dir
    foreach dir $dirs {
        if { [lsearch $auto_path ${mnas_ansys_tcl_dir}/${dir}] == -1 } {
            lappend auto_path ${mnas_ansys_tcl_dir}/${dir} } }
    check_auto_path}

# Выводит в консоль пути для автозагружаемых каталогов.
proc check_auto_path {} {
    global auto_path 
    foreach path $auto_path {
        mess "$path \n"} }

# Создает автоиндекс (tclIndex) для подкаталогов SubDirs каталога
# mnas_ansys_tcl_dir. 
proc make_auto {} {
    global auto_path mnas_ansys_tcl_dir SubDirs
    add_auto_path $SubDirs    
    foreach dir $SubDirs {
        auto_mkindex ${mnas_ansys_tcl_dir}/$dir }}

# Создает автоиндекс (pkgIndex.tcl) для подкаталогов SubDirs каталога
# mnas_ansys_tcl_dir.
proc make_pkg_mkIndex {} {
    global auto_path mnas_ansys_tcl_dir SubDirs
    add_auto_path $SubDirs
    foreach dir $SubDirs {
        pkg_mkIndex ${mnas_ansys_tcl_dir}/ic *.tcl } }

# Забывает регистрацию для пакета mnas_icem_utils 1.0 и повторно
# требует восстановить регистрацию пакета mnas_icem_utils 1.0
proc require_pkg {} {
    global auto_path mnas_ansys_tcl_dir SubDirs
    make_pkg_mkIndex
    package forget  mnas_icem_utils 1.0
    package require mnas_icem_utils 1.0
    mnas_help }

make_auto

mess "\n\n\n====================================================================================================\n"
mess "To load mnas_icem_utils 1.0 invoke command: \n"
mess "source $mnas_ansys_tcl_dir/load_all.tcl; make_auto; require_pkg \n"
mess "source d:/home/_namatv/PRG/msys64/home/namatv/quicklisp/local-projects/ZM/cfx/n70-base/tcl/prj_06.tcl\n"
mess "====================================================================================================\n"
