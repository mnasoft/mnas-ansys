(in-package :mnas-ansys/cfx/file-bak)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; Vars

(progn
  (defparameter *res-file*
    #+nil
    "D:/home/_namatv/CFX/n70/cfx/Ne_R=1.00/N70_prj_10/274_full.res"
    #+nil
    "D:/home/_namatv/CFX/n70/cfx/Ne_R=1.00/N70_prj_10/N70_prj_10mt_014.res"
;;  #+nil
    "D:/home/_namatv/CFX/n70/cfx/Ne_R=1.00/N70_prj_09/N70_prj_09mt_007.res"
    "Полный путь к res-файлу.")

  (defparameter *s-obj-file*
    #+nil
    "D:/home/_namatv/CFX/n70/cfx/Ne_R=1.00/N70_prj_10/274_full.s-obj"
    #+nil
    "D:/home/_namatv/CFX/n70/cfx/Ne_R=1.00/N70_prj_10/N70_prj_10mt_014.s-obj"
;;  #+nil
    "D:/home/_namatv/CFX/n70/cfx/Ne_R=1.00/N70_prj_09/N70_prj_09mt_007.s-obj"
    "Полный путь к файлу с  сериализованными данными для объекта, класса
 foo.")

  (defparameter *n-iter* 150
    "Количество итераций")

;;; Создаем переменную, которая ссылается на res-файл.
  (defparameter *res*
    (make-instance '<res>
                   :res-pname *res-file*
                   :pathname  *s-obj-file*)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; Tests

;;; Данный фрагмент программного кода следует выполнять для извлечения
;;; данных вновьполученного res-файла с целью: извлечения данных о
;;; постановке задачи на языке ccl; извлечения мониторов; и сохранения
;;; в формат пригодный для быстрой загрузки (с целью последующей
;;; загрузки и обработки). В результате работы этого кода в качестве
;;; побочного эффекта: образуется файл *s-obj-file* (сериализованного
;;; представления); переменная *res* получает значения о постановке
;;; задачи в формате ccl и мониторах. Ориентировочное время выполнения
;;; 170 секунд.
#+nil
(progn
  (mon-extract *res* *n-iter*) ; Извлекаем данные о мониторах из res-файла
  (ccl-extract *res*)          ; Извлекаем данные ccl
  (save        *res*)          ; Сохраняем объект в res-файл
  )

;;; Данный фрагмент программного кода выполняет для объекта *res*:
;;; загрузку данных симуляции и мониторов из сериализованного
;;; представления; вывод мониторов в org-файлы.
(progn
  (setf *res* (load-instance *res*)) ; Загружаем объект из s-obj-файла

;;; Выборка всех полей
  (mon-to-org ".*"                                     *res* :suffix "-ALL")

  (mon-to-org "USER POINT,GT OUT.*Total Temperature.*" *res* :suffix "-GT-OUT-TT")
  (mon-to-org "USER POINT,GT OUT.*Velocity.*"          *res* :suffix "-GT-OUT-V")
  (mon-to-org "USER POINT,GT OUT.*Density.*"           *res* :suffix "-GT-OUT-D")

  (mon-to-org "USER POINT,*MFR.*"                      *res* :suffix "-MFR")
  (mon-to-org "ACCUMULATED TIMESTEP"                   *res* :suffix "-A-TIME")

  (mon-to-org "USER POINT,CH1.*CH4.Mass Fraction.*"    *res* :suffix "-CH1-CH4")
  (mon-to-org "USER POINT,CH1.*Density.*"              *res* :suffix "-CH1-D") 
  (mon-to-org "USER POINT,CH1.*Total Temperature.*"    *res* :suffix "-CH1-TT") 
  (mon-to-org "USER POINT,CH1.*Velocity u.*"           *res* :suffix "-CH1-Vu")
  (mon-to-org "USER POINT,CH1.*Velocity v.*"           *res* :suffix "-CH1-Vv")
  (mon-to-org "USER POINT,CH1.*Velocity w.*"           *res* :suffix "-CH1-Vw")

  (mon-to-org "USER POINT,CH2.*CH4.Mass Fraction.*"    *res* :suffix "-CH2-CH4")
  (mon-to-org "USER POINT,CH2.*Density.*"              *res* :suffix "-CH2-D") 
  (mon-to-org "USER POINT,CH2.*Total Temperature.*"    *res* :suffix "-CH2-TT") 
  (mon-to-org "USER POINT,CH2.*Velocity u.*"           *res* :suffix "-CH2-Vu")
  (mon-to-org "USER POINT,CH2.*Velocity v.*"           *res* :suffix "-CH2-Vv")
  (mon-to-org "USER POINT,CH2.*Velocity w.*"           *res* :suffix "-CH2-Vw")

  (mon-to-org "USER POINT,GT CONE11.*Density.*"           *res* :suffix "-GT-CONE11-D") 
  (mon-to-org "USER POINT,GT CONE11.*Total Temperature.*" *res* :suffix "-GT-CONE11-TT") 
  (mon-to-org "USER POINT,GT CONE11.*Velocity u.*"        *res* :suffix "-GT-CONE11-Vu")
  (mon-to-org "USER POINT,GT CONE11.*Velocity v.*"        *res* :suffix "-GT-CONE11-Vv")
  (mon-to-org "USER POINT,GT CONE11.*Velocity w.*"        *res* :suffix "-GT-CONE11-Vw")

  (mon-to-org "USER POINT,GT CONE5.*Density.*"            *res* :suffix "-GT-CONE5-D") 
  (mon-to-org "USER POINT,GT CONE5.*Total Temperature.*"  *res* :suffix "-GT-CONE5-TT") 
  (mon-to-org "USER POINT,GT CONE5.*Velocity u.*"         *res* :suffix "-GT-CONE5-Vu")
  (mon-to-org "USER POINT,GT CONE5.*Velocity v.*"         *res* :suffix "-GT-CONE5-Vv")
  (mon-to-org "USER POINT,GT CONE5.*Velocity w.*"         *res* :suffix "-GT-CONE5-Vw")
  )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Вспомогательные тесты
(<res>-data *res*) ;; Проверка данных проекта
(mon-select ".*" *res*) ;; Проверка выборки пар индекс, значение
