;;;; ./src/cfx/pre/test.lisp

(in-package :mnas-ansys/cfx/pre)

(defmethod initialize-instance :after ((obj <mesh>) &key)
  "@b(Описание:) функция @b(make-mesh) возвращает объект класса
@b(<mesh>).

 @b(Переменые:)
@begin(list)
@item(pathname - задает путь к файлу геометрии ICEM (tin-файл).)
@end(list)

 @b(Пример использования:)
@begin[lang=lisp](code)
 (make-mesh \"z:/ANSYS/CFX/a32/tin/DOM/G1/A32_prj_06_DG1.tin\")
@end(code)"
  (let ((tin
          (mnas-ansys/tin:open-tin-file
           (<mesh>-tin-pathname obj))))
    (block  2d-regions-populating
      (map 'nil
           #'(lambda (el)
               (setf (gethash el (<mesh>-2d-regions obj)) ;; (2d-region el obj)
                     (name-icem->cfx el)))
           (remove-duplicates 
            (loop :for sur
                    :in (alexandria:hash-table-values
                         (mnas-ansys/tin:<tin>-surfaces tin))
                  :collect 
                  (mnas-ansys/tin:<ent>-family sur))
            :test #'equal)))
    (setf (<mesh>-name obj)
          (subseq (second
                   (nreverse
                    (ppcre:split "[_.]"
                                 (namestring
                                  (<mesh>-tin-pathname obj)))))
                  1))))



