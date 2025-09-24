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
  "Создаем домены и интерфейсы типа флюид - солид.

 @b(Пример использования:)
@begin[lang=lisp](code)
 (flow-add *simulation*)
@end(code)
"
  (add (make-instance '<simulation-flow>
                      :domain-fluid-name (domain-names-fluid simulation)
                      :domain-solid-names (domain-names-solid simulation)
                      :reference-pressure "1.943 [MPa]"
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
  "Добавляем настройку хостов SOLVER CONTROL"
  (add (make-instance '<simulation-control>) *simulation*))

(defun simulation-monitor-point-region-add (simulation)
  "Добавляем мониторы, связанные с регионами"
  (add (make-instance '<simulation-monitor-point-region>
                      :prefix "MFR"
                      :2d-regions-template
                      '("C G1 G[0-9].*.*" "C G2 G2.*" "C G2 G6.*" ))
       simulation))

(defun simulation-monitor-point-add (simulation)
  (let ((locations
          (mapcar #'name
                  (remove-if-not
                   #'(lambda (el)
                       (or 
                        (eq (type-of el) '<simulation-boundary-inlet>)
                        (eq (type-of el) '<simulation-boundary-outlet>)))
                   (<simulation>-commands simulation)))))
    (push "C G2 G6 Side 1" locations)
    (add (make-instance  '<simulation-monitor-point>
                         :prefix-expression '(("MFR" "massFlow()")
                                              ("TP" "massFlowAve(Total Pressure)")
                                              ("TT" "massFlowAve(Total Temperature)"))
                         :locations locations)
         simulation)))

#+nil
(defun simulation-monitor-point-named-points-add (simulation)
  "Добавляем мониторы, связанные с регионами" 
  (add (make-instance '<simulation-monitor-point-named-points>
                      :prefix "GT R OUT"
                      :domain-name "D1"
                      :named-points a32-base::*named-points-r*
                      :output-variables-list '("Total Temperature" "Density" "Velocity u"))
       simulation)
  (add (make-instance '<simulation-monitor-point-named-points>
                      :prefix "GT L OUT"
                      :domain-name "D1"
                      :named-points a32-base::*named-points-l*
                      :output-variables-list '("Total Temperature" "Density" "Velocity u"))
       simulation)
  (add (make-instance '<simulation-monitor-point-named-points>
                      :prefix "SA IN"
                      :domain-name "D1"
                      :named-points a32-base::*sa-name-point-list*
                      :output-variables-list '("Total Temperature"))
       simulation)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  (add (make-instance '<simulation-monitor-point-named-points>
                      :prefix "GT R 05"
                      :domain-name "M1"
                      :named-points a32-base::*gt05-r-tc*
                      :output-variables-list '("Temperature"))
       simulation)

  (add (make-instance '<simulation-monitor-point-named-points>
                      :prefix "GT R 13"
                      :domain-name "M1"
                      :named-points a32-base::*gt13-r-tc*
                      :output-variables-list '("Temperature"))
       simulation)
  (add (make-instance '<simulation-monitor-point-named-points>
                      :prefix "GT R 06"
                      :domain-name "M1"
                      :named-points a32-base::*gt06_12-r-tc*
                      :output-variables-list '("Temperature"))
       simulation)
;;;;
  (add (make-instance '<simulation-monitor-point-named-points>
                      :prefix "GT L 05"
                      :domain-name "M1"
                      :named-points a32-base::*gt05-l-tc*
                      :output-variables-list '("Temperature"))
       simulation)
  (add (make-instance '<simulation-monitor-point-named-points>
                      :prefix "GT L 13"
                      :domain-name "M1"
                      :named-points a32-base::*gt13-l-tc*
                      :output-variables-list '("Temperature"))
       simulation)
  (add (make-instance '<simulation-monitor-point-named-points>
                      :prefix "GT L 06" 
                      :domain-name "M1"
                      :named-points a32-base::*gt06_12-l-tc* 
                      :output-variables-list '("Temperature"))
       simulation)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  (add (make-instance '<simulation-monitor-point-named-points>
                      :prefix "GU R"
                      :domain-name "M2"
                      :named-points a32-base::*gu01-02-r-tc*
                      :output-variables-list '("Temperature"))
       simulation)
  (add (make-instance '<simulation-monitor-point-named-points>
                      :prefix "GU L"
                      :domain-name "M2"
                      :named-points a32-base::*gu01-02-l-tc*
                      :output-variables-list '("Temperature"))
       simulation))

(defun simulation-setup-test (simulation msh-num-ang
                              &key
                                (3d-region t)
                                (materials t)
                                (flow t)
                                (fluid-interface t)
                                (fluid-boundary t)
                                (monitor-point-region t)
                                (monitor-point t)
                                (monitor-point-named-points t)
                                (solver-add t)
                                (control-add t)
                                )
  "Выполняет настройку симуляции"
  (reset simulation)
  (when 3d-region                       ; Создаем 3d-регионы
    (3d-region-add simulation msh-num-ang))
  (when materials                       ; Добавляем материал и реакции
    (materials-add simulation))
  (when flow          ; Создаем домены и интерфейсы типа флюид - солид
    (flow-add  simulation))
  (when fluid-interface                 ; Создаем флюидовые интерфейсы
    (fluid-interface-add simulation))
  (when fluid-boundary                  ; Создаем флюидовые интерфейсы
    (fluid-boundary-add  simulation))
  (when monitor-point-region          ; Добавляем мониторы связанные с
                                      ; сечениями массового расхода
    (simulation-monitor-point-region-add simulation))
  (when monitor-point                 ; Добавляем мониторы связанные с
                                      ; граничными условиями
    (simulation-monitor-point-add simulation))
  (when monitor-point-named-points      ; Добавляем мониторы по точкам
    (simulation-monitor-point-named-points-add simulation))
  (when solver-add                  ; Задаем единицы измерения солвера
    (simulation-solver-add simulation))
  (when control-add                 ; Добавляем настройку хостов
                                    ; SOLVER CONTROL
    (simulation-control-add simulation)))

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
  (simulation-setup-test *simulation* msh-num-ang
                         :3d-region nil
                         :materials nil
                         :flow nil
                         :fluid-interface nil
                         :fluid-boundary nil
                         :monitor-point-region nil
                         :monitor-point nil
                         :monitor-point-named-points nil
                         :solver-add nil
                         :control-add nil)
  *simulation*)

;;;; Сброс настроек симуляции
#+nil (reset *simulation*)

#+nil (main-test *msh-num-ang* *tin-pathnames* *msh-pathnames*)

#+nil (create-script *simulation* t)

#+nil *simulation*

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

#+nil
(create-script (nth 0 (<simulation>-commands *simulation*)) t)
