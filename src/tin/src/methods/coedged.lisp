(in-package :mnas-ansys/tin)

(defmethod coedged ((curve <curve>) (surface <surface>))
  "@b(Описание:) метод @b(coedged) возвращает объект типа @b(surface),
если кривая @b(curve) имеет совпадающие грани с поверхностью @b(surface)
или @b(nil) в противном случае.

 Реализация весьма странная (нелогичная, не соответствующая духу
 обобщенной функции). Лучше переименовать coedged -> coedged-p ."
  (when (find (<obj>-name curve)
	      (<surface>-coedges surface)
	      :key #'<coedge>-name :test #'string=)
    surface))

(defmethod coedged ((curve <curve>) (tin <tin>))
  " @b(Описание:) метод @b(coedged) возвращает список объектов типа
 @b(<surface>), у которых грани (кромки) совпадают с кривой @b(curve)."
  (loop :for i :in (tin-surfaces tin)
        ;; (<tin>-surfaces tin)
        :when (coedged curve i) :collect :it))

(defmethod coedged ((surface <surface>) (tin <tin>))
  "@b(Описание:) метод @b(coedged) возвращает список объектов типа
 @b(curve), сопряженных с поверхностью @b(surface)."
  (loop :for i :in (<surface>-coedges surface)
        :when (find-curve-by-name (<coedge>-name i) tin) :collect :it))

(defmethod coedged ((coedge <coedge>) (tin <tin>))
  " @b(Описание:) метод @b(coedged) возвращает объект типа @b(<curve>)
 из набора объектов @b(tin), по имени кривой.
"
  (nreverse
   (reduce
    #'(lambda (lst sur)
	(if (coedged coedge sur) (cons sur lst)
	    lst))
    (tin-surfaces tin)
    ;; (<tin>-surfaces tin)
    :initial-value ())))
