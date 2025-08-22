;;;; ../src/cfx/pre/package.lisp

(defpackage :mnas-ansys/cfx/pre
  (:use #:cl )
  (:export gtmImport
           gtmAction-rename-Region
           gtmTransform
           )
  (:export preambule
           cmd-invoke
           update
           mesh-transformation
           general-int
           rotational-int
           outlet-mfr-boundary
           make-monitor-point
           fluid-dom
           solid-dom
           )
  (:export load-mesh)
  (:export rotate-point-around-vector
           mk-gt-cone-pnts
           move-rotate-point-around-vector
           make-ic-point
           mk-t-f-points
           )
  (:export mk-mfr
           mk-mfr-region
           mk-tt
           mk-tp
           )
  (:export domains
           
           solid-domains
           )
  (:export icem-fluid-domain-p
           icem-solid-domain-p)
  (:export <mesh>
           <mesh>-name
           <mesh>-2d-regions
           make-meshes
           )
  (:export <simulation>
           <simulation>-domains
           <simulation>-surfaces
           make-simulation)
  (:export surfaces)
  (:export mesh-name->domain-name
           domain-name->mesh-name)
  (:export mk-domain-fluid
           mk-domain-solid
           )
  (:export main-test
           reset
           2d-region
           2d-regions
           3d-region
           3d-regions
           3d-region-mesh
           3d-region-min
           3d-region-max
           3d-region-left
           3d-region-right
           add
           name
           create-script
           )
  (:export ht-keys
           ht-values
           ht-keys-sort 
           ht-values-sort)
  (:export interfaces
           interfaces-with)
  (:export mesh)
  )
 
(in-package :mnas-ansys/cfx/pre)

