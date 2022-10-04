"Simulatrion
  Flow Analysis 1
    Solver
      Output Control
"


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
