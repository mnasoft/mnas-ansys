# source d:/home/_namatv/PRG/msys64/home/namatv/quicklisp/local-projects/ANSYS/mnas-ansys/tcl/ic/prj_06.tcl

proc topo {} {
    ic_undo_group_begin
    ic_geo_delete_unattached [ic_geo_non_empty_families] 0 1
    ic_build_topo 0.05 -angle 30 [ic_geo_non_empty_families]
    ic_geo_delete_unattached [ic_geo_non_empty_families]
    ic_undo_group_end }

proc msh {size {angle 0}} {
    ch_all;   # Перенос кривых в семейства ицидентных с ними поверхностей
    clear_all;                     # Очистка неиспользуемые семейств    
    ch_tan;                
    
    # Настройка параметров сетки. Начало    
    msh_per $angle;                # С периодичностью
    msh_par $size;                 # Максимальный размер  
    msh_prt;                       # Настройка размеров для семейств    
    # Настройка параметров сетки. Конец
    curves_mesh_params;            # Устанавливаем параметры для кривых
    msh_prt;                       # Настройка размеров для семейств    
}

##################################################
# dg1
##################################################
proc del_dg1 {} {
    # Удаление частей, которые ненужны для
    # построения сетки в этой области.    
    del_asm {DM DG2 DG3 DG4 DG5 DG6 DG7}
    del_asm {C/M C/G2 C/G6 C/G7}
}

# Здесь нужно обновить топологию командой
# topo

proc msh_dg1 {} {
    msh 6 36;
}

proc dg1 {} {
    del_dg1
    topo
    msh_dg1
}

# Здесь нужно выключить видимость семейтсва ΤΑΝ

# Здесь нужно сгенерировать сетку

##################################################
# dg2
##################################################
proc del_dg2 {} {
    # Удаление частей, которые ненужны для
    # построения сетки в этой области.    
    del_asm {DM DG1 DG3 DG4 DG5 DG6 DG7}
    del_asm {C/M}
    del_asm {C/G1-G1 C/G1-G3 C/G1-G4 C/G1-G5}
    del_asm {C/G6}
    del_asm {C/G7}
}

proc dg2 {} {
    del_dg2;    # Удаляем лишнее
    topo;       # Обновляем топологию 
    msh_dg2;    # Настраиваем параметры сетки
    ic_geo_set_family_params TAN no_crv_inf prism 0 emax 0.0 ehgt 0.0 hrat 0 nlay 0 emin 0.0 edev 0.0
}

# Здесь нужно выключить видимость семейтсва ΤΑΝ

# Здесь нужно сгенерировать сетку

##################################################
# dg3
##################################################

proc del_dg3 {} {
    # Удаление частей, которые ненужны для
    # построения сетки в этой области.    
    del_asm {DM}
    del_asm {DG1 DG2 DG4 DG5 DG6 DG7}
    del_asm {C/M}
    del_asm {C/G1-G1 C/G1-G2 C/G1-G4 C/G1-G5}
    del_asm {C/G2-G2 C/G2-G4 C/G2-G5 C/G2-G6}
    del_asm {C/G6 C/G7}
}

proc dg3 {} {
    del_dg3;   # Удаляем лишнее
    topo;      # Обновляем топологию 
    msh 1;     # Настраиваем параметры сетки
    ic_geo_set_family_params TAN no_crv_inf prism 0 emax 0.0 ehgt 0.0 hrat 0 nlay 0 emin 0.0 edev 0.0
}

# Здесь нужно выключить видимость семейтсва ΤΑΝ
# Здесь нужно сгенерировать сетку

##################################################
# dg4
##################################################
proc del_dg4 {} {
    # Удаление частей, которые ненужны для
    # построения сетки в этой области.    
    del_asm {DM}
    del_asm {DG1 DG2 DG3 DG5 DG6 DG7}
    del_asm {C/M}
    del_asm {C/G1-G1 C/G1-G2 C/G1-G3 C/G1-G5}
    del_asm {C/G2-G2 C/G2-G3 C/G2-G5 C/G2-G6}
    del_asm {C/G6 C/G7}
}

proc dg4 {} {
    del_dg4;    # Удаляем лишнее
    topo;       # Обновляем топологию 
    msh 1;      # Настраиваем параметры сетки
    ic_geo_set_family_params TAN no_crv_inf prism 0 emax 0.0 ehgt 0.0 hrat 0 nlay 0 emin 0.0 edev 0.0
}

# Здесь нужно выключить видимость семейтсва ΤΑΝ
# Здесь нужно сгенерировать сетку

##################################################
# dg5
##################################################
proc del_dg5 {} {
    # Удаление частей, которые ненужны для
    # построения сетки в этой области.    
    del_asm {DM}
    del_asm {DG1 DG2 DG3 DG4 DG6 DG7}
    del_asm {C/M}
    del_asm {C/G1-G1 C/G1-G2 C/G1-G3 C/G1-G4}
    del_asm {C/G2-G2 C/G2-G3 C/G2-G4 C/G2-G6}
    del_asm {C/G6 C/G7}
}

proc dg5 {} {
    del_dg5;    # Удаляем лишнее
    topo;       # Обновляем топологию 
    msh 2;      # Настраиваем параметры сетки
    ic_geo_set_family_params TAN no_crv_inf prism 0 emax 0.0 ehgt 0.0 hrat 0 nlay 0 emin 0.0 edev 0.0
}

# Здесь нужно выключить видимость семейтсва ΤΑΝ
# Здесь нужно сгенерировать сетку

##################################################
# dg6
##################################################
proc del_dg6 {} {
    # Удаление частей, которые ненужны для
    # построения сетки в этой области.    
    del_asm {DM}
    del_asm {DG1 DG2 DG3 DG4 DG5 DG7}
    del_asm {C/M}
    del_asm {C/G1-G1 C/G1-G2 C/G1-G3 C/G1-G4 C/G1-G5}
    del_asm {C/G2-G2 C/G2-G3 C/G2-G4 C/G2-G5}
    del_asm {C/G7}
}

proc dg6 {} {
    del_dg6;    # Удаляем лишнее
    topo;       # Обновляем топологию 
    msh 2 36;      # Настраиваем параметры сетки
    ic_geo_set_family_params TAN no_crv_inf prism 0 emax 0.0 ehgt 0.0 hrat 0 nlay 0 emin 0.0 edev 0.0
}

# Здесь нужно выключить видимость семейтсва ΤΑΝ
# Здесь нужно сгенерировать сетку


##################################################
# dg7
##################################################

proc del_dg7 {} {
    # Удаление частей, которые ненужны для
    # построения сетки в этой области.
    del_asm {DM DG1 DG2 DG3 DG4 DG5 DG6}
    del_asm {C/M C/G1 C/G2 C/G6-G6}
}
proc dg7 {} {
    del_dg7;    # Удаляем лишнее
    topo;       # Обновляем топологию 
    msh 4 36;   # Настраиваем параметры сетки
    ic_geo_set_family_params TAN no_crv_inf prism 0 emax 0.0 ehgt 0.0 hrat 0 nlay 0 emin 0.0 edev 0.0
}

# Здесь нужно выключить видимость семейтсва ΤΑΝ
# Здесь нужно сгенерировать сетку

