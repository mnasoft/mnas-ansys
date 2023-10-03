# source d:/home/_namatv/PRG/msys64/home/namatv/quicklisp/local-projects/ANSYS/mnas-ansys/tcl/load_all.tcl
# source d:/PRG/msys64/home/mnaso/quicklisp/local-projects/ANSYS/mnas-ansys/tcl/load_all.tcl

proc load_all {} {
    set directiry d:/home/_namatv/PRG/msys64/home/namatv/quicklisp/local-projects/ANSYS/mnas-ansys/tcl/ic/
    set extension *.tcl
    foreach file [glob  -nocomplain -type f $directiry$extension] {
        source $file
    }
}

load_all
