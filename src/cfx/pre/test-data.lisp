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
  
;;; Добавляем флюидовые граничные условия
  (add 
   (make-instance '<simulation-boundary-inlet>
                  :name "INLET"
                  :mass-flow-rate "10.557098 [kg s^-1]"
                  :total-temperature "455.6 [C]"
                  :location "DG1 B AIR_IN D_32.0,DG1 B AIR_IN D_32.0 2"
                  :components '(("O2" 0.232)))
   *simulation*)
  
  simulation)

;;;; Сброс настроек симуляции
#+nil (reset *simulation*)

#+nil (main-test *simulation* *msh-num-ang* *tin-pathnames* *msh-pathnames*)
#+nil (create-script *simulation* t)
#+nil *simulation*

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;
(add 
 (make-instance '<simulation-boundary-inlet>
                :name "INLET"
                :mass-flow-rate "10.557098 [kg s^-1]"
                :total-temperature "455.6 [C]"
                :location "DG1 B AIR_IN D_32.0,DG1 B AIR_IN D_32.0 2"
                :components '(("O2" 0.232))
                ;;:simulation *simulation*
                )
 *simulation*)

(create-script
 (make-instance '<simulation-boundary-inlet>
                :name "INLET"
                :mass-flow-rate "10.557098 [kg s^-1]"
                :total-temperature "455.6 [C]"
                :location "DG1 B AIR_IN D_32.0,DG1 B AIR_IN D_32.0 2"
                :components '(("O2" 0.232))
                :simulation *simulation*)
 t)

(create-script
 (make-instance '<simulation-boundary-inlet>
                :name "INLET CH4 1"
                :mass-flow-rate "0.02453831 [kg s^-1]"
                :static-temperature "18.1 [C]"
                :location "DG31 B31 G1IN 01 D_0.0,DG31 B31 G1IN 01 D_0.0 2"
                :components '(("CH4" 1.0))
                :simulation *simulation*)
 t)

(create-script
 (make-instance '<simulation-boundary-inlet>
                :name "INLET CH4 2"
                :mass-flow-rate "0.15048356 [kg s^-1]"
                :static-temperature "18.1 [C]"
                :location "DG41 B41 G2IN 01 D_0.0,DG41 B41 G2IN 01 D_0.0 2"
                :components '(("CH4" 1.0))
                :simulation *simulation*)
 t)

(create-script
 (make-instance '<simulation-boundary-outlet> 
                :name "OUTLET"
                :location "DG7 B OUT D_4.0_S_1.0"
                :Relative-Pressure "-680 [kPa]"
                :simulation *simulation*)
 t)

(create-script
 (make-instance '<simulation-boundary-outlet> 
                :name "OUTLET"
                :location "DG7 B OUT D_4.0_S_1.0"
                :Relative-Pressure "-680 [kPa]"
                :simulation *simulation*)
 t)

(create-script
 (make-instance '<simulation-boundary-outlet> 
                :name "OUTLET AIR RL"
                :location "DG1 B AIR_RL D_5.0,DG1 B AIR_RL D_5.0 2"
                :Mass-Flow-Rate "0.5258471 [kg s^-1]"
                :simulation *simulation*)
 t)

(create-script
 (make-instance '<simulation-boundary-outlet> 
                :name "OUTLET AIR SA"
                :location "DG8 B SA_OUT D_8.0"
                :Mass-Flow-Rate "0.5323591 [kg s^-1]"
                :simulation *simulation*)
 t)

(create-script
 (make-instance '<simulation-boundary-outlet> 
                :name "OUTLET AIR SL"
                :location "DG10 B SAOUT D_16.0"
                :Mass-Flow-Rate "0.5258471 [kg s^-1]"
                :simulation *simulation*)
 t)
