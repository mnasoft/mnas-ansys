(defpackage #:mnas-icem/select
  (:use #:cl #:mnas-icem)
  (:export entities-by-families
           curves-by-families
           surfaces-by-families
           curves-by-coedges-number
           exclude-by-families
           include-by-families
           surfaces-coedged-with-curve-by-number
           )
  (:documentation
   " Пакет @b(mnas-icem/select) определяет функции для выбора объектов
   из контейнера геометрии."))

(in-package #:mnas-icem/select)

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
          (mnas-icem::tin-curves tin)
          ;; (<tin>-curves tin)
          :initial-value ()))

(defmethod surfaces-by-families (families (tin <tin>))
  " @b(Описание:) метод @b(surfaces-by-families) возвращает
  список поверхностей, принадлежащих семействам @b(families) объекта
  @b(tin)."
  (reduce #'(lambda (lst surf)
              (if (find (mnas-icem::<ent>-family surf) families :test #'string=)
                  (cons surf lst)
                  lst))
          (mnas-icem::tin-surfaces tin)
          ;; (<tin>-surfaces tin)
          :initial-value ()))

(defmethod curves-by-coedges-number (coedges-number (tin <tin>))
  "@b(Описание:) метод @b(curves-by-coedges-number) возвращает
 список кривых tin-файла @b(tin) с числом сопряженных поверностей
 равным @b(coedges-number)."
  (let ((rez nil))
    (loop :for curv :in (mnas-icem::tin-curves tin)
          :do (when (= coedges-number (length (mnas-icem::<curve>-surfaces curv)))
               (push curv rez)))
    rez))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defmethod exclude-by-families (entyties families)
  " @b(Описание:) метод @b(exclude-by-families) возвращает список
 объектов, у которых слот семейтсво не соответствует ни одному из имен
 семейств, содержащихся в списке @b(families).

 @b(Переменые:)
@begin(list)
 @item(entyties - список объектов, являющихся потомками mnas-icem:<ent>;)
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
 @item(entyties - список объектов, являющихся потомками mnas-icem:<ent>;)
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
                      (mnas-icem::<curve>-surfaces curv))
                  (mnas-icem/select:curves-by-coedges-number number tin)))))
