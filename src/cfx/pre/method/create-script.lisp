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

