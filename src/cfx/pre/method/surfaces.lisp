;;;; ./src/cfx/pre/test.lisp

(in-package :mnas-ansys/cfx/pre)

(defmethod surfaces ((d (eql nil)))
  d)


;;;; surfaces -> 2d-region-values
(defmethod surfaces ((mesh <mesh>))
  "@b(Описание:) метод @b(surfaces) возвращает список имен 2d-регионов...

 @b(Пример использования:)
@begin[lang=lisp](code)
 (surfaces (mesh \"G1\" *simulation*))
@end(code)"
  (ht-values-sort (<mesh>-2d-regions mesh)))

;;;;  surface-keys -> 2d-region-keys
(defmethod surface-keys ((mesh <mesh>))
  (ht-keys-sort (<mesh>-2d-regions mesh)))

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
