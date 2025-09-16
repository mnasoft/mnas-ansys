;;;; ./src/cfx/pre/method.lisp

(in-package :mnas-ansys/cfx/pre)

(defun name-icem->cfx (name)
  (ppcre:regex-replace-all "[/-]" name " "))

(defmethod locations ((location null))
  "")

(defmethod locations ((location string))
  (format nil "~A" location))

(defmethod locations ((location sequence))
  (format nil "~{~A~^,~}" (coerce location 'list)))

(defmethod name ((3d-region <3d-region>))
  "@b(Описание:) метод @b(name) возвращает имя 3d-региона @b(3d-region).

 @b(Пример использования:)
@begin[lang=lisp](code)
 (name (3d-region \"DG1 G1 1\" *simulation*))
@end(code)"
  (let ((mesh-name (<mesh>-name (<3d-region>-mesh 3d-region))))
    (format nil "D~A ~A ~A" mesh-name mesh-name (<3d-region>-3d-suffix 3d-region))))

(defmethod name ((obj <simulation-boundary-inlet>))
  (<simulation-boundary-inlet>-name obj))

(defmethod name ((obj <simulation-boundary-outlet>))
  (<simulation-boundary-outlet>-name obj))

(defmethod name-old ((3d-region <3d-region>))
  "Возвращает имя 3d-региона при добавлении."
  (let ((mesh-name (<mesh>-name (<3d-region>-mesh 3d-region))))
    (format nil "D~A ~A" mesh-name mesh-name)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defmethod do-add ((3d-region string) (simulation <simulation>))
  (gtmImport (namestring (<mesh>-msh-pathname
                          (<3d-region>-mesh
                           (3d-region 3d-region simulation))))
             :genopt "-n")
  (gtmAction-rename-Region 
   (name-old (3d-region 3d-region simulation))
   (name (3d-region 3d-region simulation)))
  (loop :for key :in (ht-keys-sort
                      (<mesh>-2d-regions
                       (<3d-region>-mesh
                        (3d-region 3d-region simulation))))
        :do (let ((val (gethash key (<mesh>-2d-regions
                                     (<3d-region>-mesh
                                      (3d-region 3d-region simulation))))))
              (gtmAction-rename-Region
               val
               (format nil "~A ~A" val
                       (<3d-region>-2d-suffix (3d-region 3d-region simulation)))))))

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
                          (Location "DG1 G1,DG1 G1 2,DG10 G10,DG2 G2,DG2 G2 2,DG31 G31,DG31 G31 2,DG32 G32,DG32 G32 2,DG33 G33,DG33 G33 2,DG34 G34,DG34 G34 2,DG41 G41,DG41 G41 2,DG42 G42,DG42 G42 2,DG5 G5,DG5 G5 2,DG6 G6,DG7 G7,DG8 G8,DG9 G9,DG9 G9 2")
                          (Reference-Pressure "1.943 [MPa]"))
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
                                               :reference-pressure Reference-Pressure))
                 :solid-definition nil
                 :solid-models nil 
                 ))

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
                  (domain-solid-names '("M1" "M2" "M3")))
  (let ((doms (loop :for d :in domain-solid-names
                    :collect
                    (mk-domain-solid
                     :domain-name d
                     :location (simulation-solid-domain-mesh-location d simulation)))))
    (push (mk-domain-fluid
           :domain-name domain-fluid-name
           :location (simulation-fluid-domain-location simulation))
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
               (make-instance  '<heat-transfer>
                               :option "Static Temperature"
                               :static-temperature static-temperature
                               :total-temperature  nil))
              (total-temperature
               (make-instance  '<heat-transfer>
                               :option "Total Temperature"
                               :static-temperature nil
                               :total-temperature total-temperature))))
         (boundary-conditions
           (make-instance '<boundary-conditions>
                          :heat-transfer heat-transfer
                          :mass-and-momentum
                          (make-instance  '<mass-and-momentum>
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
  (let* ((mass-and-momentum (cond
                              (Relative-Pressure
                               (make-instance  '<mass-and-momentum>
                                               :option "Static Pressure" 
                                               :momentum-interface-model nil
                                               :Relative-Pressure Relative-Pressure))
                              (Mass-Flow-Rate
                               (make-instance  '<mass-and-momentum>
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
                                         :heat-transfer  nil
                                         :turbulence     nil 
                                         :mass-and-momentum mass-and-momentum))))
    boundary))
