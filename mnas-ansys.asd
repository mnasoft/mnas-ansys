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
  :version "0.0.23"
  :serial nil
  :depends-on ("mnas-string"
               "mnas-hash-table"
               "mnas-package/sys"
               "mnas-ansys/tin"
               "mnas-ansys/ccl"
               "mnas-ansys/belt"
               "mnas-ansys/exchange"
               "mnas-ansys/dia"
               "mnas-ansys/ic"
               "mnas-ansys/cfx/pre"
               "mnas-ansys/cfx/solver"
               "mnas-ansys/cfx/file"
               "mnas-ansys/cfx/post")
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
  :depends-on ("mnas-string" "mnas-package/sys" "mnas-ansys/tin/read")
  :components ((:module "src/tin"
                :serial nil
                :components ((:file "package")))
               (:module "src/tin/src"
                :serial nil
                :depends-on ("src/tin")
                :serial nil
                :components
                ((:file "classes")
                 (:file "parameters" :depends-on ("classes"))
                 (:file "generics")))
               (:module "src/tin/src/methods"
                :serial nil
                :depends-on ("src/tin/src")
                :components
                ((:file "object-tag")
                 (:file "coedged")
                 (:file "coincident")
                 (:file "print-object")
                 (:file "read-object")
                 (:file "methods")))
               (:module "src/tin/src/open"
                :serial nil
                :depends-on ("src/tin/src/methods")
                :components
                ((:file "open")))))
                   
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
                ((:file "belt")))))

(defsystem "mnas-ansys/contour"
  :description
  "Система @b(mnas-ansys/belt) определяет функции для генерирования
 поверхностей в системе ANSYS CFX при помощи языка CCL."
  :author "Mykola Matvyeyev <mnasoft@gmail.com>"
  :license  "GNU GENERAL PUBLIC LICENSE Version 3, 29 June 2007 or later" 
  :serial nil
  :depends-on ("mnas-string/translit" "math/coord")
  :components ((:module "src/ccl/contour" 
                :serial nil
                :components
                ((:file "contour")))))
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
               "mnas-ansys/ic/util")
  :components ((:module "src/ic"   :serial nil :components ((:file "ic"))))
  )

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

(defsystem "mnas-ansys/dia"
  :description
  "Подсистема @(mnas-ansys/dia) определяет функции, выполняющиеся при
помощи диалога выбора файла."
  :author "Mykola Matvyeyev <mnasoft@gmail.com>"
  :license  "GNU GENERAL PUBLIC LICENSE Version 3, 29 June 2007 or later" 
  :serial nil
  :depends-on (#+nil "mnas-ansys/tin/read"
               "cl-fad"
               "mnas-file-dialog"
               "mnas-hash-table"
               "mnas-ansys/tin"
               "mnas-ansys/ic/geo"
               "mnas-ansys/exchange"
               #+nil "mnas-ansys/tin/utils"
               #+nil "mnas-ansys/ccl"
               #+nil "mnas-ansys/belt")
  :components ((:module "src/dia"
                :serial nil
                :components
                ((:file "dia")))))

(defsystem "mnas-ansys/exchange"
  :description
  "Подсистема @(mnas-ansys/exchande) определяет функции, позволяющие
 извлечь информацию из файлов которые экспортирует Ansys."
  :author "Mykola Matvyeyev <mnasoft@gmail.com>"
  :license  "GNU GENERAL PUBLIC LICENSE Version 3, 29 June 2007 or later" 
  :serial nil
  :depends-on ("cl-fad"
               "mnas-string"
               "math/stat"
               "math/matr"
               "mnas-ansys/cfx/bin"
               "mnas-ansys/ccl/parse"
               )
  :components ((:module "src/exchange"
                :serial nil
                :components
                ((:file "exchange")))))

(defsystem "mnas-ansys/cfx/solver"
  :description
  "Подсистема @(mnas-ansys/cfx-solver) определяет функции, позволяющие
 определять время, затрачиваемое CFX-SOLVER на одну итерацию."
  :author "Mykola Matvyeyev <mnasoft@gmail.com>"
  :license  "GNU GENERAL PUBLIC LICENSE Version 3, 29 June 2007 or later" 
  :serial nil
;;;; :depends-on () 
  :components ((:module "src/cfx/solver"
                :serial nil
                :components
                ((:file "solver")))))

(defsystem "mnas-ansys/cfx/bin"
  :description
  "Подсистема @(mnas-ansys/cfx/bin) определяет функции, которые позволяют
определить версию ANSYS CFX и пути к её программам."
  :author "Mykola Matvyeyev <mnasoft@gmail.com>"
  :license  "GNU GENERAL PUBLIC LICENSE Version 3, 29 June 2007 or later" 
  :serial nil
  :depends-on ("cl-ppcre" "mnas-string") 
  :components ((:module "src/cfx/bin"
                :serial nil
                :components
                ((:file "bin")))))

(defsystem "mnas-ansys/cfx/post"
  :description "Подсистема @(mnas-ansys/cfx/post) определяет функции,
 позволяющие создавать сценарии для генерирования отчетов CFX-POST."  
  :author "Mykola Matvyeyev <mnasoft@gmail.com>"
  :license  "GNU GENERAL PUBLIC LICENSE Version 3, 29 June 2007 or later" 
  :serial nil
  :depends-on ("mnas-string"
               "mnas-path"
               "mnas-format"
               "recoder/get"
               "mnas-path"
               "mnas-ansys/ccl"
               "mnas-dim-value"
               "mnas-ansys/cfx/file") ;;"serializable-object" "mnas-ansys/cfx/bin" "mnas-org-mode" "mnas-ansys/exchange" )
  :components ((:module "src/cfx/post"
                :serial t
                :components ((:file "package")
                             (:file "class")
                             (:file "res-report")
                             (:module "method"
                              :serial t
                              :components ((:file "mfr-gt-tract")
                                           (:file "mfr-gt")
                                           (:file "tf-gt")))))))

