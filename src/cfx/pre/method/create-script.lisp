;;;; ./src/cfx/pre/method/create-script.lisp

(in-package :mnas-ansys/cfx/pre)

(defmethod create-script ((simulation <simulation>) stream)
  (loop :for 3d-region :in (3d-regions simulation)
        :do (do-add 3d-region simulation))
  (loop :for cmd :in (reverse (<simulation>-commands simulation))
        :do (create-script cmd stream)))

(defmethod create-script ((obj <simulation-mesh-transformation>) stream)
  (format t "~A" (<simulation>-mesh-transformation obj))
  (gtmtransform
   (mnas-ansys/ccl/core:<mesh-transformation>-Target-Location
    (<simulation>-mesh-transformation obj))))

(defmethod create-script ((obj <simulation-interface-general>) stream)
  (mk-gen-interfaces-n-m
   (<simulation-interfaces-general>-mesh-name-1 obj)
   (<simulation-interfaces-general>-mesh-name-2 obj)
   (<simulation-command>-simulation obj)))

(defmethod create-script ((obj <simulation-interface-rotational-periodicity>) stream)
  (mk-rot-per-interfaces-n-m
   (<simulation-interface-rotational-periodicity>-mesh-name obj)
   (<simulation-command>-simulation obj)))

(defmethod create-script ((obj <simulation-interface-rotational-general>) stream)
  (mk-rot-gen-interfaces-n-m
   (<simulation-interface-rotational-general>-mesh-name obj)
   (<simulation-command>-simulation obj)))

