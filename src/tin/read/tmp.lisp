(in-package :mnas-ansys/tin/read)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defparameter *v*
  (line-by-line
   (probe-file "~/quicklisp/local-projects/ANSYS/mnas-ansys/data/ccl/base01-frc-ed-G1-12/library.ccl")))

(defun foo (lst)
  "Определить функцию прохода через vector строк и возвращающую вектор с
объединенными строками если они заканчиваются на \."
  
  )

(loop :for i :in *v*
      :do
      )

(let* ((string (nth 2 *v*))
       (char (char string (1- (length string)))))
  ()
  
  (subseq string 1 1))


(last (nth 2 *v*))
