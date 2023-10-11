#### Tcl and the Tk Toolkit (2nd Edi - John K. Ousterhout.pdf

button .b -text "Press me" -command {puts Ouch!}
button .top -text "Top button"
button .bottom -text "Bottom button"
grid .top 
grid .bottom

##################################################
#### 
{} - pixels;
c  - centimeters;
i  - inches;
m  - millimeters;
p  - printer’s points (1/72 inch);


##################################################
#### 18.2 Frames

global relief_color
set relief_color {
    raised {dark grey} \
        sunken red\
        flat green\
        groove blue \
        ridge cyan}

proc mk_frames {} {
    global relief_color
    set c -1
    frame .$relief \
        -width 15m \
        -height 10m \
        -relief $relief \
        -borderwidth 4 \
        -background $color }

proc grid_frames {} {
    global relief_color
    set c -1
    foreach {relief color} $relief_color {
        grid .$relief \
            -column [incr c] \
            -row 0 \
            -padx 12m \
            -pady 12m }}

proc forget_frames {} {
    global relief_color
    foreach {relief color} $relief_color {
        grid forget .$relief }}

mk_frames; grid_frames
forget_frames

##################################################
#### 18.4 Toplevels

proc mk_toplevel {} {
    global relief_color
    set c -1
    foreach {relief color} $relief_color {
        toplevel .tl_$relief \
            -width 150m \
            -height 100m \
            -relief $relief \
            -borderwidth 4 \
            -background $color }}

proc grid_toplevel {} {
    global relief_color
    set c -1
    foreach {relief color} $relief_color {
        grid .tl_$relief \
            -column [incr c] \
            -row 0 \
            -padx 12m \
            -pady 12m }}

# Это не работает
proc destroy_toplevel {} {
    global relief_color
    foreach {relief color} $relief_color {
        destroy .tl_$relief }}

mk_toplevel; grid_toplevel
destroy_toplevel

##################################################
#### 18.5 Labels

label .label -text "No new mail" -bitmap \
    @$tk_library/demos/images/flagdown.xbm \
    -compound top

grid .label

.label configure -text "Yes new mail"
.label configure -bitmap @$tk_library/demos/images/flagup.xbm

.label configure -text "No new mail"
.label configure -bitmap @$tk_library/demos/images/flagdown.xbm

destroy .label 

proc watch {name} {
    toplevel .watch 
    label .watch.label -text "Value of \"$name\": "
    label .watch.value -textvariable $name
    grid .watch.label .watch.value -padx 2m -pady 2m
}
destroy .watch
set value_of_somthig {Value of Somthig}
watch value_of_somthig
