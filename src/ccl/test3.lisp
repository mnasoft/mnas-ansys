(in-package :mnas-ansys/ccl)

(loop :for name :in *surface* :do
      (if (is-boundary name)
        (format t "~S~%" name )))


