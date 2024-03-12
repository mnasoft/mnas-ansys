(in-package :mnas-ansys/exchange)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun average-value-h-d (regexp h-d)
  "@b(Описание:) функция @b(average-value-h-d) возвращает 2d-list, каждым
элементом которого является список у которого:
@begin(list)
 @item(первым элементом является заголовок;)
 @item(вторым элементом является среднее значение;)
@end(list)

 @b(Пример использования:)
@begin[lang=lisp](code)
  (average-value-h-d \"USER POINT,.*MFR.*\" (foo-data *foo*) )
  =>
  ((\"USER POINT,MFR G1 G1 LR Side 1\" 1.0441316)
   (\"USER POINT,MFR G1 G2 X_049i5 Side 1\" -0.022962399)
   (\"USER POINT,MFR G1 G2 X_067i8 Side 1\" -0.042467475))
@end(code)
"
  (let ((d (cdr h-d)))
    (loop :for (i name) :in (setect-matches regexp h-d)
          :collect
          (list name
                (math/stat:average-value
                 (loop :for val :in d :collect (svref val i)))))))

(defun extract-average-value (regexp h-d)
  "@b(Описание:) функция @b(extract-average-value) выводит по столбцам в
org-формате таблицу, содержащую заголовки и средние значения. Таблица
имеет две строки и несколько столбцов.
"
  (let ((rez (average-value-h-d regexp h-d)))
    (format t "~{| ~{ ~A~^ | ~}~%~} " (math/matr:transpose rez))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

