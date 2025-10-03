;;;; ./src/cfx/pre/test.lisp

(in-package :mnas-ansys/cfx/pre)

(defmethod select-3d-regions-by-mesh-name (mesh-name (simulation <simulation>))
  "@b(Описание:) метод @b(select-3d-regions-by-mesh-name) возвращает
список 3d-регионов по имени сетки.

 @b(Пример использования:)
@begin[lang=lisp](code)
  (select-3d-regions-by-mesh-name \"G1\" *simulation*)
@end(code)"
  (sort
   (remove-if
    (complement (3d-region-with-mesh-name mesh-name))
    (ht-values (<simulation>-3d-regions simulation)))
    #'<
   :key #'<3d-region>-3d-suffix))

(defmethod select-3d-regions-name-by-mesh-name (mesh-name (simulation <simulation>))
  "@b(Описание:) метод @b(select-3d-regions-by-mesh-name) возвращает
список имен 3d-регионов по имени сетки.

 @b(Пример использования:)
@begin[lang=lisp](code)
  (select-3d-regions-name-by-mesh-name \"G1\" *simulation*)
@end(code)"  
  (mapcar #'name
          (select-3d-regions-by-mesh-name mesh-name simulation)))

(defmethod select-3d-regions-fluid ((simulation <simulation>))
  "@b(Описание:) метод @b(select-3d-regions-fluid) возвращает
список флюидовых 3d-регионов симуляции @b(simulation).

 @b(Пример использования:)
@begin[lang=lisp](code)
  (select-3d-regions-fluid *simulation*)
@end(code)" 
  (remove-if-not
   #'(lambda (el)
       (uiop:string-prefix-p "DG" (name el)))
   (ht-values (<simulation>-3d-regions simulation))))


(defmethod select-3d-regions-solid ((simulation <simulation>))
  "@b(Описание:) метод @b(select-3d-regions-solid) возвращает
список солидовых 3d-регионов симуляции @b(simulation).

 @b(Пример использования:)
@begin[lang=lisp](code)
  (select-3d-regions-fluid *simulation*)
@end(code)" 
  (remove-if-not
   #'(lambda (el)
       (uiop:string-prefix-p "DM" (name el)))
   (ht-values (<simulation>-3d-regions simulation))))

(defmethod simulation-fluid-domain-location ((simulation <simulation>))
  "@b(Описание:) метод @b(simulation-fluid-domain-location) возвращает
строку, представляющую список 3d-регионов составляющих флюидовый домен
симуляции @b(simulation).

 @b(Пример использования:)
@begin[lang=lisp](code)
  (simulation-fluid-domain-location *simulation*)
@end(code)"
  (format nil "~{~A~^,~}"
          (sort (mapcar #'name (select-3d-regions-fluid simulation))
                #'string<)))

(defmethod simulation-solid-domain-mesh-location (mesh-name (simulation <simulation>))
  "@b(Описание:) метод @b(simulation-solid-domain-mesh-location) возвращает
строку, представляющую список 3d-регионов составляющих солидовый домен
с именем сети @b(mesh-name) симуляции @b(simulation).

 @b(Пример использования:)
@begin[lang=lisp](code)
  (simulation-solid-domain-mesh-location \"M1\" *simulation*)
@end(code)" 
  (format nil "~{~A~^,~}"
          (select-3d-regions-name-by-mesh-name mesh-name simulation)))

(defmethod select-2d-region-keys (regexp (obj null)) nil)

(defmethod select-2d-region-values (regexp (obj null)) nil)

(defmethod select-2d-region-values (regexp (3d-region <3d-region>))
  "@b(Описание:) метод @b(select-2d-regions) возвращает список значений
2d-регионов для 3d-региона @b(3d-region), соответствующих регулярном
выражению @b(regexp).

 @b(Пример использования:)
@begin[lang=lisp](code)
 ;; Пример для поиска всех флюидовых 2d-регионов, используемых как
 ;; интерфейс.
 (select-2d-regions \"C G1 G2.*\" (3d-region \"DG1 G1 1\" *simulation*))
@end(code)"
  (remove-if-not
   #'(lambda (el)
       (ppcre:scan regexp el))
   (2d-region-values 3d-region)))

(defmethod select-2d-region-keys (regexp (3d-region <3d-region>))
  "@b(Описание:) метод @b(select-2d-region-keys) возвращает список ключей
2d-регионов для 3d-региона @b(3d-region), соответствующих регулярном
выражению @b(regexp).

 @b(Пример использования:)
@begin[lang=lisp](code)
 ;; Пример для поиска всех флюидовых 2d-регионов, используемых как
 ;; интерфейс.
 (select-2d-region-keys \"C/G1-G2.*\" (3d-region \"DG1 G1 1\" *simulation*))
@end(code)"
  (remove-if-not
   #'(lambda (el)
       (ppcre:scan regexp el))
   (2d-region-keys 3d-region)))

(defmethod select-2d-region-values (regexp (simulation <simulation>))
  "@b(Описание:) метод @b(select-2d-region-values) возвращает список
2d-регионов для симуляции @b(simulation), соответствующих регулярном
выражению @b(regexp).

 @b(Пример использования:)
@begin[lang=lisp](code)
 ;; Пример для поиска всех флюидовых 2d-регионов используемых для
 ;; задания граничных условий
 (select-2d-region-values \"DG[0-9]* B[0-9]* .*\" *simulation*)
 ;; Пример для поиска флюидовых 2d-регионов используемых для
 ;; задания конкретного граничного условия
 (select-2d-region-values \"DG[0-9]* B[0-9]* AIR_IN .*\" *simulation*)
@end(code)"
  (remove-if-not
   #'(lambda (el)
       (ppcre:scan regexp el))
   (2d-region-values simulation)))

