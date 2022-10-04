"Simulatrion
  Flow Analysis 1
    Solver
      Output Control"


"
FLOW: Flow Analysis 1
  &replace OUTPUT CONTROL: 
    MONITOR OBJECTS: 
      MONITOR BALANCES: 
        Option = Full
      END
      MONITOR FORCES: 
        Option = Full
      END
      MONITOR PARTICLES: 
        Option = Full
      END
      MONITOR POINT: P02 L
        Coord Frame = Coord 0
        Expression Value = massFlowAve(Total Pressure )@REGION:B B_I 1_N01_D070.00_S18.91
        Option = Expression
      END
      MONITOR POINT: P02 R
        Coord Frame = Coord 0
        Expression Value = massFlowAve(Total Pressure )@REGION:B B_I 1_N01_D070.00_S18.91 2
        Option = Expression
      END
      MONITOR POINT: P03
        Coord Frame = Coord 0
        Expression Value = massFlowAve(Total Pressure )@REGION:D7 C C_2 7_N01_D028.00_S03.00
        Option = Expression
      END
      MONITOR POINT: T03
        Coord Frame = Coord 0
        Expression Value = massFlowAve(Total Temperature)@REGION:D7 C C_2 7_N01_D028.00_S03.00
        Option = Expression
      END
      MONITOR RESIDUALS: 
        Option = Full
      END
      MONITOR TOTALS: 
        Option = Full
      END
    END
    RESULTS: 
      File Compression Level = Default
      Option = Standard
    END
  END
END
"


"Simulatrion
  Flow Analysis 1
    Reactions"

"
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
"
