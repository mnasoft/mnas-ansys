;;;; ./src/rpl/rpl.lisp

(defpackage #:mnas-ansys/rpl
  (:use #:cl )
  (:export 
   ))

(defun ic-undo-group-end (stream)
  "ic_undo_group_end text [undo_group]

 Sets undo group end."
  (format stream "ic_undo_group_end~%"))

(defun ic-undo-group-begin (stream)
  "ic_undo_group_begin text [undo_group]

 Sets undo group begin.
"
  (format stream "ic_undo_group_begin~%"))
  
(defun ic-geo-new-family (name do-update stream)
  "ic_geo_new_family name do_update [1]

 Creates a new family if it is not already there. Returns 1 if a new
 family was created, or 0 if it already existed.

 Note: The newly created family will not appear in the interactive
 family list unless you issue the update_family_display command
 interactively."
  (format stream "ic_geo_new_family ~A~%" name)

  )

(defun ic_empty_tetin ()
  "ic_empty_tetin

 Creates an empty geometry database."
(format stream "ic_empty_tetin~%"))

(defun ic-point (family name x y z)
  "ic_point {} GEOM pnt.08 100,100,0"
  (format stream "ic_point {} ~A ~A ~F,~F,~F" family name x y z))

(defparameter *crv-inf* '(:no-crv-inf :only-crv-inf))

(defun ic-geo-set-family-params (fam &key
                                       (crv-inf nil)
                                       (prism 0)       ;; prism 0 
                                       (emax 0)        ;; max-size
                                       (ehgt 0)        ;; ehgt
                                       (hrat 0)        ;; height-ratio
                                       (nlay 0)        ;; num-layers
                                       (erat 0) ;; tetra-size-ratio
                                       (ewid 0) ;; tetra-width
                                       (emin 0) ;; min-size-limit
                                       (edev 0) ;; max-deviation
                                       (split-wall 0) ;; split_wall 0 
                                       (internal-wall 0) ;; internal_wall 0
                                       ;;
                                       (stream t)
                                       )
  "ic_geo_set_family_params fam args

 Sets the family parameters. If there is no such family, nothing will be done.

 @b(Пример использования:)
@begin[lang=lisp](code)
 ic_geo_set_family_params PART.1 no_crv_inf prism 0 emax 10.0 ehgt 0.0 hrat 0 nlay 0 erat 0 ewid 0 emin 0.0 edev 0.0 split_wall 0 internal_wall 0
 ic_geo_set_family_params PART.1 no_crv_inf prism 1 emax 1.0  ehgt 2.0 hrat 3 nlay 4 erat 5 ewid 6 emin 7.0 edev 8.0 split_wall 1 internal_wall 0
 ic_geo_set_family_params PART.1            prism 1 emax 1.0  ehgt 2.0 hrat 3 nlay 4 erat 5 ewid 6 emin 7.0 edev 8.0 split_wall 0 internal_wall 1
 ic_geo_set_family_params GEOM only_crv_inf                   ehgt 0.0        nlay 0 hrat 0 ewid 0
@end(code)
"
  (cond
    ((null crv-inf)
     (format stream "ic_geo_set_family_params ~A prism ~A emax ~A ehgt ~A hrat ~A nlay ~A erat ~A ewid ~A emin ~A edev ~A split_wall ~A internal_wall ~A;~%"
             fam prism emax ehgt hrat nlay erat ewid emin edev split-wall internal-wall))
    ((eq crv-inf :no-crv-inf)
     (format stream "ic_geo_set_family_params ~A no_crv_inf prism ~A emax ~A ehgt ~A hrat ~A nlay ~A erat ~A ewid ~A emin ~A edev ~A split_wall ~A internal_wall ~A;~%"
             fam prism emax ehgt hrat nlay erat ewid emin edev split-wall internal-wall))
    ((eq crv-inf :only-crv-inf)
     (format stream " ic_geo_set_family_params ~a only_crv_inf ehgt ~A nlay ~A hrat ~A ewid ~A;~%"
             fam ehgt nlay hrat ewid))))

(defun ic-geo-get-family-param (fam name &key (stream t))
  "ic_geo_get_family_param fam name

 Returns the family parameters."
  (format stream "ic_geo_get_family_param ~A ~A;~%" fam name))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(ic-geo-get-family-param "GEOM" "emax" )

(ic-geo-set-family-params "GEOM" :emax 8.0)
