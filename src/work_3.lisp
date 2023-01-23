(in-package :mnas-ansys/tin)

(progn
  (defparameter *tin* (mnas-ansys/dia:open-tin-file))
  (mnas-ansys/tin/utils:surface-names-coeged-with-surface-in-family
   '(
     "OUT_1"
     ;; "C/D_01.000"
     )
   *tin*
   :times 1
   :families-excluded
   '("C/D_01.000"
     ;; "B/D_00.800"
     ;; "IN"
     )))

(dia:setup-family-parameters :gmax 8)
