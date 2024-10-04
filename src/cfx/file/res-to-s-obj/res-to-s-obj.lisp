;;;; ./src/cfx/file/res-to-s-obj/res-to-s-obj.lisp

(defpackage :mnas-ansys/cfx/file/res-to-s-obj
  (:use #:cl)
  (:export prompt-read-line
           load-res)
  (:export *res*)
  )

(in-package :mnas-ansys/cfx/file/res-to-s-obj)

(defparameter *res* nil)

(defun prompt-read-line ()
  (format t "Введите имя каталога:")
  (force-output t)
  (let ((str   (read-line)))
    (format t "~S" str)
    (load-res str)))

(defun load-res (f-res)
  "@b(Описание:) функция @b(load-res) открывает представление
res-файла системы ANSYS (s-obj-файл) с именем f-res,
присваивая переменной *res* его значение. 

 @b(Переменые:)
@begin(list)
 @item(f-res - глобальная )
@end(list)

 @b(Пример использования:)
@begin[lang=lisp](code)
 (load-res *f-res-22*)
@end(code)
"
  (cond
    ((and *res*
          (eq (type-of *res*) 'MNAS-ANSYS/CFX/FILE:<RES>)
          (string= (mnas-ansys/cfx/file:<res>-pathname *res*) f-res))
     *res*)
    ((and *res*
          (eq (type-of *res*) 'MNAS-ANSYS/CFX/FILE:<RES>)
          (string/= (mnas-ansys/cfx/file:<res>-pathname *res*) f-res))
     (let ((res (mnas-ansys/cfx/file:open-cfx-file f-res)))
       (if (and res
                (eq (type-of res) 'MNAS-ANSYS/CFX/FILE:<RES>)
                (string/= (mnas-ansys/cfx/file:<res>-pathname res) f-res))
           (setf *res* (mnas-ansys/cfx/file:open-cfx-file f-res :force-load t))
           (setf *res* res))))
    (t
     (setf *res* (mnas-ansys/cfx/file:open-cfx-file f-res)))))
