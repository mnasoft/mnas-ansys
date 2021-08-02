;;;; mnas-icem.asd

(asdf:defsystem "mnas-icem"
  :description
  " Система @b(mnas-icem) предназначена для выполнения операций с
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
  :version "0.0.7"
  :serial nil
  :depends-on ("mnas-string"
               "mnas-hash-table"
               "mnas-package/sys"
               "mnas-icem/read"
               "mnas-icem/core"
               "mnas-icem/utils"

               "mnas-icem/ccl"
               ))

(asdf:defsystem "mnas-icem/read"
  :description
  "Подсистема @(mnas-icem/read) определяет вспомогательные функции для парсинга tin-файла."
  :author "Nick Matvyeyev <mnasoft@gmail.com>"
  :license  "GNU GENERAL PUBLIC LICENSE Version 3, 29 June 2007 or later" 
  :serial nil
  :depends-on ("mnas-string" "mnas-package/sys")
  :components ((:module "src/read" 
                :serial nil
                :components
                ((:file "read")))))

(asdf:defsystem "mnas-icem/core"
  :description "Подсистема @(mnas-icem/core) определяет базовые
  функции и методы работы с геометрией <tin>-объекта."
  :author "Nick Matvyeyev <mnasoft@gmail.com>"
  :license  "GNU GENERAL PUBLIC LICENSE Version 3, 29 June 2007 or later" 
  :serial nil
  :depends-on ("mnas-string" "mnas-package/sys" "mnas-icem/read")
  :components ((:module "src/core" 
                :serial nil
                :components
                ((:file "core")
                 ))))

(asdf:defsystem "mnas-icem/select"
  :description
  "Система @(mnas-icem/select) определяет функции для выбора объектов из контейнера геометрии."
  :author "Nick Matvyeyev <mnasoft@gmail.com>"
  :license  "GNU GENERAL PUBLIC LICENSE Version 3, 29 June 2007 or later" 
  :serial nil
  :depends-on ("mnas-string" "mnas-package/sys" "mnas-icem/core")
  :components ((:module "src/select" 
                :serial nil
                :components
                ((:file "select")))))

(asdf:defsystem "mnas-icem/utils"
  :description
  "Система @(mnas-icem/utils) определяет пользовательские функции для
   взаимодействия с контейнером геометрии (tin-файлом)."
  :author "Nick Matvyeyev <mnasoft@gmail.com>"
  :license  "GNU GENERAL PUBLIC LICENSE Version 3, 29 June 2007 or later" 
  :serial nil
  :depends-on ("mnas-icem/core"
               "mnas-icem/select"
               "math/geom")
  :components ((:module "src/utils" 
                :serial nil
                :components
                ((:file "utils")))))

(asdf:defsystem "mnas-icem/clim"
  :description
  "Система @(mnas-icem/clim) определяет функции дотупные в диалоговом
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

(defsystem "mnas-icem/docs"
  :description "Зависимости для сборки документации к проекту mnas-icem"
  :author "Nick Matvyeyev <mnasoft@gmail.com>"
  :license "GNU GENERAL PUBLIC LICENSE Version 3, 29 June 2007 or later"
  :depends-on ("codex" "inferior-shell" "mnas-package" "mnas-icem")
  :components ((:module "src/docs"
		:serial nil
                :components ((:file "docs"))))
  :depends-on ("mnas-package" "codex"))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(asdf:defsystem "mnas-icem/ccl"
  :description
  "Система @b(mnas-icem/ccl) функции для извлечения и преобразования данных в формате CCL ANSYS CFX."
  :author "Nick Matvyeyev <mnasoft@gmail.com>"
  :license  "GNU GENERAL PUBLIC LICENSE Version 3, 29 June 2007 or later" 
  :serial nil
  :depends-on ("mnas-icem/ccl-parse")
  :components ((:module "src/ccl" 
                :serial nil
                :components
                ((:file "ccl")))))

(asdf:defsystem "mnas-icem/ccl-parse"
  :description
  "Система @b(mnas-icem/ccl-parse) определяет функции для разбора CCL формата ANSYS CFX."
  :author "Nick Matvyeyev <mnasoft@gmail.com>"
  :license  "GNU GENERAL PUBLIC LICENSE Version 3, 29 June 2007 or later" 
  :serial nil
  ;; :depends-on ()
  :components ((:module "src/ccl/parse" 
                :serial nil
                :components
                ((:file "ccl-parse")))))
