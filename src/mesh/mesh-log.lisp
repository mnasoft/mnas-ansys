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
