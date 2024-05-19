(defpackage :mnas-ansys/tin
  (:use #:cl #:mnas-ansys/tin/read)
  (:nicknames "TIN")
  (:export open-tin-file)
;;;; generics
  (:export <object>-tag
           read-object
           coedged
           coincident
           )
;;;; classes ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; <obj>
  (:export <obj>
           <obj>-name)
;;;; <ent>
  (:export <ent>
           <ent>-family)
;;;; <tetra>
  (:export <tetra>
           <tetra>-size)
;;;; <point>  
  (:export <point>
           <point>-x
           <point>-y
           <point>-z)
;;;; <family>
  (:export <family>
           <family>-color
           <family>-prism
           <family>-internal-wall
           <family>-split-wall
           <family>-tetra-size
           <family>-height
           <family>-hratio
           <family>-nlay
           <family>-ratio
           <family>-width
           <family>-min
           <family>-dev)
;;;; <curve>
  (:export <curve>
           <curve>-vertex1
           <curve>-vertex2
           <curve>-bspline
           <curve>-surfaces)
;;;; <material-point>  
  (:export <material-point>)
;;;; <coedge>  
  (:export <coedge>
           <coedge>-curve-type
           <coedge>-direction
           <coedge>-name)
;;;; <surface>
  (:export <surface>
           <surface>-coedges)
  (:export <solid>
           <solid>-material-point
           <solid>-n-lumps
           <solid>-n-sheets
           <solid>-matlpoint
           )
;;;; <tin>
  (:export <tin>
           <tin>-file-name
           <tin>-families
           <tin>-points
           <tin>-curves
           <tin>-surfaces
           <tin>-triangulation-tolerance
           tin-points
           tin-curves
           tin-surfaces           
           )
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  (:export find-point-by-name
           find-curve-by-name
           find-surface-by-name
           )
  (:export find-coincidense)
  (:intern position-tin-in-objects
           populate-by-name
           init-curves
           )
  (:export find-curve-by-name
           find-surface-by-name
           find-surfaces-coeged-with-curves
           )
  (:export families
           names
           surface-coeged-with-surfaces
           )
  (:export count-surface)
  (:export <bspline>
           )
  (:documentation
   " Пакет предназначен для выполнения операций с представлением tin-файлов 
 (представления геометрии) системы ANSYS ICEM.

 Для того, чтобы осуществлять манипуляции с геометрическими объектами
 сначала необходимо выполнить открытие и разбор tin-файлова при помощи
 функции @b(open-tin-file)."
   ))

(in-package :mnas-ansys/tin)
