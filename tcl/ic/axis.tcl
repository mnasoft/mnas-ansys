# source d:/home/_namatv/PRG/msys64/home/namatv/quicklisp/local-projects/ANSYS/mnas-ansys/tcl/ic/axis.tcl
mess "source axis.tcl START... \n"

package provide mnas_icem_utils 1.0

proc axis {x0 y0 z0 dx dy dz} {
    set x1 [expr {$x0+$dx}]
    set y1 [expr {$y0+$dy}]
    set z1 [expr {$z0+$dz}]    
    ic_point {} GEOM pnt $x0,$y0,$z0
    ic_point {} GEOM pnt $x1,$y1,$z1 }

proc axis_gt {} {
    axis 0 335 0 100 0 0 }

proc axis_en {} {
    axis 0 0 0 1000 0 0 }

mess "source axis.tcl FINISH. \n"
