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
