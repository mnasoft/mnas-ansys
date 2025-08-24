;;;; ../src/cfx/pre/package.lisp

(defpackage :mnas-ansys/cfx/pre
  (:use #:cl )
  (:export gtmImport
           gtmAction-rename-Region
           gtmTransform
           )
  (:export cmd-invoke
           update
           preambule
           make-monitor-point ;;;;;;;;;;
           )
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
  (:export add-interface-general
           add-interface-rot-per           
           add-interface-rot-gen
           )
  (:export <mesh>
           <mesh>-3d-region-instance-number
           <mesh>-tin-pathname
           <mesh>-msh-pathname
           <mesh>-name
           <mesh>-2d-regions
           )
  (:export <3d-region>
           <3d-region>-mesh
           <3d-region>-simulation
           <3d-region>-3d-suffix
           <3d-region>-2d-suffix
           )
  (:export <simulation>
           <simulation>-meshes
           <simulation>-3d-regions
           <simulation>-commands
           )
  (:export <simulation-command>
           <simulation-command>-simulation)
  (:export <simulation-mesh-transformation>
           <simulation>-mesh-transformation)
  (:export <simulation-interface-general>
           <simulation-interfaces-general>-mesh-name-1
           <simulation-interfaces-general>-mesh-name-2)
  (:export <simulation-interface-rotational-periodicity>
           <simulation-interface-rotational-periodicity>-mesh-name)
  (:export <simulation-interface-rotational-general>
           <simulation-interface-rotational-general>-mesh-name)
  (:export <simulation-materials>)
  (:export <simulation-flow>
           <simulation-flow>-flow-name
           <simulation-flow>-domain-fluid-name
           <simulation-flow>-domain-solid-names
           )
  (:export mk-domain-fluid
           mk-domain-solid
           mk-flow
           )
  (:export main-test
           reset
           2d-region
           2d-regions
           2d-region-values
           2d-region-keys
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
  (:export interface-pairs
           interface-pairs-fluid
           interface-pairs-solid
           interface-pairs-fluid-general
           interface-pairs-fluid-rotational)
  (:export mesh)
  (:export select-3d-regions-by-mesh-name
           select-3d-regions-name-by-mesh-name
           select-3d-regions-fluid
           select-3d-regions-solid
           simulation-fluid-domain-location
           simulation-solid-domain-mesh-location))

(in-package :mnas-ansys/cfx/pre)

;;;; (unexport '(OUTLET-MFR-BOUNDARY))

