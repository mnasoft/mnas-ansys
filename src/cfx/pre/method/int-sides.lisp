;;;; ./src/cfx/pre/method/int-sides.lisp

(in-package :mnas-ansys/cfx/pre)

(defmethod int-sides ((obj <simulation-interface-general>))
  (let* ((g1 (<simulation-interfaces-general>-mesh-name-1 obj))
         (g2 (<simulation-interfaces-general>-mesh-name-2 obj))
         (simulation (<simulation-command>-simulation obj))
         (g1-3d-regions
           (select-3d-regions-by-mesh-name g1 simulation))
         (g2-3d-regions
           (select-3d-regions-by-mesh-name g2 simulation))
         (il1 (apply #'append
                     (mapcar
                      #'(lambda (el)
                          (interfaces-general-with-01 el g2))
                      g1-3d-regions)))
         (il2 (apply #'append
                     (mapcar
                      #'(lambda (el)
                          (interfaces-general-with-01 el g1))
                      g2-3d-regions))))
    (list il1 il2)))

(defmethod int-sides ((obj <simulation-interface-rotational-periodicity>))
  (let* ((mesh-name (<simulation-interface-rotational-periodicity>-mesh-name obj))
         (simulation (<simulation-command>-simulation obj))
         (i-min (interface-rot-min mesh-name simulation))
         (i-max (interface-rot-max mesh-name simulation)))
    (list i-min i-max)))

(defmethod int-sides ((obj <simulation-interface-rotational-general>))
  (let* ((mesh-name (<simulation-interface-rotational-general>-mesh-name obj))
         (simulation (<simulation-command>-simulation obj))
         (i-left (interface-rot-left mesh-name simulation))
         (i-right (interface-rot-right mesh-name simulation)))
    (list i-left i-right)))

(defmethod int-sides ((obj <simulation-interface-diff-periodicity>))
  (let* ((mesh-name-1 (<simulation-interface-diff-periodicity>-mesh-name-1 obj))
         (mesh-name-2 (<simulation-interface-diff-periodicity>-mesh-name-2 obj))
         (meshes (list mesh-name-1 mesh-name-2))
         (simulation (<simulation-command>-simulation obj))
         (i-min (mapcar #'(lambda (el) (3d-region-min el simulation)) meshes))
         (i-max (mapcar #'(lambda (el) (3d-region-max el simulation)) meshes))
         (int-r (mapcar #'(lambda (3d-reg) (2d-region-values 3d-reg)) i-min))
         (int-l (mapcar #'(lambda (3d-reg) (2d-region-values 3d-reg)) i-max))
         (i-r   (apply #'append
                       (mapcar #'(lambda (2d-reg)
                                   (remove-if-not #'interface-diff-mesh-right-p 2d-reg))
                               int-r)))
         (i-l   (apply #'append
                       (mapcar #'(lambda (2d-reg)
                                   (remove-if-not #'interface-diff-mesh-left-p 2d-reg))
                               int-l))))
    (list i-r i-l)))

(defmethod int-sides ((obj <simulation-interface-diff-general>))
  (let* ((mesh-name-1 (<simulation-interface-diff-general>-mesh-name-1 obj))
         (mesh-name-2 (<simulation-interface-diff-general>-mesh-name-2 obj))
         (meshes (list mesh-name-1 mesh-name-2))
         (simulation (<simulation-command>-simulation obj))
         (3d-not-min (apply #'append (mapcar #'(lambda (el) (3d-region-not-min el simulation)) meshes)))
         (3d-not-max (apply #'append (mapcar #'(lambda (el) (3d-region-not-max el simulation)) meshes)))
         (2d-not-min (mapcar #'(lambda (3d-reg) (2d-region-values 3d-reg)) 3d-not-min))
         (2d-not-max (mapcar #'(lambda (3d-reg) (2d-region-values 3d-reg)) 3d-not-max))
         (i-not-min  (apply #'append
                            (mapcar #'(lambda (2d-reg)
                                        (remove-if-not #'interface-diff-mesh-right-p 2d-reg))
                                    2d-not-min)))
         (i-not-max  (apply #'append
                            (mapcar #'(lambda (2d-reg)
                                        (remove-if-not #'interface-diff-mesh-left-p 2d-reg))
                                    2d-not-max))))
    (list i-not-min i-not-max)))

