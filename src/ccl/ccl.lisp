
;;;; ./src/clim/clim.lisp

(defpackage #:mnas-icem/ccl
  (:use #:cl #:mnas-icem/ccl-parse)
  (:export find-in-tree
           find-in-tree-key
           find-in-tree-value)
  (:documentation
   "STUB"))

(in-package #:mnas-icem/ccl)

(defun find-in-tree (item tree &key (test #'eql) (key #'identity))
  "@b(Описание:) функция @b(find-in-tree) выполняет рекурсивый поиск
  элемента @b(item) в древовидном списке @b(tree).

 @b(Пример использования:)
@begin[lang=lisp](code)
 (defparameter *l* '(\"FLOW\" \"Flow Analysis 1\"
                     (\"&replace DOMAIN INTERFACE\" \"C T_1 R\"
                      (\"Boundary List1\" \"C T_1 R Side 1\")
                      (\"Boundary List2\" \"C T_1 R Side 2\")
                      (\"Filter Domain List1\" \"D1L\")
                      (\"Filter Domain List2\" \"D1R\")
                      (\"Interface Region List1\" \"D1 C T_1 L_N01_D070.0_S18.90\")
                      (\"Interface Region List2\" \"D1 C T_1 R_N01_D070.0_S18.90 2\")
                      (\"Interface Type\" \"Fluid Fluid\")
                      (\"INTERFACE MODELS\" \"\"
                       (\"Option\" \"Rotational Periodicity\")
                       (\"AXIS DEFINITION\" \"\"
                        (\"Option\" \"Coordinate Axis\")
                        (\"Rotation Axis\" \"Coord 0.1\")))
                      (\"MESH CONNECTION\" \"\" (\"Option\" \"GGI\")))))

 (find-in-tree \"D1L\" *l* :test #'equal :key (lambda (i) (when (consp i) (second i))))
@end(code)
"
  (labels ((find-in-tree-aux (tree)                                   
             (cond ((funcall test item (funcall key tree))
                    (return-from find-in-tree tree))
                   ((listp tree)
                    (mapc #'find-in-tree-aux tree)
                    nil))))
    (find-in-tree-aux tree)))

(defun find-in-tree-key (key tree &key (test #'equal))
  (find-in-tree key tree :test test
                         :key (lambda (i) (when (consp i) (first i)))))

(defun find-in-tree-value (value tree &key (test #'equal))
  (find-in-tree value tree :test test
                           :key (lambda (i) (when (consp i) (second i)))))

(defun value (x) (cadr x))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defparameter *lines*
  (mnas-icem/read:read-file-as-lines
   "~/quicklisp/local-projects/ANSYS/mnas-icem/data/ccl/interfaces.ccl"))

(defparameter *ccl* (mnas-icem/ccl-parse::parse-slow *lines*))
(defparameter *ccl* (mnas-icem/ccl-parse::parse *lines*))

(value
 (find-in-tree-key "Option"
                  (find-in-tree-key "INTERFACE MODELS" (elt *ccl* 1))))

(defun domain-interface-graph (item &key (stream t))
  (let* ((d-i (find-in-tree-key "&replace DOMAIN INTERFACE" item))
         (d-i-name (value d-i))
         (d-i-f-d-l1 (value (find-in-tree-key "Filter Domain List1" item)))
         (d-i-f-d-l2 (value (find-in-tree-key "Filter Domain List2" item))))
    (when d-i
      d-i-name
      #+nil (format stream "~A -- ~A [label=~S]~%" d-i-f-d-l1 d-i-f-d-l2 d-i-name)
      (format stream "~A -- ~A~%" d-i-f-d-l1 d-i-f-d-l2))))

(mapcar #'domain-interface-graph *ccl*)

(domain-interface-graph (elt *ccl* 68))

