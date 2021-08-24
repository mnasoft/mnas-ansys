;;;; mnas-ansys.asd

(asdf:defsystem "mnas-ansys"
  :description
  " Система @b(mnas-ansys) предназначена для выполнения операций с
 представлением геометрии tin-файлов системы ANSYS ICEM.

@begin(section) @title(Мотивация)

 ANSYS ICEM - великолепная система, которая позволяет выполнять
генерирование сетки для передачи ее в систему подготовки расчета ANSYS
CFX-PRE.

 Одним из ее недостатков является сложность выделения отдельных частей
элементов геометрии, носящая рутинный характер.

 Данный проект пытается облегчить выделение геометрии для отнесения ее
к различным частям.

@end(section)
"
  :author "Nick Matvyeyev <mnasoft@gmail.com>"
  :license  "GNU GENERAL PUBLIC LICENSE Version 3, 29 June 2007 or later" 
  :version "0.0.8"
  :serial nil
  :depends-on ("mnas-string"
               "mnas-hash-table"
               "mnas-package/sys"
               "mnas-ansys/read"
               "mnas-ansys/core"
               "mnas-ansys/utils"
               "mnas-ansys/ccl"
               "mnas-ansys/belt"
               ))

(asdf:defsystem "mnas-ansys/read"
  :description
  "Подсистема @(mnas-ansys/read) определяет вспомогательные функции для парсинга tin-файла."
  :author "Nick Matvyeyev <mnasoft@gmail.com>"
  :license  "GNU GENERAL PUBLIC LICENSE Version 3, 29 June 2007 or later" 
  :serial nil
  :depends-on ("mnas-string" "mnas-package/sys")
  :components ((:module "src/read" 
                :serial nil
                :components
                ((:file "read")))))

(asdf:defsystem "mnas-ansys/core"
  :description "Подсистема @(mnas-ansys/core) определяет базовые
  функции и методы работы с геометрией <tin>-объекта."
  :author "Nick Matvyeyev <mnasoft@gmail.com>"
  :license  "GNU GENERAL PUBLIC LICENSE Version 3, 29 June 2007 or later" 
  :serial nil
  :depends-on ("mnas-string" "mnas-package/sys" "mnas-ansys/read")
  :components ((:module "src/core" 
                :serial nil
                :components
                ((:file "core")
                 ))))

(asdf:defsystem "mnas-ansys/select"
  :description
  "Система @(mnas-ansys/select) определяет функции для выбора объектов из контейнера геометрии."
  :author "Nick Matvyeyev <mnasoft@gmail.com>"
  :license  "GNU GENERAL PUBLIC LICENSE Version 3, 29 June 2007 or later" 
  :serial nil
  :depends-on ("mnas-string" "mnas-package/sys" "mnas-ansys/core")
  :components ((:module "src/select" 
                :serial nil
                :components
                ((:file "select")))))

(asdf:defsystem "mnas-ansys/utils"
  :description
  "Система @(mnas-ansys/utils) определяет пользовательские функции для
   взаимодействия с контейнером геометрии (tin-файлом)."
  :author "Nick Matvyeyev <mnasoft@gmail.com>"
  :license  "GNU GENERAL PUBLIC LICENSE Version 3, 29 June 2007 or later" 
  :serial nil
  :depends-on ("mnas-ansys/core"
               "mnas-ansys/select"
               "math/geom")
  :components ((:module "src/utils" 
                :serial nil
                :components
                ((:file "utils")))))

(asdf:defsystem "mnas-ansys/clim"
  :description
  "Система @(mnas-ansys/clim) определяет функции дотупные в диалоговом
   режиме для взаимодействия пользователя с контейнером геометрии (tin-файлом)."
  :author "Nick Matvyeyev <mnasoft@gmail.com>"
  :license  "GNU GENERAL PUBLIC LICENSE Version 3, 29 June 2007 or later" 
  :serial nil
  :depends-on ("src/utils"
               "clim-lisp"
               "alexandria")
  :components ((:module "src/clim" 
                :serial nil
                :components
                ((:file "clim")))))

(defsystem "mnas-ansys/docs"
  :description "Зависимости для сборки документации к проекту mnas-ansys"
  :author "Nick Matvyeyev <mnasoft@gmail.com>"
  :license "GNU GENERAL PUBLIC LICENSE Version 3, 29 June 2007 or later"
  :depends-on ("codex" "inferior-shell" "mnas-package" "mnas-ansys")
  :components ((:module "src/docs"
		:serial nil
                :components ((:file "docs"))))
  :depends-on ("mnas-package" "codex"))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(asdf:defsystem "mnas-ansys/ccl"
  :description
  "Система @b(mnas-ansys/ccl) функции для извлечения и преобразования данных в формате CCL ANSYS CFX."
  :author "Nick Matvyeyev <mnasoft@gmail.com>"
  :license  "GNU GENERAL PUBLIC LICENSE Version 3, 29 June 2007 or later" 
  :serial nil
  :depends-on ("mnas-ansys/ccl-parse")
  :components ((:module "src/ccl" 
                :serial nil
                :components
                ((:file "ccl")))))

(asdf:defsystem "mnas-ansys/ccl-parse"
  :description
  "Система @b(mnas-ansys/ccl-parse) определяет функции для разбора CCL формата ANSYS CFX."
  :author "Nick Matvyeyev <mnasoft@gmail.com>"
  :license  "GNU GENERAL PUBLIC LICENSE Version 3, 29 June 2007 or later" 
  :serial nil
  ;; :depends-on ()
  :components ((:module "src/ccl/parse" 
                :serial nil
                :components
                ((:file "ccl-parse")))))

(asdf:defsystem "mnas-ansys/belt"
  :description
  "Система @b(mnas-ansys/belt) определяет функции для генерирования
 поверхностей в системе ANSYS CFX при помощи языка CCL."
  :author "Nick Matvyeyev <mnasoft@gmail.com>"
  :license  "GNU GENERAL PUBLIC LICENSE Version 3, 29 June 2007 or later" 
  :serial nil
  :depends-on ("mnas-string/translit" "math/coord")
  :components ((:module "src/ccl/belt" 
                :serial nil
                :components
                ((:file "belt")
                 (:file "contour")))))
