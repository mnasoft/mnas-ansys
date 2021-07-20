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
    '((:mnas-icem :mnas-icem)
      (:mnas-icem/read :mnas-icem/read)
      (:mnas-icem/select :mnas-icem/select)
      (:mnas-icem/utils :mnas-icem/utils)
      )
    :do (apply #'mnas-package:document i)))

(defun make-graphs ()
  (loop
    :for i :in
    '(:mnas-icem
      :mnas-icem/read
      :mnas-icem/select
      :mnas-icem/utils
      )
    :do (mnas-package:make-codex-graphs i i)))

(defun make-all ()
  (inferior-shell:run `("mkdir" "-p" ,(mnas-package::codex-html-pathname :mnas-icem)))
  (make-document)
  (make-graphs)
  (codex:document :mnas-icem)
  (make-graphs))

;;;; (make-all)



;;;; => "D:/home/_namatv/PRG/msys64/home/namatv/quicklisp/local-projects/ANSYS/mnas-icem/docs/build/mnas-icem/html"


