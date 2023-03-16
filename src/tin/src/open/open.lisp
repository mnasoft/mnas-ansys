;;;; ./src/tin/core/open.lisp

(in-package :mnas-ansys/tin)

(defun position-tin-in-objects (lines 
				  &key (objects *defines*) from-end (start 0) end
				    (key #'(lambda (el) (first (mnas-string:split " " el)))))
  "@b(Описание:) функция @b(position-tin-in-objects) возвращает номер строки
из списка строк @b(lines) для, которого было найдено совпадение первой
строки из списка типов объектов @b(objects)"
  (position-if #'(lambda (el) (find el objects :test #'string=))
               lines :start start :key key :from-end from-end :end end))

(defun key-tin-in-objects (lines n)
  (first (mnas-string:split " " (elt lines n))))


(defun open-tin-file (f-name)
  "@b(Описание:) функция @b(open-tin-file) возвращает объект типа
  @b(<tin>), представляющий содержимое tin-файла с сменем
  @b(f-name). 

 В настоящий момент производится частичное считыванние tin-файла.
"
  (when (probe-file f-name)
    (let* ((lines (read-file-as-lines f-name))
           (tin (make-instance '<tin>)))
      (setf (<tin>-file-name tin) (truename f-name))
      (read-object lines 0 tin))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun exclude-by-families (objects families)
  "@b(Описание:) метод @b(exclude-by-families) возвращает
  список объектов среди, которых нет объектов из семейств @b(families)."
  (reduce #'(lambda (lst surf)
              (if (find (<ent>-family surf) families :test #'string=)
                  lst
                  (cons surf lst)))
          objects
          :initial-value ()))
