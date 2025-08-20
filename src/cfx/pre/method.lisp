;;;; ./src/cfx/pre/method.lisp

(in-package :mnas-ansys/cfx/pre)

(defun underscore-name-by-pathname (pathname)
  "@b(Описание:) функция @b(underscore-name-by-pathname) выделяет из пути
@b(pathname) последнюю часть имени перед которой стоит знак подчерка.

 @b(Пример использования:)
@begin[lang=lisp](code)
  (underscore-name-by-pathname #P\"z:/ANSYS/CFX/a32/tin/DOM/G5/A32_prj_06_DG10.tin\") => \"DG10\"
@end(code)"
  (first 
   (nreverse
    (ppcre:split "_" (pathname-name pathname)))))

(defun domain-name-by-pathname (pathname)
  "@b(Описание:) функция @b(domain-name-by-pathname) возвращает имя
домена основываясь на имени tin-файла.

 @b(Пример использования:)
@begin[lang=lisp](code)
 (domain-name-by-pathname #P\"z:/ANSYS/CFX/a32/tin/DOM/G5/A32_prj_06_DG10.tin\") => \"G10\"
@end(code)"
  (tail-of-string
   (underscore-name-by-pathname pathname)))

(defun mesh-name->domain-name (mesh-name)
  "@b(Описание:) функция @b(mesh-name->domain-name) возвращает имя домена
на основании имени сетки.
 
 @b(Пример использования:)
@begin[lang=lisp](code)
 (mesh-name->domain-name \"G1\") => \"DG1 G1\"
@end(code)"
  (concatenate 'string "D" mesh-name " " mesh-name))

(defun domain-name->mesh-name (domain-name)
  "@b(Описание:) функция @b(domain-name->mesh-name) возвращает имя сетки
на основании имени домена.
 
 @b(Пример использования:)
@begin[lang=lisp](code)
 (domain-name->mesh-name \"DG1 G1\") => \"G1\"
@end(code)"
  (second (ppcre:split " " domain-name)))

(defmethod next-domain-name ((mesh-name string) (cfx-domains <simulation>))
  "@b(Описание:) метод @b(next-domain-name) возвращает следующее
доступное имя для домена при вставке сетки в симуляцию CFX.
"
  (when (gethash mesh-name (<meshes>-meshes cfx-domains))
    (let ((d-name (mesh-name->domain-name mesh-name)))
      (if (gethash d-name (<simulation>-domains cfx-domains))
          (loop :for i :from 2 
                :do
                   (unless (gethash (format nil "~A ~D" d-name i)
                                    (<simulation>-domains cfx-domains))
                     (return-from next-domain-name (format nil "~A ~D" d-name i))))
          d-name))))

(defun name-icem->cfx (name)
  (ppcre:regex-replace-all "[/-]" name " "))


(defmethod next-surface-name ((mesh-name string) (cfx-domains <simulation>))
  (let ((surface-name (name-icem->cfx mesh-name)))
    (if (gethash surface-name (<simulation>-surfaces cfx-domains))
          (loop :for i :from 2 
                :do
                   (unless (gethash (format nil "~A ~D" surface-name i)
                                    (<simulation>-surfaces cfx-domains))
                     (return-from next-surface-name (format nil "~A ~D" surface-name i))))
          surface-name)))

#+nil
(defun check-equality (variable string)
  (equalp 
   (sort (ppcre:split "," variable) #'string<)
   (sort
    (alexandria:hash-table-values
     (<domain>-surfaсes
      (gethash string
               (<simulation>-domains *simulation*))))
    #'string<)))

(defun check-equality (variable string)
  (let ((control (sort (ppcre:split "," variable) #'string<))
        (test (sort
               (alexandria:hash-table-values
                (<domain>-surfaсes
                 (gethash string
                          (<simulation>-domains *simulation*))))
               #'string<)))
    
    (if  (equalp control test) t
         (let ((u (union control test :test #'equal)))
           (list string
           (set-difference u test     :test #'equal)
           (set-difference u control  :test #'equal))))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
#+nil 
(defmethod suffix (mesh-surface-name (domain <domain>))
  "Возвращает строку, которая представляет суффикс. Он добавляется к
имени преобразованному из именного соглашения ICEM в именное
соглашение CFX.

 @b(Пример использования:)
@begin[lang=lisp](code)
 (suffix \"C/G1-G2/X_049.5/D_1.0\" (domain \"DG2 G2\" *simulation*))
@end(code)"
  (extract-suffix (name-icem->cfx  mesh-surface-name)
                  (gethash mesh-surface-name (<domain>-surfaсes domain))))

(defmethod suffix (mesh-surface-name (simulation <simulation>))
  "Возвращает список суффиксов для поверхности и с менем @b(mesh-surface-name),
представленном в именном соглашении ICEM, для симуляции @b(simulation).

 @b(Пример использования:)
@begin[lang=lisp](code)
 (suffix \"C/G1-G2/X_075.0/PPR_D_0.0\" *simulation*)
@end(code)"
  #+nil
  (sort 
   (loop :for d :in (domains simulation)
         :when (suffix mesh-surface-name (domain d simulation)) 
           :collect :it)
   #'string<)
  (loop :for d :in (domains simulation)
         :when (suffix mesh-surface-name (domain d simulation)) 
           :collect :it))



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

(defmacro mk-interface-general (mesh-name-1 mesh-name-2 simulation)
  `(add
    (make-instance
     '<simulation-interface-general>
     :mesh-name-1 ,mesh-name-1
     :mesh-name-2 ,mesh-name-2
     :simulation ,simulation)
    ,simulation))

(defmacro mk-interface-rot-per (mesh-name simulation)
  `(add
    (make-instance
     '<simulation-interface-rotational-periodicity>
     :mesh-name ,mesh-name
     :simulation ,simulation)
    ,simulation))

(defmacro mk-interface-rot-gen (mesh-name simulation)
  `(add
    (make-instance
     '<simulation-interface-rotational-general>
     :mesh-name ,mesh-name
     :simulation ,simulation)
    ,simulation))

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
