;;;; ./src/dia/dia.lisp

(defpackage #:mnas-ansys/tin/dia
  (:use #:cl #:mnas-ansys/tin)
  (:export open-dia
           choose-directory)
  (:export *tin*
           *initial-directory*)
  (:documentation
   "Пакет @b(mnas-ansys/tin/dia) выполнения команд в диалоговом режиме."))

(in-package :mnas-ansys/tin/dia)

(defparameter *tin* nil)

(defparameter *initial-directory* *default-pathname-defaults*)

(defun open-dia ()
  "@b(Описание:) функция @b(open-dia) возвращает открытый tin-файл.


 @b(Пример использования:)
@begin[lang=lisp](code)
 (open-dia)
@end(code)
"
  (setf *tin*
        (open-tin-file
         (mnas-file-dialog:get-open-file
          :filetypes
          '(("tin Files" "*.tin")
            ("All Files" "*"))
          :initialdir *initial-directory*))))

(defun choose-directory ()
  "@b(Описание:) функция @b(choose-directory) запускате на выполнение
 диалог, при помощи которого можно выбрать стартовый каталог для
 диалога открытия файлов.

 @b(Пример использования:)
@begin[lang=lisp](code)
 (choose-directory)
@end(code)
"
  (setf *initial-directory*
        (mnas-file-dialog:choose-directory)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;; (mnas-ansys/tin:families (mnas-ansys/tin:<tin>-curves *trd*)) 
