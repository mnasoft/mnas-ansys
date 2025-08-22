;;;; ./src/cfx/pre/monitor-objects/monitor-objects.lisp

(in-package :mnas-ansys/cfx/pre)

(defun mk-mfr (name
               &key (side "Side 1")
               &aux (nm
                     (concatenate
                      'string
                      name " " side)))
  (format t "FLOW: Flow Analysis 1~%")
  (format t "  OUTPUT CONTROL: ~%")
  (format t "    MONITOR OBJECTS: ~%")
  (format t "      &replace MONITOR POINT: MFR ~A~%"  nm)
  (format t "        Coord Frame = Coord 0~%")
  (format t "        Expression Value = massFlow()@~A~%" nm)
  (format t "        Option = Expression~%")
  (format t "      END~%")
  (format t "    END~%")
  (format t "  END~%")
  (format t "END~2%"))


(defun mk-mfr-region (region)
  (format t "FLOW: Flow Analysis 1~%")
  (format t "  OUTPUT CONTROL: ~%")
  (format t "    MONITOR OBJECTS: ~%")
  (format t "      &replace MONITOR POINT: MFR ~A~%" (mnas-ansys/ccl:good-name region))
  (format t "        Coord Frame = Coord 0~%")
  (format t "        Expression Value = massFlow()@REGION:~A~%" region)
  (format t "        Option = Expression~%")
  (format t "      END~%")
  (format t "    END~%")
  (format t "  END~%")
  (format t "END~2%"))

(defun mk-tt (name
               &key (side "Side 1")
               &aux (nm
                     (concatenate
                      'string
                      name " " side 
                      )))
  
  (format t "FLOW: Flow Analysis 1~%")
  (format t "  OUTPUT CONTROL: ~%")
  (format t "    MONITOR OBJECTS: ~%")
  (format t "      &replace MONITOR POINT: TT ~A~%" nm)
  (format t "        Coord Frame = Coord 0~%")
  (format t "        Expression Value = massFlowAve(Total Temperature )@~A~%" nm)
  (format t "        Option = Expression~%")
  (format t "      END~%")
  (format t "    END~%")
  (format t "  END~%")
  (format t "END~2%"))


(defun mk-tp (name
               &key (side "Side 1")
               &aux (nm
                     (concatenate
                      'string
                      name " " side 
                      )))
  
  (format t "FLOW: Flow Analysis 1~%")
  (format t "  OUTPUT CONTROL: ~%")
  (format t "    MONITOR OBJECTS: ~%")
  (format t "      &replace MONITOR POINT: TP ~A~%" nm)
  (format t "        Coord Frame = Coord 0~%")
  (format t "        Expression Value = massFlowAve(Total Pressure)@~A~%" nm)
  (format t "        Option = Expression~%")
  (format t "      END~%")
  (format t "    END~%")
  (format t "  END~%")
  (format t "END~2%"))
