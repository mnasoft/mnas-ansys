;;;; ./src/cfx/pre/method/solid-2d-regions.lisp

(in-package :mnas-ansys/cfx/pre)

(defmethod solid-2d-regions (s-body-name (simulation <simulation>))
  (sort
   (remove-if
    #'(lambda (el)
        (or (uiop:string-prefix-p "DG0" el)
            (not (uiop:string-prefix-p "DG" el))
            (string/= s-body-name (second (mnas-ansys/ccl:mk-split el)))))
    (2d-region-values (select-3d-regions-solid simulation)))
   #'string<))
