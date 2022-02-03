;;;; ./src/icem/geometry.lisp

(defpackage #:mnas-ansys/icem/geometry
  (:use #:cl)
  (:export ic_geo_cre_pnt
           ic_geo_cre_line)
;;;; generics

  (:documentation
   " Пакет предназначен для создания геометрии через API системы ANSYS ICEM CFD."
   ))

(in-package #:mnas-ansys/icem/geometry)

(defun ic_geo_cre_pnt (family name pnt &optional (in_lcs 1))
  "
ic_geo_cre_pnt family name pnt in_lcs [1]

Creates a prescribed point from coordinates.

family family containing point  
name name of created point 
pnt point data, e.g. {1 2 3} 
in_lcs 1 if the location should be in the current local coordinate system (default)  
return name of created point  

Notes: 

The specified point name may be modified to resolve name collisions

If the function returns with the error status set, the result string will contain an error message.

Example 

# Create a prescribed point from coordinates

 if [catch {ic_geo_cre_pnt duck louie {1 2 3} } pnt1] {
 mess \"$pnt1\n\" red
 } else {
 mess \"created a ducky point, $pnt1\n\"
 }
"
  (format t "ic_geo_cre_pnt ~A ~A {~{~A~^ ~}} ~A~%" family name pnt in_lcs)
  name)

(defun ic_geo_create_unstruct_curve_from_points (name fam pts)
  "Creates a piecewise linear curve from the points. This curve is
given the specified name and family. pts is a list of triples of
floating point numbers or list of prescribed point names and they are
connected in order. The points are in the current local coordinate
system.
"
  (format t "ic_geo_create_unstruct_curve_from_points ~A ~A {~{ {~{~A~^ ~}} ~}}~%"
          name fam pts))

(ic_geo_create_unstruct_curve_from_points
 "curve"
 "FAM/TOOL"
 '((1.0 0.0 0.0) (1.0 1.0 0.0) (-1.0 0.0 0.0)))

(ic_geo_cre_pnt "FAM/COOL" "pnt" '(50 50 50))

(defun ic_geo_cre_line (family name p1 p2)
"
ic_geo_cre_line family name p1 p2

Create a bspline line from 2 points.

family family containing curve 
name name of created curve 
p1 point data, e.g. {1 2 3} 
p2 point data, e.g. {1 2 3} 
return name of created curve 

Notes: 

The specified curve name may be modified to resolve name collisions

If the function returns with the error status set, the result string
will contain an error message.

Positions may be specified explicitly or using names of prescribed
points

For an annotated example of usage, refer to ic_geo_cre_line.tcl in the
ANSYS installation directory under
v145/icemcfd/Samples/ProgrammersGuide/med_test.
"
  (format t "ic_geo_cre_line ~A ~A {~{~A~^ ~}} {~{~A~^ ~}}~%"
          family name p1 p2))

(ic_geo_cre_line "FAM/SOOL" "line" '(0.0 0.0 0.0) '(50 80 140))

(defun ic_geo_cre_arc_from_pnts (family name p1 p2 p3)
  "
ic_geo_cre_arc_from_pnts family name p1 p2 p3

Create a bspline arc from 3 points.

family family containing curve 
name name of created curve 
p1 point data, e.g. {1 2 3}  
p2 point data, e.g. {1 2 3}  
p3 point data, e.g. {1 2 3} 

Notes: 

The specified curve name may be modified to resolve name collisions.

Positions may be specified explicitly or using names of prescribed points.

If the function returns with the error status set, the result string will contain an error message.

For an annotated example of usage, refer to ic_geo_cre_arc_from_pnts.tcl in the ANSYS installation directory under v145/icemcfd/Samples/ProgrammersGuide/med_test.
"
  (format t "ic_geo_cre_arc_from_pnts ~A ~A {~{~A~^ ~}} {~{~A~^ ~}} {~{~A~^ ~}}~%"
          family name p1 p2 p3))

(ic_geo_cre_arc_from_pnts "FAM/COOL" "arc"
                          '(100.0 0.0 0.0)
                          '(0.0 100.0 0.0)
                          '(-100.0 0.0 0.0))

(defun ic_geo_cre_bsp_crv_n_pnts (family name pnts &optional (tol 0.0001) (deg 3))
"ic_geo_cre_bsp_crv_n_pnts family name pnts tol [0.0001] deg [3]

Creates a bspline curve from n points.

family family containing curve 
name name of created curve 
pnts point data 
tol approximation tolerance 
deg curve degree = 1 (linear) or 3 (cubic)  

Notes: 

The specified curve name may be modified to resolve name collisions.

If the function returns with the error status set, the result string will contain an error message.

Positions may be specified explicitly or using names of prescribed points.

The approximation tolerance is relative. It will be scaled by the pointset chordlength to form an absolute tolerance. It has a default value of 0.0001.

For example usage, refer to ic_geo_cre_bsp_crv_n_pnts.tcl in the ANSYS installation directory under v145/icemcfd/Samples/ProgrammersGuide/med_test.
"
  )

(defun ic_geo_cre_bsp_crv_n_pnts_cons family name pnts fixPnts tanCons tanIndx tol [0.001]
"  
ic_geo_cre_bsp_crv_n_pnts_cons family name pnts fixPnts tanCons tanIndx tol [0.001]

Creates a bspline curve from n points with constraints.

family family containing curve 
name name of created curve 
pnts point data 
fixPnts fixed points 
tanCons specified tangents 
tanIndx indices of points in pnts associated to tangent vectors 
tol approximation tolerance 

Notes: 

The specified curve name may be modified to resolve name collisions.

If the function returns with the error status set, the result string will contain an error message.

Positions may be specified explicitly or using names of prescribed points

Point array is indexed as 0, 1, 2, . . .

The approximation tolerance is relative. It will be scaled by the pointset chordlength to form an absolute tolerance. It has a default value of 0.0001.

For example usage, refer to ic_geo_cre_bsp_crv_n_pnts_cons.tcl in the ANSYS installation directory under v145/icemcfd/Samples/ProgrammersGuide/med_test.

ic_geo_cre_crv_arc_ctr_rad family name center x_ax normal radius srtang endang

Creates a bspline arc from center, radius information.

family family containing curve 
name name of created curve 
center arc center 
x_ax vector aligned along angle == 0 
normal arc normal 
radius arc radius 
srtang start angle (degrees) 
endang end angle (degrees) 
return name of created curve 

Notes: 

The specified curve name may be modified to resolve name collisions.

If the function returns with the error status set, the result string will contain an error message.

If endang < srtang or (endang - srtang) > 360, the angle will be adjusted by adding 360 increments.

Positions may be specified explicitly or using names of prescribed points.

For annotated examples of usage, refer to ic_geo_cre_crv_arc_ctr_rad.tcl and ic_geo_create_surface_from_curves.tcl in the ANSYS installation directory under v145/icemcfd/Samples/ProgrammersGuide/med_test.
"
  )

(defun ic_geo_cre_srf_cyl (family name center x_ax z_ax radius srtang endang length)
  "  
ic_geo_cre_srf_cyl family name center x_ax z_ax radius srtang endang length

Create a bspline cylinder from center, radius information.

family family containing surface 
name name of created surface 
base cylinder base point 
x_ax vector aligned along angle == 0 
z_ax vector aligned along cyl axis 
radius cylinder radius 
srtang start angle (degrees)  
endang end angle (degrees) 
length length 
return name of created surface 

Notes: 

The specified surface name may be modified to resolve name collisions.

If the function returns with the error status set, the result string
will contain an error message.

If endang < srtang or (endang - srtang) > 360, the angle will be
adjusted by adding 360 degree increments.

Positions may be specified explicitly or using names of prescribed
points.

For an annotated example of usage, refer to ic_geo_cre_srf_cyl.tcl in
the ANSYS installation directory under
v145/icemcfd/Samples/ProgrammersGuide/med_test.
"
  (format t "ic_geo_cre_srf_cyl ~A ~A {~{~A~^ ~}} {~{~A~^ ~}} {~{~A~^ ~}} ~A ~A ~A ~A~%"
          family name center x_ax z_ax radius srtang endang length))

(ic_geo_cre_srf_cyl "family" "name" '(100.0 100.0 50.0) '(1.0 1.0 0.0) '(1.0 0.0 1.0) 100 0.0 180.0 800.0)

(defun ic_geo_cre_mat (fam name pt &optional (in_lcs 1))
  "    
ic_geo_cre_mat fam name pt in_lcs [1]

Create a material point from coordinates.

family family containing material point  
name name of created material point  
pnt point data, e.g. {1 2 3}, or the word outside 
in_lcs 1 if the location should be in the current local coordinate system (default) 
return name of created material point  

Notes: 

The specified point name may be modified to resolve name collisions.

If the function returns with the error status set, the result string will contain an error message.

Example 

# Create a material point from coordinates

 if [catch {ic_geo_cre_mat duck louie {1 2 3} } pnt1] {
 mess \"$pnt1\n\" red
 } else {
 mess \"created a ducky point, $pnt1\n\"
 }
"
  (format t "ic_geo_cre_mat ~A ~A {~{~A~^ ~}} ~A~%" fam name pt in_lcs)
  name
  )

(ic_geo_cre_mat "fam" "name" '(400.0 100.0 50.0)) 
