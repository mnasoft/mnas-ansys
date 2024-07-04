"
> gtmImport filename=D:\home\_namatv\CFX\n70\tin\DOMAINS\G1\msh\N70_prj_08_DG1.msh, type=Generic, units=mm, genOpt= -n, nameStrategy= Assembly
> gtmImport filename=D:\home\_namatv\CFX\n70\tin\DOMAINS\G2\msh\N70_prj_08_DG2.msh, type=Generic, units=mm, genOpt= -n, nameStrategy= Assembly
> gtmImport filename=D:\home\_namatv\CFX\n70\tin\DOMAINS\G3\msh\N70_prj_08_DG3.msh, type=Generic, units=mm, genOpt= -n, nameStrategy= Assembly
> gtmImport filename=D:\home\_namatv\CFX\n70\tin\DOMAINS\G4\msh\N70_prj_08_DG4.msh, type=Generic, units=mm, genOpt= -n, nameStrategy= Assembly
> gtmImport filename=D:\home\_namatv\CFX\n70\tin\DOMAINS\G5\msh\N70_prj_08_DG5.msh, type=Generic, units=mm, genOpt= -n, nameStrategy= Assembly
> gtmImport filename=D:\home\_namatv\CFX\n70\tin\DOMAINS\G6\msh\N70_prj_08_DG6.msh, type=Generic, units=mm, genOpt= -n, nameStrategy= Assembly
> gtmImport filename=D:\home\_namatv\CFX\n70\tin\DOMAINS\G7\msh\N70_prj_08_DG7.msh, type=Generic, units=mm, genOpt= -n, nameStrategy= Assembly
> gtmImport filename=D:\home\_namatv\CFX\n70\tin\DOMAINS\M1\msh\N70_prj_08_DM1.msh, type=Generic, units=mm, genOpt= -n, nameStrategy= Assembly
> gtmImport filename=D:\home\_namatv\CFX\n70\tin\DOMAINS\M2\msh\N70_prj_08_DM2.msh, type=Generic, units=mm, genOpt= -n, nameStrategy= Assembly
> gtmImport filename=D:\home\_namatv\CFX\n70\tin\DOMAINS\M3\msh\N70_prj_08_DM3.msh, type=Generic, units=mm, genOpt= -n, nameStrategy= Assembly

> update
"

(progn (preambule)
       (loop :for i
               :in '("DG1 G1"
                     "DG2 G2"
                     "DG3 G3"
                     "DG4 G4"
                     "DG8 G8"
                     "DG9 G9"
                     "DG10 G10"
                     "DM1 M1" 
                     "DM2 M2" 
                     )
             :do
                (mesh-transformation i)))
