(defpackage #:mnas-ansys/tin/select
  (:use #:cl #:mnas-ansys/tin)
  (:nicknames "SELECT")
  (:export entities-by-families
           curves-by-families
           surfaces-by-families
           curves-by-coedges-number
           exclude-by-families
           include-by-families
           surfaces-coedged-with-curve-by-number
           families-by-assembly-name
           )
  (:export curves-coeged-ally
           curves-coeged-internally
           curves-coeged-externally)
  (:documentation
   " Пакет @b(mnas-ansys/tin/select) определяет функции для выбора объектов
   из контейнера геометрии."))

(in-package #:mnas-ansys/tin/select)

(defmethod entities-by-families (families entities)
  " @b(Описание:) метод @b(entities-by-families) возвращает
  список объектов, принадлежащих семействам @b(families) объекта
  @b(tin).

 @b(Пример использования:)
@begin[lang=lisp](code)
(entities-by-families
  '(\"GT_P15_STUB\" \"GT_P15_OUTER\")
  (<tin>-curves *tin*))
@end(code)
"
  (reduce #'(lambda (lst curve)
              (if (find (<ent>-family curve) families :test #'string=)
                  (cons curve lst)
                  lst))
          entities
          :initial-value ()))

(defmethod curves-by-families (families (tin <tin>))
  " @b(Описание:) метод @b(surfaces-by-families) возвращает список
  кривых, принадлежащих семействам @b(families) объекта @b(tin)."
  (reduce #'(lambda (lst curve)
              (if (find (<ent>-family curve) families :test #'string=)
                  (cons curve lst)
                  lst))
          (tin-curves tin)
          ;; (<tin>-curves tin)
          :initial-value ()))

(defmethod surfaces-by-families (families (tin <tin>))
  " @b(Описание:) метод @b(surfaces-by-families) возвращает
  список поверхностей, принадлежащих семействам @b(families) объекта
  @b(tin)."
  (reduce #'(lambda (lst surf)
              (if (find (<ent>-family surf) families :test #'string=)
                  (cons surf lst)
                  lst))
          (tin-surfaces tin)
          ;; (<tin>-surfaces tin)
          :initial-value ()))

(defmethod curves-by-coedges-number (coedges-number (tin <tin>))
  "@b(Описание:) метод @b(curves-by-coedges-number) возвращает
 список кривых tin-файла @b(tin) с числом сопряженных поверностей
 равным @b(coedges-number)."
  (let ((rez nil))
    (loop :for curv :in (tin-curves tin)
          :do (when (= coedges-number (length (<curve>-surfaces curv)))
               (push curv rez)))
    rez))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defmethod exclude-by-families (entyties families)
  " @b(Описание:) метод @b(exclude-by-families) возвращает список
 объектов, у которых слот семейтсво не соответствует ни одному из имен
 семейств, содержащихся в списке @b(families).

 @b(Переменые:)
@begin(list)
 @item(entyties - список объектов, являющихся потомками mnas-ansys/tin:<ent>;)
 @item(families - список строк, содержащих имена семейтсв.)
@end(list)"
  (loop :for i :in entyties
        :unless (some #'(lambda (el) (string= el (<ent>-family i))) families)
          :collect i))

(defmethod include-by-families (entyties families)
  " @b(Описание:) метод @b(exclude-by-families) возвращает список
 объектов, у которых слот семейтсво соответствует хотя-бы одному из
 имен семейств, содержащихся в списке @b(families).

 @b(Переменые:)
@begin(list)
 @item(entyties - список объектов, являющихся потомками mnas-ansys/tin:<ent>;)
 @item(families - список строк, содержащих имена семейтсв.)
@end(list) "
  (loop :for i :in entyties
        :when (some #'(lambda (el) (string= el (<ent>-family i))) families)
          :collect i))

(defmethod surfaces-coedged-with-curve-by-number ((number integer) (tin <tin>))
  "@b(Описание:) метод @b(surfaces-coedged-with-curve-by-number)
   возвращает поверхности, сопряженные хотябы одним краем с
   кривой, сопряженной с поверхностями number раз."
  (remove-duplicates
   (apply #'append
          (mapcar #'(lambda (curv)
                      (<curve>-surfaces curv))
                  (curves-by-coedges-number number tin)))))

(defun families-by-assembly-name (assembly families)
  "@b(Описание:) функция @b(families-by-assembly-name) 
"
  (loop :for i :in families
        :when (member assembly (mnas-string:split "/" i) :test #'equal) :collect i))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defmethod curves-coeged-ally  ((family string) (tin <tin>) &optional (new-family family))
  "@b(Описание:) метод @b(curves-coeged-ally) печатает на стандартный
   вывод и возвращает имена кривых сопряженных любым образом с
   поверхностями из семейства @b(family)."
  (let ((names
          (names 
           (remove-duplicates
            (apply #'append
                   (loop :for i :in (surfaces-by-families `(,family) tin)
                         :collect
                         (coedged i tin)))))))
    (geo:set-part-curve names new-family)
    names))

(defmethod curves-coeged-ally ((family cons) (tin <tin>) &optional (new-family family))
  "@b(Описание:) метод @b(curves-coeged-ally) печатает на стандартный
   вывод и возвращает имена кривых сопряженных любым образом с
   поверхностями из семейства @b(family)."
  (names 
   (remove-duplicates
    (apply #'append
           (loop :for i :in (surfaces-by-families family tin)
                 :collect
                 (coedged i tin))))))

(defmethod curves-coeged-internally ((family string) (tin <tin>) &optional (new-family family))
  "@b(Описание:) метод @b(curves-coeged-internally) печатает на
   стандартный вывод и возвращает имена кривых сопряженных
   исключительно с поверхностями из семейства @(family)."
  (let* ((curves
          (loop :for i
                  :in (remove-duplicates
                       (apply #'append
                              (loop :for s :in (select:surfaces-by-families `(,family) tin)
                                    :collect (tin:coedged s tin))))
                :when
                (every #'(lambda (el)
                           (string=  el family))
                       (loop :for j :in (tin:coedged i tin)
                             :collect (tin:<ent>-family j)))
                :collect i))
         (names (names curves)))
    (geo:set-part-curve names new-family)
    names))

(defmethod curves-coeged-externally ((family string) (tin <tin>))
  "@b(Описание:) метод @b(curves-coeged-externally) печатает на
   стандартный вывод и возвращает имена кривых сопряженных
   исключительно с поверхностями из семейства @(family)."
  (let ((curves
          (loop :for i
                  :in (remove-duplicates
  (apply #'append
         (loop :for s :in (select:surfaces-by-families `(,family) tin)
               :collect (tin:coedged s tin))))
                :when
                (notevery #'(lambda (el)
                           (string=  el family))
                       (loop :for j :in (tin:coedged i tin)
                             :collect (tin:<ent>-family j)))
                :collect i)))
    (tin:names curves)))



#+nil
(defmethod curves-with-same-family-surface ((family string) (tin <tin>))
  "@b(Описание:) метод @b(curves-with-same-family-surface) возвращает
 имена кривых из семейства @(family), сопряженных с поверхностями
 семейтсва @(family)."
  (let ((curves
          (loop :for i
                  :in (mnas-ansys/tin/select:curves-by-families `(,family) tin)
                :when
                (every #'(lambda (el)
                           (string=  el family))
                       (loop :for j :in (tin:coedged i tin)
                             :collect (tin:<ent>-family j)))
                :collect i)))
    (tin:names curves)))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

