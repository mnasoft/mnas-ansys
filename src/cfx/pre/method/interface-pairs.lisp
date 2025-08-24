;;;; ./src/cfx/pre/method/interface-pairs.lisp

(in-package :mnas-ansys/cfx/pre)

(defmethod interface-pairs ((mesh <mesh>))
  (remove-duplicates 
   (loop :for i :in (interfaces mesh)
         :collect
         (sort 
          (ppcre:split "-" (between-first-two-slashes i))
          #'string<))
   :test #'equal))

(defmethod interface-pairs ((simulation <simulation>))
  (remove-duplicates 
   (apply #'append
          (loop :for mesh :in (ht-values (<simulation>-meshes simulation))
                :collect
                (interface-pairs mesh)))
   :test #'equal))

(defmethod interface-pairs-fluid ((simulation <simulation>))
  (remove-if-not
   #'(lambda (el)
       (and 
        (uiop:string-prefix-p "G" (first el))
        (uiop:string-prefix-p "G" (second el))))
   (interface-pairs simulation)))

(defmethod interface-pairs-solid ((simulation <simulation>))
  "@b(Описание:) метод @b(interface-pairs-solid) возвращает список пар
строк представляющих имена солидовых сеток для создания между ними
интерфейсов типа solid-solid.

 @b(Пример использования:)
@begin[lang=lisp](code)
 (interface-pairs-solid *simulation*)
@end(code)"
  (sort 
   (remove-if-not
    #'(lambda (el)
        (and 
         (uiop:string-prefix-p "M" (first el))
         (uiop:string-prefix-p "M" (second el))))
    (interface-pairs simulation))
   #'two-string-list<))

(defmethod interface-pairs-fluid-general ((simulation <simulation>))
  "@b(Описание:) метод @b(interface-pairs-fluid-general) возвращает список пар
строк представляющих имена флюидовых сеток для создания между ними
интерфейсов типа fluid-fluid типа general.

 @b(Пример использования:)
@begin[lang=lisp](code)
 (interface-pairs-fluid-general *simulation*)
@end(code) "
  (sort 
   (remove-if-not
    #'(lambda (el)
        (string/= (first el) (second el)))
    (interface-pairs-fluid simulation))
   #'two-string-list<))

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
