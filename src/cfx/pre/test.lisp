;;;; ./src/cfx/pre/test.lisp

(in-package :mnas-ansys/cfx/pre)

(defparameter *cfx-domains*
  (make-instance '<cfx-domains> :icem-parts *parts*))


(ppcre:split "/"
             (alexandria:hash-table-values (<cfx-domains>-icem-parts *cfx-domains*)))



(let ((rez nil))
  (alexandria:maphash-keys
   #'(lambda (el)
       (push (second (ppcre:split "/" el)) rez))
       (<cfx-domains>-icem-parts *cfx-domains*))
  (sort (remove-duplicates rez :test #'equal) #'string< ))



(let* ((surface-name "C/G31-G32/01/D_0.6")
      (domain-name  "G31")
      (path (ppcre:split "/" surface-name))
      )
  
  (string= (first path) "C")
  (ppcre:split "-" (second path))
  )

(ppcre:split "/" surface-name)
(is-icem-fluid-surface ) 

(icem-fluid-domains *cfx-domains*)



*parts*

(length (find-icem-surfaces "G1" *cfx-domains*))
(length (cadr (assoc "DG1 G1" *i* :test #'equal)))





(mapcar
 #'(lambda (el)
     (cl-ppcre:regex-replace-all "[/-]" el " "))
 (find-icem-surfaces "G1" *cfx-domains*))


(set-difference
 (mapcar
  #'(lambda (el)
      (cl-ppcre:regex-replace-all "[/-]" el " "))
  (find-icem-surfaces "G1" *cfx-domains*))
 (cadr (assoc "DG1 G1" *i* :test #'equal))
 
 :test #'string=)
 ; => ("C G1 G10 K_G1 01 D_0.0" "C G1 G10 K_G1 02 D_0.0" "C G1 G8 K_G1 01 D_0.0")
 
 '("foo" "bar" "baz") '("bar" "qux") )
;; => ("foo" "baz")


(icem-domains *cfx-domains*)
(icem-solid-domains *cfx-domains*)

(icem-solid-domain-p "M2" *cfx-domains*)

(icem-fluid-domain-p "G1" *cfx-domains*)








(<cfx-domains>-icem-parts *cfx-domains*)

;;(domains )
