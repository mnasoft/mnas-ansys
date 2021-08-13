(defpackage #:mnas-icem/docs
  (:use #:cl ) 
  (:nicknames "MICEM/DOCS")
  (:export make-all)
  (:documentation "Пакет @b(mnas-icem/docs) содержит функции
  генерирования и публикации документации.
"))

(in-package :mnas-icem/docs)

(defun make-document ()
  (loop
    :for i :in
    '((:mnas-icem           :mnas-icem)
      (:mnas-icem/read      :mnas-icem/read)
      (:mnas-icem/select    :mnas-icem/select)
      (:mnas-icem/utils     :mnas-icem/utils)
      (:mnas-icem/ccl       :mnas-icem/ccl)
      (:mnas-icem/ccl-parse :mnas-icem/ccl-parse)
      (:mnas-icem/belt      :mnas-icem/belt)
      
      )
    :do (apply #'mnas-package:document i)))

(defun make-graphs ()
  (loop
    :for i :in
    '(:mnas-icem
      :mnas-icem/read
      :mnas-icem/select
      :mnas-icem/utils
      
      :mnas-icem/ccl
      :mnas-icem/ccl-parse
      :mnas-icem/belt
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
;;  (inferior-shell:run `("mkdir" "-p" ,(mnas-package::codex-html-pathname :mnas-icem)))
  (make-document)
  (make-graphs)
  (mnas-package:make-mainfest-lisp
   '(:mnas-icem :mnas-icem/docs)
   "Mnas-Icem"
   '("Nick Matvyeyev")
   (mnas-package:find-sources "mnas-icem")
   :output-format of)
  (codex:document :mnas-icem)
  (make-graphs)
  (mnas-package:copy-doc->public-html "mnas-icem")
  (mnas-package:rsync-doc "mnas-icem"))

;;;; (make-all)

;;;; => "D:/home/_namatv/PRG/msys64/home/namatv/quicklisp/local-projects/ANSYS/mnas-icem/docs/build/mnas-icem/html"


