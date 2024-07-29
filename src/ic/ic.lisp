;;;; ./src/ic/ic.lisp

(defpackage :mnas-ansys/ic
  (:use #:cl)
  (:export point
           curve-point)
  (:documentation
   " Пакет предназначен для создания геометрии через API системы ANSYS ICEM CFD."))

(in-package :mnas-ansys/ic)

(defun point (fam name point)
  (format
   t
   "ic_point {} ~A ~A ~{~F~^,~}; " fam name point))

(defun curve-point (fam name point-names)
  (format
   t
   "ic_curve point ~A ~A {~{~F~^ ~}}; " fam name point-names))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


