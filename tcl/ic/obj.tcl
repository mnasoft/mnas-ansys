#source d:/home/_namatv/PRG/msys64/home/namatv/quicklisp/local-projects/ANSYS/mnas-ansys/tcl/ic/obj.tcl
package provide mnas_icem_utils 1.0

# Возвращает количество общее объектов определенного типа.
proc obj_num {{types {point curve surface}}} {
    set x {}
    foreach type $types {
        lappend x [list $type [llength [ic_geo_get_objects $type]]] }
    return $x }

# Возвращает количество общее объектов определенного типа,
# содержащихся в части TAN.
proc obj_num_part {{types {point curve surface}} {part TAN}} {
    set x {}
    foreach type $types {
        lappend x [list $type [llength [ic_geo_get_objects $type $part]]] }
    return $x }
