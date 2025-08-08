;;;; ./src/cfx/pre/test.lisp

(in-package :mnas-ansys/cfx/pre)

(defmethod surfaces ((d (eql nil)))
  d)

(defmethod surfaces ((mesh <mesh>))
  (ht-values-sort (<mesh>-2d-regions mesh)))
#+nil 
(defmethod surfaces ((domain <domain>))
  (ht-values-sort (<domain>-surfaсes domain)))
#+nil 
(defmethod surface-keys ((domain <domain>))
  (ht-keys-sort (<domain>-surfaсes domain)))
#+nil 
(defmethod surface-value (key (domain <domain>))
  (gethash key (<domain>-surfaсes domain)))

(defmethod surface-keys ((mesh <mesh>))
  (ht-keys-sort (<mesh>-2d-regions mesh)))

(defmethod surfaces ((simulation <simulation>))
  (ht-values-sort (<simulation>-surfaces simulation)))

(defmethod simulation-doman-surfaces ((domain-name string) (simulation <simulation>))
  "@b(Описание:) метод @b(simulation-doman-surfaces) возвращает список
поверхностей для домена с именем @b(domain-name), из симуляции
@b(simulation).

 @b(Пример использования:)
@begin[lang=lisp](code)
 (simulation-doman-surfaces \"DG1 G1\" *simulation*)
@end(code)
"
  ;; поверхности, которые входят в домен
  (surfaces
   (gethash domain-name
            (<simulation>-domains simulation))))
