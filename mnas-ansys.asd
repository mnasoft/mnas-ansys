;;;; mnas-ansys.asd

(defsystem "mnas-ansys"
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
  :author "Mykola Matvyeyev <mnasoft@gmail.com>"
  :license  "GNU GENERAL PUBLIC LICENSE Version 3, 29 June 2007 or later" 
  :version "0.0.15"
  :serial nil
  :depends-on ("mnas-string"
               "mnas-hash-table"
               "mnas-package/sys"
               "mnas-ansys/tin"
               "mnas-ansys/ccl"
               "mnas-ansys/belt"
               "mnas-ansys/dia"
               "mnas-ansys/ic")
  :components ((:module "src" 
                :serial nil
                :components
                ((:file "mnas-ansys")))))

(defsystem "mnas-ansys/tin/read"
  :description
  "Подсистема @(mnas-ansys/tin/read) определяет вспомогательные функции для парсинга tin-файла."
  :author "Mykola Matvyeyev <mnasoft@gmail.com>"
  :license  "GNU GENERAL PUBLIC LICENSE Version 3, 29 June 2007 or later" 
  :serial nil
  :depends-on ("mnas-string" "mnas-package/sys")
  :components ((:module "src/tin/read" 
                :serial nil
                :components
                ((:file "read")))))

(defsystem "mnas-ansys/tin"
  :description "Подсистема @(mnas-ansys/tin) определяет базовые
  функции и методы работы с геометрией <tin>-объекта."
  :author "Mykola Matvyeyev <mnasoft@gmail.com>"
  :license "GNU GENERAL PUBLIC LICENSE Version 3, 29 June 2007 or later" 
  :serial nil
  :depends-on ("mnas-ansys/tin/core" "mnas-ansys/tin/utils"))

(defsystem "mnas-ansys/tin/core"
  :description "Подсистема @(mnas-ansys/tin) определяет базовые
  функции и методы работы с геометрией <tin>-объекта."
  :author "Mykola Matvyeyev <mnasoft@gmail.com>"
  :license "GNU GENERAL PUBLIC LICENSE Version 3, 29 June 2007 or later" 
  :serial nil
  :depends-on ("mnas-string"
               "mnas-package/sys"
               "mnas-ansys/tin/read")
  :components ((:module "src/tin/core" 
                :serial nil
                :components
                ((:file "core")))))

(defsystem "mnas-ansys/tin/select"
  :description
  "Система @(mnas-ansys/tin/select) определяет функции для выбора объектов из контейнера геометрии."
  :author "Mykola Matvyeyev <mnasoft@gmail.com>"
  :license  "GNU GENERAL PUBLIC LICENSE Version 3, 29 June 2007 or later" 
  :serial nil
  :depends-on ("mnas-string" "mnas-package/sys" "mnas-ansys/tin/core" "mnas-ansys/ic/geo")
  :components ((:module "src/tin/select" 
                :serial nil
                :components
                ((:file "select")))))

(defsystem "mnas-ansys/tin/utils"
  :description
  "Система @(mnas-ansys/tin/utils) определяет пользовательские функции для
   взаимодействия с контейнером геометрии (tin-файлом)."
  :author "Mykola Matvyeyev <mnasoft@gmail.com>"
  :license  "GNU GENERAL PUBLIC LICENSE Version 3, 29 June 2007 or later" 
  :serial nil
  :depends-on ("mnas-ansys/tin/core"
               "mnas-ansys/tin/select"
               "math/geom")
  :components ((:module "src/tin/utils" 
                :serial nil
                :components
                ((:file "utils")))))

(defsystem "mnas-ansys/clim"
  :description
  "Система @(mnas-ansys/clim) определяет функции дотупные в диалоговом
   режиме для взаимодействия пользователя с контейнером геометрии (tin-файлом)."
  :author "Mykola Matvyeyev <mnasoft@gmail.com>"
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
  :author "Mykola Matvyeyev <mnasoft@gmail.com>"
  :license "GNU GENERAL PUBLIC LICENSE Version 3, 29 June 2007 or later"
  :depends-on ("codex" "inferior-shell" "mnas-package" "mnas-ansys")
  :components ((:module "src/docs"
		:serial nil
                :components ((:file "docs"))))
  :depends-on ("mnas-package" "codex"))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defsystem "mnas-ansys/ccl"
  :description
  "Система @b(mnas-ansys/ccl) функции для извлечения и преобразования данных в формате CCL ANSYS CFX."
  :author "Mykola Matvyeyev <mnasoft@gmail.com>"
  :license  "GNU GENERAL PUBLIC LICENSE Version 3, 29 June 2007 or later" 
  :serial nil
  :depends-on ("mnas-ansys/tin/read"
               "mnas-ansys/ccl/parse"
               "mnas-ansys/ccl/classes"
               )
  :components ((:module "src/ccl" 
                :serial nil
                :components
                ((:file "ccl")))))

