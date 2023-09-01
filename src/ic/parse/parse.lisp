(ql:quickload :mnas-dict)
(ql:quickload :mnas-html-translation)

(defparameter *root*
  (mnas-html-translation:parse-path "c:/Users/namatv/Desktop/123.html"))

(defun find-ic-func-header (root)
      (loop :for i :in (mnas-html-translation:find-nodes-by-tag root "strong")
          :when (let ((node-txt (plump:text i))
                      (parent-txt
                        (plump:text
                         (mnas-html-translation:find-parent i))))
                  (string= node-txt (subseq parent-txt 0 (length node-txt))))
            :collect (mnas-html-translation:find-parent i)))

(defun find-ic-func (root)
  (let ((p-all (mnas-html-translation:find-nodes-by-tag root "p"))
        (p-head (find-ic-func-header root))
        (rez nil)
        (cur nil))
    (loop :for i :in p-all :do
      (if (find i p-head)
          (progn
            (when cur (push (reverse cur) rez))
            (setf cur (list i)))
          (when cur (push i cur))))
    (when cur (push (reverse cur) rez))
    (reverse rez)))

(defun foo (txt)
  (string-trim
   " "
   (ppcre:regex-replace-all "[©\\t\\n\\r\\s ]+" txt " ")))



(defun args (p-head)
  (let* ((args (mnas-string:split " " p-head))
         (pos  (position-if 
                #'(lambda (el)
                    (eq (char el 0)  #\[))
                args)))
    (if pos
        (progn
          (list
           (first args)
           (subseq args 1 (1- pos))
           (subseq args (1- pos))))
        (progn (list (first args) (cdr args))))))

(defun defun-print (header)
  (cond
    ((= (length header) 2)
     (format t "(defun ~A (~{~A~^ ~})" (first header) (second header)))
    ((= (length header) 3)
     (format t "(defun ~A (~{~A~^ ~} &optional" (first header) (second header))
     (loop :for (arg def-val)
        :in
        (mapcar #'list
                (third header)
                (cdr (third header)))
      :do
         (format t " (~A ~A)" arg (string-trim "[]" def-val))
         (format t ")")))))


(defun-print 
    (args "ic_meshdirect_spotweld_file_import filename args "))

(defun-print
    (args "ic_meshdirect_spotweld_file_import filename args [\"\"]"))

(defun doc-print (p-all)
  (format t "\"" )
  (format t "~A~2%" (foo (plump:text (car p-all))))
  (mapcar
   #'(lambda (el_1)
       (format t "~A~%" (foo(plump:text el_1))))
   (cdr p-all))
  (format t "\"~2%" ))

(defun body-print (p-all)
  (format t "(format t )" )
  
  )

(mapcar
 #'(lambda (el)
     (format t "~S~%" (foo (plump:text (car el))))
     (mapcar
      #'(lambda (el_1)
          (format t "~S~%" (foo(plump:text el_1))))
      (cdr el)))
 (find-ic-func *root*))
