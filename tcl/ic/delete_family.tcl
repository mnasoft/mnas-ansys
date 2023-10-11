# source d:/home/_namatv/PRG/msys64/home/namatv/quicklisp/local-projects/ANSYS/mnas-ansys/tcl/ic/delete_family.tcl
package provide mnas_icem_utils 1.0

proc del_part {part} {
    ic_undo_group_begin
    ic_start_bigunsop
    ic_delete_elements family $part no_undo 1
    ic_delete_geometry all families $part 1 1
    ic_geo_delete_family $part
    ic_finish_bigunsop 
    ic_undo_group_end
}

# Возвращает список семейств, в которых
# присутствуют бъекты типов types.
proc parts {types} {
    set x {}
    foreach type $types {
        foreach object [ic_geo_get_objects $type] {
            lappend x [ic_geo_get_family $type $object] } }
    return [lsort -unique $x] }

# Печатает в консоль tcl имена частей в которых есть объекты типа
# types.
proc parts_print {types} {
    mess "\n\n\n(defparameter *$types*\n'("
    foreach i [parts $types] {
        mess "\"$i\"\n" }
    mess "))\n\n\n"}

proc del_asm {assembles} {
    foreach assembly $assembles {
        foreach part [parts {body point curve surface}] {
            if {[regexp $assembly $part]} then {
                del_part $part } } } }

proc all_parents {part} {
    set x {}
    set p $part
    while { $p != {} } {
        lappend x $p    
        set p [path_name $p] }
    return $x }

# Возвращает непустые семейства.
proc not_empty_parts {} {
    set not_empty {}
    foreach  family [ic_geo_list_families] {
        if {[ic_geo_family_is_empty $family] == 0} then {
            lappend not_empty $family } }
    return $not_empty }

# Возвращает непустые семейства и их родителей.
proc not_empty_parents {} {
    set x {}
    foreach fam [not_empty_parts]  {
        foreach fam [all_parents $fam] {
            lappend x $fam } }
    return [lsort -unique $x] }

# Возвращает пустые семейства и их родителей.
proc empty_parents {} {
    set x {}
    set not_empty_parents [not_empty_parents]
    foreach  family [ic_geo_list_families] {
        if {[lsearch -exact $not_empty_parents $family] == -1} then {
            lappend x $family } }
    return [lsort -unique $x] }

# Удаляет все неиспользуемае семейства и их предков. 
proc clear_all {} {
    foreach family [empty_parents] {
        ic_geo_delete_family $family } }

####################################################################################################

# ic_geo_list_families
# ic_geo_family_is_empty
# ic_geo_family_is_empty DG1/B1/AIR_RL_OUT/N2/D_05.000
# clear_all
