;;;; ./src/mesh/mesh-log.lisp

(in-package :mnas-ansys/mesh-log)

(defmethod print-object ((obj <mesh-log>) stream)
  "Вывод объекта <mesh-log> в поток"
  (print-unreadable-object (obj stream :type t)
    (format stream "~A: nodes=~D tetra=~D prism=~D hex=~D"
            (<mesh-log>-name obj)
            (<mesh-log>-nodes obj)
            (<mesh-log>-tetra obj)
            (<mesh-log>-prism obj)
            (<mesh-log>-hex obj))))

(defmethod print-object ((obj <mesh-log-collection>) stream)
  "Вывод объекта <mesh-log-collection> в поток"
  (print-unreadable-object (obj stream :type t)
    (format stream "pattern=~S count=~D"
            (<mesh-log-collection>-pattern obj)
            (hash-table-count (<mesh-log-collection>-logs obj)))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defmethod load-logs ((collection <mesh-log-collection>))
  "Загрузить лог-файлы в коллекцию согласно шаблону
   Аргументы:
   - collection: объект <mesh-log-collection>
   Возвращает количество загруженных файлов"
  (let ((logs-list (parse-log-files (<mesh-log-collection>-pattern collection)))
        (hash (<mesh-log-collection>-logs collection)))
    (clrhash hash)
    (dolist (log logs-list)
      (setf (gethash (<mesh-log>-name log) hash) log))
    collection))

(defmethod get-log ((name string) (collection <mesh-log-collection>))
  "Получить объект <mesh-log> из коллекции по имени
   Аргументы:
   - collection: объект <mesh-log-collection>
   - name: имя файла (без расширения)
   Возвращает объект <mesh-log> или NIL"
  (gethash name (<mesh-log-collection>-logs collection)))

(defmethod log-names ((collection <mesh-log-collection>))
  (alexandria:hash-table-keys
   (<mesh-log-collection>-logs collection)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
