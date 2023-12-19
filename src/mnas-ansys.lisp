(defpackage :mnas-ansys
  (:use #:cl)
  (:documentation
   " Пакет предназначен для коммуницирования с различными подсистемами ANSYS:
@begin(list)
 @item(mnas-ansys/tin - манипулирования с данными в tin - файле;)
 @item(mnas-ansys/iс - построения команд подсистемы ANSYS ICEM CFD;)
 @item(mnas-ansys/ccl - построения команд на языке CCL подсистем ANSYS PRE, ANSYS POST;)
@end(list)"))

(in-package :mnas-ansys)

;;;; # encoding: utf-8
;;;; # 2022 R1
;;;; SetScriptVersion(Version="22.1.217")
;;;; system1 = GetSystem(Name="ICM")
;;;; system1.Copy(KeepConnections=True)
;;;; system2 = GetSystem(Name="ICM 1")
;;;; system2.Move(
;;;;     Position="Right",
;;;;     RelativeTo=system1)
;;;; system2.DisplayText = "N70_prj_06-G1"

;;;; system-postfix

(defun wb-icm-del (system-name)
  (format t "
system = GetSystem(Name=~S)
system.Delete()"
          system-name))

(loop :for i :from 1 :to 10 :do
  (wb-icm-del (format nil "ICM ~A" i))
  (format t "~2%"))

(defun wb-icm-dup (ref-system-name s1 system-prefix index)
  (let ((s0 0))
    (format t
            "
SetScriptVersion(Version=\"22.1.217\")
system~a = GetSystem(Name=~S)
system~a.Copy(KeepConnections=True)
system~a = GetSystem(Name=\"ICM ~a\")
system~a.DisplayText = \"~a~a\"
" s0 ref-system-name s0 s1 s1 s1 system-prefix index)))

(progn
  (loop :for i :from 1 :to 7
        :for index :from 1
        :do
    (wb-icm-dup "ICM" i "N70_prj_06-G" index))
  (loop :for i :from 8 :to 10
        :for index :from 1
        :do
           (wb-icm-dup "ICM" i "N70_prj_06-Μ" index))
  (format t "~2%"))

;;;; source d:/home/_namatv/PRG/msys64/home/namatv/devel/tcl/PkgLoader/PkgLoader.tcl; source d:/home/_namatv/PRG/msys64/home/namatv/devel/tcl/IcemStartup/IcemStartup.tcl

(* 2.8 (/ (* 0.8 18.0 18.0 pi 0.25) 3720.0))  ; => 0.15322865274321862d0 (15.322865274321861d0%)
(- 2.8 (* 2.8 (/ (* 0.8 18.0 18.0 pi 0.25) 3720.0)))  ; => 2.6467712995730657d0
1460.0
450.0
;;; /display/path-lines/write-to-files/particle-id in-2 () 0 no geometry "p-l-003"
;(number->string 10)

;(string-append (number->string 10) "COOOOL")

;/display/path-lines/write-to-files/particle-id in-2 () 0 no geometry (string-append "p-l-" (number->string (set! foo (+ 1 foo))))

;(define ifExample
;    (lambda (x) (if (>= x 0) (+ x 1) (- x 1))))

;(display/path-lines/write-to-files/particle-id in-2 () 0 no geometry (new-f-name))

;(define foo 1000)
;(define fname  1000)
;(define new-f-name
;    (lambda ()
;      (set! foo (+ 1 foo))
;      (string-append "p-l-" (number->string foo))
;      ))

;(define fname (new-f-name))
