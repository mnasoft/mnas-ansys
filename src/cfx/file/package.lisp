;;;; ./src/cfx/file/package.lisp

(defpackage :mnas-ansys/cfx/file
  (:use #:cl)
  (:export <res>
           <res>-pathname ;; Аксессор к имени res-файла
           <res>-ccl      ;; Аксессор к списку ccl
           <res>-mon      ;; Хешированная таблица мониторов
           )
  (:export save          ;; Сохранение объекта
           load-instance ;; Загрузка объекта из файла
           )
  (:export ccl-extract ;; Извлечение данных связанных их файла.
           )
  (:export mon-extract ;; Извлечение данных о мониторах из res-файла
           mon-select  ;; Выборка из объекта по определенным мониторам
           mon-table   ;; Список номер пп, имя, данные по монитору
           mon-table-ave ;; Список номер пп, имя, среднее значение по  монитору СКО
           mon-to-org ;; Вывод в файл с именем как у res-файла и расширением org
           mon-check ;; Проверка монитора (списка мониторов) на корректность по имени (именам)
           mon-average-value ;; Среднее значение по монитору
           mon               ;; Поиск монитора по ключу
           )
  (:export iterations      ;; Количество итераций, по данным мониторов
           iteration-start ;; Номер начальной итерации
           iteration-end   ;; Номер конечной  итерации
           ) 
  (:export find-in-ccl ;; Поиск вглубину по данным ccl.
           )
  (:export *n-iter* ;; Количество итераций для мониторов, выгружаемое по умолчанию
           res-to-s-obj ;; Сохранение res-файла в формате s-obj
           dir-to-s-obj ;; Сохранение групы res-файлов в формате s-obj
           )
  (:export open-cfx-file ;; Открытие/сохранение res-файла в формате s-obj
           open-last-cfx-file ;; Открытие/сохранение последнего res-файла из калалога
           )
  (:export *mask-suffix* 
           res-to-org ;; Сохранение данных о мониторах res-файла в формате org
           dir-to-org ;; Сохранение данных о мониторах res-файлов в формате org
           )
  (:export slice ;; Укорачивает данные объекта от start до end
           slice-last ;; Укорачивает данные объекта оставляя последние number их число
           )
  (:export mk-fname-s-obj ;; Формирует имя s-obj файла на основании res-файла
           mk-fname-res ;; Формирует имя res   файла на основании res-файла
           )
  (:documentation
   "Пакет @(mnas-ansys/exchande) определяет функции, позволяющие извлечь
    информацию из файлов, которые экспортирует Ansys"))

(in-package :mnas-ansys/cfx/file)
