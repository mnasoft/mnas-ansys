;;;; ./src/tin/core/generics.lisp

(in-package :mnas-ansys/tin)

(defgeneric <object>-tag (object)
  (:documentation
   "@b(Описание:) обобщенная_функция @b(<object>-tag) тег объекта."))

(defgeneric read-object (lines n object)
  (:documentation
   "@b(Описание:) обобщенная_функция @b(lines-to-object) считывает данные из tin-файла.
Должна возвращать два значения:
@begin(list)
@item(первое - считанный объект;)
@item(второе - количество считанных строк.)
 
 @b(Переменые:)
@begin(list)
@item(lines - список строк, из которых производится считывание ниформации;)
@item(n - номер строки, соответствующих началу размещения объекта;)
@item(object - объект, данные которого считываются.)
@end(list)
"))

(defgeneric coedged (object container)
  (:documentation "@b(Описание:) обобщенная функция @b(coedged) возвращает 
список объектов, имеющих с объектом @b(object) совпадающие грани.
 
 Для кривых типа @b(<curve>) должны возвращаться поверхности типа @b(<surfaces>),
находящиеся в контейненре @b(container).

 Для поверхностей типа @b(<surfaces>) должны возвращаться кривые типа @b(<curve>),
находящиеся в контейненре @b(container)."))

(defgeneric coincident (object container)
  (:documentation "@b(Описание:) обобщенная функция @b(coincident) возвращает 
список объектов, имеющих с объектом @b(object) совпадающие точки.
 
 Для кривых @b(<curve>) должны возвращаться объекты типа @b(<point>),
находящиеся в контейненре @b(container).

 Для точек @b(<point>) должны возвращаться кривые типа @b(<curve>),
находящиеся в контейненре @b(container)."))

(defgeneric find-point-by-name (name container)
  (:documentation
   "@b(Описание:) обобщенная_функция @b(find-point-by-name) возвращает
    объект типа @b(<point>) из контейнера @b(container) по имени
    @(name)."))

(defgeneric find-curve-by-name (name container)
  (:documentation
   "@b(Описание:) обобщенная_функция @b(find-curve-by-name) возвращает
    объект типа @b(<curve>) из контейнера @b(container) по имени
    @(name)."))

(defgeneric find-surface-by-name (name container)
    (:documentation
   "@b(Описание:) обобщенная_функция @b(find-surface-by-name) возвращает
    объект типа @b(<surface>) из контейнера @b(container) по имени
    @(name)."))