(defsystem "mnas-ansys/ccl/classes"
  :description
  "Система @b(mnas-ansys/ccl/classes) определяет классы, представляющие
   некоторые объекты язка CCL системы ANSYS."
  :author "Mykola Matvyeyev <mnasoft@gmail.com>"
  :license  "GNU GENERAL PUBLIC LICENSE Version 3, 29 June 2007 or later" 
  :serial nil
  ;; :depends-on ()
  :components ((:module "src/ccl/core"
                :serial nil
                :components
                ((:file "core")))))

(defsystem "mnas-ansys/ccl/parse"
  :description
  "Система @b(mnas-ansys/ccl/parse) определяет функции для разбора CCL формата ANSYS CFX."
  :author "Mykola Matvyeyev <mnasoft@gmail.com>"
  :license  "GNU GENERAL PUBLIC LICENSE Version 3, 29 June 2007 or later" 
  :serial nil
  ;; :depends-on ()
  :components ((:module "src/ccl/parse" 
                :serial nil
                :components
                ((:file "ccl-parse")))))

(defsystem "mnas-ansys/belt"
  :description
  "Система @b(mnas-ansys/belt) определяет функции для генерирования
 поверхностей в системе ANSYS CFX при помощи языка CCL."
  :author "Mykola Matvyeyev <mnasoft@gmail.com>"
  :license  "GNU GENERAL PUBLIC LICENSE Version 3, 29 June 2007 or later" 
  :serial nil
  :depends-on ("mnas-string/translit" "math/coord")
  :components ((:module "src/ccl/belt" 
                :serial nil
                :components
                ((:file "belt")
                 (:file "contour")))))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defsystem "mnas-ansys/ic"
  :description
  "Подсистема @(mnas-ansys/ic)."
  :author "Mykola Matvyeyev <mnasoft@gmail.com>"
  :license  "GNU GENERAL PUBLIC LICENSE Version 3, 29 June 2007 or later" 
  :serial nil
  :depends-on ("mnas-ansys/ic/geo"
               "mnas-ansys/ic/trans"
               "mnas-ansys/ic/boco"
               "mnas-ansys/ic/dis"
               "mnas-ansys/ic/util"))

(defsystem "mnas-ansys/ic/geo"
  :description
  "Подсистема @(mnas-ansys/ic/geo)."
  :author "Mykola Matvyeyev <mnasoft@gmail.com>"
  :license  "GNU GENERAL PUBLIC LICENSE Version 3, 29 June 2007 or later" 
  :serial nil
  :depends-on ("mnas-ansys/ic/util")
  :components ((:module "src/ic/geo"   :serial nil :components ((:file "geo")))))

(defsystem "mnas-ansys/ic/util"
  :description
  "Подсистема @(mnas-ansys/ic/util)."
  :author "Mykola Matvyeyev <mnasoft@gmail.com>"
  :license  "GNU GENERAL PUBLIC LICENSE Version 3, 29 June 2007 or later" 
  :serial nil
  :components ((:module "src/ic/util" :serial nil :components ((:file "util")))))


(defsystem "mnas-ansys/ic/trans"
  :description
  "Подсистема @(mnas-ansys/ic/trans)."
  :author "Mykola Matvyeyev <mnasoft@gmail.com>"
  :license  "GNU GENERAL PUBLIC LICENSE Version 3, 29 June 2007 or later" 
  :serial nil
  :components ((:module "src/ic/trans" :serial nil :components ((:file "trans")))))

(defsystem "mnas-ansys/ic/boco"
  :description
  "Подсистема @(mnas-ansys/ic/boco)."
  :author "Mykola Matvyeyev <mnasoft@gmail.com>"
  :license  "GNU GENERAL PUBLIC LICENSE Version 3, 29 June 2007 or later" 
  :serial nil
  :components ((:module "src/ic/boco"  :serial nil :components ((:file "boco")))))

(defsystem "mnas-ansys/ic/dis"
  :description
  "Подсистема @(mnas-ansys/ic/dis)."
  :author "Mykola Matvyeyev <mnasoft@gmail.com>"
  :license  "GNU GENERAL PUBLIC LICENSE Version 3, 29 June 2007 or later" 
  :serial nil
  :components ((:module "src/ic/dis"   :serial nil :components ((:file "dis")))))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(asdf:defsystem "mnas-ansys/dia"
  :description
  "Подсистема @(mnas-ansys/dia) определяет функции, выполняющиеся при
помощи диалога выбора файла."
  :author "Mykola Matvyeyev <mnasoft@gmail.com>"
  :license  "GNU GENERAL PUBLIC LICENSE Version 3, 29 June 2007 or later" 
  :serial nil
  :depends-on (#+nil "mnas-ansys/tin/read"
               "mnas-file-dialog"
               "mnas-hash-table"
               "mnas-ansys/tin"
               "mnas-ansys/ic/geo"
               #+nil "mnas-ansys/tin/utils"
               #+nil "mnas-ansys/ccl"
               #+nil "mnas-ansys/belt")
  :components ((:module "src/dia"
                :serial nil
                :components
                ((:file "dia")))))
