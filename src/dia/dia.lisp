;;;; ./src/dia/dia.lisp

(defpackage #:mnas-ansys/dia
  (:use #:cl)
  (:nicknames "DIA")
  (:export open-tin-file
           choose-directory)
  (:export *tin*
           *initial-directory*)
  (:export setup-family-parameters
           families)
  (:documentation
   "Пакет @b(mnas-ansys/tin/dia) выполнения команд в диалоговом режиме."))

(in-package :mnas-ansys/dia)

(defparameter *tin* nil)

(defparameter *initial-directory* *default-pathname-defaults*
  "@b(Описание:) переменная @b(*initial-directory*) определяет стартовый
каталог для поиска файлов.")

(defun open-tin-file ()
  "@b(Описание:) функция @b(open-tin-file) возвращает открытый tin-файл.

 @b(Пример использования:)
@begin[lang=lisp](code)
 (open-tin-file)
@end(code)
"
  (setf *tin*
        (mnas-ansys/tin:open-tin-file
         (mnas-file-dialog:get-open-file
          :filetypes
          '(("tin Files" "*.tin")
            ("All Files" "*"))
          :initialdir *initial-directory*))))

(defun choose-directory ()
  "@b(Описание:) функция @b(choose-directory) запускате на выполнение
 диалог, при помощи которого можно выбрать стартовый каталог для
 диалога открытия файлов.

 @b(Пример использования:)
@begin[lang=lisp](code)
 (choose-directory)
@end(code)
"
  (setf *initial-directory*
        (mnas-file-dialog:choose-directory)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun setup-family-parameters (&key (d-scale 1/4)
                                  (gref 1)
                                  (gmax 2))
  " @b(Описание:) функция @b(setup-family-parameters) печатает на
стандартный вывод скрипт, устанавливающий параметры на поверхностях
определенных семейств, содержащихся в tin- файле.

 Перед выполнением скрипта в диалоге выбора файла необходимо выбрать
соответсткующий tin-файл.

 @b(Переменые:)
@begin(list)
 @item(d-scale - коэффициент масштабирования максимального размера сетки.)
@end(list)

 @b(Пример использования:)
@begin[lang=lisp](code)
 (tin/dia:setup-family-parameters :d-scale 1/4)
@end(code) "
  (let* ((tin (open-tin-file))
         (d-names
           (loop :for i :in (mnas-ansys/tin:names (mnas-ansys/tin:<tin>-families tin))
                 :if (let ((str (first (last (mnas-string:split "/" i)))))
                       (and (eq #\D (char str 0))
                            (eq #\_ (char str 1))))
                   :collect i :into d-rez
                 :finally (return d-rez))))
    (progn
      (format t "~A~%" "ic_undo_group_begin")
      (mnas-ansys/ic/geo:set-meshing-params-global :gref 1 :gmax gmax)
      (format t "~A~2%" "ic_undo_group_end"))
    (progn
      (format t "~A~%" "ic_undo_group_begin")
      (loop :for i :in d-names
            :do
               (let ((d-size
                       (read-from-string
                        (first
                         (last
                          (mnas-string:split
                           "_"
                           (first (last (mnas-string:split "/" i)))))))))
                 d-size
                 (format t "ic_geo_set_family_params ~A no_crv_inf prism 0 emax ~A ehgt 0.0 hrat 0 nlay 0 erat ~A ewid 0 emin 0.0 edev 0.0 split_wall 0 internal_wall 0~%"
                         i (* d-size d-scale) 0.0)))
      (format t "~A~2%" "ic_undo_group_end"))))

(defun families ()
  "@b(Описание:) функция @b(families) возвращает список имен семейств,
выбранного в диалоге tin-файла."
  (let ((names
          (mnas-ansys/tin:names
           (mnas-ansys/tin:<tin>-families
            (open-tin-file)))))
    (format t "~2%~{~A~^~%~}~2%" names)
    names))

#+nil (setup-family-parameters :d-scale 1/4 :gmax 2)
#+nil (choose-directory)
"
ic_undo_group_begin 
ic_coords_dir_into_global {1 0 0} global
ic_geo_set_periodic_data {axis {1 0 0} type none angle 36 base {0 0 0}}
ic_undo_group_end 

ic_undo_group_begin 
ic_coords_dir_into_global {1 0 0} global
ic_geo_set_periodic_data {axis {1 0 0} type rot angle 36 base {0 0 0}}
ic_undo_group_end 
"
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
