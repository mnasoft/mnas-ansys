(in-package :mnas-ansys/cfx/pre)

(defparameter *simulation* nil
  #+nil (make-instance '<simulation>)
  "Ссылка на объект смуляции.")

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

(defun mesh-add (simulation tin-pathnames msh-pathnames)
  ;;; Загружаем сетки
  (loop :for tin :in tin-pathnames
        :for msh :in msh-pathnames
        :do (add (make-instance '<mesh>
                                :tin-pathname tin 
                                :msh-pathname msh)
                 simulation)))

(defun 3d-region-add (simulation msh-num-ang)
  "Создаем 3d-регионы
   Создаем команды для вращения доменов"
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
               simulation))))

(defun materials-add (simulation)
  "Добавляем материал и реакции"
  (add (make-instance '<simulation-materials> :simulation simulation)
       simulation))

(defun flow-add (simulation)
  "Создаем домены и интерфейсы типа флюид - солид"
  (add (make-instance '<simulation-flow>
                      :domain-fluid-name (domain-names-fluid simulation)
                      :domain-solid-names (domain-names-solid simulation)
                      :simulation simulation)
       simulation))

(defun fluid-interface-add (simulation)
  "Создаем команды для добавления флюидовых интерфейсов"
  ;; Генеральных
  (loop :for (mesh-name-1 mesh-name-2) :in (interface-pairs-fluid-general simulation)
        :do (add-interface-general mesh-name-1 mesh-name-2 simulation))
  ;; Вращательных периодического типа
  (loop :for mesh-name :in (interface-pairs-fluid-rotational simulation)
        :do (add-interface-rot-per mesh-name simulation))
  ;; Вращательных генерального типа
  (loop :for mesh-name :in (interface-pairs-fluid-rotational simulation)
        :do (add-interface-rot-gen mesh-name simulation)))

(defun mk-location  (location)
  (locations
   (select-2d-regions
    (concatenate 'string "DG[0-9]* B[0-9]* " location " .*")
    *simulation*)))

(defun fluid-boundary-add (simulation)
  "Добавляем флюидовые граничные условия"
  (labels ((mk-location (location)
             (locations
              (select-2d-regions
               (concatenate 'string "DG[0-9]* B[0-9]* " location " .*")
               simulation))))
    (add (make-instance '<simulation-boundary-inlet>
                        :name "INLET"
                        :mass-flow-rate "10.557098 [kg s^-1]"
                        :total-temperature "455.6 [C]"
                        :location (mk-location "AIR_IN")
                        :components '(("O2" 0.232)))
         simulation)
    (add (make-instance '<simulation-boundary-inlet>
                        :name "INLET CH4 1"
                        :mass-flow-rate "0.02453831 [kg s^-1]"
                        :static-temperature "18.1 [C]"
                        :location (mk-location "G1IN")
                        :components '(("CH4" 1.0)))
         simulation)
    (add (make-instance '<simulation-boundary-inlet>
                        :name "INLET CH4 2"
                        :mass-flow-rate "0.15048356 [kg s^-1]"
                        :static-temperature "18.1 [C]"
                        :location (mk-location "G2IN")
                        :components '(("CH4" 1.0)))
         simulation)
    (add (make-instance '<simulation-boundary-outlet> 
                        :name "OUTLET"
                        :location (mk-location "OUT")
                        :Relative-Pressure "-680 [kPa]")
         simulation)
    (add (make-instance '<simulation-boundary-outlet> 
                        :name "OUTLET AIR RL"
                        :location (mk-location "AIR_RL")
                        :Mass-Flow-Rate "0.5258471 [kg s^-1]")
         simulation)
    (add 
     (make-instance '<simulation-boundary-outlet> 
                    :name "OUTLET AIR SA"
                    :location (mk-location "SA_OUT")
                    :Mass-Flow-Rate "0.5323591 [kg s^-1]")
     simulation)
    (add
     (make-instance '<simulation-boundary-outlet> 
                    :name "OUTLET AIR SL"
                    :location (mk-location "SAOUT")
                    :Mass-Flow-Rate "0.5258471 [kg s^-1]")
     simulation )))

(defun simulation-solver-add (simulation)
  "Добавляем: единицы измерения - SOLUTION UNITS; управление солвером -
SOLVER CONTROL"
  (add (make-instance '<simulation-solver>) simulation))

(defun simulation-control-add (simulation)
  "Добавляем настройку хостовSOLVER CONTROL"
  (add (make-instance '<simulation-control>) *simulation*))

(defmethod print-object ((obj <simulation-control>) s)
  (print-unreadable-object (obj s :type t)))

(defun simulation-setup-test (simulation msh-num-ang)
  "Выполняем настройку симуляции"
  ;; Создаем 3d-регионы
  (3d-region-add simulation msh-num-ang)
  ;; Добавляем материал и реакции
  (materials-add simulation)
  ;; Создаем домены и интерфейсы типа флюид - солид
  (flow-add  simulation)
  ;; Создаем флюидовые интерфейсы
  (fluid-interface-add simulation)
  ;; Создаем флюидовые интерфейсы  
  (fluid-boundary-add  simulation)
  ;; 
  (simulation-solver-add simulation)
  (simulation-control-add simulation))

(defun main-test (msh-num-ang tin-pathnames msh-pathnames)
  "Пример главной настроечной функции (точки входа).
Глобальная переменная - *simulation*.
"
  (unless *simulation*
    ;; Создаем симуляцию 
    (setf *simulation* (make-instance '<simulation>))
    ;; Загружаем сетки 
    (mesh-add *simulation* tin-pathnames msh-pathnames))
  ;; Выполняем настройку симуляции
  (simulation-setup-test *simulation* msh-num-ang)
  *simulation*)

;;;; Сброс настроек симуляции
#+nil (reset *simulation*)

#+nil (main-test *msh-num-ang* *tin-pathnames* *msh-pathnames*)

#+nil (create-script *simulation* t)

#+nil *simulation*

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(loop :for i :in
             (append
              (select-2d-regions "C G1 G[0-9].*.*" *simulation*)
              (select-2d-regions "C G2 G2.*"       *simulation*)
              (select-2d-regions "C G2 G6.*"       *simulation*))
      :do (mk-mfr-region i))

(mk-mfr-region "C G2 G2 R GT D_4.0 4")

mnas-ansys/ccl/core:<monitor-point>
