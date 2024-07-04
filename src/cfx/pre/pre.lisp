(defpackage :mnas-ansys/cfx/pre
  (:use #:cl )
  (:export preambule
           cmd-invoke
           gtmImport
           update
           mesh-transformation
           ))

(in-package :mnas-ansys/cfx/pre)

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

(defun mesh-transformation (target-location)
  (format t "MESH TRANSFORMATION:~%")
  (format t "  Angle End = 0 , 0 , 0~%")
  (format t "  Angle Start = 0 , 0 , 0~%")
  (format t "  Delete Original = Off~%")
  (format t "  Glue Copied = On~%")
  (format t "  Glue Reflected = On~%")
  (format t "  Glue Strategy = Location And Transformed Only~%")
  (format t "  Nonuniform Scale = 1 , 1 , 1~%")
  (format t "  Normal = 0 , 0 , 0~%")
  (format t "  Number of Copies = 1~%")
  (format t "  Option = Rotation~%")
  (format t "  Passages in 360 = 1~%")
  (format t "  Passages per Mesh = 1~%")
  (format t "  Passages to Model = 1~%")
  (format t "  Point = 0 , 0 , 0~%")
  (format t "  Point 1 = 0 , 0 , 0~%")
  (format t "  Point 2 = 0 , 0 , 0~%")
  (format t "  Point 3 = 0 , 0 , 0~%")
  (format t "  Preserve Assembly Name Strategy = Existing~%")
  (format t "  Principal Axis = X~%")
  (format t "  Reflection Method = Original (No Copy)~%")
  (format t "  Reflection Option = YZ Plane~%")
  (format t "  Rotation Angle = -22.5 [degree]~%")
  (format t "  Rotation Angle Option = Specified~%")
  (format t "  Rotation Axis Begin = 0 , 0 , 0~%")
  (format t "  Rotation Axis End = 0 , 0 , 0~%")
  (format t "  Rotation Option = Principal Axis~%")
  (format t "  Scale Method = Original (No Copy)~%")
  (format t "  Scale Option = Uniform~%")
  (format t "  Scale Origin = 0 , 0 , 0~%")
  (format t "  Target Location = ~A~%" target-location)
  (format t "  Theta Offset = 0.0 [degree]~%")
  (format t "  Transform Targets Independently = Off~%")
  (format t "  Translation Deltas = 0 , 0 , 0~%")
  (format t "  Translation Option = Deltas~%")
  (format t "  Translation Root = 0 , 0 , 0~%")
  (format t "  Translation Tip = 0 , 0 , 0~%")
  (format t "  Uniform Scale = 1.0~%")
  (format t "  Use Coord Frame = Off~%")
  (format t "  Use Multiple Copy = On~%")
  (format t "  X Pos = 0.0~%")
  (format t "  Y Pos = 0.0~%")
  (format t "  Z Pos = 0.0~%")
  (format t "END~%")
  (update)
  (format t ">gtmTransform ~A~%" target-location)
  (update)
  (format t "~%~%")  
  )


