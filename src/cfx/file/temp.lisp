(in-package :mnas-ansys/cfx/file)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; Vars

(progn
  (defparameter *res-file*
    #+nil "D:/home/_namatv/CFX/n70/cfx/Ne_R=1.00/N70_prj_10/274_full.res"
    #+nil "D:/home/_namatv/CFX/n70/cfx/Ne_R=1.00/N70_prj_10/N70_prj_10mt_010.res"
    "D:/home/_namatv/CFX/n70/cfx/Ne_R=1.00/N70_prj_09/N70_prj_09mt_006.res"
    "Полный путь к res-файлу.")

  (defparameter *s-obj-file*
    #+nil "D:/home/_namatv/CFX/n70/cfx/Ne_R=1.00/N70_prj_10/274_full.s-obj"
    #+nil "D:/home/_namatv/CFX/n70/cfx/Ne_R=1.00/N70_prj_10/N70_prj_10mt_010.s-obj"
    "D:/home/_namatv/CFX/n70/cfx/Ne_R=1.00/N70_prj_09/N70_prj_09mt_006.s-obj"
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

(defparameter *h* nil)
(setf *h* (mon-extract *res* *n-iter*))
(svref  *h* 3)

(let ((i 3))
  (mnas-ansys/cfx/file/mon:mk-mon (list i (svref  *h* i))))

#+nil
(progn
  (mon-extract *res* *n-iter*) ; Извлекаем данные о мониторах из res-файла
  (ccl-extract *res*)          ; Извлекаем данные ccl
  (save        *res*)          ; Сохраняем объект в res-файл
  )

(progn
  (setf *res* (load-instance *res*)) ; Загружаем объект из s-obj-файла


  (<res>-data *res*)
  (mon-select ".*" *res*)


;;; Выборка всех полей
  (mon-to-org ".*"                 *res* )

  (mon-to-org "USER POINT,GT OUT.*Total Temperature.*" *res* :suffix "-GT-OUT-TT")
  (mon-to-org "USER POINT,GT OUT.*Velocity.*"          *res* :suffix "-GT-OUT-V")
  (mon-to-org "USER POINT,GT OUT.*Density.*"           *res* :suffix "-GT-OUT-D")

  (mon-to-org "USER POINT,GT OUT.*MFR.*"               *res* :suffix "-MFR")
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

(<res>-mon *res*)


(mnas-ansys/ccl:find-in-tree-in-deep
 '(("FLOW" "Flow Analysis 1") ("BOUNDARY" "INLET") "Mass Flow Rate")
 *ccl* t )

(mnas-ansys/ccl:find-in-tree-in-deep 
 '(("FLOW" "Flow Analysis 1") ("BOUNDARY" "INLET") "Total Temperature")
 *ccl* t  )
