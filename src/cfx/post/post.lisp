;;;; ./src/cfx/post/post.lisp

(defpackage :mnas-ansys/cfx/post
  (:use #:cl)
  (:nicknames "CFX-POST")
  (:export mk-report
           mk-reports)
  (:documentation
   "Пакет @(mnas-ansys/cfx/post) определяет функции, позволяющие
  создавать сценарии для генерирования отчетов CFX-POST."))

(in-package :mnas-ansys/cfx/post)

(defun command-file ()
  (format t "COMMAND FILE:~%")
  (format t "  CFX Post Version = 14.5~%")
  (format t "END~2%"))

(defun domains-to-load (domains)
  (format t "DATA READER:~%")
  (format t "  Domains to Load = ~{~A~^, ~}~%" domains)
  (format t "END~2%")
  )

(defun load-filename (filename)
  (format t "> load filename=~A, force_reload=true~2%" (namestring filename)))

(defun readstate-filename (filename)
  (format t   "> readstate filename=~A, mode = overwrite, load = false, keepexpressions = false~2%"
          (namestring filename)))

(defun mk-report (res-filename domains state-filename cmds)
  (command-file)
  (domains-to-load domains)
  (load-filename res-filename)
  (readstate-filename state-filename )
  (format t "~{~A ~^~%~}~2%" cmds)
  (format t "> report save, format=preview~2%")
  (let* ((device    (pathname-device res-filename))
         (directory (pathname-directory res-filename))
         (name      (pathname-name res-filename))
         (htm      (make-pathname :device  device
                                  :directory (append directory `("Reports" ,name))
                                  :name "Report"
                                  :type "htm"
                                  )))
    (ensure-directories-exist 
     (make-pathname :device  device
                    :directory (append directory `("Reports" ,name))))
    (format t "REPORT:~%")
    (format t "  PUBLISH:~%")
    (format t "    Generate CVF = Off~%")
    (format t "    Report Format = HTML~%")
    (format t "    Report Path = ~A~%" (namestring htm))
    (format t "    Save Images In Separate Folder = On~%")
    (format t "  END~%")
    (format t "END~2%"))

  (format t "> report save~2%")
  (format t "> close~2%"))

(defun mk-reports (dir domains state-filename cmds)
  "@b(Описание:) функция @b(mk-reports) выводит на стандартный вывод
сессию для CFX-POST, которая создает отчеты по заданному шаблону.

 @b(Переменые:)
@begin(list)
 @item(dir - шалон по которому отбираются res-файлы для создания отчета;)
 @item(domains - список загружаемых доменов;)
 @item(state-filename - полный путь к шаблону отчета;)
 @item(cmds - дополнительные команды вставляемые в отчет для, как
       правило, отражения правильной легенды;)
@end(list)
"
  (loop :for res-filename :in (directory dir)
        :do (mk-report (namestring res-filename) domains state-filename cmds)))
