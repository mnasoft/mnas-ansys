(defpackage :mnas-ansys/icem
  (:use #:cl)
  (:export uns-to-fluent
           uns-to-cfx5
           )
  (:documentation
   "Пакет @(mnas-ansys/exchande) определяет функции, позволяющие извлечь
    информацию из файлов, которые экспортирует Ansys"))

(in-package :mnas-ansys/icem)

(defparameter *fluent6* "c:/ANSYS/v145/icemcfd/win64_amd/icemcfd/output-interfaces/fluent6.exe"
  "
 Running FLUENT V6 Interface Vers. 14.5.12

Usage: C:\ANSYS\v145\icemcfd\win64_amd\icemcfd\output-interfaces\fluent6.exe -dom {.uns file} -b {.fbc file} 
     [-scale {x,y,z}] [-log] [-dim2d] [-bin] [-nocoupling]
     [-tgrid]  fluenfile 
"
  )
(defparameter *cfx5* "c:/ANSYS/v145/icemcfd/win64_amd/icemcfd/output-interfaces/cfx5.exe"
  "
 Running ICEMCFD - CFX5 Interface Vers. 14.5.2

Usage: C:\ANSYS\v145\icemcfd\win64_amd\icemcfd\output-interfaces\cfx5.exe -dom {.uns file} -b {.fbc file} 
     [-scale {x,y,z}] [-ascii] [-db] [-internal_faces]
     [-lcs {lcs_parameters}] cfx5file 
"
  )


(defun uns-to-fluent (name domains-directory &key (scale '(1 1 1)))
  "@b(Описание:) функция @b(uns-to-fluent) 

 @b(Пример использования:)
@begin[lang=lisp](code)
 (uns-to-fluent \"T71030091_prj_01\" \"Z:/ANSYS/FLUENT/t71/tin/DOMAINS\")
@end(code)
"
  (let ((uns-file-names
          (directory (concatenate 'string domains-directory "/*/" name "*.uns"))))
    (loop :for uns-file :in uns-file-names
          :collect
             (let* ((uns (namestring uns-file))
                    (fbc (ppcre:regex-replace "\.uns$" uns ".fbc"))
                    (msh-00 (ppcre:regex-replace "\.uns$" uns ".msh"))
                    (msh (ppcre:regex-replace "/tin/DOMAINS/.*/" msh-00 "/msh/")))
               (uiop:run-program 
                (format nil "~a -dom ~a -b ~a -scale ~{~A~^,~} ~a" *fluent6* uns fbc scale msh))
               msh))))

(defun uns-to-cfx5 (name domains-directory &key (scale '(1 1 1)))
  "@b(Описание:) функция @b(uns-to-fluent) 

 @b(Пример использования:)
@begin[lang=lisp](code)
 (uns-to-cfx5 \"T71030091_prj_01\" \"Z:/ANSYS/FLUENT/t71/tin/DOMAINS\")
@end(code)
"
  (let ((uns-file-names
          (directory (concatenate 'string domains-directory "/*/" name "*.uns"))))
    (loop :for uns-file :in uns-file-names
          :collect
             (let* ((uns (namestring uns-file))
                    (fbc (ppcre:regex-replace "\.uns$" uns ".fbc"))
                    (msh-00 (ppcre:regex-replace "\.uns$" uns ".msh"))
                    (msh (ppcre:regex-replace "/tin/DOMAINS/.*/" msh-00 "/msh/")))
               (uiop:run-program 
                (format nil "~a -dom ~a -b ~a -scale ~{~A~^,~} ~a" *cfx5* uns fbc scale msh))
               msh))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
