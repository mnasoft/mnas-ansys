;;;; ./src/cfx/pre/method/reset.lisp

(in-package :mnas-ansys/cfx/pre)

(defmethod reset ((obj <simulation>))
  "@b(Описание:) метод @b(reset) сбрасывает объект в исходное состояние и
возвращает его.

При этом: хеш-таблица 3d-регионов очищается, счетчики количества
ссылок на 3d-сетки устанавливаются в 0, список команд очищается.
"
  (clrhash                              ; Удаляем 3d-регионы
   (<simulation>-3d-regions obj)) 
  (setf                                 ; Удаляем команды
   (<simulation>-commands obj) nil)
  ;; Сбрасываем счетчики 3d-регионов для сеток
  (loop :for msh :in (ht-values (<simulation>-meshes obj))
        :do (reset msh))
  ;; Возвращаем объект
  obj)

(defmethod reset ((obj <mesh>))
  ;; Сбрасываем счетчик 3d-регионов для сетки
  (setf (<mesh>-3d-region-instance-number obj) 0)
  ;; Возвращаем объект
  obj)
