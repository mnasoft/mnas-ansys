(defpackage :mnas-ansys/cfx/pre
  (:use #:cl )
  (:export preambule
           cmd-invoke
           gtmImport
           update
           mesh-transformation
           general-int
           rotational-int
           outlet-mfr-boundary
           make-monitor-point

           fluid-dom
           solid-dom
           )
  (:export load-mesh)
  (:export rotate-point-around-vector
           mk-gt-cone-pnts
           move-rotate-point-around-vector
           make-ic-point
           mk-t-f-points
           )
  (:export mk-mfr)
  )

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

(defun s-list (str-or-lst)
    (format nil "~{~A~^,~}"
                    (if (stringp str-or-lst)
                        (list str-or-lst)
                        str-or-lst)))

(defun general-int (d-i-name
                    f-dom-list1
                    f-dom-list2
                    i-reg-lst-1
                    i-reg-lst-2)
  (let ((d-i (mnas-ansys/ccl:good-name d-i-name)))
    (format t "FLOW: Flow Analysis 1~%")
    (format t "  &replace DOMAIN INTERFACE: ~A ~A ~A~%" f-dom-list1 f-dom-list2 d-i)
    (format t "    Boundary List1 = ~A ~A ~A Side 1~%" f-dom-list1 f-dom-list2 d-i)
    (format t "    Boundary List2 = ~A ~A ~A Side 2~%" f-dom-list1 f-dom-list2 d-i)
    (format t "    Filter Domain List1 = ~A~%" f-dom-list1)
    (format t "    Filter Domain List2 = ~A~%" f-dom-list2)
    (format t "    Interface Region List1 = ~A~%" (s-list i-reg-lst-1))
    (format t "    Interface Region List2 = ~A~%" (s-list i-reg-lst-2))
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
    (format t "END~3%")))

(defun rotational-int (d-i-name f-dom-list1 f-dom-list2 i-reg-lst-1 i-reg-lst-2)
  (let ((d-i (mnas-ansys/ccl:good-name d-i-name)))
    (format t "FLOW: Flow Analysis 1~%")
    (format t "  &replace DOMAIN INTERFACE: ~A ~A ~A LR~%" f-dom-list1 f-dom-list2 d-i)
    (format t "    Boundary List1 = ~A ~A ~A LR Side 1~%" f-dom-list1 f-dom-list2 d-i)
    (format t "    Boundary List2 = ~A ~A ~A LR Side 2~%" f-dom-list1 f-dom-list2 d-i)
    (format t "    Filter Domain List1 = ~A~%" f-dom-list1)
    (format t "    Filter Domain List2 = ~A~%" f-dom-list2)
    (format t "    Interface Region List1 = ~A~%" (s-list i-reg-lst-1))
    (format t "    Interface Region List2 = ~A~%" (s-list i-reg-lst-2))
    (format t "    Interface Type = Fluid Fluid~%")
    (format t "    INTERFACE MODELS: ~%")
    (format t "      Option = Rotational Periodicity~%")
    (format t "      AXIS DEFINITION: ~%")
    (format t "        Option = Coordinate Axis~%")
    (format t "        Rotation Axis = Coord 0.1~%")
    (format t "      END~%")
    (format t "    END~%")
    (format t "    MESH CONNECTION: ~%")
    (format t "      Option = Automatic~%")
    (format t "    END~%")
    (format t "  END~%")
    (format t "END~3%")))

(defun gtmImport (filename
                  &key
                  (type "Generic")
                  (units "mm")
                  (genOpt "-n")
                    (nameStrategy "Assembly"))
  "@b(Описание:) функция @b(gtmImport)

 @b(Пример использования:)
@begin[lang=lisp](code)
 (gtmImport \"D:\\\\home\\\\_namatv\\\\CFX\\\\a32\\\\msh\\\\prj_04\\\\A32_prj_04_DG1.msh\")
@end(code)

"
  (format t "> gtmImport filename=~A, type=~A, units=~A, genOpt= ~A, nameStrategy= ~A~%"
          filename
          type
          units
          genOpt
          nameStrategy))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun outlet-mfr-boundary (domain boundary location mfr
                            &key
                              (mfr-dim "kg s^-1"))
  "@b(Описание:) функция @b(outlet-mfr-boundary)

 @b(Пример использования:)
@begin[lang=lisp](code)
 (mk-boundary-outlet \"DG1/B1/AIR_RL_OUT/D_05.000\" 0.185745 )
@end(code)

"
  (format t "FLOW: Flow Analysis 1~%")
  (format t "  DOMAIN: ~A~%" domain)
  (format t "    &replace BOUNDARY: B ~A ~A~%" domain boundary) 
  (format t "      Boundary Type = OUTLET~%")
  (format t "      Location = ~A~%" location)
  (format t "      BOUNDARY CONDITIONS: ~%")
  (format t "        FLOW REGIME: ~%")
  (format t "          Option = Subsonic~%")
  (format t "        END~%")
  (format t "        MASS AND MOMENTUM: ~%")
  (format t "          Mass Flow Rate = ~A [~A]~%" mfr mfr-dim)
  (format t "          Option = Mass Flow Rate~%")
  (format t "        END~%")
  (format t "      END~%")
  (format t "    END~%")
  (format t "  END~%")
  (format t "END~3%"))

(defun inlet-boundary (domain
                       boundary
                       location
                       mfr
                       T-Tem
                       &key
                         (mfr-dim "kg s^-1")
                         (T-Tem-dim "C")
                         (CH4-fr 0.0)
                         (CO-fr 0.0)
                         (CO2-fr 0.0)
                         (H2O-fr 0.0)
                         (NO-fr 0.0)
                         (O2-fr 0.0)
                         (T-type "Total"))
  "@b(Описание:) функция @b(mk-boundary-inlet)

 @b(Пример использования:)
@begin[lang=lisp](code)
 (mk-boundary-input \"DG1 B1 AIR_IN D_00.000\" 2.855695 406)
@end(code)
"
  (labels ((component (name fraction)
             (format t "        COMPONENT: ~A~%" name)
             (format t "          Mass Fraction = ~A~%" fraction)
             (format t "          Option = Mass Fraction~%")
             (format t "        END~%")))
    (format t "FLOW: Flow Analysis 1~%")
    (format t "  DOMAIN: ~A~%" domain)
    (format t "    &replace BOUNDARY: B ~A ~A~%" domain boundary) 
    (format t "      Boundary Type = INLET~%")
    (format t "      Interface Boundary = Off~%")
    (format t "      Location = ~A~%" location)
    (format t "      BOUNDARY CONDITIONS: ~%")
    (component "CH4" CH4-fr)
    (component "CO"  CO-fr)
    (component "CO2" CO2-fr)
    (component "H2O" H2O-fr)
    (component "NO"  NO-fr)
    (component "O2"  O2-fr)
    (format t "        FLOW DIRECTION: ~%")
    (format t "          Option = Normal to Boundary Condition~%")
    (format t "        END~%")
    (format t "        FLOW REGIME: ~%")
    (format t "          Option = Subsonic~%")
    (format t "        END~%")
    (format t "        HEAT TRANSFER: ~%")
    (format t "          Option = ~A Temperature~%" T-type) 
    (format t "          ~A Temperature = ~A [~A]~%" T-type T-Tem T-Tem-dim)
    (format t "        END~%")
    (format t "        MASS AND MOMENTUM: ~%")
    (format t "          Mass Flow Rate = ~A [~A]~%" mfr mfr-dim)
    (format t "          Option = Mass Flow Rate~%")
    (format t "        END~%")
    (format t "        TURBULENCE: ~%")
    (format t "          Option = Medium Intensity and Eddy Viscosity Ratio~%")
    (format t "        END~%")
    (format t "      END~%")
    (format t "    END~%")
    (format t "  END~%")
    (format t "END~3%")))

(defun make-monitor-point (name-point m-prefix m-variable domain)
  (loop :for (name point) :in name-point
        :do
           (format t "FLOW: Flow Analysis 1~%")
           (format t "  OUTPUT CONTROL: ~%")
           (format t "    MONITOR OBJECTS: ~%")
           (format t "      &replace MONITOR POINT: ~A ~A~%" m-prefix name )
           (format t "        Cartesian Coordinates = ~{~8,3F [mm]~^, ~}~%" point)
           (format t "        Coord Frame = Coord 0~%")
           (format t "        Option = Cartesian Coordinates~%")
           (format t "        Output Variables List = ~A~%" m-variable)
           (format t "        MONITOR LOCATION CONTROL: ~%")
           (format t "          Domain Name = ~A~%" domain)
           (format t "          Interpolation Type = Nearest Vertex~%")
           (format t "        END~%")
           (format t "        POSITION UPDATE FREQUENCY: ~%")
           (format t "          Option = Initial Mesh Only~%")
           (format t "        END~%")
           (format t "      END~%")
           (format t "    END~%")
           (format t "  END~%")
           (format t "END~%~%")))

(defun fluid-dom (domain location
                  &key
                    (reference-pressure "2.0 [MPa]")
                    (temperature "403 [C]")
                    )
  (format t "FLOW: Flow Analysis 1~%")
  (format t "  &replace DOMAIN: ~A~%" domain)
  (format t "    Coord Frame = Coord 0~%")
  (format t "    Domain Type = Fluid~%")
  (format t "    Location = ~A~%" location)
  (format t "    DOMAIN MODELS: ~%")
  (format t "      BUOYANCY MODEL: ~%")
  (format t "        Option = Non Buoyant~%")
  (format t "      END~%")
  (format t "      DOMAIN MOTION: ~%")
  (format t "        Option = Stationary~%")
  (format t "      END~%")
  (format t "      MESH DEFORMATION: ~%")
  (format t "        Option = None~%")
  (format t "      END~%")
  (format t "      REFERENCE PRESSURE: ~%")
  (format t "        Reference Pressure = ~A~%" reference-pressure)
  (format t "      END~%")
  (format t "    END~%")
  (format t "    FLUID DEFINITION: Fluid 1~%")
  (format t "      Material = GAS~%")
  (format t "      Option = Material Library~%")
  (format t "      MORPHOLOGY: ~%")
  (format t "        Option = Continuous Fluid~%")
  (format t "      END~%")
  (format t "    END~%")
  (format t "    FLUID MODELS: ~%")
  (format t "      COMBUSTION MODEL: ~%")
  (format t "        Option = Finite Rate Chemistry and Eddy Dissipation~%")
  (format t "      END~%")
  (format t "      COMPONENT: CH4~%")
  (format t "        Option = Automatic~%")
  (format t "      END~%")
  (format t "      COMPONENT: CO~%")
  (format t "        Option = Automatic~%")
  (format t "      END~%")
  (format t "      COMPONENT: CO2~%")
  (format t "        Option = Automatic~%")
  (format t "      END~%")
  (format t "      COMPONENT: H2O~%")
  (format t "        Option = Automatic~%")
  (format t "      END~%")
  (format t "      COMPONENT: N2~%")
  (format t "        Option = Constraint~%")
  (format t "      END~%")
  (format t "      COMPONENT: NO~%")
  (format t "        Option = Automatic~%")
  (format t "      END~%")
  (format t "      COMPONENT: O2~%")
  (format t "        Option = Automatic~%")
  (format t "      END~%")
  (format t "      HEAT TRANSFER MODEL: ~%")
  (format t "        Option = Total Energy~%")
  (format t "      END~%")
  (format t "      THERMAL RADIATION MODEL: ~%")
  (format t "        Option = None~%")
  (format t "      END~%")
  (format t "      TURBULENCE MODEL: ~%")
  (format t "        Option = SST~%")
  (format t "      END~%")
  (format t "      TURBULENT WALL FUNCTIONS: ~%")
  (format t "        High Speed Model = Off~%")
  (format t "        Option = Automatic~%")
  (format t "      END~%")
  (format t "    END~%")
  (format t "    INITIALISATION: ~%")
  (format t "      Option = Automatic~%")
  (format t "      INITIAL CONDITIONS: ~%")
  (format t "        Velocity Type = Cartesian~%")
  (format t "        CARTESIAN VELOCITY COMPONENTS: ~%")
  (format t "          Option = Automatic~%")
  (format t "        END~%")
  (format t "        COMPONENT: CH4~%")
  (format t "          Option = Automatic~%")
  (format t "        END~%")
  (format t "        COMPONENT: CO~%")
  (format t "          Option = Automatic~%")
  (format t "        END~%")
  (format t "        COMPONENT: CO2~%")
  (format t "          Option = Automatic~%")
  (format t "        END~%")
  (format t "        COMPONENT: H2O~%")
  (format t "          Option = Automatic~%")
  (format t "        END~%")
  (format t "        COMPONENT: NO~%")
  (format t "          Option = Automatic~%")
  (format t "        END~%")
  (format t "        COMPONENT: O2~%")
  (format t "          Mass Fraction = 0.232~%")
  (format t "          Option = Automatic with Value~%")
  (format t "        END~%")
  (format t "        STATIC PRESSURE: ~%")
  (format t "          Option = Automatic with Value~%")
  (format t "          Relative Pressure = 0 [kPa]~%")
  (format t "        END~%")
  (format t "        TEMPERATURE: ~%")
  (format t "          Option = Automatic with Value~%")
  (format t "          Temperature = ~A~%" temperature)
  (format t "        END~%")
  (format t "        TURBULENCE INITIAL CONDITIONS: ~%")
  (format t "          Option = Medium Intensity and Eddy Viscosity Ratio~%")
  (format t "        END~%")
  (format t "      END~%")
  (format t "    END~%")
  (format t "  END~%")
  (format t "END~3%"))

(defun solid-dom (domain location)
  (format t "FLOW: Flow Analysis 1~%")
  (format t "  &replace DOMAIN: ~A~%" domain)
  (format t "    Coord Frame = Coord 0~%")
  (format t "    Domain Type = Solid~%")
  (format t "    Location = ~A~%" location)
  (format t "    DOMAIN MODELS: ~%")
  (format t "      DOMAIN MOTION: ~%")
  (format t "        Option = Stationary~%")
  (format t "      END~%")
  (format t "      MESH DEFORMATION: ~%")
  (format t "        Option = None~%")
  (format t "      END~%")
  (format t "    END~%")
  (format t "    SOLID DEFINITION: Solid 1~%")
  (format t "      Material = HN60VT~%")
  (format t "      Option = Material Library~%")
  (format t "      MORPHOLOGY: ~%")
  (format t "        Option = Continuous Solid~%")
  (format t "      END~%")
  (format t "    END~%")
  (format t "    SOLID MODELS: ~%")
  (format t "      HEAT TRANSFER MODEL: ~%")
  (format t "        Option = Thermal Energy~%")
  (format t "      END~%")
  (format t "      THERMAL RADIATION MODEL: ~%")
  (format t "        Option = None~%")
  (format t "      END~%")
  (format t "    END~%")
  (format t "  END~%")
  (format t "END~%"))

(defun load-mesh (dir-msh-template)
"@b(Описание:) функция @b(load-mesh) - выводит на стандартный вывод
сценарий, позволяющий загрузить сетки в CFX-PRE.

 @b(Переменые:)
@begin(list)
 @item(dir-msh-template - шаблон, задающий имена файлов загружаемых сеток.)
@end(list)

 @b(Пример использования:)
@begin[lang=lisp](code)
 (load-mesh \"Z:/CFX/n70/msh/prj_29/*.msh\")
@end(code)
"  
  (preambule)
  (loop :for i :in (directory dir-msh-template)
        :do (gtmImport (cl-ppcre:regex-replace-all "/" (namestring i) "\\")
                       ;; :genopt "-n -D"
                       :genopt "-n")
            (update)))

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

(defun move-rotate-point-around-vector (point-3d v point-1 point-2 teta)
  "@b(Описание:) функция @b(move-rotate-point-around-vector) смещает
точку @b(point-3d) в направлении вектора @b(v) и затем вращает
смещенную точку вокруг оси, проходящей через точки @b(point-1)
@b(point-2) на угол @b(teta) против часовой стрелки.

 @b(Пример использования:)
@begin[lang=lisp](code)
 (move-rotate-point-around-vector
  '(10.0   5.0 0.0)
  '( 0.0   5.0 0.0)
  '( 0.0   0.0 0.0)
  '(1000.0 0.0 0.0)
  45.0)
 => (10.0 7.071068 -7.071068)
@end(code)
"
  (let* ((rotate-teta (math/matr:rotate-around point-1 point-2 (math/coord:dtr teta)))
         (move-x-y-z (math/matr:move-v v))
         (matrix-4x4 (math/matr:multiply move-x-y-z rotate-teta)))
    (math/matr:transform point-3d matrix-4x4)))

(defun make-ic-point (pnt &optional (part "GEOM") (names "pnt"))
  (loop :for (name p) :in pnt :do
    (format t "ic_point {} ~A ~A {~{~8,3F~^,~}}; " part names p))
  (format t "~3%"))


(defun mk-t-f-points (p1
                      p2
                      &key
                        (axis-start *axis-start*)
                        (axis-end   *axis-end*)
                        (h-start    100)
                        (teta-start 100)
                        (h-list    (math/core:split-range-at-center 0.0 1.0 10))
                        (teta-list (math/core:split-range -17.0 17.0 34))
                        )
  (let ((d-p1-p2 (math/core:distance p1 p2)))
    (apply #'append
           (loop :for hight   :in h-list
                 :for hight-i :from h-start
                 :collect
                 (loop :for teta   :in   teta-list
                       :for teta-i :from teta-start
                       :collect 
                       (list (format nil "~A ~A" hight-i teta-i)
                             (move-rotate-point-around-vector
                              p1
                              (list 0.0d0 (* hight d-p1-p2) 0.0d0)
                              axis-start                         
                              axis-end
                              teta)))))))
(defun mk-mfr (name
               &key (side "Side 1")
               &aux (nm
                     (concatenate
                      'string
                      name " " side)))
  (format t "FLOW: Flow Analysis 1")
  (format t "  OUTPUT CONTROL: ")
  (format t "    MONITOR OBJECTS: ")
  (format t "      &replace MONITOR POINT: MFR ~A"  nm)
  (format t "        Coord Frame = Coord 0")
  (format t "        Expression Value = massFlow()@~A" nm)
  (format t "        Option = Expression")
  (format t "      END")
  (format t "    END")
  (format t "  END")
  (format t "END~2%"))

