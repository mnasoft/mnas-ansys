;;;; ./src/utils/utils.lisp

(defpackage :mnas-ansys/tin/utils
  (:use #:cl #:mnas-ansys/tin #:mnas-ansys/tin/select #:math/geom)
  (:export surface-names-coeged-with-surface-in-family
           surface-names-coeged-with-surfaces 
           surface-names-coedged-with-curve-by-number
           curve-names-by-coedges-number
           )
  (:export tetra-size-for-hole-by-cell-number
           )
  (:export quality-series)
  (:export secect-surfaces-by-families 
           curve-names-coeged-with-surface-in-family
           curve-names-coeged-with-surfaces-in-families)
  (:export surface-families
           curves-families
           points-families)
  (:export tangent-curve-names
           tangent-point-names
           )
  (:documentation
   " Пакет @b(mnas-ansys/tin/utils) определяет функции, предназаченные для
   манипулирования графическими объектами при взаимодействии
   пользователя с программой ANSYS ICEM."
   ))

(in-package :mnas-ansys/tin/utils)

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
		  (list (<obj>-name el)
			(sort
			 (mapcar #'<ent>-family (coedged el tin))
			 #'string<)))
              (tin-curves tin))
	      ;; (<tin>-curves tin))
	     :initial-value ()))))

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

(defmethod secect-surfaces-by-families (families (tin <tin>))
  "@b(Описание:) метод @b(secect-surfaces-by-families) возвращает список
 поверхностей принадлежащих любому семейству из списка имен семейств
 @b(families).
"
  (loop :for sur :being :the :hash-value :in (<tin>-surfaces tin) 
        :if (member (<ent>-family sur) families :test #'equal)
          :collect sur :into surfs
        :finally (return surfs)))

(defmethod curve-names-coeged-with-surfaces (surfaces (tin <tin>))
  "@b(Описание:) метод @b(curve-names-coeged-with-surf) возвращает
 количество и список кривых (два значения) сопряженных с поверхностями
 из списка @b(surfaces)."
  (let* ((ht-curves (make-hash-table))
         (curve-names
           (loop :for sur :in surfaces :do
             (loop :for cur in (coedged sur tin)
                   :do (setf (gethash (<obj>-name cur) ht-curves) cur))
                 :finally
                    (return
                      (loop :for curve-name :being :the :hash-keys :in ht-curves 
                            :collect curve-name)))))
    (format t "~{~A~^ ~}~2%" curve-names)
    (values
     (length curve-names)
     curve-names)))

(defmethod curve-names-coeged-with-surfaces-in-families (families (tin <tin>) &key (operation :union))
  "@b(Описание:) метод @b(curve-names-coeged-with-surfaces-in-families)
 @b(Переменые:)
 @begin(list)
 @item(operation :union - возвращаются кривые, являющиеся сопряженными
       с любой поверхностью;)
 @item(operation :intersection - возвращаются кривые, являющиеся
       сопряженными поверхностями принадлежащими всем поверхностям;)
 @end(list)"
  (cond
    ((eq operation :union)
     (curve-names-coeged-with-surfaces
      (secect-surfaces-by-families families tin)
      tin))
    ((eq operation :intersection)
     (curve-names-coeged-with-surface-in-family families tin))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defmethod surface-families ((tin <tin>))
  "@b(Описание:) функция @b(families) возвращает список имен семейств,
   содержащих поверхности."
  (tin:families (tin:<tin>-surfaces tin)))

(defmethod curves-families ((tin <tin>))
  "@b(Описание:) функция @b(curves-families) возвращает список имен семейств,
   содержащих кривые."
      (tin:families (tin:<tin>-curves tin)))

(defmethod points-families ((tin <tin>))
  "@b(Описание:) функция @b(points-families) возвращает список имен семейств,
   содержащих точки."
  (tin:families (tin:<tin>-points tin)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defmethod coeged-have-same-path ((curve <curve>) (tin <tin>))
  (let ((ht (make-hash-table :test #'equal)))
    (mapcar
     #'(lambda (el)
         (let ((key (family-path (<ent>-family el))))
           (setf (gethash key ht) key)))
     (coedged curve tin))
    (when (= (hash-table-count ht) 1) (<obj>-name curve))))

(defmethod coeged-have-same-path ((point <point>) (tin <tin>))
  (when (<= (length (loop :for i :in (coincident point tin)
                          :when (string/= "TAN" (<ent>-family i))
                            :collect i))
            2)
    (<obj>-name point)))

(defun family-path (name)
  (format nil "~{~A~^/~}"
          (reverse (cdr (reverse (mnas-string:split "/" name))))))

(defun exclude-nil (lst)
  (loop :for i :in lst
        :when i :collect i))

(defun tangent-curve-names (tin)
  "@b(Описание:) функция @b(tangent-curve-names) в качестве побочного
эффекта печатает на стандартный вывод имена кривых, для которых
сопряженные с ними поверхности имеют один и тотже самый путь."
  (format t "~{~A~^ ~}~3%"
          (exclude-nil
           (mapcar
            #'(lambda (el)
                (coeged-have-same-path el tin))
            (tin-curves tin)))))

(defun tangent-point-names (tin)
  "@b(Описание:) функция @b(tangent-point-names) в качестве побочного
эффекта печатает на стандартный вывод имена точек, сопряженных не
более чем с двумя кривыми."
  (format t "~{~A~^ ~}~3%"
          (exclude-nil
           (mapcar
            #'(lambda (el)
                (coeged-have-same-path el tin))
            (tin-points tin)))))

;; (dia:open-tin-file)
;; (tangent-curve-names dia:*tin*)
