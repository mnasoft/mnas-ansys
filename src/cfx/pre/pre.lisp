(defpackage :mnas-ansys/cfx/pre
  (:use #:cl )
  (:export preambule
           cmd-invoke
           gtmImport
           update
           mesh-transformation
           make-domain-interface-general-connection
           )
  (:export rotate-point-around-vector
           mk-gt-cone-pnts))

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


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun make-domain-interface-general-connection (d-i-name
                                                 f-dom-list1
                                                 f-dom-list2
                                                 i-reg-lst-1
                                                 i-reg-lst-2)
  (let ((d-i (good-name d-i-name)))
    (format t "FLOW: Flow Analysis 1~%")
    (format t "  &replace DOMAIN INTERFACE: ~A~%" d-i)
    (format t "    Boundary List1 = ~A Side 1~%" d-i)
    (format t "    Boundary List2 = ~A Side 2~%" d-i)
    (format t "    Filter Domain List1 = ~A~%" f-dom-list1)
    (format t "    Filter Domain List2 = ~A~%" f-dom-list2)
    (format t "    Interface Region List1 = ~A~%" i-reg-lst-1)
    (format t "    Interface Region List2 = ~A~%" i-reg-lst-2)
    (format t "    Interface Type = Fluid Fluid~%")
    (format t "    INTERFACE MODELS: ~%")
    (format t "      Option = General Connection~%")
    (format t "      FRAME CHANGE: ~%")
    (format t "        Option = None~%")
    (format t "      END~%")
    (format t "      MASS AND MOMENTUM: ~%")
    (format t "        Option = Conservative Interface Flux~%")
    (format t "        MOMENTUM INTERFACE MODEL: ~%")
    (format t "          Option = None~%")
    (format t "        END~%")
    (format t "      END~%")
    (format t "      PITCH CHANGE: ~%")
    (format t "        Option = None~%")
    (format t "      END~%")
    (format t "    END~%")
    (format t "    MESH CONNECTION: ~%")
    (format t "      Option = Automatic~%")
    (format t "    END~%")
    (format t "  END~%")
    (format t "END~%")))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun rotate-point-around-vector (point-3d point-1 point-2 teta)
  (let* ((rotate-teta (math/matr:rotate-around point-1 point-2  (math/coord:dtr teta)))
         (move-x-y-z (math/matr:move-xyz 0.0d0 0.0d0 0.0d0))
         (matrix-4x4 (math/matr:multiply move-x-y-z rotate-teta)))
    (math/matr:transform point-3d matrix-4x4)))

(defun mk-gt-cone-pnts (point-tcs pa-start pa-end)
  (apply
   #'append
   (loop :for (point tc) :in point-tcs
         :when tc
           :collect
           (loop :for (name teta) :in tc
                 :collect
                 `(,name
                   ,(rotate-point-around-vector
                     point
                     pa-end
                     pa-start
                     teta))))))
