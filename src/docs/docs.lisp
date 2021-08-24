(defpackage #:mnas-ansys/docs
  (:use #:cl ) 
  (:nicknames "MICEM/DOCS")
  (:export make-all)
  (:documentation "Пакет @b(mnas-ansys/docs) содержит функции
  генерирования и публикации документации.
"))

(in-package :mnas-ansys/docs)

(defun make-document ()
  (loop
    :for i :in
    '((:mnas-ansys           :mnas-ansys)
      (:mnas-ansys/read      :mnas-ansys/read)
      (:mnas-ansys/select    :mnas-ansys/select)
      (:mnas-ansys/utils     :mnas-ansys/utils)
      (:mnas-ansys/ccl       :mnas-ansys/ccl)
      (:mnas-ansys/ccl-parse :mnas-ansys/ccl-parse)
      (:mnas-ansys/belt      :mnas-ansys/belt)
      
      )
    :do (apply #'mnas-package:document i)))

(defun make-graphs ()
  (loop
    :for i :in
    '(:mnas-ansys
      :mnas-ansys/read
      :mnas-ansys/select
      :mnas-ansys/utils
      
      :mnas-ansys/ccl
      :mnas-ansys/ccl-parse
      :mnas-ansys/belt
      )
    :do (mnas-package:make-codex-graphs i i)))

(defun make-all (&aux
                   (of (if (find (uiop:hostname)
                                 mnas-package:*intranet-hosts*
                                 :test #'string=)
                           '(:type :multi-html :template :gamma)
                           '(:type :multi-html :template :minima))))
  "@b(Описание:) функция @b(make-all) служит для создания документации.

 Пакет документации формируется в каталоге
~/public_html/Common-Lisp-Programs/mnas-string.
"
  (mnas-package:make-html-path :mnas-ansys)
  (make-document)
  (make-graphs)
  (mnas-package:make-mainfest-lisp
   '(:mnas-ansys :mnas-ansys/docs)
   "Mnas-Ansys"
   '("Nick Matvyeyev")
   (mnas-package:find-sources "mnas-ansys")
   :output-format of)
  (codex:document :mnas-ansys)
  (make-graphs)
  (mnas-package:copy-doc->public-html "mnas-ansys")
  (mnas-package:rsync-doc "mnas-ansys"))

;;;; (make-all)
