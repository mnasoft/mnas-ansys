;;;; ./src/mesh/mesh-log.lisp

(in-package :mnas-ansys/mesh-log)

(parse-log-file #P"Z:/ANSYS/CFX/a32/msh/prj_15/A32_prj_15_DG1.msh.log")
(parse-log-files "Z:/ANSYS/CFX/a32/msh/prj_15/A32_prj_15_*.msh.log")


(defparameter *coll*
  (make-collection
   "Z:/ANSYS/CFX/a32/msh/prj_15/A32_prj_15_*.msh.log"))

(log-names *coll*)

(get-log "A32_prj_15_DM3" *coll*)
