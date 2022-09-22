(defpackage #:mnas-ansys/docs
  (:use #:cl ) 
  (:nicknames "M-ANSYS/DOCS")
  (:export make-all)
  (:documentation "Пакет @b(mnas-ansys/docs) содержит функции
  генерирования и публикации документации.
"))

(in-package :mnas-ansys/docs)

(defun make-document ()
  (loop
    :for j :from 1
    :for i :in
    '((:mnas-ansys           :mnas-ansys)
      (:mnas-ansys/read      :mnas-ansys/read)
      (:mnas-ansys/select    :mnas-ansys/select)
      (:mnas-ansys/utils     :mnas-ansys/utils)
      (:mnas-ansys/ccl       :mnas-ansys/ccl)
      (:mnas-ansys/ccl-parse :mnas-ansys/ccl-parse)
      (:mnas-ansys/belt      :mnas-ansys/belt)
      
      )
    :do (progn
          (apply #'mnas-package:document i)
          (format t "~A ~A~%" j i))))

(defun make-graphs ()
  (loop
    :for j :from 1    
    :for i :in
    '(:mnas-ansys
      :mnas-ansys/read
      :mnas-ansys/select
      :mnas-ansys/utils
      
      :mnas-ansys/ccl
      :mnas-ansys/ccl-parse
      :mnas-ansys/belt
      )
    :do (progn
          (mnas-package:make-codex-graphs i i)
          (format t "~A ~A~%" j i))))

(defun make-all (&aux
                   (of (if (find (uiop:hostname)
                                 mnas-package:*intranet-hosts*
                                 :test #'string= :key #'first)
                           '(:type :multi-html :template :gamma)
                           '(:type :multi-html :template :minima))))
  (let* ((sys-symbol :mnas-ansys)
         (sys-string (string-downcase (format nil "~a" sys-symbol))))
    (mnas-package:make-html-path sys-symbol)
    (make-document)
    (mnas-package:make-mainfest-lisp `(,sys-symbol)
                                     (string-capitalize sys-string)
                                     '("Mykola Matvyeyev")
                                     (mnas-package:find-sources sys-symbol)
                                     :output-format of)
    (codex:document sys-symbol)
    (make-graphs)
    (mnas-package:copy-doc->public-html sys-string)
    (mnas-package:rsync-doc sys-string) 
    :make-all-finish))

;;;; (make-all)
