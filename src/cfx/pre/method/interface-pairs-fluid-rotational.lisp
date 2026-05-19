;;;; ./src/cfx/pre/method/interface-pairs-fluid-rotational.lisp

(in-package :mnas-ansys/cfx/pre)

(defmethod interface-pairs-fluid-rotational ((simulation <simulation>))
  "@b(Описание:) метод @b(interface-pairs-fluid-general) возвращает список
строк представляющих имена флюидовых сеток для создания между ними
интерфейсов типа fluid-fluid типа rotational-periodicy и general."
  (mapcar #'first
          (sort
           (remove-if-not
            #'(lambda (el)
                (string= (first el) (second el)))
            (interface-pairs-fluid simulation))
           #'two-string-list<)))
