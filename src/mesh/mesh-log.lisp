;;;; ./src/mesh/mesh-log.lisp

(in-package :mnas-ansys/mesh-log)

(defun make-collection (pattern)
  "Создать коллекцию лог-файлов по шаблону
   Аргументы:
   - pattern: шаблон пути (например \"path/to/*.msh.log\")
   Возвращает объект <mesh-log-collection>"
  (let ((collection
          (make-instance '<mesh-log-collection> :pattern pattern)))
    (load-logs collection)
    collection))

(defun change-count (name count collection)
  (setf (<mesh-log>-count
         (get-log name collection))
        count))

(defun load-msh-log-by-location (prj-name)
  (let* ((coll (make-collection
                (concatenate 'string prj-name "_*.msh.log"))))
    (ignore-errors (load (concatenate 'string prj-name ".lisp")))
    (map nil #'(lambda (el)
                 (change-count (first el) (second el) coll))
         *change-count-data*)
    (format t "~S" coll)
    coll))


