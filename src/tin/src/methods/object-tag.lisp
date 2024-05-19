(in-package :mnas-ansys/tin)

(defmethod <object>-tag ((point <prescribed-point>))
  "prescribed_point")

(defmethod <object>-tag ((curve <curve>))
  "define_curve")

(defmethod <object>-tag ((material-point <material-point>))
  "material_point")

(defmethod <object>-tag ((coedge <coedge>))
  "coedge")

(defmethod <object>-tag ((surface <surface>)) "
define_surface")

(defmethod <object>-tag ((solid <solid>))
  "define_solid")

(defmethod <object>-tag ((bspline <bspline>))
  "bspline")