(defmethod create-script ((obj <simulation-materials>) stream)
  (format t "
LIBRARY: 
  CEL: 
    &replace FUNCTION: HN60VT Specific Heat Capacity
      Argument Units = C
      Option = Interpolation
      Result Units = kJ / (kg K)
      INTERPOLATION DATA: 
        Data Pairs = 100 , 0.440 , 200 , 0.461 , 300 , 0.482 , 400 , 0.503 , 500 , 0.524 , 600 , 0.545 , 700 , 0.545 , 800 , 0.566 , 900 , 0.587 , 1000 , 0.625
        Extend Max = On
        Extend Min = On
        Option = One Dimensional
      END
    END
  END
END

LIBRARY: 
  CEL: 
    &replace FUNCTION: HN60VT Thermal Conductivity
      Argument Units = C
      Option = Interpolation
      Result Units = W / (m K)
      INTERPOLATION DATA: 
        Data Pairs = 25 , 9.64 , 100 , 10.5 , 200 , 11.7 , 300 , 13.8 , 400 , 16.4 , 500 , 18.9 , 600 , 21.4 , 700 , 23.5 , 800 , 25.6 , 900 , 28.1
        Extend Max = On
        Extend Min = On
        Option = One Dimensional
      END
    END
  END
END

LIBRARY: 
  &replace MATERIAL: HN60VT
    Material Description = ХН60ВТ
    Material Group = User
    Option = Pure Substance
    Thermodynamic State = Solid
    PROPERTIES: 
      Option = General Material
      EQUATION OF STATE: 
        Density = 8800 [kg m^-3]
        Molar Mass = 61.9235 [kg kmol^-1]
        Option = Value
      END
      SPECIFIC HEAT CAPACITY: 
        Option = Value
        Specific Heat Capacity = HN60VT Specific Heat Capacity (T)
      END
      TABLE GENERATION: 
        Maximum Temperature = 5000.0 [K]
        Minimum Temperature = 100 [K]
      END
      THERMAL CONDUCTIVITY: 
        Option = Value
        Thermal Conductivity = HN60VT Thermal Conductivity (T)
      END
    END
  END
END

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
END

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
END

LIBRARY: 
  &replace MATERIAL: Water
    Material Description = Water (liquid)
    Material Group = Water Data, Constant Property Liquids
    Object Origin = Default
    Option = Pure Substance
    Thermodynamic State = Liquid
    PROPERTIES: 
      Option = General Material
      ABSORPTION COEFFICIENT: 
        Absorption Coefficient = 1.0 [m^-1]
        Option = Value
      END
      DYNAMIC VISCOSITY: 
        Dynamic Viscosity = 8.899E-4 [kg m^-1 s^-1]
        Option = Value
      END
      EQUATION OF STATE: 
        Density = 997.0 [kg m^-3]
        Molar Mass = 18.02 [kg kmol^-1]
        Option = Value
      END
      REFERENCE STATE: 
        Option = Specified Point
        Reference Pressure = 1 [atm]
        Reference Specific Enthalpy = 0.0 [J/kg]
        Reference Specific Entropy = 0.0 [J/kg/K]
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
        Option = Value
        Specific Heat Capacity = 4181.7 [J kg^-1 K^-1]
        Specific Heat Type = Constant Pressure
      END
      THERMAL CONDUCTIVITY: 
        Option = Value
        Thermal Conductivity = 0.6069 [W m^-1 K^-1]
      END
      THERMAL EXPANSIVITY: 
        Option = Value
        Thermal Expansivity = 2.57E-04 [K^-1]
      END
    END
  END
END

LIBRARY: 
  &replace REACTION: Methane Air WD2 NO PDF
    Additional Materials List = CH4, O2, CO, CO2, H2O, NO, N2
    Option = Multi Step
    Reaction Description = Methane Air Two Step and NO Formation with Temperature PDF
    Reactions List = Methane Oxygen WD2, NO Formation Methane PDF
  END
END

LIBRARY: 
  &replace REACTION: Methane Oxygen WD2
    Option = Multi Step
    Reactions List = WD2 Methane Oxidation, WD2 CO Oxidation
  END
END

LIBRARY: 
  &replace REACTION: NO Formation Methane PDF
    Option = Multi Step
    Reaction Description = NO Formation with Temperature PDF for Methane
    Reactions List = Thermal NO PDF, Prompt NO Methane PDF
  END
END

LIBRARY: 
  &replace REACTION: Prompt NO Methane PDF
    Option = Single Step
    Reaction Description = Prompt NO Formation by Methane with Temperature PDF
    COMBUSTION MODEL: 
      Option = Finite Rate Chemistry
    END
    FORWARD REACTION RATE: 
      Lower Temperature = 300 [K]
      Option = Arrhenius with Temperature PDF
      Pre Exponential Factor = 6.4E+6 [s^-1] * (mw/density)^1.5
      Temperature Exponent = 0
      Upper Temperature = 2300 [K]
      REACTION ACTIVATION: 
        Activation Temperature = 36510 [K]
        Option = Activation Temperature
      END
    END
    PRODUCTS: 
      Materials List = NO
      Option = Child Materials
      CHILD MATERIAL: NO
        Option = Stoichiometric
        Stoichiometric Coefficient = 1.0
      END
    END
    REACTANTS: 
      Materials List = O2, N2, CH4
      Option = Child Materials
      CHILD MATERIAL: CH4
        Option = Stoichiometric
        Reaction Order = 1.0
        Stoichiometric Coefficient = 0.0
      END
      CHILD MATERIAL: N2
        Option = Stoichiometric
        Reaction Order = 1.0
        Stoichiometric Coefficient = 0.5
      END
      CHILD MATERIAL: O2
        Option = Stoichiometric
        Reaction Order = 0.5
        Stoichiometric Coefficient = 0.5
      END
    END
  END
END

LIBRARY: 
  &replace REACTION: Thermal NO PDF
    Option = Single Step
    Reaction Description = Thermal NO Formation with Temperature PDF
    COMBUSTION MODEL: 
      Option = Finite Rate Chemistry
    END
    FORWARD REACTION RATE: 
      Lower Temperature = 300 [K]
      Option = Arrhenius with Temperature PDF
      Pre Exponential Factor = 1.8E+11 [kmol^-1 m^3 s^-1] * 12.567E+3 [kmol^0.5 m^-1.5 K^0.5]
      Temperature Exponent = -0.5
      Upper Temperature = 2300 [K]
      REACTION ACTIVATION: 
        Activation Temperature = 38370 [K] + 31096 [K]
        Option = Activation Temperature
      END
    END
    PRODUCTS: 
      Materials List = NO
      Option = Child Materials
      CHILD MATERIAL: NO
        Option = Stoichiometric
        Stoichiometric Coefficient = 2.0
      END
    END
    REACTANTS: 
      Materials List = N2, O2
      Option = Child Materials
      CHILD MATERIAL: N2
        Option = Stoichiometric
        Reaction Order = 1.0
        Stoichiometric Coefficient = 1.0
      END
      CHILD MATERIAL: O2
        Option = Stoichiometric
        Reaction Order = 0.5
        Stoichiometric Coefficient = 1.0
      END
    END
  END
END

LIBRARY: 
  &replace REACTION: WD2 CO Oxidation
    Option = Single Step
    FORWARD REACTION RATE: 
      Option = Arrhenius
      Pre Exponential Factor = (10.^14.6) [mol^-0.75 cm^2.25 s^-1]
      Temperature Exponent = 0.0
      REACTION ACTIVATION: 
        Activation Energy = 40. [kcal mol^-1]
        Option = Activation Energy
      END
    END
    PRODUCTS: 
      Materials List = CO2
      Option = Child Materials
      CHILD MATERIAL: CO2
        Option = Stoichiometric
        Stoichiometric Coefficient = 1.0
      END
    END
    REACTANTS: 
      Materials List = CO, O2, H2O
      Option = Child Materials
      CHILD MATERIAL: CO
        Option = Stoichiometric
        Reaction Order = 1.0
        Stoichiometric Coefficient = 1.0
      END
      CHILD MATERIAL: H2O
        Option = Stoichiometric
        Reaction Order = 0.5
        Stoichiometric Coefficient = 0.0
      END
      CHILD MATERIAL: O2
        Option = Stoichiometric
        Reaction Order = 0.25
        Stoichiometric Coefficient = 0.5
      END
    END
  END
END

LIBRARY: 
  &replace REACTION: WD2 Methane Oxidation
    Option = Single Step
    FORWARD REACTION RATE: 
      Option = Arrhenius
      Pre Exponential Factor = 1.5E7 [s^-1]
      Temperature Exponent = 0.
      REACTION ACTIVATION: 
        Activation Energy = 30. [kcal mol^-1]
        Option = Activation Energy
      END
    END
    PRODUCTS: 
      Materials List = CO, H2O
      Option = Child Materials
      CHILD MATERIAL: CO
        Option = Stoichiometric
        Stoichiometric Coefficient = 1.0
      END
      CHILD MATERIAL: H2O
        Option = Stoichiometric
        Stoichiometric Coefficient = 2.0
      END
    END
    REACTANTS: 
      Materials List = CH4, O2
      Option = Child Materials
      CHILD MATERIAL: CH4
        Option = Stoichiometric
        Reaction Order = -0.3
        Stoichiometric Coefficient = 1.0
      END
      CHILD MATERIAL: O2
        Option = Stoichiometric
        Reaction Order = 1.3
        Stoichiometric Coefficient = 1.5
      END
    END
  END
END

LIBRARY: 
  &replace MATERIAL: GAS
    Material Group = User
    Option = Reacting Mixture
    Reactions List = Methane Air WD2 NO PDF
  END
END

" ))

(defmethod create-script ((obj <simulation-flow>) stream)
  (format stream "~A"
          (mk-flow :simulation         (<simulation-command>-simulation      obj)
                   :flow-name          (<simulation-flow>-flow-name          obj)
                   :domain-fluid-name  (<simulation-flow>-domain-fluid-name  obj)
                   :domain-solid-names (<simulation-flow>-domain-solid-names obj)
                   :reference-pressure (<simulation-flow>-reference-pressure obj)
                   ))
  (loop :for solid-dom :in (<simulation-flow>-domain-solid-names obj)
        :do
           (mk-f-s-interface-n-m
            (<simulation-flow>-domain-fluid-name  obj)
            solid-dom
            (<simulation-command>-simulation obj))))

(defmethod create-script ((obj <simulation-boundary-inlet>) stream)
  (format stream "~%")  
  (format stream "~A~%"  "FLOW: Flow Analysis 1")
  (format stream "~A~%"  "DOMAIN: D1")
  (format stream "&replace ~A"
          (mk-boundary-inlet (<simulation-boundary-inlet>-name               obj)
                             (<simulation-boundary-inlet>-mass-flow-rate     obj)
                             (<simulation-boundary-inlet>-location           obj)
                             :static-temperature (<simulation-boundary-inlet>-static-temperature obj)
                             :total-temperature (<simulation-boundary-inlet>-total-temperature  obj)
                             :components        (<simulation-boundary-inlet>-components         obj)))
  (format stream "~A~%"  "END")
  (format stream "~A~%"  "END"))

(defmethod create-script ((obj <simulation-boundary-outlet>) stream)
  (format stream "~%")
  (format stream "~A~%"  "FLOW: Flow Analysis 1")
  (format stream "~A~%"  "DOMAIN: D1")
  (format stream "&replace ~A"  
          (mk-boundary-outlet (<simulation-boundary-outlet>-name     obj)
                              (<simulation-boundary-outlet>-location obj)
                              :mass-flow-rate (<simulation-boundary-outlet>-mass-flow-rate obj)
                              :relative-pressure (<simulation-boundary-outlet>-relative-pressure obj)))
  (format stream "~A~%"  "END")
  (format stream "~A~%"  "END"))

(defmethod create-script ((obj <simulation-solver>) stream)
  (format stream "~%~A~%"  "FLOW: Flow Analysis 1")
  (format stream "~A" (<simulation-solver>-solution-units obj))
  (format stream "~A" (<simulation-solver>-solver-control obj))
  (format stream "~A~%"  "END"))

(defmethod create-script ((obj <simulation-control>) stream)
  (format stream "~%~A~%"
          "SIMULATION CONTROL: 
  &replace EXECUTION CONTROL: 
    EXECUTABLE SELECTION: 
      Double Precision = Off
    END
    INTERPOLATOR STEP CONTROL: 
      Runtime Priority = Standard
      MEMORY CONTROL: 
        Catalogue Size Override = 2.5x
        Memory Allocation Factor = 1
      END
    END
    PARALLEL HOST LIBRARY: 
      HOST DEFINITION: n133905
        Host Architecture String = winnt-amd64
        Installation Root = C:/ANSYS/v%v/CFX
        Number of Processors = 8
        Relative Speed = 9.2
      END
      HOST DEFINITION: n133906
        Host Architecture String = winnt-amd64
        Installation Root = C:/ANSYS/v%v/CFX
        Number of Processors = 8
        Relative Speed = 9.2
      END
      HOST DEFINITION: n142012
        Host Architecture String = winnt-amd64
        Installation Root = C:/ANSYS/v%v/CFX
        Number of Processors = 8
        Relative Speed = 11.15
      END
      HOST DEFINITION: n142013
        Host Architecture String = winnt-amd64
        Installation Root = C:/ANSYS/v%v/CFX
        Number of Processors = 8
        Relative Speed = 11.15
      END
    END
    PARTITIONER STEP CONTROL: 
      Multidomain Option = Independent Partitioning
      Runtime Priority = Standard
      EXECUTABLE SELECTION: 
        Use Large Problem Partitioner = On
      END
      MEMORY CONTROL: 
        Character Memory Override = 2.5x
        Memory Allocation Factor = 1.1
      END
      PARTITIONING TYPE: 
        Option = Optimized Recursive Coordinate Bisection
        Partition Size Rule = Automatic
        Partition Weight Factors = 0.03424, 0.03424, 0.03424, 0.03424, 0.03424, 0.03424, 0.03424, 0.03424, 0.03424, 0.03424, 0.03424, 0.03424, 0.03424, 0.03424, 0.03424, 0.03424, 0.02826, 0.02826, 0.02826, 0.02826, 0.02826, 0.02826, 0.02826, 0.02826, 0.02826, 0.02826, 0.02826, 0.02826, 0.02826, 0.02826, 0.02826, 0.02826
      END
    END
    RUN DEFINITION: 
      Run Mode = Full
      Solver Input File = D:/home/_namatv/ANSYS/CFX/a32/cfx/A32_prj_07/DP=003/A32_prj_07.def
      INITIAL VALUES SPECIFICATION: 
        INITIAL VALUES CONTROL: 
          Use Mesh From = Solver Input File
        END
        INITIAL VALUES: Initial Values 1
          File Name = D:/home/_namatv/ANSYS/CFX/a32/cfx/A32_prj_07/DP=003/A32_prj_07_001.res
          Option = Results File
        END
      END
    END
    SOLVER STEP CONTROL: 
      Runtime Priority = Standard
      MEMORY CONTROL: 
        Character Memory Override = 2.5x
        Memory Allocation Factor = 1.1
      END
      PARALLEL ENVIRONMENT: 
        Parallel Host List = n142013*8,n142012*8,n133906*8,n133905*8
        Start Method = Platform MPI Distributed Parallel
      END
    END
  END
END
" ))

(defun create-script-monitor-point-preamble  (stream)
  (format stream "~%")
  (format stream "~A~%" "FLOW: Flow Analysis 1")
  (format stream "~A~%" "  OUTPUT CONTROL: ")
  (format stream "~A~%" "    MONITOR OBJECTS: ")
  (format stream "~A~%" "      MONITOR BALANCES: ")
  (format stream "~A~%" "        Option = Full")
  (format stream "~A~%" "      END")
  (format stream "~A~%" "      MONITOR FORCES: ")
  (format stream "~A~%" "        Option = Full")
  (format stream "~A~%" "      END")
  (format stream "~A~%" "      MONITOR PARTICLES: ")
  (format stream "~A~%" "        Option = Full")
  (format stream "~A~%" "      END")
  )

(defun create-script-monitor-point-postamble  (stream)
  (format stream "~A~%" "      MONITOR RESIDUALS: ")
  (format stream "~A~%" "        Option = Full")
  (format stream "~A~%" "      END")
  (format stream "~A~%" "      MONITOR TOTALS: ")
  (format stream "~A~%" "        Option = Full")
  (format stream "~A~%" "      END")
  (format stream "~A~%" "    END")
  (format stream "~A~%" "    RESULTS: ")
  (format stream "~A~%" "      File Compression Level = Default")
  (format stream "~A~%" "      Option = Standard")
  (format stream "~A~%" "    END")
  (format stream "~A~%" "  END")
  (format stream "~A"   "END")
  (format stream "~%"))

(defmethod create-script ((obj <simulation-monitor-point-region>) stream)
  (let* ((regions
           (apply #'append
                  (mapcar
                   #'(lambda (el)
                       (select-2d-region-values
                        el
                        (<simulation-command>-simulation obj)))
                   (<simulation-monitor-point-region>-2d-regions-template obj))))
         (monitors (loop :for i :in regions
                         :collect 
                         (mk-monitor-point
                          :prefix (<simulation-monitor-point-region>-prefix obj)
                          :expression (<simulation-monitor-point-region>-expression obj)
                          :region i))))
    (create-script-monitor-point-preamble stream)
    (format stream "~{~A~}" monitors)
    (create-script-monitor-point-postamble stream)))

(defmethod create-script ((obj <simulation-monitor-point-named-points>) stream)
  (let ((monitors
          (loop :for (name coord) :in (<simulation-monitor-point-named-points>-named-points obj)
                :collect
                (mk-monitor-point
                 :name (mnas-ansys/ccl:good-name
                        (concatenate
                         'string
                         (<simulation-monitor-point-named-points>-prefix obj)
                         " "
                         name))
                 :cartesian-coordinates coord
                 :domain-name
                 (<simulation-monitor-point-named-points>-domain-name obj)
                 :output-variables-list
                 (<simulation-monitor-point-named-points>-output-variables-list obj)))))
    (create-script-monitor-point-preamble stream)
    (format stream "~{~A~}" monitors)
    (create-script-monitor-point-postamble stream)))

(defmethod create-script ((obj <simulation-monitor-point>) stream)
  (let* ((monitors nil))
    (loop :for (prefix expression)
            :in (<simulation-monitor-point>-prefix-expression obj) :do
              (loop :for i :in (<simulation-monitor-point>-locations  obj) :do
                (push (mk-monitor-point :prefix prefix
                                        :expression expression
                                        :location i)
                      monitors)))
    (create-script-monitor-point-preamble stream)
    (format stream "~{~A~}" monitors)
    (create-script-monitor-point-postamble stream)))
