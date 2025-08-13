;;;; ./src/cfx/pre/method/interface.lisp

(in-package :mnas-ansys/cfx/pre)


(defmethod interfaces ((3d-region <3d-region>))
  (sort 
   (remove-if #'(lambda (el)
                  (not
                   (uiop:string-prefix-p "C" el)))
              (2d-regions 3d-region))
   #'string<))

(defmethod interfaces-with ((3d-region <3d-region>) mesh-name-2)
  (labels ((foo (str)
             (let ((lst (ppcre:split " " str)))
               (list (second lst) (third lst)))))
    (let ((mesh-name-1 (<mesh>-name (<3d-region>-mesh 3d-region))))
      (remove-if-not
       #'(lambda (el)
           (let ((lst (foo el)))
             (equalp 
              (sort lst #'string<)
              (sort (list mesh-name-1 mesh-name-2) #'string<))))
       (interfaces 3d-region)))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun prepare-list (lst)
  (cond
    ((stringp lst) lst)
    ((consp lst)
     (format nil "~{~A~^,~}" lst))))

(defun make-domain-interface-general-connection (name i-reg-lst-1 i-reg-lst-2 &key postfix)
  (let ((d-i
          (mnas-ansys/ccl:good-name
           (if postfix
               (format nil "~A ~A" name postfix)
               (format nil "~A" name)))))
    (format t "FLOW: Flow Analysis 1~%")
    (format t "  &replace DOMAIN INTERFACE: ~A~%" d-i)
    (format t "    Boundary List1 = ~A Side 1~%" d-i)
    (format t "    Boundary List2 = ~A Side 2~%" d-i)
    (format t "    Filter Domain List1 = D1~%" )
    (format t "    Filter Domain List2 = D1~%" )
    (format t "    Interface Region List1 = ~A~%" (prepare-list i-reg-lst-1))
    (format t "    Interface Region List2 = ~A~%" (prepare-list i-reg-lst-2))
    (format t "    Interface Type = Fluid Fluid~%")
    (format t "    INTERFACE MODELS: ~%")
    (format t "      Option = General Connection~%")
    (format t "      FRAME CHANGE: ~%")
    (format t "        Option = None~%")
    (format t "      END~%")
    (format t "      MASS AND MOMENTUM: ~%")
    (format t "        Option = Conservative Interface Flux~%")
    (format t "        MOMENTUM INTERFACE MODEL: ~%")
    (format t "          Option = None~%")
    (format t "        END~%")
    (format t "      END~%")
    (format t "      PITCH CHANGE: ~%")
    (format t "        Option = None~%")
    (format t "      END~%")
    (format t "    END~%")
    (format t "    MESH CONNECTION: ~%")
    (format t "      Option = Automatic~%")
    (format t "    END~%")
    (format t "  END~%")
    (format t "END~%")))

(defun make-domain-interface-rotational-periodicity (domain-interface i-reg-lst-1 i-reg-lst-2 &key postfix)
  (let ((d-i
          (mnas-ansys/ccl:good-name
           (if postfix
               (format nil "~A ~A" domain-interface postfix)
               (format nil "~A" domain-interface)))))

    (format t "FLOW: Flow Analysis 1~%")
    (format t "  &replace DOMAIN INTERFACE: ~A~%" d-i )
    (format t "    Boundary List1 = ~A Side 1~%" d-i )
    (format t "    Boundary List2 = ~A Side 2~%" d-i)
    (format t "    Filter Domain List1 = D1~%")
    (format t "    Filter Domain List2 = D1~%")
    (format t "    Interface Region List1 = ~A~%" (prepare-list i-reg-lst-1))
    (format t "    Interface Region List2 = ~A~%" (prepare-list i-reg-lst-2))
    (format t "    Interface Type = Fluid Fluid~%")
    (format t "    INTERFACE MODELS: ~%")
    (format t "      Option = Rotational Periodicity~%")
    (format t "      AXIS DEFINITION: ~%")
    (format t "        Option = Coordinate Axis~%")
    (format t "        Rotation Axis = Coord 0.1~%")
    (format t "      END~%")
    (format t "    END~%")
    (format t "    MESH CONNECTION: ~%")
    (format t "      Option = Automatic~%")
    (format t "    END~%")
    (format t "  END~%")
    (format t "END~%")))

(defmethod mk-gen-interfaces-n-m (g1 g2 (simulation <simulation>))
  (let* ((g1-3d-regions
           (select-3d-regions-by-mesh-name g1 simulation))
         (g2-3d-regions (select-3d-regions-by-mesh-name g2 simulation))
         (il1 (apply #'append
                     (mapcar
                      #'(lambda (el)
                          (interfaces-with  el g2))
                      g1-3d-regions)))
         (il2 (apply #'append
                     (mapcar
                      #'(lambda (el)
                          (interfaces-with  el g1))
                      g2-3d-regions))))
    (make-domain-interface-general-connection
     (mnas-string:common-prefix (append il1 il2)) il1 il2)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defmethod interface-rot-min (mesh-name (simulation <simulation>))
  (remove-if-not
   #'2d-region-right-p
   (interfaces (3d-region-min mesh-name simulation))))

(defmethod interface-rot-max (mesh-name (simulation <simulation>))
  (remove-if-not
   #'2d-region-left-p
   (interfaces (3d-region-max mesh-name simulation))))

(defmethod mk-rot-per-interfaces-n-m (mesh-name
                                      (simulation <simulation>)
                                      &key (postfix "ROT"))
  (let* ((i-min (interface-rot-min mesh-name simulation))
         (i-max (interface-rot-max mesh-name simulation)))
    (when (and i-min i-max)
      (make-domain-interface-rotational-periodicity 
       (mnas-string:common-prefix (append i-min i-max)) i-min i-max
       :postfix postfix))))
