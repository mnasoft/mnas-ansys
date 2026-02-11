;;;; ./src/mesh/mesh-log.lisp

(in-package :mnas-ansys/mesh-log)

;;;; Функции для парсинга лог-файлов

(defun extract-number (line prefix)
  "Извлечь число из строки после заданного префикса"
  (let ((pos (search prefix line)))
    (when pos
      (let* ((start (+ pos (length prefix)))
             (num-str (string-trim '(#\Space #\Tab) (subseq line start))))
        (parse-integer num-str :junk-allowed t)))))

(defun extract-scaling-factor (line)
  "Извлечь масштабный коэффициент из строки вида 'Scaling factor : (1.0,1.0,1.0)'"
  (let ((start (search "(" line))
        (end (search ")" line)))
    (when (and start end)
      (let* ((coords-str (subseq line (1+ start) end))
             (coords (mapcar (lambda (s) 
                              (read-from-string (string-trim '(#\Space #\Tab) s)))
                           (mnas-string:split "," coords-str))))
        (when (= 3 (length coords))
          coords)))))

(defun parse-log-file (pathname)
  "Разобрать лог-файл ICEM CFD и вернуть объект <mesh-log>
   Аргументы:
   - pathname: путь к лог-файлу
   Возвращает объект <mesh-log> или NIL в случае ошибки"
  (when (probe-file pathname)
    (let ((log-obj (make-instance '<mesh-log>))
          (name (pathname-name pathname)))
      ;; Убираем расширение .msh из имени, если оно есть
      (when (and (> (length name) 4)
                 (string= ".msh" (subseq name (- (length name) 4))))
        (setf name (subseq name 0 (- (length name) 4))))
      (setf (<mesh-log>-name log-obj) name)
      
      (with-open-file (stream pathname :direction :input)
        (loop for line = (read-line stream nil nil)
              while line
              do (cond
                   ;; Количество узлов
                   ((search "nr. of nodes in model:" line)
                    (let ((num (extract-number line "nr. of nodes in model:")))
                      (when num (setf (<mesh-log>-nodes log-obj) num))))
                   ;; Масштабный коэффициент
                   ((search "Scaling factor" line)
                    (let ((factor (extract-scaling-factor line)))
                      (when factor (setf (<mesh-log>-scaling-factor log-obj) factor))))
                   ;; Тетраэдральные элементы
                   ((search "nr. of tetra elements:" line)
                    (let ((num (extract-number line "nr. of tetra elements:")))
                      (when (and num (> num 0))
                        (setf (<mesh-log>-tetra log-obj) num))))
                   ;; Призматические элементы
                   ((search "nr. of prism elements:" line)
                    (let ((num (extract-number line "nr. of prism elements:")))
                      (when num (setf (<mesh-log>-prism log-obj) num))))
                   ;; Гексаэдральные элементы
                   ((search "nr. of hex   elements:" line)
                    (let ((num (extract-number line "nr. of hex   elements:")))
                      (when num (setf (<mesh-log>-hex log-obj) num))))
                   ;; Block refinements
                   ((search "This mesh has block refinements" line)
                    (setf (<mesh-log>-has-refinements log-obj) t)))))
      log-obj)))

(defun parse-log-files (pattern)
  "Разобрать все лог-файлы, соответствующие шаблону
   Аргументы:
   - pattern: шаблон пути (например \"path/to/*.msh.log\")
   Возвращает список объектов <mesh-log>"
  (let ((files (directory pattern)))
    (loop for file in files
          for log = (parse-log-file file)
          when log
          collect log)))
