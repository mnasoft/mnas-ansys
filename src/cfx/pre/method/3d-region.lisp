;;;; ./src/cfx/pre/test.lisp

(in-package :mnas-ansys/cfx/pre)

(defmethod 3d-regions ((simulation <simulation>))
  " @b(Пример использования:)
@begin[lang=lisp](code)
 (domains *ds*)
@end(code)"
  (ht-keys-sort (<simulation>-3d-regions simulation)))

(defmethod 3d-region (name (simulation <simulation>))
  "@b(Описание:) метод @b(domain) возвращает объект типа @b(<3d-region>) по
его имени из симуляции @b(simulation).

 @b(Пример использования:)
@begin[lang=lisp](code)
 (domain \"DG1 G1\" *simulation*)
@end(code)"
  (gethash name (<simulation>-3d-regions simulation)))

(defmethod 3d-region-mesh (mesh-name (simulation <simulation>))
  "@b(Описание:) метод @b(3d-region-mesh) возвращает список объектов типа
@b(<3d-region>) по имени сетки @b(mesh-name) из симуляции @b(simulation).

 @b(Пример использования:)
@begin[lang=lisp](code)
 (3d-region-mesh \"G1\" *simulation*)
@end(code)"
  (remove-if-not
   #'(lambda (el)
       (string=
        mesh-name
       (<mesh>-name (<3d-region>-mesh el))))
   (ht-values (<simulation>-3d-regions simulation))))

(defmethod 3d-region-min (mesh-name (simulation <simulation>))
  "@b(Описание:) метод @b(3d-region-min) возвращает объект типа
@b(<3d-region>) с минимальным 3d-суффиксом по имени сетки
@b(mesh-name) из симуляции @b(simulation)."
  (first (sort (3d-region-mesh mesh-name simulation)
               #'<
               :key #'<3d-region>-3d-suffix)))

(defmethod 3d-region-max (mesh-name (simulation <simulation>))
  "@b(Описание:) метод @b(3d-region-min) возвращает объект типа
@b(<3d-region>) с максимальным 3d-суффиксом по имени сетки
@b(mesh-name) из симуляции @b(simulation)."  
  (first (sort (3d-region-mesh mesh-name simulation)
               #'>
               :key #'<3d-region>-3d-suffix)))
