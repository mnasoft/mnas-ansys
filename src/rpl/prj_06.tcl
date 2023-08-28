# source d:/home/_namatv/PRG/msys64/home/namatv/quicklisp/local-projects/ANSYS/mnas-ansys/src/rpl/prj_06.tcl

##################################################
# dg7
proc del_dg1 {} {
    # Удаление частей, которые ненужны для
    # построения сетки в этой области.    
    del_asm {DM DG2 DG3 DG4 DG5 DG6 DG7}
    del_asm {C/M C/G2 C/G6 C/G7}
}

# Здесь нужно обновить топологию

# Здесь нужно выполнить:
# ch_all; ch_tan

proc msh_dg1 {} {
    msh_per 36
    msh_par 6
    msh_prt
}

# Здесь нужно выключить видимость семейтсва ΤΑΝ

# Здесь нужно сгенерировать сетку

##################################################
# dg7

proc del_dg7 {} {
    # Удаление частей, которые ненужны для
    # построения сетки в этой области.
    del_asm {DM DG1 DG2 DG3 DG4 DG5 DG6}
    del_asm {C/M C/G1 C/G2 C/G6-G6}
}

