;;;; ./src/cfx/pre/method/make.lisp

(in-package :mnas-ansys/cfx/pre)

(defun make-mesh (pathname)
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
  (let* ((domain (make-instance '<mesh>))
        (tin (mnas-ansys/tin:open-tin-file pathname)))
    (setf (<mesh>-name domain)
          (domain-name-by-pathname pathname))
    (map 'nil
         #'(lambda (el)
             (setf
              (gethash el (<mesh>-2d-regions domain))
              el))
         (remove-duplicates 
          (loop :for sur
                  :in (alexandria:hash-table-values
                       (mnas-ansys/tin:<tin>-surfaces tin))
                :collect 
                (mnas-ansys/tin:<ent>-family sur))
          :test #'equal))
    domain))

(defun make-meshes (directory-template)
    "@b(Описание:) функция @b(make-meshes) возвращает объект класса
@b(<meshes>). Объект наполняется 3d-сетками ICEM.
 
 @b(Переменые:)
@begin(list)
@item(directory-template - задает шаблон для поиска файлов геометрии
     ICEM (tin-файлов).)
@end(list)

 @b(Пример использования:)
@begin[lang=lisp](code)
 (make-meshes \"z:/ANSYS/CFX/a32/tin/DOM/*/A32_prj_06_*.tin\")
@end(code)
"

  (let ((meshes (make-instance '<meshes>)))
    (loop :for d :in (directory directory-template)
          :do (add (make-mesh d) meshes))
    meshes))

(defun make-simulation (directory-template)
  "@b(Описание:) функция @b(make-simulation) возвращает объект класса
@b(<simulation>). Объект наполняется 3d-сетками ICEM.
 
 @b(Переменые:)
@begin(list)
@item(directory-template - задает шаблон для поиска файлов геометрии
     ICEM (tin-файлов).)
@end(list)

 @b(Пример использования:)
@begin[lang=lisp](code)
 (make-simulation \"z:/ANSYS/CFX/a32/tin/DOM/*/A32_prj_06_*.tin\")
@end(code)
"
  (let ((simulation (make-instance '<simulation>)))
    (loop :for d :in (directory directory-template)
          :do (add (make-mesh d) simulation))
    simulation))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun make-corelation (domain-name result simulation)
  "
 @b(Пример использования:)
@begin[lang=lisp](code)
 (make-corelation \"DG2 G2\" *DG2-G2* *simulation*)
@end(code)
"
  (let ((dom-result (ppcre:split "," result)))
    (loop :for i :in (simulation-doman-surfaces domain-name simulation)
          :collect
          (list i
                (extract-suffix i (first (filter-by-prefix i dom-result)))
                (mapcar
                 #'(lambda (el) (extract-suffix i el))
                 (filter-by-prefix i (surfaces simulation)))))))

(defun make-corelation-0 (domain-name result simulation)
  "
 @b(Пример использования:)
@begin[lang=lisp](code)
 (make-corelation-0 \"DG2 G2\" *DG2-G2* *simulation*)
@end(code)
"
  (let ((dom-result (ppcre:split "," result)))
    (loop :for i :in (simulation-doman-surfaces domain-name simulation)
          :collect
          (list i
                (first (filter-by-prefix i dom-result))
                (filter-by-prefix i (surfaces simulation))))))
