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
       *msh-num*))

;; Вывод на печать
*simulation*

;; Сброс настроек симуляции
(reset *simulation*)

;;;;
(create-script *simulation* t)

(clrhash (<simulation>-3d-regions *simulation*))
(setf (<simulation>-commands *simulation*) nil)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defmethod 2d-regions ((3d-region <3d-region>))
  (loop :for 2d-region
          :in (ht-values
               (<mesh>-2d-regions
                (<3d-region>-mesh 3d-region)))
        :collect (format nil "~A ~A"
                         2d-region
                         (<3d-region>-2d-suffix 3d-region))))

(defmethod interfaces ((3d-region <3d-region>))
  (sort 
   (remove-if #'(lambda (el)
                  (not
                   (uiop:string-prefix-p "C" el)))
              (2d-regions 3d-region))
   #'string<))

(defmethod interfaces-dom ((3d-region <3d-region>) mesh-name-1 mesh-name-2)
  (remove-if
   #'(lambda (el)
       (not
        (mk-pred el di-1 di-2)))
   (interfaces dom dom-sur))
  (interfaces 3d-region)
  )

(2d-regions (second (select-3d-regions-by-mesh-name "G2" *simulation*)))
(interfaces (first (select-3d-regions-by-mesh-name "G1" *simulation*)))
(interfaces-dom (first (select-3d-regions-by-mesh-name "G1" *simulation*))
                "G1" "G2"
                )

(interfaces (ht-values (<simulation>-3d-regions *simulation*)))
(select-3d-regions-by-mesh-name "G1" *simulation*)
(select-3d-regions-name-by-mesh-name "G1" *simulation*)



(defmethod mk-gen-interfaces-n-m (g1 g2 (simulation <simulation>))
  (let* ((d1 (domains g1 simulation))
         (d2 (domains g2 simulation))
         (il1 (apply #'append
                     (mapcar #'(lambda (el) 
                                 (interfaces-dom el g1 g2 simulation))
                             d1)))
         (il2 (apply #'append
                     (mapcar #'(lambda (el) 
                                 (interfaces-dom el g1 g2 simulation))
                             d2))))
    (make-domain-interface-general-connection
     (mnas-string:common-prefix (append il1 il2)) il1 il2))) 

(let ((g1 "G1")
      (g2 "G2")
      (simulation *simulation*))
  (let* ((d1 (select-3d-regions-name-by-mesh-name g1 simulation))
         (d2 (select-3d-regions-name-by-mesh-name g2 simulation)))
    d2))


(select-3d-regions-name-by-mesh-name "G2" *simulation*)
