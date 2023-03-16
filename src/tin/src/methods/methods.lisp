(in-package :mnas-ansys/tin)

(defmethod tin-points ((tin <tin>))
  "@b(Описание:) метод @b(tin-points) возвращает список точек tin-файла."
  (loop :for k :being :the :hash-key
          :using (hash-value v) :of (<tin>-points tin)
      :collect v))

(defmethod tin-curves ((tin <tin>))
  "@b(Описание:) метод @b(tin-curves) возвращает список кривых tin-файла."
  (loop :for k :being :the :hash-key
          :using (hash-value v) :of (<tin>-curves tin)
      :collect v))

(defmethod tin-surfaces ((tin <tin>))
  "@b(Описание:) метод @b(tin-curves) возвращает список поверхностей tin-файла."
  (loop :for k
          :being :the :hash-key
          :using (hash-value v) :of (<tin>-surfaces tin)
      :collect v))

(defun add-obj-to-ht-by-name (obj ht)
  (setf (gethash (<obj>-name obj) ht) obj))

(defun populate-by-name (hash-table obj-list)
  " @b(Описание:) функция @b(populate-by-name) вспомогательная функция
 добавляет в хеш-таблицу @b(hash-table) элементы, находящиеся в
 таблице @b(obj-list) в качестве ключей имена объектов, в качестве
 значений используются собственно объекты.

 Планируется к использованию с кривыми и повехностями tin-файла."
  (map nil
       #'(lambda (el)
	   (setf (gethash (<obj>-name el) hash-table) el))
       obj-list)
  hash-table)

(defmethod init-curves ((tin <tin>))
  "@b(Описание:) метод @b(init-curves) выполняет инициализацию кривых."
  (map nil #'(lambda (surf)
               (map nil #'(lambda (curv)
                            (push surf (<curve>-surfaces curv)))
                    (coedged surf tin)))
       (tin-surfaces tin)))

(defmethod find-curve-by-name ((name string) (tin <tin>))
  (gethash name (<tin>-curves tin))
  )

(defmethod find-surface-by-name ((name string) (tin <tin>))
  (gethash name (<tin>-surfaces tin))
  )

(defmethod find-curves-coeged-with-surfases (surfaces (tin <tin>))
  (remove-duplicates
   (apply #'append
          (mapcar #'(lambda (sur) (coedged sur tin)) surfaces))))

(defmethod find-surfaces-coeged-with-curves (curves (tin <tin>))
  (remove-duplicates
   (apply #'append
          (mapcar #'(lambda (sur) (coedged sur tin)) curves))))



(defmethod families ((entytes cons))
  "@b(Описание:) метод @b(families) возвращает список семейств,
  содержащий уникальные имена.

 @b(Пример использования:)
@begin[lang=lisp](code)
 (families (<tin>-surfaces *tin*))
 (families (<tin>-curves  *tin*))
 (families (<tin>-points  *tin*))
@end(code)"
  (let ((rez (sort 
              (remove-duplicates 
               (mapcar #'(lambda(el) (<ent>-family el)) entytes)
               :test #'equal)
              #'string<)))
    (format t "~{~A~%~}~2%" rez)
    rez))

(defmethod families ((entytes hash-table))
  "@b(Описание:) метод @b(families) возвращает список семейств,
  содержащий уникальные имена.

 @b(Пример использования:)
@begin[lang=lisp](code)
 (dia:open-tin-file)
 (families (<tin>-surfaces dia:*tin*))
 (families (<tin>-curves   dia:*tin*))
 (families (<tin>-points   dia:*tin*))
@end(code)"
  (families (loop :for k :being :the :hash-key
        :using (hash-value v)
          :of entytes
      :collect v)))

(defun names (entities &optional (stream t))
  "@b(Описание:) функция @b(entities) 
"
  (let ((names (sort (loop :for i :in entities
                           :collect (<obj>-name i))
                     #'string<)))
    (format stream "~{~S~^ ~}~2%" names)
    names))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defmethod surface-coeged-with-surfaces (surf (tin <tin>)
                                         &key
                                           (excluded nil)
                                           (times 1))
  " @b(Описание:) метод @b(surface-coeged-with-surfaces) возвращает
  поверхности, сопряженные с поверхностями из списка @b(surf) для
  контейнера геометрии @b(tin). 

  Параметр   @b(times) задает глубину поиска - количество итераций.

  На каждом шаге @b(times) поверхности, задаваемые ключевым параметром
  @(excluded) из результирующего списка исключаются.  
"
  (let* ((family-surfaces surf)
         (surfaces-excluded excluded)
         (start-surfaces family-surfaces))
    (loop :for i :from 0 :below times :do
          (let* ((curves  (find-curves-coeged-with-surfases start-surfaces tin))
                 (sufaces (find-surfaces-coeged-with-curves curves tin)))
            (map nil #'(lambda (el) (setf sufaces (remove el sufaces))) surfaces-excluded)
            (setf start-surfaces sufaces)))
    (map nil #'(lambda (el) (setf start-surfaces (remove el start-surfaces))) family-surfaces)
    start-surfaces))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defmethod count-surface ((tin <tin>))
  "@b(Описание:) метод @b(count-surface) возвращает список каждым
  элементом которого явяется список, содержащий имя семейства и
  количество поверхностей, которые находятся в этих семействах.

 @b(Пример использования:)
@begin[lang=lisp](code)
  (count-surface 
    (open-tin-file \"D:/home/_namatv/CFX/a32_base/PR-01/tin/DOMAINS/D-4/a32-D-4.tin\"))
    => ( (\"D1/C/C_1-3_N01_D024.00_S01.61\" 2) 
         (\"D1/C/C_1-4_N01_D032.00_S04.32\" 2)
         ...
         )
@end(code)"
  (let ((rez (make-hash-table :test #'equal)))
    (mapcar
     #'(lambda (sur)
         (if (null (gethash (<ent>-family sur) rez))
             (setf (gethash (<ent>-family sur) rez) 1)
             (setf (gethash (<ent>-family sur) rez) (1+ (gethash (<ent>-family sur) rez)))))
     (tin-surfaces tin))
    (sort 
     (mnas-hash-table:to-list rez)
     #'string<
     :key #'first)))
