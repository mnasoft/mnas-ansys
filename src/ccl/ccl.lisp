;;;; ./src/clim/clim.lisp

(defpackage #:mnas-icem/ccl
  (:use #:cl)
  (:export <mesh-connection>
           <mesh-connection>-option)
  )

(in-package #:mnas-icem/ccl)

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

(defun start-char (char string)
  "@b(Описание:) функция @b(start-chars) возвращает количество
  символов @b(char), с которых начинается строка @b(string).

 @b(Пример использования:)
@begin[lang=lisp](code)
 (start-char #\space \"    Boundary List1 = C T_1 G Side 1\") => 4
 (start-char #\space \"\") => 0
@end(code)
"
  (let ((rez 0))
    (loop :for i :from 0 :below (length string) :do
      (if (eq char (char string i))
          (incf rez)
          (return rez)))
    rez))

(defun string-depth (string)
  "@b(Описание:) функция @b(string-depth) возвращает глубину
 вложенности списка для формата ccl комплекса CFX.

 @b(Пример использования:) @begin[lang=lisp](code)
 (string-depth \"    Boundary List1 = C T_1 G Side 1\")
@end(code)
"
  (floor (start-char #\space string) 2))

(defun section-header-p (string)
  "@b(Описание:) функция @b(section-header-p) возврашает T, если строка
  @b(string) является заголовком секции.
"
  (when (find #\: string) t))

(defun key-value-p (string)
  "@b(Описание:) функция @b(key-value-p) возврашает T, если строка
  @b(string) является парой ключ-значение.

 @b(Пример использования:)
@begin[lang=lisp](code)
 (key-value-p \"    Boundary List1 = C T_1 G Side 1\") => T
@end(code)"
  (when (find #\= string) t))

(defun end-p (string)
  "@b(Описание:) функция @b(end-p) возвращает:
@begin(list)
 @item(- глубну вложенности, закрывающегося списка; )
 @item(- nil, если передаваемая строка не содержит признака закрытия
 списка.)
@end(list)"
  (let ((rez (search "END" string)))
    (when (numberp rez) (floor rez 2))))

(defun empty-p (string)
  "@b(Описание:) функция @b(empty-p) возвращает T, если строка
 является пустой."
  (string= "" string))

(defun separate (delimiter string)
  (let ((n (search delimiter string )))
    (list (subseq string 0 n)
          (subseq string (+ n (length delimiter))))))

(defun read-key-value (string)
  "
 @b(Пример использования:)
@begin[lang=lisp](code)
 (read-key-value \"    Filter Domain List1 = D1L\")
@end(code)
"
  (let ((rez (separate " = " string)))
    (setf (first rez) (string-left-trim " " (first rez)))
    (nreverse rez)))

(defun read-section-header (string)
  "
 @b(Пример использования:)
@begin[lang=lisp](code)
 (read-section-header \"        MOMENTUM INTERFACE MODEL: \")
@end(code)
"
  (let ((rez (separate ": " string)))
    (setf (first rez) (string-left-trim " " (first rez)))
    (nreverse rez)))

(defun deep-reverse (l)
  "@b(Описание:) функция @b(deep-reverse) выполняет рекурсивное
 реверсирование списка @b(l).

 @b(Пример использования:)
@begin[lang=lisp](code)
 (deep-reverse '(1 (2 3 (4 5 6) 7) 8 9))
 => (9 8 (7 (6 5 4) 3 2) 1)
@end(code)
"
  (cond ((null l) nil)
        ((listp (car l))
         (append (my-reverse (cdr l))
                 (list (my-reverse (car l)))))
        (t (append (my-reverse (cdr l))
                   (list (car l))))))

(defun nthcar (n lst)
  "@b(Описание:) функция @b(nthcar) возвращает результат применения к
  списку @b(lst)  функции @b(car) @b(n) раз."
  (let ((rez lst))
        (dotimes (i n rez)
          (setf rez (car rez)))))

(defun nth-cons-subst (n new-list list)
  "@b(Описание:) функция @b(nth-cons-subst) 

 @b(Пример использования:)
@begin[lang=lisp](code)
 (nth-cons-subst 0 '(1 2) '(((((1) 2) 3) 4) 5)) => ((1 2) ((((1) 2) 3) 4) 5)
 (nth-cons-subst 1 '(1 2) '(((((1) 2) 3) 4) 5)) => (((1 2) (((1) 2) 3) 4) 5)
 (nth-cons-subst 3 '(1 2) '(((((1) 2) 3) 4) 5)) => (((((1 2) (1) 2) 3) 4) 5)
@end(code)"
  (setf list
        (subst
         (cons new-list (nthcar n list))
         (nthcar n list)
         list)))

(defun ccl-line (v-string i)
  (let ((string (svref v-string i)))
    (let ((empty-p          (empty-p string))
          (key-value-p      (key-value-p string))
          (section-header-p (section-header-p string))
          (end-p            (end-p string))
          (string-depth     (string-depth string)))
      (cond
        (section-header-p
         (list (read-section-header string)
               (list string-depth section-header-p key-value-p empty-p end-p)))
        #+nil
        (progn (push  rez)
               (ccl-line (first rez) v-string (1+ i) end level))
        (key-value-p
         (list (read-key-value string)
               (list string-depth section-header-p key-value-p empty-p end-p)))))))

(defun parse-ccl (v-string)
    (let ((rez nil)
          (a   nil))
      (loop :for i :from 0 :below (length v-string) :do
        (progn
          (setf a (ccl-line v-string i))
          (cond
            ((null a))
            ((numberp (first (second a)))
             (setf rez (nth-cons-subst (first (second a))
                                       (first a)
                                       rez))))))
      (deep-reverse rez)))

(parse-ccl *lines*)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defparameter *lines*
  (mnas-icem/read:read-file-as-lines
   "~/quicklisp/local-projects/ANSYS/mnas-icem/data/ccl/interfaces.ccl"))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defparameter *p02-need* 2253.8)
(defparameter *p02* 2121.0)

(defparameter *p3* (- 2000.0 1100.))

(defparameter *p3-new* (/ (* *p02-need* *p3*) *p02*))  ; => 956.35077
 
