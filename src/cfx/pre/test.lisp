;;;; ./src/cfx/pre/test.lisp

(in-package :mnas-ansys/cfx/pre)

(progn 
  (defparameter *simulation*
    (make-instance '<simulation>))

  (defparameter *msh-num*
    '(("G1"  2)
      ("G10" 1)
      ("G2"  2)
      ("G31" 2)
      ("G32" 2)
      ("G33" 2)
      ("G34" 2)
      ("G41" 2)
      ("G42" 2)
      ("G5"  2)
      ("G6"  1)
      ("G7"  1)
      ("G8"  1)
      ("G9"  2)
      ("M1"  2)
      ("M2"  2)
      ("M3"  2)))
  
;; Загружаем сетки
  (map nil
     #'(lambda (tin msh)
         (add (make-instance '<mesh>
                             :tin-pathname tin 
                             :msh-pathname msh)
              *simulation*))
     (directory
      (cond
        ((string= (machine-instance) "N000325") "z:/ANSYS/CFX/a32/tin/DOM/*/A32_prj_07_D*.tin")
        (t "~/work/tin/A32_prj_06_D*.tin")))
     (directory
      (cond
        ((string= (machine-instance) "N000325") "z:/ANSYS/CFX/a32/msh/prj_07/A32_prj_07_D*.msh")
        (t "~/work/tin/A32_prj_06_D*.tin")))))

(progn
;; Создаем 3d-регионы
  (map nil
       #'(lambda (msh-num)
           (loop :for i :from 0 :below (second msh-num)
                 :do
                    (add
                     (make-instance '<3d-region>
                                    :mesh (mesh (first msh-num) *simulation*))
                     *simulation*)))
       *msh-num*)

;; Создаем команды для вращения доменов
  (map nil
       #'(lambda (msh-num)
           (let ((msh (first msh-num))
                 (num (second msh-num)))
             (when (= num 2)
               (mk-mesh-rotation (format nil "D~A ~A 2" msh msh)
                                 "-22.5 [degree]"
                                 *simulation*))))
       *msh-num*)
;; Создаем команды для добавления генеральных флюидовых интерфейсов
(map nil
     #'(lambda (el)
         (mk-interface-general (first el)  (second el) *simulation*))
     '(("G1"  "G2")
       ("G1"  "G32")
       ("G1"  "G33")
       ("G1"  "G42")
       ("G1"  "G5")
       ("G1"  "G9")
       ("G2"  "G32")
       ("G2"  "G42")
       ("G2"  "G5")
       ("G2"  "G9")
       ("G31" "G32")
       ("G32" "G34")
       ("G33" "G34")
       ("G41" "G42")
       ("G6"  "G7")
       ("G1"  "G8")
       ("G1"  "G10")
       ("G2"  "G6"))))

(map nil
     #'(lambda (el)
         (mk-interface-rot-per el *simulation*))
     '("G1" "G2" "G6" "G7" "G8" "G10"))

 


mk-interface-rot-per

;; Вывод на печать
*simulation*

;; Сброс настроек симуляции
(reset *simulation*)

;;;;
(create-script *simulation* t)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(progn
  (mk-gen-interfaces-n-m "G1"  "G2"  *simulation*)
  (mk-gen-interfaces-n-m "G1"  "G32" *simulation*)
  (mk-gen-interfaces-n-m "G1"  "G33" *simulation*)
  (mk-gen-interfaces-n-m "G1"  "G42" *simulation*)
  (mk-gen-interfaces-n-m "G1"  "G5"  *simulation*)
  (mk-gen-interfaces-n-m "G1"  "G9"  *simulation*)
  (mk-gen-interfaces-n-m "G2"  "G32" *simulation*)
  (mk-gen-interfaces-n-m "G2"  "G42" *simulation*)
  (mk-gen-interfaces-n-m "G2"  "G5"  *simulation*)
  (mk-gen-interfaces-n-m "G2"  "G9"  *simulation*)
  (mk-gen-interfaces-n-m "G31" "G32" *simulation*)
  (mk-gen-interfaces-n-m "G32" "G34" *simulation*)
  (mk-gen-interfaces-n-m "G33" "G34" *simulation*)
  (mk-gen-interfaces-n-m "G41" "G42" *simulation*)
  (mk-gen-interfaces-n-m "G6"  "G7"  *simulation*)
  
  ;; Генеральные кратность n-m
  (mk-gen-interfaces-n-m "G1"  "G8" *simulation*)
  (mk-gen-interfaces-n-m "G1" "G10" *simulation*)
  (mk-gen-interfaces-n-m "G2"  "G6" *simulation*)
  
  ;; Вращательные периодичные кратность n-m
  (mk-rot-per-interfaces-n-m "G1" *simulation*)
  (mk-rot-per-interfaces-n-m "G2" *simulation*)
  (mk-rot-per-interfaces-n-m "G6" *simulation*)
  (mk-rot-per-interfaces-n-m "G7" *simulation*)
  (mk-rot-per-interfaces-n-m "G8" *simulation*)
  (mk-rot-per-interfaces-n-m "G10" *simulation*)
  
  ;; Вращательные генеральные
  (mk-rot-gen-interfaces-n-m "G1" *simulation*)
  (mk-rot-gen-interfaces-n-m "G2" *simulation*)
  (mk-rot-gen-interfaces-n-m "G6" *simulation*)
  (mk-rot-gen-interfaces-n-m "G7" *simulation*)
  (mk-rot-gen-interfaces-n-m "G8" *simulation*)
  (mk-rot-gen-interfaces-n-m "G10" *simulation*))

