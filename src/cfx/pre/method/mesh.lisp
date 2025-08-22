;;;; ./src/cfx/pre/test.lisp

(in-package :mnas-ansys/cfx/pre)

(defmethod mesh (name (simulation <simulation>))
  "@b(Описание:) метод @b(mesh) возвращает объект типа @b(mesh) по его
имени @b(name) из симуляции @b(simulation).

 @b(Пример использования:)
@begin[lang=lisp](code)
 (mesh   \"G2\"     *simulation*)
@end(code)"
  (gethash name (<simulation>-meshes simulation)))

(defmethod mesh (name (ht hash-table))
  "@b(Описание:) метод @b(mesh) возвращает из хеш-таблицы @b(ht),
сетку по ее имени.

 @b(Пример использования:)
@begin[lang=lisp](code)
 (mesh \"G1\" (<simulation>-meshes *simulation*))
@end(code)"
  (gethash name ht))
