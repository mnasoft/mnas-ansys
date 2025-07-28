;;;; ./src/cfx/pre/method.lisp

(in-package :mnas-ansys/cfx/pre)

(defun underscore-name-by-pathname (pathname)
  "@b(Описание:) функция @b(underscore-name-by-pathname) выделяет из пути
@b(pathname) последнюю часть имени перед которой стоит знак подчерка.

 @b(Пример использования:)
@begin[lang=lisp](code)
  (underscore-name-by-pathname #P\"z:/ANSYS/CFX/a32/tin/DOM/G5/A32_prj_06_DG10.tin\") => \"DG10\"
@end(code)"
  (first 
   (nreverse
    (ppcre:split "_" (pathname-name pathname)))))

(defun domain-name-by-pathname (pathname)
  "@b(Описание:) функция @b(domain-name-by-pathname) возвращает имя
домена основываясь на имени tin-файла.

 @b(Пример использования:)
@begin[lang=lisp](code)
 (domain-name-by-pathname #P\"z:/ANSYS/CFX/a32/tin/DOM/G5/A32_prj_06_DG10.tin\") => \"G10\"
@end(code)"
  (tail-of-string
   (underscore-name-by-pathname pathname)))

(defun mesh-name->domain-name (mesh-name)
  "@b(Описание:) функция @b(mesh-name->domain-name) возвращает имя домена
на основании имени сетки.
 
 @b(Пример использования:)
@begin[lang=lisp](code)
 (mesh-name->domain-name \"G1\") => \"DG1 G1\"
@end(code)"
  (concatenate 'string "D" mesh-name " " mesh-name))

(defun domain-name->mesh-name (domain-name)
  "@b(Описание:) функция @b(domain-name->mesh-name) возвращает имя сетки
на основании имени домена.
 
 @b(Пример использования:)
@begin[lang=lisp](code)
 (domain-name->mesh-name \"DG1 G1\") => \"G1\"
@end(code)"
  (second (ppcre:split " " domain-name)))

(defmethod next-domain-name ((mesh-name string) (cfx-domains <simulation>))
  "@b(Описание:) метод @b(next-domain-name) возвращает следующее
доступное имя для домена при вставке сетки в симуляцию CFX.
"
  (when (gethash mesh-name (<meshes>-meshes cfx-domains))
    (let ((d-name (mesh-name->domain-name mesh-name)))
      (if (gethash d-name (<simulation>-domains cfx-domains))
          (loop :for i :from 2 
                :do
                   (unless (gethash (format nil "~A ~D" d-name i)
                                    (<simulation>-domains cfx-domains))
                     (return-from next-domain-name (format nil "~A ~D" d-name i))))
          d-name))))

(defun name-icem->cfx (name)
  (ppcre:regex-replace-all "[/-]" name " "))


(defmethod next-surface-name ((mesh-name string) (cfx-domains <simulation>))
  (let ((surface-name (name-icem->cfx mesh-name)))
    (if (gethash surface-name (<simulation>-surfaces cfx-domains))
          (loop :for i :from 2 
                :do
                   (unless (gethash (format nil "~A ~D" surface-name i)
                                    (<simulation>-surfaces cfx-domains))
                     (return-from next-surface-name (format nil "~A ~D" surface-name i))))
          surface-name)))

(defun check-equality (variable string)
  (equalp 
   (sort (ppcre:split "," variable) #'string<)
   (sort
    (alexandria:hash-table-values
     (<domain>-surfaсes
      (gethash string
               (<simulation>-domains *simulation*))))
    #'string<)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defmethod suffix (mesh-surface-name (domain <domain>))
  "Возвращает строку, которая представляет суффикс. Он добавляется к
имени преобразованному из именного соглашения ICEM в именное
соглашение CFX.

 @b(Пример использования:)
@begin[lang=lisp](code)
 (suffix \"C/G1-G2/X_049.5/D_1.0\" (domain \"DG2 G2\" *simulation*))
@end(code)"
  (extract-suffix (name-icem->cfx  mesh-surface-name)
                  (gethash mesh-surface-name (<domain>-surfaсes domain))))

(defmethod suffix (mesh-surface-name (simulation <simulation>))
  "Возвращает список суффиксов для поверхности и с менем @b(mesh-surface-name),
представленном в именном соглашении ICEM, для симуляции @b(simulation).

 @b(Пример использования:)
@begin[lang=lisp](code)
 (suffix \"C/G1-G2/X_075.0/PPR_D_0.0\" *simulation*)
@end(code)
"
  (loop :for d :in (domains simulation)
        :when (suffix mesh-surface-name (domain d simulation)) 
          :collect :it))
