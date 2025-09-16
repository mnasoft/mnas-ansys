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

(defun mk-monitor-point (&key
                           (prefix "")
                           (name "")
                           domain-name
                           cartesian-coordinates
                           output-variables-list
                           expression
                           location 
                           region)
  "@b(Описание:) функция|метод|обобщенная_функция| @b(...)

 @b(Пример использования:)
@begin[lang=lisp](code)
 (mk-monitor-point
  :prefix \"MFR\"
  :expression \"massFlow()\"
  :region \"C G2 G2 R GT D_4.0 4\")

 @b(Пример использования:)
 (mk-monitor-point
  :cartesian-coordinates '(0.0 0.0 0.0)
  :output-variables-list \"Total Pressure\")

@end(code)
"
  (cond
    ((and cartesian-coordinates output-variables-list prefix)
     (make-instance
      'mnas-ansys/ccl/core:<monitor-point>
      :name name
      :cartesian-coordinates (format nil "~{~A [mm]~^, ~}" cartesian-coordinates)
      :output-variables-list output-variables-list
      :expression-value nil))
    ((and expression region prefix)
     (make-instance 'mnas-ansys/ccl/core:<monitor-point>
                    :name (mnas-ansys/ccl:good-name 
                           (ppcre:regex-replace-all
                            "\\s+" (concatenate 'string name " " prefix " " region)
                            " "))
                    :cartesian-coordinates nil
                    :expression-value (concatenate 'string expression "@REGION:" region)
                    :position-update-frequency nil
                    :monitor-location-control nil
                    :option "Expression"
                    :output-variables-list nil))
    ((and expression location prefix)
     (make-instance 'mnas-ansys/ccl/core:<monitor-point>
                    :name (mnas-ansys/ccl:good-name 
                           (ppcre:regex-replace-all
                            "\\s+" (concatenate 'string name " " prefix " " location)
                            " "))
                    :cartesian-coordinates nil
                    :expression-value (concatenate 'string expression "@" location)
                    :position-update-frequency nil
                    :monitor-location-control nil
                    :option "Expression"
                    :output-variables-list nil))))
