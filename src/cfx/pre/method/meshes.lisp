;;;; ./src/cfx/pre/test.lisp

(in-package :mnas-ansys/cfx/pre)
#+nil 
(defmethod meshes ((obj <meshes>))
  (sort 
   (alexandria:hash-table-keys (<meshes>-meshes obj))
   #'string<))
#+nil 
(defmethod meshes ((obj <meshes>))
  (ht-keys-sort (<meshes>-meshes obj)))

(defmethod mesh (name (simulation <simulation>))
  "@b(Описание:) метод @b(mesh) возвращает объект типа @b(mesh) по его
имени @b(name) из симуляции @b(simulation).

 @b(Пример использования:)
@begin[lang=lisp](code)
 (mesh   \"G2\"     *simulation*)
@end(code)"
  (gethash name (<simulation>-meshes simulation)))

(defmethod mesh (name (simulation <simulation>))
  "@b(Описание:) метод @b(mesh) возвращает объект типа @b(mesh) по его
имени @b(name) из симуляции @b(simulation).

 @b(Пример использования:)
@begin[lang=lisp](code)
 (mesh   \"G2\"     *simulation*)
@end(code)"
  (gethash name (<simulation>-meshes simulation)))

#+nil 
(defmethod mesh (name (meshes <meshes>))
  (gethash name (<meshes>-meshes meshes)))

(defmethod mesh (name (ht hash-table))
  (gethash name ht))

