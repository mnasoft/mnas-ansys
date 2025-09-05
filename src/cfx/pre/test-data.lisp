(in-package :mnas-ansys/cfx/pre)

(defparameter *simulation*
  (make-instance '<simulation>))

(defparameter *tin-pathnames*
  (directory
   (cond
     ((string= (machine-instance) "N000325") "z:/ANSYS/CFX/a32/tin/DOM/*/A32_prj_07_D*.tin")
     (t "~/work/tin/A32_prj_06_D*.tin"))))

(defparameter *msh-pathnames*
  (directory 
   (cond
     ((string= (machine-instance) "N000325") "z:/ANSYS/CFX/a32/msh/prj_07/A32_prj_07_D*.msh")
     (t "~/work/tin/A32_prj_06_D*.tin"))))

(defparameter *msh-num-ang*
  '(("G1"  2 -22.5)
    ("G10" 1 -45.0)
    ("G2"  2 -22.5)
    ("G31" 2 -22.5)
    ("G32" 2 -22.5)
    ("G33" 2 -22.5)
    ("G34" 2 -22.5)
    ("G41" 2 -22.5)
    ("G42" 2 -22.5)
    ("G5"  2 -22.5)
    ("G6"  1 -45.0)
    ("G7"  1 -45.0)
    ("G8"  1 -45.0)
    ("G9"  2 -22.5)
    ("M1"  2 -22.5)
    ("M2"  2 -22.5)
    ("M3"  2 -22.5)))

(defun main-test (simulation msh-num-ang tin-pathnames msh-pathnames)
;;; Загружаем сетки
  (loop :for tin :in tin-pathnames
        :for msh :in msh-pathnames
        :do (add (make-instance '<mesh>
                                :tin-pathname tin 
                                :msh-pathname msh)
                 simulation))
;;; Создаем 3d-регионы
  (loop :for (msh num ang) :in msh-num-ang
        :do (loop :for i :from 0 :below num
                  :do (add (make-instance '<3d-region>
                                          :mesh (mesh msh simulation))
                           simulation)))
;;; Создаем команды для вращения доменов
  (loop :for (msh num ang) :in msh-num-ang
        :do (when (>= num 2)
              (mk-mesh-rotation
               (format nil "D~A ~A 2" msh msh)
               (format nil "~A [degree]" (* ang (1- num)))
               simulation)))
;;; Добавляем материал и реакции
  (add (make-instance '<simulation-materials> :simulation simulation)
       simulation)
;;; Создаем домены
  (add (make-instance '<simulation-flow>
                      :domain-fluid-name (domain-names-fluid simulation)
                      :domain-solid-names (domain-names-solid simulation)
                      :simulation simulation)
       simulation)
;;; Создаем команды для добавления генеральных флюидовых интерфейсов
  (loop :for (mesh-name-1 mesh-name-2) :in (interface-pairs-fluid-general simulation)
        :do (add-interface-general mesh-name-1 mesh-name-2 simulation))
;;; Создаем команды для генерирования вращательных интерфейсов
;;; периодического типа
  (loop :for mesh-name :in (interface-pairs-fluid-rotational simulation)
        :do (add-interface-rot-per mesh-name simulation))
;;; Создаем команды для генерирования вращательных интерфейсов
;;; генерального типа
  (loop :for mesh-name :in (interface-pairs-fluid-rotational simulation)
        :do (add-interface-rot-gen mesh-name simulation))
  simulation)

;;;; Сброс настроек симуляции
#+nil (reset *simulation*)

#+nil (main-test *simulation* *msh-num-ang* *tin-pathnames* *msh-pathnames*)
#+nil (create-script *simulation* t)
#+nil *simulation*



(make-instance '<boundary>
               :name "OUTLET"
               :boundary-type "OUTLET"               
               :location "Some One"
               :boundary-conditions
               (make-instance '<boundary-conditions>
                              :flow-direction nil
                              :heat-transfer  nil
                              :turbulence     nil 
                              :mass-and-momentum
                              (make-instance  '<mass-and-momentum>
                                              :option "Static Pressure" 
                                              :momentum-interface-model nil
                                              :Relative-Pressure "-680 [kPa]")))

(make-instance '<boundary>
               :name "OUTLET AIR RL"
               :boundary-type "OUTLET"
               :location "Some One"
               :boundary-conditions
               (make-instance '<boundary-conditions>
                              :flow-direction nil
                              :heat-transfer  nil
                              :turbulence     nil 
                              :mass-and-momentum
                              (make-instance  '<mass-and-momentum>
                                              :option "Mass Flow Rate" 
                                              :momentum-interface-model nil
                                              :mass-flow-rate "0.5258471 [kg s^-1]")))

(make-instance '<boundary>
               :name "INLET"
               :boundary-type "INLET"
               :location "DG1 B AIR_IN D_32.0,DG1 B AIR_IN D_32.0 2"
               :boundary-conditions
               (make-instance '<boundary-conditions>
                              :heat-transfer
                              (make-instance  '<heat-transfer>
                                              :option "Total Temperature"
                                              :static-temperature nil)
                              :mass-and-momentum
                              (make-instance  '<mass-and-momentum>
                                              :option "Mass Flow Rate" 
                                              :momentum-interface-model nil
                                              :mass-flow-rate "10.557098[kg s^-1]")))

(make-instance  '<mass-and-momentum>
                :momentum-interface-model nil
                :Relative-Pressure "-680 [kPa]"
                )
