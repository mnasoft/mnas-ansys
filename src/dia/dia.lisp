;;;; ./src/dia/dia.lisp

(defpackage #:mnas-ansys/dia
  (:use #:cl)
  (:export open-dia
           choose-directory)
  (:export *tin*
           *initial-directory*)
  (:documentation
   "Пакет @b(mnas-ansys/dia) выполнения команд в диалоговом режиме."))

(in-package :mnas-ansys/dia)

(defparameter *tin* nil)

(defparameter *initial-directory* *default-pathname-defaults*)

(defun open-dia ()
  (setf *tin*
        (mnas-ansys:open-tin-file
         (mnas-file-dialog:get-open-file
          :filetypes
          '(("tin Files" "*.tin")
            ("All Files" "*"))
          :initialdir *initial-directory*))))

(defun choose-directory ()
  "@b(Описание:) функция @b(choose-directory) запускате на выполнение
 диалог, при помощи которого можно выбрать стартовый каталог для
 диалога открытия файлов.
"
  (setf *initial-directory*
        (mnas-file-dialog:choose-directory)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;; (mnas-ansys:families (mnas-ansys:<tin>-curves *trd*)) 
