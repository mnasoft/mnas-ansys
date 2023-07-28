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



(dia:setup-family-parameters :gmax 4)

(format t "~A~3%"
(ppcre:regex-replace-all "/"
                         (concatenate 'string dia:*tin-fname* ".rpl")
                         "\\"))
 ; => "D:\\home\\_namatv\\FLUENT\\UGT5000\\H2\\tin\\19-01-2020.tin.rpl", T
 ; => "D:/home/_namatv/FLUENT/UGT5000/H2/tin/19-01-2020.tin.rpl"

(- 1.0 0.233)
