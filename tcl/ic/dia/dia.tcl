#source d:/home/_namatv/PRG/msys64/home/namatv/quicklisp/local-projects/ANSYS/mnas-ansys/tcl/ic/dia/dia.tcl

set e_01 "10.25"
-textvariable arre_01

proc init_arr {} {
    global arr
    set arr(0) 1
    unset arr
    foreach {index val} {
        1 {Гидравлический Диаметр}
        2 {Масштабный Фактор}
        3 {Max Size}
        4 {Height}
        5 {Height Ratio}
        6 {Num Layers}
        7 {Tetra Size Ratio} } {
        set arr($index) $val } } 
                         
proc init_e_arr {} {
    global e_arr
    set e_arr(0) 1
    unset e_arr
    foreach {index var value} {
        1 entry_d  "00.000"
        2 entry_s  "1.0"
        3 entry_ms "0.0"
        4 entry_h  "0.0"
        5 entry_hr "0.0"
        6 entry_nl "0.0"
        7 entry_tsr "0.0" } {
        global $var
        set $var $value
        set e_arr($index) $var } }

proc bas {} {
    global arr
    global e_arr
    pack [frame .f] -side top
    for {set i 1} {$i <= 7} {incr i} {
        pack [frame       .f.f$i]                      -side top
        pack [label       .f.f$i.lbl$i -text $arr($i) -width 22 -anchor w] -side left
        pack [checkbutton .f.f$i.ch$i  -text ""]   -side left
        pack [entry       .f.f$i.ent$i -textvariable $e_arr($i)] -side left }
}

proc main {} {
    init_arr
    init_e_arr
    bas
}
main

unset arr

array get arr
array get e_arr


proc baz {} {
    global arr
    global e_arr
    pack [frame .f] -side top
    foreach {index val} [array get arr] {
        pack [frame       .f.f$index]                      -side top
        pack [label       .f.f$index.lbl$index -text $val -width 22 -anchor w] -side left
        pack [checkbutton .f.f$index.ch$index  -text ""]   -side left
        pack [entry       .f.f$index.ent$index -textvariable $e_arr($index)] -side left }
}

foreach {index val} [array get e_arr] {
        .f.f$index.ent$index -config  -textvariable $e_arr($index)}

proc foo {} {
    global e_01
    pack [frame .f] -side top
    pack [label .f.label_01 -text "label_01"] -side left
    pack [checkbutton .f.checkbutton_01 -text ""] -side left
    pack [entry  .f.entry_01 -textvariable e_01] -side left
}

foo

proc bar {} {
    global arr
    unset arr
    foreach {index val} {1 "label_01" 2 "label_02" 3 "label_03"} {
        set arr($index) $val } }

proc pr {} {
    global arr
    foreach {index value} [array get arr] {
        puts stdout "$index $value"
    }
}

array set colorcount {
    red   1
    green 5
    blue  4
    white 9
}

foreach {color count} [array get colorcount] {
    puts "Color: $color Count: $count"
}

set arr(0) 1
for {set i 1} {$i <= 10} {incr i} {
    set arr($i) [expr {$i * $arr([expr {$i - 1}])}]
}

puts stdout $arr(1)
