;;;; ./src/ccl/parse/ccl-parse.lisp

(defpackage :mnas-ansys/ccl/parse
  (:use #:cl)

  (:intern header-p
           key-value-p
           end-p
           empty-p
           )
  (:export parse
           parse-file)
  (:export convert-to-ccl)
  (:documentation
   "@b(Описание:) пакет @b(mnas-ansys/ccl/parse) предназначен для
 парсинга (разбора) данных и файлов в формате ccl."))

(in-package :mnas-ansys/ccl/parse)

(defun header-p (string)
  "@b(Описание:) функция @b(header-p) возврашает T, если строка
  @b(string) является заголовком секции.
"
  (when #+nil (find #\: string)
        (search ":" string)
        t))

(defun key-value-p (string)
  "@b(Описание:) функция @b(key-value-p) возврашает T, если строка
  @b(string) является парой ключ-значение.

 @b(Пример использования:)
@begin[lang=lisp](code)
 (key-value-p \"    Boundary List1 = C T_1 G Side 1\") => T
@end(code)"
  (when #+nil (find #\= string)
        (search " = " string) t))

(defun end-p (string)
  "@b(Описание:) функция @b(end-p) возвращает:
@begin(list)
 @item(- глубну вложенности, закрывающегося списка; )
 @item(- nil, если передаваемая строка не содержит признака закрытия
 списка.)
@end(list)"
  #+nil(string= "END" string)
  (let ((rez (search "END" string)))
    (when (numberp rez) (floor rez 2))))

(defun remove-space (lines)
  (loop :for i :in lines
        :collect
        (ppcre:regex-replace-all "\\s+" i " ")))

(defun remove-back-slesh (lines)
  (let ((os (make-string-output-stream))
        (str ""))
    (loop :for i :in lines
          :do
             (if (eq (uiop:last-char i) #\\)
                 (setf str (concatenate 'string str (subseq i 0 (1- (length i)))))
                 (progn
                   (format os "~A~%" (concatenate 'string str i))
                           (setf str ""))))
    (get-output-stream-string os)))

(defun parse (lines)
  (labels ((out (lst os)
             (cond ((= (length lst) 1) (format os "(~{~S~} \"\"" lst))
                   ((= (length lst) 2) (format os "(~{~S~^ ~}" lst)))))
    (let ((os (make-string-output-stream))
          (is (make-string-input-stream 
               (ppcre:regex-replace-all
                "[ ]+"
                (remove-back-slesh lines)
                " "))))
      (format os "(~%")
      (loop :for line = (read-line is nil)
            :while line
            :do
               (let ((s-tr (string-trim " " line)))
                 (cond
                   ((key-value-p line)
                    (out (ppcre:split " *= *" s-tr ) os)
                    (format os ")~%"))
                   ((header-p line)
                    (out (ppcre:split ": *" s-tr ) os))
                   ((end-p line)
                    (format os ")~%")))))
      (format os ")~%")
      (read-from-string (get-output-stream-string os)))))

(defun parse-file (file-name)
  (parse (uiop:read-file-lines file-name)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun process-list (nested-list &key (stream t) (indent-level 0) )
  (dolist (item nested-list)
    (cond
      ;; Если это key-value пара
      ((and (listp item) (= (length item) 2) 
            (every #'stringp item))
       (format stream "~Vt~A = ~A~%" (* 2 indent-level) (first item) (second item)))
      ;; Если это headed список
      ((and (listp item) (>= (length item) 3) (stringp (first item)) (stringp (second item)))
       (format stream "~Vt~A:~A~%" (* 2 indent-level) (first item) (second item)) ;; Двоеточие после заголовка
       (process-list (cddr item) :stream stream :indent-level (1+ indent-level))
       (format stream "~VtEND~%" (* 2 indent-level)))
      ;; Если это строка
      ((stringp item)
       (format stream "~Vt~A~%" (* 2 indent-level) item)))))

(defun convert-to-ccl (nested-list &key (stream t))
  "@b(Описание:) функция @b(convert-to-ccl)
"
  (process-list nested-list :stream stream))





