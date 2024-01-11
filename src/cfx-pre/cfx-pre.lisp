(defpackage :mnas-ansys/cfx-pre
  (:use #:cl )
  (:export preambule
           cmd-invoke
           gtmImport
           update
           ))

(defun preambule (&optional (stream t))
  "@b(Описание:) функция @b(preambule) выводит в поток преамбулу для
командного файла CFX PRE.

 @b(Пример использования:)
@begin[lang=lisp](code)
 (preambule)
->
 COMMAND FILE:
   CFX Pre Version = 14.5
 END
NIL
@end(code)
"
  (format stream "~A~%~A~%~A~2%" "COMMAND FILE:" "  CFX Pre Version = 14.5" "END"))

(defun cmd-invoke (cmd &optional (stream t))
  (format stream "> ~A~%" cmd))

(defun update (&optional (stream t))
  "@b(Описание:) функция @b(update) выводит в поток команду update
командного файла CFX PRE.

 @b(Пример использования:)
@begin[lang=lisp](code)
 (update) ->
 > update
@end(code)"
  (cmd-invoke "update" stream))
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
