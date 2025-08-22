;;;; ./src/cfx/pre/not-used.lisp

(in-package :mnas-ansys/cfx/pre)

(defmethod icem-fluid-domains ((cfx-domains <simulation>))
  (let ((rez nil))
    (alexandria:maphash-keys
     #'(lambda (el)
         (push (first (ppcre:split "/" el)) rez))
     (<simulation>-icem-parts cfx-domains))
    (mapcar
     #'tail-of-string
     (sort
      (remove-duplicates
       (remove-if
        #'(lambda (el)
            (cond ((string= "C" el))
                  ((string= "DG0" el))))
        rez)
       :test #'equal)
      #'string<))))

(defmethod icem-solid-domains ((obj <simulation>))
  (let ((rez nil))
    (alexandria:maphash-keys
     #'(lambda (el)
         (push (second (ppcre:split "/" el)) rez))
     (<simulation>-icem-parts obj))
    (sort 
     (remove-duplicates 
      (remove-if
       #'(lambda (el)
           (or
            (funcall (complement #'is-starts-with-capital-m-p) el)
            (is-dash-string el)
            (string= "M0" el)))
       rez)
      :test #'equal)
     #'string<)))

(defmethod icem-domains ((obj <simulation>))
  (append
   (icem-fluid-domains obj)
   (icem-solid-domains obj)))

(defmethod icem-fluid-domain-p (domain-name (cfx-domains <simulation>))
  (not (null (member domain-name (icem-fluid-domains cfx-domains) :test #'equal))))

(defmethod icem-solid-domain-p (domain-name (cfx-domains <simulation>))
  (not (null (member domain-name (icem-solid-domains cfx-domains) :test #'equal))))

(defmethod find-icem-surfaces (domain-name (cfx-domains <simulation>))
  (let ((rez nil))
    (cond
      ((icem-fluid-domain-p domain-name cfx-domains)
       (alexandria:maphash-keys
        #'(lambda (key)
            (when
                (is-icem-fluid-surface key domain-name)
              (push key rez)))
        (<simulation>-icem-parts cfx-domains)))

      ((icem-solid-domain-p domain-name cfx-domains)
       rez))
    rez))

(defmethod fluid-domains ((cfx-domains <simulation>))
  " @b(Пример использования:)
@begin[lang=lisp](code)
 (fluid-domains  *ds*)
@end(code)"
  (remove-if #'(lambda (el)
                 (not
                  (uiop:string-prefix-p "DG" el)))
             (all-domains cfx-domains)))

(defmethod solid-domains ((cfx-domains <simulation>))
  " @b(Пример использования:)
@begin[lang=lisp](code)
 (solid-domains  *ds*)
@end(code)"
  (remove-if #'(lambda (el)
                 (not
                  (uiop:string-prefix-p "DM" el)))
             (all-domains cfx-domains)))

(defmethod faces (dom (cfx-domains <simulation>))
  (second (assoc dom (<simulation>-data cfx-domains) :test #'equal)))

(defmethod interfaces (dom (cfx-domains <simulation>))
  (sort 
   (remove-if #'(lambda (el)
                  (not
                   (uiop:string-prefix-p "C" el)))
              (faces dom cfx-domains))
   #'string<))

(defmethod find-body (body-name (cfx-domains <simulation>))
  "
 @b(Пример использования:)
@begin[lang=lisp](code)
 (domains \"G8\" *i*)
@end(code)
"
  (sort
   (remove-if #'(lambda (el)
               (not
                (uiop:string-prefix-p
                 (concatenate 'string "D" body-name " ")
                 el)))
           (all-domains cfx-domains))
   #'string<))

(defmethod interfaces-dom (dom di-1 di-2 (cfx-domains <simulation>))
  "
 @b(Пример использования:)
@begin[lang=lisp](code)
 (interfaces-dom \"DG1 G1 2\" \"G1\" \"G2\" *ds*)
@end(code)
"
  (labels ((mk-pred (name D1 D2 )
             (let ((splited-name (ppcre:split  " " name)))
               (and
                (string= (first splited-name) "C")
                (or
                 (and (string= (second splited-name) D1) (string= (third  splited-name) D2))
                 (and (string= (second splited-name) D2) (string= (third  splited-name) D1)))))))
    (sort 
     (remove-if #'(lambda (el)
                    (not
                     (mk-pred el di-1 di-2)))
                (interfaces dom cfx-domains))
     #'string<)))

(defmethod mk-gen-interfaces-1-1 (dom-1 dom-2 di-1 di-2 (cfx-domains <simulation>) &key (postfix ""))
  (loop :for i1 :in (interfaces-dom  dom-1 di-1 di-2 cfx-domains)
        :for i2 :in (interfaces-dom dom-2 di-1 di-2 cfx-domains)
        :collect
        (make-domain-interface-general-connection
         (mnas-string:common-prefix (list i1 i2)) i1 i2 :postfix postfix)))

(defmethod mk-gen-interfaces-n-m (g1 g2 (cfx-domains <simulation>))
  (let* ((d1 (domains g1 cfx-domains))
         (d2 (domains g2 cfx-domains))
         (il1 (apply #'append
                     (mapcar #'(lambda (el) 
                                 (interfaces-dom el g1 g2 cfx-domains))
                             d1)))
         (il2 (apply #'append
                     (mapcar #'(lambda (el) 
                                 (interfaces-dom el g1 g2 cfx-domains))
                             d2))))
    (make-domain-interface-general-connection
     (mnas-string:common-prefix (append il1 il2)) il1 il2)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; Функции для создания вращательного интерфейса
;;;; Вращательная часть

(defmethod domain-min (g1 (cfx-domains <simulation>))
  (let ((doms (domains g1 cfx-domains)))
    (first (sort doms #'string<))))

(defmethod domain-max (g1 (cfx-domains <simulation>))
  (let ((doms (domains g1 cfx-domains)))
    (first (sort doms #'string>))))

(defmethod int-rot-max (g1 (cfx-domains <simulation>))
  (let ((d-max (domain-max g1 cfx-domains)))
    (sort 
     (loop :for i :in (interfaces-dom d-max g1 g1 cfx-domains)
           :when (some #'(lambda (el) (string= "L" el))
                       (mnas-ansys/ccl:mk-split i))
             :collect i)
     #'string<)))


(defmethod int-rot-min (g1 (cfx-domains <simulation>))
  (let ((d-max (domain-min g1 cfx-domains)))
    (sort 
     (loop :for i :in (interfaces-dom d-max g1 g1 cfx-domains)
           :when (some #'(lambda (el) (string= "R" el))
                       (mnas-ansys/ccl:mk-split i))
             :collect i)
     #'string<)))



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; Функции для создания вращательного интерфейса
;;;; Генеральная часть

(defmethod domains-left (g1 (cfx-domains <simulation>))
  (let ((doms (domains g1 cfx-domains)))
   (cdr (reverse doms))))

(defmethod domains-right (g1 (cfx-domains <simulation>))
  (let ((doms (domains g1 cfx-domains)))
    (cdr doms)))

(defmethod int-rot-left (g1 (cfx-domains <simulation>))
  (let ((d-left (domains-left g1 cfx-domains)))
    (sort
     (apply #'append 
            (loop :for d :in d-left
                  :collect
                  (loop :for i :in (interfaces-dom d g1 g1 cfx-domains)
                        :when (some #'(lambda (el) (string= "L" el))
                                    (mnas-ansys/ccl:mk-split i))
                          :collect i)))
     #'string<)))

(defmethod int-rot-right (g1 (cfx-domains <simulation>))
  (let ((d-left (domains-right g1 cfx-domains)))
    (sort
     (apply #'append 
            (loop :for d :in d-left
                  :collect
                  (loop :for i :in (interfaces-dom d g1 g1 cfx-domains)
                        :when (some #'(lambda (el) (string= "R" el))
                                    (mnas-ansys/ccl:mk-split i))
                          :collect i)))
     #'string<)))
    
(defmethod mk-rot-gen-interfaces-n-m (g1 (cfx-domains <simulation>) &key (postfix "ROT GEN"))
  (let* ((i-left  (int-rot-left g1 cfx-domains))
         (i-right (int-rot-right g1 cfx-domains)))
    (when (and i-left i-right)
      (make-domain-interface-general-connection
       (mnas-string:common-prefix (append i-left i-right)) i-left i-right
       :postfix postfix))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defmethod domains-surs (doms (cfx-domains <simulation>))
  (apply #'append
         (mapcar
          #'(lambda (dom)
              (faces dom cfx-domains))
          doms)))

(defmethod fluid-surs (s-body-name (cfx-domains <simulation>))
  (let ((surs (domains-surs (fluid-domains cfx-domains) cfx-domains)))
    (sort 
    (remove-if
     #'(lambda (el)
         (or (not (uiop:string-prefix-p "DG" el))
         (string/= s-body-name (second (mnas-ansys/ccl:mk-split el)))))
     surs)
    #'string<)))

(defmethod solid-surs (s-body-name (cfx-domains <simulation>))
  (let ((surs (domains-surs (solid-domains cfx-domains) cfx-domains)))
    (sort 
     (remove-if
      #'(lambda (el)
          (or (uiop:string-prefix-p "DG0" el)
              (not (uiop:string-prefix-p "DG" el))
              (string/= s-body-name (second (mnas-ansys/ccl:mk-split el)))))
      surs)
     #'string<)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; Создание интерфесов типа флюид-солид

(defmethod mk-f-s-interface-n-m (fluid-dom solid-dom (cfx-domains <simulation>))
  "
 @b(Пример использования:)
@begin[lang=lisp](code)
 (mk-f-s-interface-n-m \"D1\" \"M3\" *i*)
@end(code)
"
  (make-f-s-interface-general-connection
   fluid-dom
   solid-dom
   (fluid-surs solid-dom cfx-domains)
   (solid-surs solid-dom cfx-domains)))

(defmethod bodys ((cfx-domains <simulation>))
  (remove-duplicates 
   (loop :for i :in (all-domains cfx-domains)
         :collect
         (second (ppcre:split " " i)))
   :test #'equal))


(defmethod bodys-of-fluid ((cfx-domains <simulation>))
    "
 @b(Пример использования:)
@begin[lang=lisp](code)
 (bodys-of-fluid *ds*)
 => (\"G1\" \"G2\" \"G31\" \"G32\" \"G33\" \"G34\" \"G41\" \"G42\" \"G5\" \"G6\" \"G7\" \"G8\" \"G9\" \"G10\")
@end(code)"
  (loop :for i :in (bodys cfx-domains)
        :when (uiop:string-prefix-p "G" i)
          :collect i))

(defmethod bodys-of-solid ((cfx-domains <simulation>))
  "
 @b(Пример использования:)
@begin[lang=lisp](code)
 (bodys-of-solid *ds*)  => (\"M1\" \"M2\" \"M3\")
@end(code)"
  (loop :for i :in (bodys cfx-domains)
        :when (uiop:string-prefix-p "M" i)
          :collect i))

(bodys-of-solid *simulation*)

(defun rotate-around (named-points p-axis-start p-axis-end teta)
  "Функция вращает именованные точки повернутые вокруг оси, определяемой
точками p-axis-start p-axis-end на угол teta."
  (let ((rotate-teta (math/matr:rotate-around p-axis-start p-axis-end teta))) ;; Определяем матрицу поворота
    (loop :for (name p) :in named-points
          :collect (list name (math/matr:transform p rotate-teta)))))

;;;; ./src/cfx/pre/test.lisp

(in-package :mnas-ansys/cfx/pre)

(defun foo (pathname directory)
  (namestring
   (make-pathname :directory directory
                  :name (pathname-name pathname)
                  :type (pathname-type pathname))))

(map
 nil
 #'(lambda (el)
     (uiop:copy-file el (foo el "//n000339/Users/namatv/pp")))
 (directory "z:/ANSYS/CFX/a32/tin/DOM/*/A32_prj_06_*.tin"))

(defun next-suffix (domain-suffix simulation-suffixes)
  (cond
    ((and (string= domain-suffix "")
          (equalp '("") simulation-suffixes))
     "2")
    ((and (string= domain-suffix "")
          (equalp '("" "2") simulation-suffixes))
     "3")
    ((and (string= domain-suffix "2")
          (equalp '("" "3" "2") simulation-suffixes))
     "3")
    ((and (string= domain-suffix "2")
          (equalp '("" "2") simulation-suffixes))
     "3")
    (t
     (break "~S ~S" domain-suffix simulation-suffixes
            ))))

(defun next-surface-by-suffix (name domain-suffix simulation-suffixes)
  (concatenate 'string name " " (next-suffix domain-suffix simulation-suffixes)))

(defmethod insert-to-domain-copy ((surface-key string)
                                  (domain <3d-region>)
                                  (domain-copy <3d-region>))
  (let* ((simulation  (<3d-region>-parent domain))
        (surface-value (next-surface-by-suffix (name-icem->cfx surface-key)
                          (suffix surface-key domain)
                          (suffix surface-key simulation))))
    ;; добавляем поверхность в домен
    (setf (gethash surface-key (<3d-region>-surfaсes domain-copy)) surface-value)
    ;; добавляем поверхность в перечень поверхностей
    (setf (gethash surface-value (<simulation>-surfaces simulation)) surface-value)
    domain-copy))

(defmethod copy ((domain-name string) (simulation <simulation>))
  (let* ((domain ;; Копируемый домен
           (domain domain-name simulation))
         (domain-copy ;; Новый домен
           (make-instance '<3d-region>
                          :name (next-domain-name
                                 (domain-name->mesh-name domain-name)
                                 simulation)
                          :parent (<3d-region>-parent domain))))
    (loop :for sur-key :in (surface-keys domain)
          :do
             (insert-to-domain-copy sur-key domain domain-copy))
    (add domain-copy simulation)))


(defmethod insert ((mesh-name string) (simulation <simulation>))
  "@b(Описание:) метод @b(insert) добавляет в симуляцию @(simulation)
домен по имени 3d-сетки ICEM."
  (let ((d-name (next-domain-name mesh-name simulation)))
    (when d-name
      (let ((domain (make-instance '<3d-region> :name d-name :parent simulation)))
        (loop :for sur :in (alexandria:hash-table-keys
                            (<mesh>-2d-regions
                             (gethash mesh-name
                                      (<meshes>-meshes simulation))))
              :do
                 (let ((cfx-sur (next-surface-name sur simulation)))
                   (unless (gethash cfx-sur (<simulation>-surfaces simulation))
                     (setf (gethash sur (<3d-region>-surfaсes domain)) ;; добавляем поверхность в домен
                           cfx-sur) 
                     (setf (gethash cfx-sur (<simulation>-surfaces simulation)) ;; добавляем поверхность в перечень поверхностей
                           cfx-sur)))) ;; loop
        (add domain simulation)
        simulation ;; возвращаем симуляцию
        ))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defmethod copy ((domain-name string) (simulation <simulation>))
  (let ((d-name-next (next-domain-name
                      (domain-name->mesh-name domain-name)
                      simulation)))
    (when d-name-next
      (let ((domain (make-instance '<3d-region> :name d-name-next)))
        (loop :for sur :in (simulation-doman-surfaces domain-name simulation)
              :do
                 (let ((cfx-sur (next-surface-name sur simulation)))
                   (unless (gethash cfx-sur (<simulation>-surfaces simulation))
                     (setf (gethash sur (<3d-region>-surfaсes domain)) ;; добавляем поверхность в домен
                           cfx-sur)
                     (setf ;; добавляем поверхность в перечень поверхностей
                      (gethash cfx-sur (<simulation>-surfaces simulation)) 
                           cfx-sur))))
        (add domain simulation)))
    simulation))

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

(defun make-simulation (directory-template)
  "@b(Описание:) функция @b(make-simulation) возвращает объект класса
@b(<simulation>). Объект наполняется 3d-сетками ICEM.
 
 @b(Переменые:)
@begin(list)
@item(directory-template - задает шаблон для поиска файлов геометрии
     ICEM (tin-файлов).)
@end(list)

 @b(Пример использования:)
@begin[lang=lisp](code)
 (make-simulation \"z:/ANSYS/CFX/a32/tin/DOM/*/A32_prj_06_*.tin\")
@end(code)
"
  (let ((simulation (make-instance '<simulation>)))
    (loop :for d :in (directory directory-template)
          :do (add (make-mesh d) simulation))
    simulation))

(defun make-meshes (directory-template)
    "@b(Описание:) функция @b(make-meshes) возвращает объект класса
@b(<meshes>). Объект наполняется 3d-сетками ICEM.
 
 @b(Переменые:)
@begin(list)
@item(directory-template - задает шаблон для поиска файлов геометрии
     ICEM (tin-файлов).)
@end(list)

 @b(Пример использования:)
@begin[lang=lisp](code)
 (make-meshes \"z:/ANSYS/CFX/a32/tin/DOM/*/A32_prj_06_*.tin\")
@end(code)
"

  (let ((meshes (make-instance '<meshes>)))
    (loop :for d :in (directory directory-template)
          :do (add (make-mesh d) meshes))
    meshes))

(defun domain-name->mesh-name (domain-name)
  "@b(Описание:) функция @b(domain-name->mesh-name) возвращает имя сетки
на основании имени домена.
 
 @b(Пример использования:)
@begin[lang=lisp](code)
 (domain-name->mesh-name \"DG1 G1\") => \"G1\"
@end(code)"
  (second (ppcre:split " " domain-name)))

(defun mesh-name->domain-name (mesh-name)
  "@b(Описание:) функция @b(mesh-name->domain-name) возвращает имя домена
на основании имени сетки.
 
 @b(Пример использования:)
@begin[lang=lisp](code)
 (mesh-name->domain-name \"G1\") => \"DG1 G1\"
@end(code)"
  (concatenate 'string "D" mesh-name " " mesh-name))

(defun make-mesh (pathname)
      "@b(Описание:) функция @b(make-mesh) возвращает объект класса
@b(<mesh>).

 @b(Переменые:)
@begin(list)
@item(pathname - задает путь к файлу геометрии ICEM (tin-файл).)
@end(list)

 @b(Пример использования:)
@begin[lang=lisp](code)
 (make-mesh \"z:/ANSYS/CFX/a32/tin/DOM/G1/A32_prj_06_DG1.tin\")
@end(code)"
  (let* ((domain (make-instance '<mesh>))
        (tin (mnas-ansys/tin:open-tin-file pathname)))
    (setf (<mesh>-name domain)
          (domain-name-by-pathname pathname))
    (map 'nil
         #'(lambda (el)
             (setf
              (gethash el (<mesh>-2d-regions domain))
              el))
         (remove-duplicates 
          (loop :for sur
                  :in (alexandria:hash-table-values
                       (mnas-ansys/tin:<tin>-surfaces tin))
                :collect 
                (mnas-ansys/tin:<ent>-family sur))
          :test #'equal))
    domain))



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun make-corelation (domain-name result simulation)
  "
 @b(Пример использования:)
@begin[lang=lisp](code)
 (make-corelation \"DG2 G2\" *DG2-G2* *simulation*)
@end(code)
"
  (let ((dom-result (ppcre:split "," result)))
    (loop :for i :in (simulation-doman-surfaces domain-name simulation)
          :collect
          (list i
                (extract-suffix i (first (filter-by-prefix i dom-result)))
                (mapcar
                 #'(lambda (el) (extract-suffix i el))
                 (filter-by-prefix i (surfaces simulation)))))))

(defun make-corelation-0 (domain-name result simulation)
  "
 @b(Пример использования:)
@begin[lang=lisp](code)
 (make-corelation-0 \"DG2 G2\" *DG2-G2* *simulation*)
@end(code)
"
  (let ((dom-result (ppcre:split "," result)))
    (loop :for i :in (simulation-doman-surfaces domain-name simulation)
          :collect
          (list i
                (first (filter-by-prefix i dom-result))
                (filter-by-prefix i (surfaces simulation))))))

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

(defmethod next-surface-name ((mesh-name string) (cfx-domains <simulation>))
  (let ((surface-name (name-icem->cfx mesh-name)))
    (if (gethash surface-name (<simulation>-surfaces cfx-domains))
          (loop :for i :from 2 
                :do
                   (unless (gethash (format nil "~A ~D" surface-name i)
                                    (<simulation>-surfaces cfx-domains))
                     (return-from next-surface-name (format nil "~A ~D" surface-name i))))
          surface-name)))

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

(defun s-list (str-or-lst)
    (format nil "~{~A~^,~}"
                    (if (stringp str-or-lst)
                        (list str-or-lst)
                        str-or-lst)))

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

(defmethod surfaces ((d (eql nil)))
  d)


(defmethod simulation-doman-surfaces ((domain-name string) (simulation <simulation>))
  "@b(Описание:) метод @b(simulation-doman-surfaces) возвращает список
поверхностей для домена с именем @b(domain-name), из симуляции
@b(simulation).

 @b(Пример использования:)
@begin[lang=lisp](code)
 (simulation-doman-surfaces \"DG1 G1\" *simulation*)
@end(code)
"
  ;; поверхности, которые входят в домен
  (surfaces
   (gethash domain-name
            (<simulation>-domains simulation))))

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
