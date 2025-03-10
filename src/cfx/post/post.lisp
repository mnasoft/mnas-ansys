;;;; ./src/cfx/post/post.lisp

(defpackage :mnas-ansys/cfx/post
  (:use #:cl)
  (:nicknames "CFX-POST")
  (:export command-file
           domains-to-load
           load-filename
           load-options
           load-res
           close-res
           save-report
           setup-units
           )
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

(defun load-options (&key
                       (clear-all-objects "false")
                       (append-results    "false")
                       (edit-case-names  "false")
                       (open-to-compare "false")
                       (multi-configuration-file-load-option "Last Case")
                       (open-in-new-view "true")
                       (keep-camera-position "true")
                       (load-particle-tracks "true")
                       (files-to-compare ""))
  (format t "DATA READER:~%")
  (format t "  Clear All Objects = ~A~%" clear-all-objects)
  (format t "  Append Results = ~A~%" append-results)
  (format t "  Edit Case Names = ~A~%" edit-case-names)
  (format t "  Open to Compare = ~A~%" open-to-compare)
  (format t "  Multi Configuration File Load Option = ~A~%" multi-configuration-file-load-option)
  (format t "  Open in New View = ~A~%" open-in-new-view)
  (format t "  Keep Camera Position = ~A~%" keep-camera-position)
  (format t "  Load Particle Tracks = ~A~%" load-particle-tracks)
  (format t "  Files to Compare = ~A~%" files-to-compare)
  (format t "END~%"))

(defun load-filename (filename)
  (format t "> load filename=~A, force_reload=true~2%" (namestring filename)))

(defun close-res ()
  (format t "> close~%"))

(defun load-res (res-fname &key (domains "D1 M1 M2"))
  (command-file)
  (domains-to-load (mnas-string:split " " domains))
  (load-options)
  (load-filename res-fname))

(defun readstate-filename (filename)
  (format t   "> readstate filename=~A, mode = overwrite, load = false, keepexpressions = false~2%"
          (namestring filename)))

(defun save-report (htm-fname &key (hideItems
                                    '("/COMMENT:User Data"
                                      "/REPORT/PHYSICS SUMMARY OPTIONS"
                                      "/REPORT/MESH STATISTICS OPTIONS"
                                      "/REPORT/FILE INFORMATION OPTIONS"
                                      "/TITLE PAGE")))
  (loop :for i :in hideItems
        :do   (format t "> report hideItem=~A~%" i))
  (format t "~%")
  (format t "REPORT:~%")
  (format t "  PUBLISH:~%")
  (format t "    Generate CVF = Off~%")
  (format t "    Report Format = HTML~%")
  (format t "    Report Path = ~A~%" (namestring htm-fname)) 
  (format t "    Save Images In Separate Folder = On~%")
  (format t "  END~%")
  (format t "END~2%")
  (format t ">report save~2%"))

(defun setup-units ()
  "Настройка единиц измерения:
Температура - Цельсии;
Длина - милиметры."
  (command-file)
  (format t ">setPreferences Preferred Units System = Custom")
  (format t ">setPreferences Custom Units Setting = Temperature&C")
  (format t ">setPreferences Custom Units Setting = Length&mm"))

(defun mk-report (res-filename domains
                  &key
                    (report-fname "Report")
                    state-filename
                    before-cmds
                    objects
                    (after-cmds '(">report save"
                                  ">close"
                                  )))
  "
@b(Описание:) функция @b(mk-report-new) выводит на стандартный вывод
сценарий, предназначенный для генерирования отчета.

 @b(Переменые:)
@begin(list)
 @item(res-filename - имя res-файла;)
 @item(domains - список имен доменов;)
 @item(report-fname - имя htm-файла;)
 @item(state-filename - имя cst-файла;)
 @item(before-cmds - команды, выполняемые вначале;)
 @item(objects - объекты, вставляемые в отчет;)
 @item(after-cmds -команды, выполняемые вконце;)
@end(list)

 @b(Пример использования:)
@begin[lang=lisp](code)
 (mnas-ansys/cfx/post:mk-report-new \"Z:/CFX/n70/cfx/DP=003/N70_prj_34/N70_prj_34_003.res\" '(\"D1\" \"M1\")
               :report-fname \"Report_D\")
@end(code)
"
  (let* ((device    (pathname-device res-filename))
         (directory (pathname-directory res-filename))
         (name      (pathname-name res-filename))
         (htm-path  (make-pathname :device  device
                                   :directory (append directory `("Reports" ,name))))
         (htm       (make-pathname :device  device
                                   :directory (append directory `("Reports" ,name))
                                   :name report-fname
                                   :type "htm"))
         (report (make-instance 'mnas-ansys/ccl/core:<report>)))
    (command-file)
    (domains-to-load domains)
    (load-filename res-filename)
    (when state-filename
      (readstate-filename state-filename))
    (when before-cmds
      (format t "~{~A ~^~%~}~2%" before-cmds))
    (ensure-directories-exist htm-path) ; Удоставеряемся, что каталог существует
    (setf (mnas-ansys/ccl/core:<publish>-report-path ;; устанавливаем соответствующее имя для отчета
           (mnas-ansys/ccl/core:<report>-publish report))
          htm)
    (format t "~A~%" report)
    (when objects (format t "~{~A~}~2%" objects))
    (when after-cmds
      (format t "~{~A ~^~%~}~2%" after-cmds))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Код для модификации

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
