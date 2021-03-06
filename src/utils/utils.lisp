;;;; ./src/utils/utils.lisp

(defpackage #:mnas-ansys/utils
  (:use #:cl #:mnas-ansys #:mnas-ansys/select #:math/geom)
  (:export curve-names-coeged-with-surface-in-family
           surface-names-coeged-with-surface-in-family
           surface-names-coeged-with-surfaces 
           surface-names-coedged-with-curve-by-number
           curve-names-by-coedges-number
           )
  (:export tetra-size-for-hole-by-cell-number
           )
  (:export quality-series)
  (:documentation
   " Пакет @b(mnas-ansys/utils) определяет функции, предназаченные для
   манипулирования графическими объектами при взаимодействии
   пользователя с программой ANSYS ICEM."
   ))

(in-package :mnas-ansys/utils)

(defmethod curve-names-coeged-with-surface-in-family (families (tin <tin>))
  "@b(Описание:) функция @b(curve-names-coeged-with-surface-in-family)
  возвращает имена кривых, лежащих на границах поверхностей,
  принадлежащих семейству @b(families).  Возвращаются имена кривых,
  которые сопряжены с поверхностями, принадлежащими всем семействам.

 @b(Переменые:)
@begin(list)
 @item(families - список, содержащий имена семейств;)
 @item(tin - объект, содержащий геометрию.)
@end(list)
"
  (let ((f-s (sort families #'string<)))
    (mapcar #'first
	    (reduce
	     #'(lambda (lst x)
		 (if (equal (sort f-s #'string<) (second x))
		     (cons x lst)
		     lst))
	     (mapcar
	      #'(lambda (el)
		  (list (mnas-ansys::<obj>-name el)
			(sort
			 (mapcar #'mnas-ansys::<ent>-family (coedged el tin))
			 #'string<)))
              (mnas-ansys::tin-curves tin))
	      ;; (<tin>-curves tin))
	     :initial-value ()))))

(defmethod surface-names-coeged-with-surfaces-bak (surf (tin <tin>)
                                              &key
                                                (excluded nil)
                                                (times 1))
  " @b(Описание:) метод @b(surface-names-coeged-with-surface-in-family)
  возврвшает имена поверхностей, сопряженных с поверхностями,
  принадлежащим семействам @b(families) из контейнера геометрии
  @b(tin). Имена поверхностей, принадлежащие семействам
  @b(families-excluded) из результирующего списка исключаются.
  Параметр @b(times) задает глубину поиска.
"
  (let* ((family-surfaces surf)
         (surfaces-excluded excluded)
         (start-surfaces family-surfaces))
    (loop :for i :from 0 :below times :do
      (let* ((curves  (mnas-ansys::find-curves-coeged-with-surfases start-surfaces tin))
             (sufaces (mnas-ansys::find-surfaces-coeged-with-curves curves tin)))
        (map nil #'(lambda (el) (setf sufaces (remove el sufaces))) surfaces-excluded)
        (setf start-surfaces sufaces)))
    (map nil #'(lambda (el) (setf start-surfaces (remove el start-surfaces))) family-surfaces)
    (mapcar #'mnas-ansys::<obj>-name start-surfaces)))

(defmethod surface-names-coeged-with-surfaces (surf (tin <tin>)
                                               &key
                                                 (excluded nil)
                                                 (times 1))
    " @b(Описание:) метод @b(surface-coeged-with-surfaces) возвращает
  имена поверхностей, сопряженных с поверхностями из списка @b(surf)
  для контейнера геометрии @b(tin).

  Параметр @b(times) задает глубину поиска - количество итераций.

  На каждом шаге @b(times) поверхности, задаваемые ключевым параметром
  @b(excluded) из результирующего списка исключаются.  
"
  (names (surface-coeged-with-surfaces surf tin :excluded excluded :times times)))



(defmethod surface-names-coeged-with-surface-in-family (families (tin <tin>)
                                                       &key
                                                         (families-excluded nil)
                                                         (times 1)
                                                         )
  "@b(Описание:) метод @b(surface-names-coeged-with-surface-in-family)
  возврвшает имена поверхностей, сопряженных с поверхностями,
  принадлежащим семействам @b(families) из контейнера геометрии
  @b(tin). Имена поверхностей, принадлежащие семействам
  @b(families-excluded) из результирующего списка исключаются.
  Параметр @b(times) задает глубину поиска.
"
  (surface-names-coeged-with-surfaces
   (surfaces-by-families families tin)
   tin
   :excluded (surfaces-by-families families-excluded tin)
   :times times))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defmethod surface-names-coedged-with-curve-by-number ((number integer) (tin <tin>))
  "@b(Описание:) метод @b(surface-names-coedged-with-curve-by-number)
   возвращает имена поверхностей, сопряженных хотябы одним краем с
   кривой, сопряженной с поверхностями number раз."
  (names (surfaces-coedged-with-curve-by-number number tin)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defmethod curve-names-by-coedges-number (coedges-number (tin <tin>))
  "@b(Описание:) метод @b(curve-names-by-coedges-number) возвращает
 имена кривых, сопряженных с поверхностями @b(coedges-number) раз."
  (names (curves-by-coedges-number coedges-number tin)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun tetra-size-for-hole-by-cell-number (diameter cell-number)
  "@b(Описание:) функция @b(tetra-size-for-hole-by-cell-number)
   вычисляет длину стороны треугольника, такую чтобы в отверстии
   диаметром располагалось @b(cell-number) треугольников.

 @b(Пример использования:)
@begin[lang=lisp](code)
 (tetra-size-for-hole-by-cell-number 1.2 100)  0.1616128503228816d0, 23.326804314005766d0 
 (tetra-size-for-hole-by-cell-number 40.0 100) 5.387094796698806d0
@end(code)
"
  (let ((rez (math/geom:regular-triangle-side-by-area
              (/ (math/geom:circle-area-by-diameter diameter)
                 cell-number))))
    (values rez (/ (* diameter pi) rez))))

(defparameter *cell/in/section-diameter/koeff-cells/near/wall*
  (mapcar
   #'(lambda (el)
       (multiple-value-bind (a b) (tetra-size-for-hole-by-cell-number 1 el)
         (list el (/ a) b)))
   '(6 12 25 50 100 200 400 800 1600)
   ))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defparameter *n-tr* '(6 12 25 50 100 200 400 800 1600 3200 6000)
  "@b(Описание:) Параметр @b(*n-tr*) содержит ряд величин, задающий количество
  треугольников помещающихся в гидравлическом диаметре отверстия.")

(defparameter *q-tr* (loop :for i :in *n-tr* :for j :from 1 :collect j)
  "@b(Описание:) Параметр @b(*q-tr*) содержит ряд величин, задающий
  качество заполнения гидравлического диаметра треугольниками.")

(defun quality-series (d-hydraulic)
  ""
  (format t "    d-hydraulic = ~f~%~{~{~8,2F ~}~%~}"
          d-hydraulic
          (concatenate
           'list '(("    Q" "    N-tr" "    D, mm"))
           (loop :for q :in *q-tr*
                 :for n :in *n-tr*
                 :collect
                 (list q n (tetra-size-for-hole-by-cell-number d-hydraulic n))))))

