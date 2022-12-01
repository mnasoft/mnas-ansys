
;;;; ./src/clim/clim.lisp

(defpackage #:mnas-ansys/ccl
  (:use #:cl #:mnas-ansys/ccl/parse)
  (:export find-in-tree
           find-in-tree-key
           find-in-tree-value)
  (:export make-domain-interface-rotational-periodicity
           make-domain-interface-general-connection
           )
  (:export make-material-CH4
           make-material-CO
           make-material-CO2
           make-material-H2O
           make-material-N2
           make-material-NO
           make-material-O2
           make-material-Methane-Air-WD2-NO-PDF
           )
  (:documentation
   "STUB"))

(in-package #:mnas-ansys/ccl)

(defun find-in-tree (item tree &key (test #'eql) (key #'identity))
  "@b(Описание:) функция @b(find-in-tree) выполняет рекурсивый поиск
  элемента @b(item) в древовидном списке @b(tree).

 @b(Пример использования:)
@begin[lang=lisp](code)
 (defparameter *l* '(\"FLOW\" \"Flow Analysis 1\"
                     (\"&replace DOMAIN INTERFACE\" \"C T_1 R\"
                      (\"Boundary List1\" \"C T_1 R Side 1\")
                      (\"Boundary List2\" \"C T_1 R Side 2\")
                      (\"Filter Domain List1\" \"D1L\")
                      (\"Filter Domain List2\" \"D1R\")
                      (\"Interface Region List1\" \"D1 C T_1 L_N01_D070.0_S18.90\")
                      (\"Interface Region List2\" \"D1 C T_1 R_N01_D070.0_S18.90 2\")
                      (\"Interface Type\" \"Fluid Fluid\")
                      (\"INTERFACE MODELS\" \"\"
                       (\"Option\" \"Rotational Periodicity\")
                       (\"AXIS DEFINITION\" \"\"
                        (\"Option\" \"Coordinate Axis\")
                        (\"Rotation Axis\" \"Coord 0.1\")))
                      (\"MESH CONNECTION\" \"\" (\"Option\" \"GGI\")))))

 (find-in-tree \"D1L\" *l* :test #'equal :key (lambda (i) (when (consp i) (second i))))
@end(code)
"
  (labels ((find-in-tree-aux (tree)                                   
             (cond ((funcall test item (funcall key tree))
                    (return-from find-in-tree tree))
                   ((listp tree)
                    (mapc #'find-in-tree-aux tree)
                    nil))))
    (find-in-tree-aux tree)))

(defun find-in-tree-key (key tree &key (test #'equal))
  (find-in-tree key tree :test test
                         :key (lambda (i) (when (consp i) (first i)))))

(defun find-in-tree-value (value tree &key (test #'equal))
  (find-in-tree value tree :test test
                           :key (lambda (i) (when (consp i) (second i)))))

(defun value (x) (cadr x))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defparameter *lines*
  (mnas-ansys/tin/read:read-file-as-lines
   "~/quicklisp/local-projects/ANSYS/mnas-ansys/data/ccl/interfaces.ccl"))

(defparameter *ccl* (mnas-ansys/ccl/parse::parse-slow *lines*))
(defparameter *ccl* (mnas-ansys/ccl/parse::parse *lines*))

(value
 (find-in-tree-key "Option"
                  (find-in-tree-key "INTERFACE MODELS" (elt *ccl* 1))))

(defun interface-models-option (domain-interface)
  (second
   (find-in-tree-key "Option"
                     (find-in-tree-key "INTERFACE MODELS" domain-interface))))

(defun short-name-upper (string)
  (concatenate 'string 
               (loop :for ch :from 0 :below (length string)
                     :when (upper-case-p (char  string ch))
                       :collect (char string ch))))

(defun interface-models-option-short (domain-interface)
  (short-name-upper (interface-models-option domain-interface)))

(defun domain-interface-item (item &key (stream t))
  (let* ((d-i (find-in-tree-key "&replace DOMAIN INTERFACE" item))
         (d-i-name (value d-i))
         (d-i-f-d-l1 (value (find-in-tree-key "Filter Domain List1" item)))
         (d-i-f-d-l2 (value (find-in-tree-key "Filter Domain List2" item)))
         (d-i-int-mod-op (interface-models-option-short d-i)))
    (when d-i
      d-i-name
      #+nil
      (format stream "~A -- ~A [label=~S]~%" d-i-f-d-l1 d-i-f-d-l2 d-i-name)
      #+nil
      (format stream "~A -- ~A~%" d-i-f-d-l1 d-i-f-d-l2)
      (format stream "~A -- ~A [label=~S]~%" d-i-f-d-l1 d-i-f-d-l2 d-i-int-mod-op)
      )))

(defun domain-interface-graph (ccl &key (stream t))
  (format stream "graph {~%")  
  (mapcar
   #'(lambda (item)
            (domain-interface-item item :stream stream))
   ccl)
  (format stream "}~%"))

(domain-interface-graph *ccl*)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun make-domain-interface-rotational-periodicity (domain-interface i-reg-lst-1 i-reg-lst-2)
  (let ((d-i domain-interface
             #+nil(mnas-string/translit:translit domain-interface :ht mnas-string/translit:*cfx->en*)))
    (format t
            "
FLOW: Flow Analysis 1
  &replace DOMAIN INTERFACE: ~A
    Boundary List1 = ~A Side 1
    Boundary List2 = ~A Side 2
    Filter Domain List1 = D1
    Filter Domain List2 = D1
    Interface Region List1 = ~A
    Interface Region List2 = ~A
    Interface Type = Fluid Fluid
    INTERFACE MODELS: 
      Option = Rotational Periodicity
      AXIS DEFINITION: 
        Option = Coordinate Axis
        Rotation Axis = Coord 0.1
      END
    END
    MESH CONNECTION: 
      Option = Automatic
    END
  END
END
~2%
"
            d-i d-i d-i i-reg-lst-1 i-reg-lst-2)))

(defun make-domain-interface-general-connection (domain-interface i-reg-lst-1 i-reg-lst-2)
  (let ((d-i domain-interface
             #+nil(mnas-string/translit:translit domain-interface :ht mnas-string/translit:*cfx->en*)))
    (format t
            "
FLOW: Flow Analysis 1
  &replace DOMAIN INTERFACE: ~A
    Boundary List1 = ~A Side 1
    Boundary List2 = ~A Side 2
    Filter Domain List1 = D1
    Filter Domain List2 = D1
    Interface Region List1 = ~A
    Interface Region List2 = ~A
    Interface Type = Fluid Fluid
    INTERFACE MODELS: 
      Option = General Connection
      FRAME CHANGE: 
        Option = None
      END
      MASS AND MOMENTUM: 
        Option = Conservative Interface Flux
        MOMENTUM INTERFACE MODEL: 
          Option = None
        END
      END
      PITCH CHANGE: 
        Option = None
      END
    END
    MESH CONNECTION: 
      Option = Automatic
    END
  END
END
~2%
"
            d-i d-i d-i i-reg-lst-1 i-reg-lst-2)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun make-material-CH4 ()
  (format t "
LIBRARY: 
  &replace MATERIAL: CH4
    Material Description = Methane CH4
    Material Group = Gas Phase Combustion
    Option = Pure Substance
    Thermodynamic State = Gas
    PROPERTIES: 
      Option = General Material
      ABSORPTION COEFFICIENT: 
        Absorption Coefficient = 1.0 [m^-1]
        Option = Value
      END
      DYNAMIC VISCOSITY: 
        Dynamic Viscosity = 11.1E-06 [kg m^-1 s^-1]
        Option = Value
      END
      EQUATION OF STATE: 
        Molar Mass = 16.04 [kg kmol^-1]
        Option = Ideal Gas
      END
      REFERENCE STATE: 
        Option = NASA Format
        Reference Pressure = 1 [atm]
        Reference Temperature = 25 [C]
      END
      REFRACTIVE INDEX: 
        Option = Value
        Refractive Index = 1.0 [m m^-1]
      END
      SCATTERING COEFFICIENT: 
        Option = Value
        Scattering Coefficient = 0.0 [m^-1]
      END
      SPECIFIC HEAT CAPACITY: 
        Option = NASA Format
        LOWER INTERVAL COEFFICIENTS: 
          NASA a1 = 0.07787415E+01 []
          NASA a2 = 0.01747668E+00 [K^-1]
          NASA a3 = -0.02783409E-03 [K^-2]
          NASA a4 = 0.03049708E-06 [K^-3]
          NASA a5 = -0.01223931E-09 [K^-4]
          NASA a6 = -0.09825229E+05 [K]
          NASA a7 = 0.01372219E+03 []
        END
        TEMPERATURE LIMITS: 
          Lower Temperature = 300 [K]
          Midpoint Temperature = 1000 [K]
          Upper Temperature = 5000 [K]
        END
        UPPER INTERVAL COEFFICIENTS: 
          NASA a1 = 0.01683479E+02 []
          NASA a2 = 0.01023724E+00 [K^-1]
          NASA a3 = -0.03875129E-04 [K^-2]
          NASA a4 = 0.06785585E-08 [K^-3]
          NASA a5 = -0.04503423E-12 [K^-4]
          NASA a6 = -0.01008079E+06 [K]
          NASA a7 = 0.09623395E+02 []
        END
      END
      THERMAL CONDUCTIVITY: 
        Option = Value
        Thermal Conductivity = 343E-04 [W m^-1 K^-1]
      END
    END
  END
END
"))

(defun make-material-CO ()
  (format t "
LIBRARY: 
  &replace MATERIAL: CO
    Material Description = Carbon Monoxide CO
    Material Group = Gas Phase Combustion
    Option = Pure Substance
    Thermodynamic State = Gas
    PROPERTIES: 
      Option = General Material
      ABSORPTION COEFFICIENT: 
        Absorption Coefficient = 1.0 [m^-1]
        Option = Value
      END
      DYNAMIC VISCOSITY: 
        Dynamic Viscosity = 16.6E-06 [kg m^-1 s^-1]
        Option = Value
      END
      EQUATION OF STATE: 
        Molar Mass = 28.01 [kg kmol^-1]
        Option = Ideal Gas
      END
      REFERENCE STATE: 
        Option = NASA Format
        Reference Pressure = 1 [atm]
        Reference Temperature = 25 [C]
      END
      REFRACTIVE INDEX: 
        Option = Value
        Refractive Index = 1.0 [m m^-1]
      END
      SCATTERING COEFFICIENT: 
        Option = Value
        Scattering Coefficient = 0.0 [m^-1]
      END
      SPECIFIC HEAT CAPACITY: 
        Option = NASA Format
        LOWER INTERVAL COEFFICIENTS: 
          NASA a1 = 0.03262452E+02 []
          NASA a2 = 0.01511941E-01 [K^-1]
          NASA a3 = -0.03881755E-04 [K^-2]
          NASA a4 = 0.05581944E-07 [K^-3]
          NASA a5 = -0.02474951E-10 [K^-4]
          NASA a6 = -0.01431054E+06 [K]
          NASA a7 = 0.04848897E+02 []
        END
        TEMPERATURE LIMITS: 
          Lower Temperature = 300 [K]
          Midpoint Temperature = 1000 [K]
          Upper Temperature = 5000 [K]
        END
        UPPER INTERVAL COEFFICIENTS: 
          NASA a1 = 0.03025078E+02 []
          NASA a2 = 0.01442689E-01 [K^-1]
          NASA a3 = -0.05630828E-05 [K^-2]
          NASA a4 = 0.01018581E-08 [K^-3]
          NASA a5 = -0.06910952E-13 [K^-4]
          NASA a6 = -0.01426835E+06 [K]
          NASA a7 = 0.06108218E+02 []
        END
      END
      THERMAL CONDUCTIVITY: 
        Option = Value
        Thermal Conductivity = 251E-04 [W m^-1 K^-1]
      END
    END
  END
END"))

(defun make-material-CO2 ()
  (format t "
LIBRARY: 
  &replace MATERIAL: CO2
    Material Description = Carbon Dioxide CO2
    Material Group = Gas Phase Combustion
    Option = Pure Substance
    Thermodynamic State = Gas
    PROPERTIES: 
      Option = General Material
      ABSORPTION COEFFICIENT: 
        Absorption Coefficient = 1.0 [m^-1]
        Option = Value
      END
      DYNAMIC VISCOSITY: 
        Dynamic Viscosity = 14.9E-06 [kg m^-1 s^-1]
        Option = Value
      END
      EQUATION OF STATE: 
        Molar Mass = 44.01 [kg kmol^-1]
        Option = Ideal Gas
      END
      REFERENCE STATE: 
        Option = NASA Format
        Reference Pressure = 1 [atm]
        Reference Temperature = 25 [C]
      END
      REFRACTIVE INDEX: 
        Option = Value
        Refractive Index = 1.0 [m m^-1]
      END
      SCATTERING COEFFICIENT: 
        Option = Value
        Scattering Coefficient = 0.0 [m^-1]
      END
      SPECIFIC HEAT CAPACITY: 
        Option = NASA Format
        LOWER INTERVAL COEFFICIENTS: 
          NASA a1 = 0.02275725E+02 []
          NASA a2 = 0.09922072E-01 [K^-1]
          NASA a3 = -0.01040911E-03 [K^-2]
          NASA a4 = 0.06866687E-07 [K^-3]
          NASA a5 = -0.02117280E-10 [K^-4]
          NASA a6 = -0.04837314E+06 [K]
          NASA a7 = 0.01018849E+03 []
        END
        TEMPERATURE LIMITS: 
          Lower Temperature = 300 [K]
          Midpoint Temperature = 1000 [K]
          Upper Temperature = 5000 [K]
        END
        UPPER INTERVAL COEFFICIENTS: 
          NASA a1 = 0.04453623E+02 []
          NASA a2 = 0.03140169E-01 [K^-1]
          NASA a3 = -0.01278411E-04 [K^-2]
          NASA a4 = 0.02393997E-08 [K^-3]
          NASA a5 = -0.01669033E-12 [K^-4]
          NASA a6 = -0.04896696E+06 [K]
          NASA a7 = -0.09553959E+01 []
        END
      END
      THERMAL CONDUCTIVITY: 
        Option = Value
        Thermal Conductivity = 145E-04 [W m^-1 K^-1]
      END
    END
  END
END
"))

(defun make-material-H2O ()
  (format t "
LIBRARY: 
  &replace MATERIAL: H2O
    Material Description = Water Vapour
    Material Group = Gas Phase Combustion, Interphase Mass Transfer, Water Data
    Option = Pure Substance
    Thermodynamic State = Gas
    PROPERTIES: 
      Option = General Material
      ABSORPTION COEFFICIENT: 
        Absorption Coefficient = 1.0 [m^-1]
        Option = Value
      END
      DYNAMIC VISCOSITY: 
        Dynamic Viscosity = 9.4E-06 [kg m^-1 s^-1]
        Option = Value
      END
      EQUATION OF STATE: 
        Molar Mass = 18.02 [kg kmol^-1]
        Option = Ideal Gas
      END
      REFERENCE STATE: 
        Option = NASA Format
        Reference Pressure = 1 [atm]
        Reference Temperature = 25 [C]
      END
      REFRACTIVE INDEX: 
        Option = Value
        Refractive Index = 1.0 [m m^-1]
      END
      SCATTERING COEFFICIENT: 
        Option = Value
        Scattering Coefficient = 0.0 [m^-1]
      END
      SPECIFIC HEAT CAPACITY: 
        Option = NASA Format
        LOWER INTERVAL COEFFICIENTS: 
          NASA a1 = 0.03386842E+02 []
          NASA a2 = 0.03474982E-01 [K^-1]
          NASA a3 = -0.06354696E-04 [K^-2]
          NASA a4 = 0.06968581E-07 [K^-3]
          NASA a5 = -0.02506588E-10 [K^-4]
          NASA a6 = -0.03020811E+06 [K]
          NASA a7 = 0.02590233E+02 []
        END
        TEMPERATURE LIMITS: 
          Lower Temperature = 300 [K]
          Midpoint Temperature = 1000 [K]
          Upper Temperature = 5000 [K]
        END
        UPPER INTERVAL COEFFICIENTS: 
          NASA a1 = 0.02672146E+02 []
          NASA a2 = 0.03056293E-01 [K^-1]
          NASA a3 = -0.08730260E-05 [K^-2]
          NASA a4 = 0.01200996E-08 [K^-3]
          NASA a5 = -0.06391618E-13 [K^-4]
          NASA a6 = -0.02989921E+06 [K]
          NASA a7 = 0.06862817E+02 []
        END
      END
      THERMAL CONDUCTIVITY: 
        Option = Value
        Thermal Conductivity = 193E-04 [W m^-1 K^-1]
      END
    END
  END
END
"))

(defun make-material-N2 ()
  (format t "
LIBRARY: 
  &replace MATERIAL: N2
    Material Description = Nitrogen N2
    Material Group = Gas Phase Combustion
    Option = Pure Substance
    Thermodynamic State = Gas
    PROPERTIES: 
      Option = General Material
      ABSORPTION COEFFICIENT: 
        Absorption Coefficient = 1.0 [m^-1]
        Option = Value
      END
      DYNAMIC VISCOSITY: 
        Dynamic Viscosity = 17.7E-06 [kg m^-1 s^-1]
        Option = Value
      END
      EQUATION OF STATE: 
        Molar Mass = 28.01 [kg kmol^-1]
        Option = Ideal Gas
      END
      REFERENCE STATE: 
        Option = NASA Format
        Reference Pressure = 1 [atm]
        Reference Temperature = 25 [C]
      END
      REFRACTIVE INDEX: 
        Option = Value
        Refractive Index = 1.0 [m m^-1]
      END
      SCATTERING COEFFICIENT: 
        Option = Value
        Scattering Coefficient = 0.0 [m^-1]
      END
      SPECIFIC HEAT CAPACITY: 
        Option = NASA Format
        LOWER INTERVAL COEFFICIENTS: 
          NASA a1 = 0.03298677E+02 []
          NASA a2 = 0.01408240E-01 [K^-1]
          NASA a3 = -0.03963222E-04 [K^-2]
          NASA a4 = 0.05641515E-07 [K^-3]
          NASA a5 = -0.02444855E-10 [K^-4]
          NASA a6 = -0.01020900E+05 [K]
          NASA a7 = 0.03950372E+02 []
        END
        TEMPERATURE LIMITS: 
          Lower Temperature = 300 [K]
          Midpoint Temperature = 1000 [K]
          Upper Temperature = 5000 [K]
        END
        UPPER INTERVAL COEFFICIENTS: 
          NASA a1 = 0.02926640E+02 []
          NASA a2 = 0.01487977E-01 [K^-1]
          NASA a3 = -0.05684761E-05 [K^-2]
          NASA a4 = 0.01009704E-08 [K^-3]
          NASA a5 = -0.06753351E-13 [K^-4]
          NASA a6 = -0.09227977E+04 [K]
          NASA a7 = 0.05980528E+02 []
        END
      END
      THERMAL CONDUCTIVITY: 
        Option = Value
        Thermal Conductivity = 259E-04 [W m^-1 K^-1]
      END
    END
  END
END
"))

(defun make-material-NO ()
  (format t "
LIBRARY: 
  &replace MATERIAL: NO
    Material Description = Nitric Oxide NO
    Material Group = Gas Phase Combustion
    Option = Pure Substance
    Thermodynamic State = Gas
    PROPERTIES: 
      Option = General Material
      ABSORPTION COEFFICIENT: 
        Absorption Coefficient = 1.0 [m^-1]
        Option = Value
      END
      DYNAMIC VISCOSITY: 
        Dynamic Viscosity = 17.8E-06 [kg m^-1 s^-1]
        Option = Value
      END
      EQUATION OF STATE: 
        Molar Mass = 30.01 [kg kmol^-1]
        Option = Ideal Gas
      END
      REFERENCE STATE: 
        Option = NASA Format
        Reference Pressure = 1 [atm]
        Reference Temperature = 25 [C]
      END
      REFRACTIVE INDEX: 
        Option = Value
        Refractive Index = 1.0 [m m^-1]
      END
      SCATTERING COEFFICIENT: 
        Option = Value
        Scattering Coefficient = 0.0 [m^-1]
      END
      SPECIFIC HEAT CAPACITY: 
        Option = NASA Format
        LOWER INTERVAL COEFFICIENTS: 
          NASA a1 = 0.03376542E+02 []
          NASA a2 = 0.01253063E-01 [K^-1]
          NASA a3 = -0.03302751E-04 [K^-2]
          NASA a4 = 0.05217810E-07 [K^-3]
          NASA a5 = -0.02446263E-10 [K^-4]
          NASA a6 = 0.09817961E+05 [K]
          NASA a7 = 0.05829590E+02 []
        END
        TEMPERATURE LIMITS: 
          Lower Temperature = 300 [K]
          Midpoint Temperature = 1000 [K]
          Upper Temperature = 5000 [K]
        END
        UPPER INTERVAL COEFFICIENTS: 
          NASA a1 = 0.03245435E+02 []
          NASA a2 = 0.01269138E-01 [K^-1]
          NASA a3 = -0.05015890E-05 [K^-2]
          NASA a4 = 0.09169283E-09 [K^-3]
          NASA a5 = -0.06275419E-13 [K^-4]
          NASA a6 = 0.09800840E+05 [K]
          NASA a7 = 0.06417294E+02 []
        END
      END
      THERMAL CONDUCTIVITY: 
        Option = Value
        Thermal Conductivity = 238E-04 [W m^-1 K^-1]
      END
    END
  END
END
"))

(defun make-material-O2 ()
  (format t "
LIBRARY: 
  &replace MATERIAL: O2
    Material Description = Oxygen O2
    Material Group = Gas Phase Combustion
    Option = Pure Substance
    Thermodynamic State = Gas
    PROPERTIES: 
      Option = General Material
      ABSORPTION COEFFICIENT: 
        Absorption Coefficient = 1.0 [m^-1]
        Option = Value
      END
      DYNAMIC VISCOSITY: 
        Dynamic Viscosity = 19.2E-06 [kg m^-1 s^-1]
        Option = Value
      END
      EQUATION OF STATE: 
        Molar Mass = 31.99 [kg kmol^-1]
        Option = Ideal Gas
      END
      REFERENCE STATE: 
        Option = NASA Format
        Reference Pressure = 1 [atm]
        Reference Temperature = 25 [C]
      END
      REFRACTIVE INDEX: 
        Option = Value
        Refractive Index = 1.0 [m m^-1]
      END
      SCATTERING COEFFICIENT: 
        Option = Value
        Scattering Coefficient = 0.0 [m^-1]
      END
      SPECIFIC HEAT CAPACITY: 
        Option = NASA Format
        LOWER INTERVAL COEFFICIENTS: 
          NASA a1 = 0.03212936E+02 []
          NASA a2 = 0.01127486E-01 [K^-1]
          NASA a3 = -0.05756150E-05 [K^-2]
          NASA a4 = 0.01313877E-07 [K^-3]
          NASA a5 = -0.08768554E-11 [K^-4]
          NASA a6 = -0.01005249E+05 [K]
          NASA a7 = 0.06034738E+02 []
        END
        TEMPERATURE LIMITS: 
          Lower Temperature = 300 [K]
          Midpoint Temperature = 1000 [K]
          Upper Temperature = 5000 [K]
        END
        UPPER INTERVAL COEFFICIENTS: 
          NASA a1 = 0.03697578E+02 []
          NASA a2 = 0.06135197E-02 [K^-1]
          NASA a3 = -0.01258842E-05 [K^-2]
          NASA a4 = 0.01775281E-09 [K^-3]
          NASA a5 = -0.01136435E-13 [K^-4]
          NASA a6 = -0.01233930E+05 [K]
          NASA a7 = 0.03189166E+02 []
        END
      END
      THERMAL CONDUCTIVITY: 
        Option = Value
        Thermal Conductivity = 266E-04 [W m^-1 K^-1]
      END
    END
  END
END"))

(defun make-material-Methane-Air-WD2-NO-PDF ()
  (format t "
LIBRARY: 
  &replace MATERIAL: GAS
    Material Group = User
    Object Origin = User
    Option = Reacting Mixture
    Reactions List = Methane Air WD2 NO PDF
  END
END"))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
