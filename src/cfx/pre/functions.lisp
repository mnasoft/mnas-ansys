;;;; ./src/cfx/pre/functions.lisp

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
                        (axis-start '(0.0 0.0 0.0))
                        (axis-end   '(1000.0 0.0 0.0))
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

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun name-icem->cfx (name)
  (ppcre:regex-replace-all "[/-]" name " "))

(defmacro mk-mesh-rotation (Target-Location Rotation-Angle simulation)
  `(add (make-instance '<simulation-mesh-transformation>
                      :mesh-transformation (make-instance 'mnas-ansys/ccl/core:<mesh-transformation>
                                                          :Target-Location ,Target-Location
                                                          :Use-Multiple-Copy "Off"
                                                          :Delete-Original nil
                                                          :Glue-Copied "On"
                                                          :Glue-Reflected "On"
                                                          :Number-of-Copies nil
                                                          :Rotation-Angle ,Rotation-Angle))
        ,simulation))

(defun add-interface-general (mesh-name-1 mesh-name-2 simulation)
  (add (make-instance '<simulation-interface-general>
                      :mesh-name-1 mesh-name-1
                      :mesh-name-2 mesh-name-2
                      :simulation simulation)
       simulation))

(defun add-interface-rot-per (mesh-name simulation)
  (add
   (make-instance '<simulation-interface-rotational-periodicity>
                  :mesh-name mesh-name
                  :simulation simulation)
   simulation))

(defun add-interface-rot-gen (mesh-name simulation)
  (add (make-instance '<simulation-interface-rotational-general>
                      :mesh-name mesh-name
                      :simulation simulation)
       simulation))

(defun mk-domain-fluid (&key
                          (domain-name "D1")
                          (fluid-name "Fluid 1")
                          (location "DG1 G1,DG1 G1 2,DG10 G10,DG2 G2,DG2 G2 2,DG31 G31,DG31 G31 2,DG32 G32,DG32 G32 2,DG33 G33,DG33 G33 2,DG34 G34,DG34 G34 2,DG41 G41,DG41 G41 2,DG42 G42,DG42 G42 2,DG5 G5,DG5 G5 2,DG6 G6,DG7 G7,DG8 G8,DG9 G9,DG9 G9 2")
                          (reference-pressure "1.943 [MPa]"))
  "Создание флюидового домена без инициализации."
  (make-instance '<domain>
                 :name domain-name
                 :location Location
                 :fluid-definition
                 (make-instance '<fluid-definition>
                                :name fluid-name)
                 :domain-models
                 (make-instance '<domain-models>
                                :reference-pressure
                                (make-instance '<reference-pressure>
                                               :reference-pressure reference-pressure))
                 :solid-definition nil
                 :solid-models nil))

(defun mk-domain-solid (&key
                          (domain-name "M1")
                          (solid-name "Solid 1")
                          (Location "DM1 M1 2,DM1 M1"))
  "Создание солидового домена без инициализации."
  (make-instance '<domain>
                 :name domain-name
                 :domain-type "Solid"
                 :location Location
                 :fluid-definition nil
                 :fluid-models nil
                 :solid-definition (make-instance '<solid-definition>
                                                  :name solid-name)
                 :solid-models (make-instance '<solid-models>)
                 :domain-models (make-instance '<domain-models>
                                               :reference-pressure nil
                                               :buoyancy-model nil)))

(defun mk-flow (&key
                  simulation
                  (flow-name "Flow Analysis 1")
                  (domain-fluid-name "D1")
                  (domain-solid-names '("M1" "M2" "M3"))
                  (reference-pressure "1.943 [MPa]"))
  (let ((doms (loop :for d :in domain-solid-names
                    :collect
                    (mk-domain-solid
                     :domain-name d
                     :location (simulation-solid-domain-mesh-location d simulation)))))
    (push (mk-domain-fluid
           :domain-name domain-fluid-name
           :location (simulation-fluid-domain-location simulation)
           :reference-pressure reference-pressure)
          doms)
    (make-instance '<flow>
                   :name flow-name
                   :domains (make-instance '<domains-list> :domains doms))))

(defun mk-boundary-inlet (name
                          Mass-Flow-Rate
                          Location
                          &key
                            Static-Temperature
                            Total-Temperature
                            (components
                             '(("CH4" 0.0)
                               ("CO"  0.0)
                               ("CO2" 0.0)
                               ("H2O" 0.0)
                               ("NO"  0.0)
                               ("O2"  0.0))))
  (let* ((heat-transfer
           (cond
             (static-temperature
               (make-instance '<heat-transfer>
                              :option "Static Temperature"
                              :static-temperature static-temperature
                              :total-temperature nil))
             (total-temperature
               (make-instance '<heat-transfer>
                              :option "Total Temperature"
                              :static-temperature nil
                              :total-temperature total-temperature))))
         (boundary-conditions
           (make-instance '<boundary-conditions>
                          :heat-transfer heat-transfer
                          :mass-and-momentum
                          (make-instance '<mass-and-momentum>
                                         :option "Mass Flow Rate"
                                         :momentum-interface-model nil
                                         :mass-flow-rate mass-flow-rate)))
         (boundary
           (make-instance '<boundary>
                          :name name
                          :boundary-type "INLET"
                          :location location
                          :boundary-conditions boundary-conditions)))
    (loop :for (component-name mass-fraction) :in components
          :do
             (let ((component
                     (find component-name
                           (<component-list>-components
                            (<boundary-conditions>-components
                             boundary-conditions))
                           :key #'mnas-ansys/ccl/core:<obj>-name :test #'equal)))
               (when (and component (/= mass-fraction 0.0))
                 (setf (<component>-mass-fraction component)
                       mass-fraction))))
    boundary))

(defun mk-boundary-outlet (name
                           Location
                           &key
                             Relative-Pressure
                             Mass-Flow-Rate)
  (let* ((mass-and-momentum
           (cond
             (Relative-Pressure
               (make-instance '<mass-and-momentum>
                              :option "Static Pressure"
                              :momentum-interface-model nil
                              :Relative-Pressure Relative-Pressure))
             (Mass-Flow-Rate
               (make-instance '<mass-and-momentum>
                              :option "Mass Flow Rate"
                              :momentum-interface-model nil
                              :mass-flow-rate Mass-Flow-Rate))))
         (boundary
           (make-instance '<boundary>
                          :name name
                          :boundary-type "OUTLET"
                          :location Location
                          :boundary-conditions
                          (make-instance '<boundary-conditions>
                                         :components nil
                                         :flow-direction nil
                                         :heat-transfer nil
                                         :turbulence nil
                                         :mass-and-momentum mass-and-momentum))))
    boundary))

(defun prepare-list (lst)
  (cond
    ((stringp lst) lst)
    ((consp lst)
     (format nil "~{~A~^,~}" lst))))

