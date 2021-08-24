;;;; ./src/ccl/test.lisp

(in-package #:mnas-ansys/ccl)

(defclass <mesh-connection> ()
  ((option :accessor <mesh-connection>-option)))

(defclass <pitch-change> ()
 ((option :accessor <pitch-change>-option)))

(defclass <momentum-interface-model>
    ((option :accessor <momentum-interface-model>-option)))
     
(defclass <mass-and-momentum>
    ((option :accessor <mass-and-momentum>-option)
     (momentum-interface-model)))

(defclass <frame-change> ()
  ((option :accessor <frame-change>-option)))

(defclass <interface-models> ()
  ((option            :accessor <interface-models>-option)
   (frame-change      :accessor <interface-models>-frame-change)
   (mass-and-momentum :accessor <interface-models>-mass-and-momentum)
   (pitch-change      :accessor <interface-models>-pitch-change)
   (mesh-connection   :accessor <interface-models>-mesh-connection)))

(defclass <domain-interface> ()
  ((name                   :initform "C"
                           :initarg  :name
                           :accessor <domain-interface>-name)
   (boundary-list1         :initform nil
                           :initarg  :boundary-list1
                           :accessor <domain-interface>-boundary-list1)
   (boundary-list2         :initform nil
                           :initarg  :boundary-list2
                           :accessor <domain-interface>-boundary-list2)
   (filter-domain-list1    :initform nil
                           :initarg  :filter-domain-list1
                           :accessor <domain-interface>-filter-domain-list1)
   (filter-domain-list2    :initform nil
                           :initarg  :filter-domain-list2
                           :accessor <domain-interface>-filter-domain-list2)
   (interface-region-list1 :initform nil
                           :initarg  :interface-region-list1
                           :accessor <domain-interface>-interface-region-list1)
   (interface-region-list2 :initform nil
                           :initarg  :interface-region-list2
                           :accessor <domain-interface>-interface-region-list2)
   (interface-type         :initform "Fluid Fluid"
                           :initarg  :interface-type
                           :accessor <domain-interface>-interface-type)
   )
  (:documentation
   "@b(Описание:) класс @b(domain-interface) представляет итерфейс меду двумя доменами.
"))

(defmethod print-object ((domain-interface <domain-interface>) s)
  (format s "  &replace DOMAIN INTERFACE: ~A~%"
          (<domain-interface>-name domain-interface))
  (format s "    Boundary List1 = ~{~A~^,~}~%"
          (<domain-interface>-boundary-list1 domain-interface))
  (format s "    Boundary List2 = ~{~A~^,~}~%"
          (<domain-interface>-boundary-list2 domain-interface))
  (format s "    Filter Domain List1 = ~{~A~^,~}~%"
          (<domain-interface>-filter-domain-list1 domain-interface))
  (format s "    Filter Domain List2 = ~{~A~^,~}~%"
          (<domain-interface>-filter-domain-list2 domain-interface))
  (format s "    Interface Region List1 = ~{~A~^,~}~%"
          (<domain-interface>-interface-region-list1 domain-interface))
  (format s "    Interface Region List2 = ~{~A~^,~}~%"
          (<domain-interface>-interface-region-list2 domain-interface))
  (format s "    Interface Type = ~A~%"
          (<domain-interface>-interface-type domain-interface)))

(make-instance '<domain-interface>
               :name "C T_1 G"
               :boundary-list1 '("C_1 A_N01 Side 1" "C_1 A_N01 in D1R Side 1")
               :boundary-list2 '("C_1 A_N01 Side 2")
               :filter-domain-list1 '("D1L" "D1R")
               :filter-domain-list2 '("DA")
               :interface-region-list1 '("D1 C C_1 A_N01_D034.10_S02.50" "D1 C C_1 A_N01_D034.10_S02.50 2")
               :interface-region-list2 '("DA C C_1 A_N01_D034.10_S02.50")
               )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun is-start-with (bag str)
  (let ((l-bag (length bag))
        (l-str (length str)))
    (and (<= l-bag l-str)
         (string= bag (subseq str 0 l-bag)))))

(is-start-with "FLOW:" "END")

(defun is-start (str) (is-start-with "FLOW:" str))

(defun is-end   (str) (is-start-with "END" str))

(defun split-interface (v-string)
  (let ((start nil)
        (end   nil))
    (loop :for i :from 0 :below (length v-string) :do
      (progn
        (when (is-start (svref v-string i))
          (push i start))
        (when (is-end (svref v-string i))
          (push i end))))
    (nreverse (mapcar #'list start end))))

(split-interface *lines*)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defparameter *p02-need* 2253.8)

(defparameter *p02* 2121.0)

(defparameter *p3* (- 2000.0 1100.))

(defparameter *p3-new* (/ (* *p02-need* *p3*) *p02*))  ; => 956.35077
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

graph graphname {
rankdir=LR;
D1L -- D1R
D1L -- D1R
D2L -- D2R
D2L -- D2R
D7 -- D7
D8 -- D8
D9 -- D9
DA -- DA
D1L -- D2R
D1R -- D2L
D1L -- D2L
D1R -- D2R
D1L -- D2L
D1R -- D2R
D1L -- D2L
D1R -- D2R
D1L -- D2L
D1R -- D2R
D1L -- D2L
D1R -- D2R
D1L -- D2L
D1R -- D2R
D1L -- D2L
D1R -- D2R
D1L -- D2L
D1R -- D2R
D1L -- D2L
D1R -- D2R
D1L -- D2L
D1R -- D2R
D1L -- D2L
D1R -- D2R
D1L -- D2L
D1R -- D2R
D1L -- D2L
D1R -- D2R
D1L -- D2L
D1R -- D2R
D1L -- D2L
D1R -- D2R
D1L -- D2L
D1R -- D2R
D1L -- D2L
D1R -- D2R
D1L -- D2L
D1R -- D2R
D1L -- D3L
D1R -- D3R
D1L -- D4L
D1R -- D4R
D1L -- D5L
D1R -- D5R
D1L -- D5L
D1R -- D5R
D1L -- D6L
D1R -- D6R
D1L,D1R -- DA
D1L,D1R -- DB
D2L -- D4L
D2R -- D4R
D2L -- D5L
D2R -- D5R
D2L -- D6L
D2R -- D6R
D2L,D2R -- D7
D3L -- D5L
D3R -- D5R
D7 -- D8
D9 -- DA
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

