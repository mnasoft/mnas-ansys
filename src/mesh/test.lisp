;;;; ./src/mesh/mesh-log.lisp

(in-package :mnas-ansys/mesh-log)

(parse-log-file #P"Z:/ANSYS/CFX/a32/msh/prj_15/A32_prj_15_DG1.msh.log")
(parse-log-files "Z:/ANSYS/CFX/a32/msh/prj_15/A32_prj_15_*.msh.log")


(defparameter *coll*
  (make-collection
   "Z:/ANSYS/CFX/a32/msh/prj_15/A32_prj_15_*.msh.log"))

;;;; g90


(defparameter *prh-log*
  (load-msh-log-by-location
   "Z:/ANSYS/CFX/g90/msh/prj_01/G90L2d1_prj_01"))

(format t "~S" *prh-log*)


