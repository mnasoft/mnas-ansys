;;;; ./src/mesh/package.lisp

(defpackage :mnas-ansys/mesh-log
  (:use #:cl)
  (:export <mesh-log>
           <mesh-log>-name
           <mesh-log>-nodes
           <mesh-log>-tetra
           <mesh-log>-prism
           <mesh-log>-hex
           <mesh-log>-scaling-factor
           <mesh-log>-has-refinements
           )
  (:export parse-log-file
           parse-log-files
           )
  (:export <mesh-log-collection>
           <mesh-log-collection>-pattern
           <mesh-log-collection>-logs
           make-collection
           load-logs
           get-log
           log-names
           )
  (:documentation
   "Пакет @b(mnas-ansys/mesh-log) предназначен для разбора файлов 
    логирования создания сеток в ANSYS ICEM CFD."))

(in-package :mnas-ansys/mesh-log)
