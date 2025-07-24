;;;; ./src/cfx/post/method-mfr-gt-tract.lisp

(in-package :mnas-ansys/cfx/post)

(defmethod print-object ((obj <mfr-gt-tract>) s)
  (print-unreadable-object (obj s :type t)
    (format s "~{~S~^ ~}"
            (list
             (<mfr-gt-tract>-designation obj)
             (<mfr-gt-tract>-x           obj)
             (<mfr-gt-tract>-monitor     obj)
             (<mfr-gt-tract>-group       obj)
             (<mfr-gt-tract>-description obj)
             (<mfr-gt-tract>-sign        obj)))))