(defsystem "mnas-ansys/cfx/pre"
  :description "Подсистема @(mnas-ansys/cfx/pre) определяет функции,
 позволяющие создавать команды, используемые в CFX-PRE."  
  :author "Mykola Matvyeyev <mnasoft@gmail.com>"
  :license  "GNU GENERAL PUBLIC LICENSE Version 3, 29 June 2007 or later" 
  :serial nil
  :depends-on ("mnas-ansys/ccl" "mnas-format" "math/matr" "mnas-ansys/tin") 
  :components ((:module "src/cfx/pre"
                :serial t
                :components ((:file "package")
                             (:file "ccl-functions")
                             (:file "gtm")
                             (:file "functions") 
                             (:file "class")
                             (:file "generic")
                             (:file "predicat")                             
                             (:file "method")
                             (:module "monitor-objects"
                              :serial t
                              :components ((:file "monitor-objects")))
                             (:module "./method"
                              :serial t
                              :components ((:file "print-object")
                                           (:file "mesh")
                                           (:file "add")
                                           (:file "initialize-instance")
                                           (:file "create-script")
                                           (:file "ht")
                                           (:file "reset")
                                           (:file "select")
                                           (:file "2d-region")
                                           (:file "3d-region")
                                           (:file "interface")
                                           (:file "interface-pairs")
                                           (:file "domain")
                                           ))
                             (:module "classes"
                              :serial t
                              :components ((:file "domain")
                                           (:file "library")
                                           (:file "initialisation")
                                           (:file "domain-interface")
                                           (:file "boundary")
                                           (:file "solver")))
                             (:file "test-data")))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defsystem "mnas-ansys/cfx/file/mon/core"
  :description
  "Подсистема @(mnas-ansys/cfx/file/mon/core) определяет вспомогательные
функции, обеспечивающие работу функций определяемых системой
:mnas-ansys/cfx/file/mon."
  :author "Mykola Matvyeyev <mnasoft@gmail.com>"
  :license  "GNU GENERAL PUBLIC LICENSE Version 3, 29 June 2007 or later" 
  :serial nil
  :depends-on ("mnas-string" "mnas-ansys/exchange")  
  :components ((:module "src/cfx/file/mon/core"
                :serial nil
                :components
                ((:file "core")))))

(defsystem "mnas-ansys/cfx/file/mon"
  :description
  "Подсистема @(mnas-ansys/cfx/file/mon) определяет класс монитора <mon>
и функции, обеспечивающие манипуляции с его слотами."
  :author "Mykola Matvyeyev <mnasoft@gmail.com>"
  :license  "GNU GENERAL PUBLIC LICENSE Version 3, 29 June 2007 or later" 
  :serial nil
  :depends-on ("mnas-ansys/cfx/file/mon/core")
  :components ((:module "src/cfx/file/mon"
                :serial nil
                :components
                ((:file "mon")))))

(defsystem "mnas-ansys/cfx/file"
  :description
  "Подсистема @(mnas-ansys/cfx/file) определяет функции, которые позволяют
осуществить извлечение информации из cfx, def и res файлов ANSYS CFX."
  :author "Mykola Matvyeyev <mnasoft@gmail.com>"
  :license  "GNU GENERAL PUBLIC LICENSE Version 3, 29 June 2007 or later" 
  :serial nil
  :depends-on ("serializable-object"
               "mnas-ansys/cfx/bin"
               "mnas-org-mode"
               "mnas-ansys/exchange"
               "mnas-ansys/cfx/file/mon"
               )
  :components ((:module "src/cfx/file"
                :serial nil
                :components
                ((:file "package")
                 (:file "file")))))

(defsystem "mnas-ansys/cfx/file/res-to-s-obj"
  :description
  "Подсистема @(mnas-ansys/cfx/file/res-to-s-obj) создает бинарный файл,
который по res-файлу создает s-obj-файл"
  :author "Mykola Matvyeyev <mnasoft@gmail.com>"
  :license  "GNU GENERAL PUBLIC LICENSE Version 3, 29 June 2007 or later"
  
  :defsystem-depends-on ("deploy")
  :build-operation "deploy-op"
  :build-pathname "res-to-s-obj"
  :entry-point "mnas-ansys/cfx/file/res-to-s-obj:prompt-read-line"

  :serial nil
  :depends-on ("mnas-ansys/cfx/file" "gsll")
  :components ((:module "src/cfx/file/res-to-s-obj"
                :serial nil
                :components
                ((:file "res-to-s-obj")))))

(defsystem "mnas-ansys/icem"
  :description
  "Подсистема @(mnas-ansys/icem) определяет функции для преобразования
uns-файлов icem в msh-файлы, предназначенные для импорта в другие
системы (fluent, cfx)."
  :author "Mykola Matvyeyev <mnasoft@gmail.com>"
  :license  "GNU GENERAL PUBLIC LICENSE Version 3, 29 June 2007 or later" 
  :serial nil
  :depends-on ("cl-ppcre")
  :components ((:module "src/icem" 
                :serial nil
                :components
                ((:file "icem")))))
