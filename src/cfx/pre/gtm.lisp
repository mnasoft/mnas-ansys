;;;; ./src/cfx/pre/gtm.lisp

(in-package :mnas-ansys/cfx/pre)

(defun gtmImport (filename
                  &key
                    (type "Generic")
                    (units "mm")
                    (genOpt "-n")
                    (nameStrategy "Assembly"))
  "@b(Описание:) функция @b(gtmImport) осуществляет импорт фала 3d-сетки
ICEM в файл CFX.

 @b(Пример использования:)
@begin[lang=lisp](code)
 (gtmImport \"D:\\\\home\\\\_namatv\\\\CFX\\\\a32\\\\msh\\\\prj_04\\\\A32_prj_04_DG1.msh\")
@end(code)

"
  (format t "> gtmImport filename=~A, type=~A, units=~A, genOpt= ~A, nameStrategy= ~A~%"
          filename
          type
          units
          genOpt
          nameStrategy))

(defun gtmAction-rename-Region (old-name  new-name)
  "@b(Описание:) функция @b(gtmAction-rename-Region) осуществляет
переименование 2d-региона (principal-2d-region)"
  (format t "> gtmAction op=renameRegion,~A,~A~%"
          old-name
          new-name))

(defun gtmTransform (3d-region)
  (format t "~A ~A~%" "> gtmTransform" 3d-region))
