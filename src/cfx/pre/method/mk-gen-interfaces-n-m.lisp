;;;; ./src/cfx/pre/method/mk-gen-interfaces-n-m.lisp

(in-package :mnas-ansys/cfx/pre)

(defmethod mk-gen-interfaces-n-m (g1 g2 (simulation <simulation>))
  (let* ((g1-3d-regions
           (select-3d-regions-by-mesh-name g1 simulation))
         (g2-3d-regions
           (select-3d-regions-by-mesh-name g2 simulation))
         (il1 (apply #'append
                     (mapcar
                      #'(lambda (el)
                          (interfaces-with el g2))
                      g1-3d-regions)))
         (il2 (apply #'append
                     (mapcar
                      #'(lambda (el)
                          (interfaces-with el g1))
                      g2-3d-regions))))
    (when (and il1 il2)
      (make-domain-interface-general-connection
       (mnas-string:common-prefix (append il1 il2)) il1 il2))))
