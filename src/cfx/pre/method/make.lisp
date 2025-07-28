;;;; ./src/cfx/pre/method/make.lisp

(in-package :mnas-ansys/cfx/pre)

(defun make-mesh (pathname)
  (let* ((domain (make-instance '<mesh>))
        (tin (mnas-ansys/tin:open-tin-file pathname)))
    (setf (<mesh>-name domain)
          (domain-name-by-pathname pathname))
    (map 'nil
         #'(lambda (el)
             (setf
              (gethash el (<mesh>-surfaces domain))
              el))
         (remove-duplicates 
          (loop :for sur
                  :in (alexandria:hash-table-values
                       (mnas-ansys/tin:<tin>-surfaces tin))
                :collect 
                (mnas-ansys/tin:<ent>-family sur))
          :test #'equal))
    domain))

(defun make-meshes (directory-template)
  (let ((meshes (make-instance '<meshes>)))
    (loop :for d :in (directory directory-template)
          :do (add (make-mesh d) meshes))
    meshes))

(defun make-simulation (directory-template)
  (let ((simulation (make-instance '<simulation>)))
    (loop :for d :in (directory directory-template)
          :do (add (make-mesh d) simulation))
    simulation))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun make-corelation (domain-name result simulation)
  "
 @b(Пример использования:)
@begin[lang=lisp](code)
 (make-corelation \"DG2 G2\" *DG2-G2* *simulation*)
@end(code)
"
  (let ((dom-result (ppcre:split "," result)))
    (loop :for i :in (simulation-doman-surfaces domain-name simulation)
          :collect
          (list i
                (extract-suffix i (first (filter-by-prefix i dom-result)))
                (mapcar
                 #'(lambda (el) (extract-suffix i el))
                 (filter-by-prefix i (surfaces simulation)))))))

(defun make-corelation-0 (domain-name result simulation)
  "
 @b(Пример использования:)
@begin[lang=lisp](code)
 (make-corelation-0 \"DG2 G2\" *DG2-G2* *simulation*)
@end(code)
"
  (let ((dom-result (ppcre:split "," result)))
    (loop :for i :in (simulation-doman-surfaces domain-name simulation)
          :collect
          (list i
                (first (filter-by-prefix i dom-result))
                (filter-by-prefix i (surfaces simulation))))))
