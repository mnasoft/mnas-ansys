;;;; ./src/cfx/post/res-report.lisp

(in-package :mnas-ansys/cfx/post)

(defparameter *boundares*
    '((:mfr-air-inlet "MFR INLET:")
      (:tt-air-inlet  "TT INLET:")
      (:tp-air-inlet  "TP INLET:")
      ;;
      (:mfr-ch4-1-inlet "MFR INLET CH4 1:")
      (:tt-ch4-1-inlet  "TT INLET CH4 1:")
      (:tp-ch4-1-inlet  "TP INLET CH4 1:")
      ;;
      (:mfr-ch4-2-inlet "MFR INLET CH4 2:")
      (:tt-ch4-2-inlet  "TT INLET CH4 2:")
      (:tp-ch4-2-inlet  "TP INLET CH4 2:")
      ;;
      (:mfr-gt-out "MFR C G2 G6 Side 1:")
      (:tt-gt-out  "TT C G2 G6 Side 1:")
      (:tp-gt-out  "TP C G2 G6 Side 1:")
      ;;
      (:tt-outlet-air-sl  "TT OUTLET AIR SL:")
      (:tp-outlet-air-sl  "TP OUTLET AIR SL:")
      (:mfr-outlet-air-sl "MFR OUTLET AIR SL:")
      ;;
      (:tt-outlet-air-sa  "TT OUTLET AIR SA:")
      (:tp-outlet-air-sa  "TP OUTLET AIR SA:")
      (:mfr-outlet-air-sa "MFR OUTLET AIR SA:")
      ;;
      (:tt-outlet-air-rl "TT OUTLET AIR RL:")
      (:tp-outlet-air-rl "TP OUTLET AIR RL:")
      (:mfr-outlet-air-rl "MFR OUTLET AIR RL:")
      ;;
      (:tt-outlet "TT OUTLET:")
      (:tp-outlet "TP OUTLET:")
      (:mfr-outlet "MFR OUTLET:")))

(defparameter *mfr-flame-tubes* nil  
  "Список жаровых труб с распределением воздуха в них.")



(defmethod boundary-by-key (key (res-report <res-report>))
  (math/stat:average-value
   (mnas-ansys/cfx/file/mon:<mon>-data
    (gethash
     (second (assoc key (<res-report>-boundares res-report)))
     (mnas-ansys/cfx/file:<res>-mon (<res>-res res-report))))))

(defmethod reference-pressure ((res-report <res-report>))
  "Опорное давление"
  (reference-pressure (<res>-res res-report)))

(defmethod p-02 ((res-report <res-report>))
  "Полное давление на входе в расчетную область"
  (+ (reference-pressure (<res>-res res-report))
     (boundary-by-key :TP-AIR-INLET res-report)))

(defmethod t-02 ((res-report <res-report>))
  "Полная температура на входе в расчетную область"
  (boundary-by-key :TT-AIR-INLET res-report))

(defmethod t-03 ((res-report <res-report>))
  "Полная температура на выходе из ЖТ"
  (boundary-by-key :tt-gt-out res-report))

(defmethod dt-ks ((res-report <res-report>))
  "Подогрев воздуха в КС"
  (- (t-03 res-report) (t-02 res-report)))

(defmethod p-03 ((res-report <res-report>))
    "Полное давление на выходе из ЖТ"
  (+ (reference-pressure (<res>-res res-report))
     (boundary-by-key :TP-GT-OUT res-report)))

(defmethod dp-ks ((res-report <res-report>))
  "Абсолютные потери полного давления на КС, Па"
  (- (p-02 res-report) (p-03 res-report)))

(defmethod dpr-ks ((res-report <res-report>))
  "Относительные птери полного давления на КС, доли"
  (1- (/ (p-02 res-report) (p-03 res-report))))


