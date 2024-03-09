;;;; ./src/exchange/cfx-bin/cfx-bin.lisp

(defpackage :mnas-ansys/cfx/bin
  (:use #:cl)
  (:export environ
           ansys-versions
           ansys-version
           *ansys-version*
           executables
           setup
           help
           )
  (:export *cfdpost*
           *cfx5*
           *cfx5adapt*
           *cfx5cloud*
           *cfx5cmds*
           *cfx5control*
           *cfx5cvfconvert*
           *cfx5detach*
           *cfx5dfile*
           *cfx5doexternal*
           *cfx5export*
           *cfx5gtmconv*
           *cfx5help*
           *cfx5htmlconvert*
           *cfx5info*
           *cfx5interp*
           *cfx5launch*
           *cfx5licenseman*
           *cfx5mkext*
           *cfx5mondata*
           *cfx5parallel*
           *cfx5params*
           *cfx5parhosts*
           *cfx5perl*
           *cfx5post*
           *cfx5pre*
           *cfx5profile*
           *cfx5remote*
           *cfx5rsm*
           *cfx5solve*
           *cfx5stop*
           *cfx5submit*
           *cfx5viewer*
           *cfx_helpclient*
           *cfxdsdbreader*)
  (:documentation "@b(Описание:) пакет @b(:mnas-ansys/cfx/bin)
"))

(in-package :mnas-ansys/cfx/bin)

(defparameter *cfdpost*         nil)
(defparameter *cfx5*            nil)
(defparameter *cfx5adapt*       nil)
(defparameter *cfx5cloud*       nil)
(defparameter *cfx5cmds*        nil)
(defparameter *cfx5control*     nil)
(defparameter *cfx5cvfconvert*  nil)
(defparameter *cfx5detach*      nil)
(defparameter *cfx5dfile*       nil)
(defparameter *cfx5doexternal*  nil)
(defparameter *cfx5export*      nil)
(defparameter *cfx5gtmconv*     nil)
(defparameter *cfx5help*        nil)
(defparameter *cfx5htmlconvert* nil)
(defparameter *cfx5info*        nil)
(defparameter *cfx5interp*      nil)
(defparameter *cfx5launch*      nil)
(defparameter *cfx5licenseman*  nil)
(defparameter *cfx5mkext*       nil)
(defparameter *cfx5mondata*     nil)
(defparameter *cfx5parallel*    nil)
(defparameter *cfx5params*      nil)
(defparameter *cfx5parhosts*    nil)
(defparameter *cfx5perl*        nil)
(defparameter *cfx5post*        nil)
(defparameter *cfx5pre*         nil)
(defparameter *cfx5profile*     nil)
(defparameter *cfx5remote*      nil)
(defparameter *cfx5rsm*         nil)
(defparameter *cfx5solve*       nil)
(defparameter *cfx5stop*        nil)
(defparameter *cfx5submit*      nil)
(defparameter *cfx5viewer*      nil)
(defparameter *cfx_helpclient*  nil)
(defparameter *cfxdsdbreader*   nil)

#+nil (defparameter *cfx5mondata* "C:/ANSYS/v145/CFX/bin/cfx5mondata.exe")

(defun environ ()
  "@b(Описание:) функция @b(environ) возвращает переменные окружения в
виде 2d-list, каждым элементом которого является 1d-list состоящий из
имени переменной окружения и её
значения.

 @b(Пример использования:)
@begin[lang=lisp](code)
 (environ)
@end(code)
"
  (let ((rgx (ppcre:create-scanner "=")))
    (loop :for i :in (sb-ext:posix-environ)
          :collect
          (ppcre:split rgx i))))

(defun ansys-versions ()
  (sort 
   (loop :for (name val)
           :in (mnas-string:select "ANSYS[0-9]{3}_DIR" (environ) :key #'first)
         :collect (parse-integer (ppcre:scan-to-strings "[0-9]{3}" name)))
   #'< ))
#+nil (defun ansys-versions () '(145 221 231 232 241))

(defun ansys-version ()
  (let ((versions (ansys-versions)))
    (cond
      ((and (listp versions) (= 0 (length versions)))
       (error "Сan't find environment variables like: ~S." "ANSYS[0-9]{3}_DIR"))
      ((and (listp versions) (= 1 (length versions)))
       (first versions))
      ((and (listp versions) (< 1 (length versions)))
       (mnas-string/parse:read-integer-alt versions)))))

(defparameter *ansys-version* (ansys-version))

(defun executables ()
  "@b(Описание:) функция @b(executables) возвращает список
выполняемых файлов системы ANSYS CFX.

 @b(Пример использования:)
@begin[lang=lisp](code)
 (executables)
@end(code)"
  (loop :for pname
          :in (directory
               (concatenate
                'string
                (uiop:getenv (format nil "ANSYS~A_DIR" *ansys-version*))
                "\\..\\CFX\\bin\\" "*.exe"))
        :collect (namestring pname)))

(defun setup ()
  (loop :for i :in (executables)
        :do
           (let ((var-name (read-from-string 
                            (concatenate
                             'string
                             "*"
                             (ppcre:scan-to-strings "[^\\/]*(?=[.][a-z|A-Z|0-9]+$)" i )
                             "*"))))
             (set var-name      
                  i))))

(defun help (program)
  "@b(Описание:) функция @b(help) выводит на стандартный вывод
описание для соответствующей программы.

 @b(Пример использования:)
@begin[lang=lisp](code)
 (help *cfx5mondata*)
 (help *cfx5dfile*)
@end(code)

"
  (format
   t "~A"
   (ppcre:regex-replace-all
    "" (uiop:run-program (list program  "-help") :output :string) "")))

(defun run-program (program &rest args)
  "@b(Описание:) функция @b(help) выводит на стандартный вывод
описание для соответствующей программы.

 @b(Пример использования:)
@begin[lang=lisp](code)
 (help *cfx5mondata*)
 (help *cfx5dfile*)
@end(code)

"
  (ppcre:regex-replace-all
    "" (uiop:run-program (append (list program) args) :output :string) ""))

(setup)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

#+nil (mnas-string:select "ANSYS[0-9]{3}_DIR" (environ) :key #'first)
#+nil (mnas-string:select "ICEMCFD_ROOT[0-9]{3}" (environ) :key #'first)

