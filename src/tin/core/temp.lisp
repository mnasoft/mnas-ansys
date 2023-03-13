;;;; ./src/core/temp.lisp
(in-package :mnas-ansys/tin)

(defun z-plane-x-axis (point)
  "@b(Описание:) функция @b(z-plane-x-axis) возвращает координаты точки,
 являющиеся вращением ее вокруг оси Χ до плоскости Ζ."
  (let ((x (first point))
        (y (second point))
        (z (third point)))
    (list x (sqrt (+ (* y y) (* z z))))))

(defun make-z-plane-x-axis (point &optional (color 1))
  (format t "(dr:pline '~S~%~S)~%~%~%" (mapcar #'z-plane-x-axis point) color))

(make-z-plane-x-axis
 '((461.5000 303.0708 202.5054)
   (461.5000 330.0883 220.5580)
   (464.4500 330.0883 220.5580)
   (464.4500 320.1156 213.8944)
   (467.4500 320.1156 213.8944)
   (467.4500 325.9356 217.7832)
   (473.4500 325.9356 217.7832)
   (473.4500 330.0883 220.5580)
   (495.9500 330.0883 220.5580)
   (495.9500 312.1871 208.5967)
   (497.9500 309.3019 206.6689)
   (500.7500 309.3019 206.6689)
   (500.7500 303.0660 202.5022)))

(make-z-plane-x-axis
 '((466.5000 497.7485 99.00834)
   (474.5000 497.7485 99.00834)
   (474.5000 497.7485 99.00834)
   (475.3684 497.9432 99.04707)
   (475.9645 498.3745 99.13284)
   (476.3589 498.9869 99.25466)
   (476.5000 499.7101 99.39853)
   (478.5000 523.2490 104.0807)
   (478.5000 528.1529 105.0561)
   (490.0000 528.1529 105.0561)
   (471.5000 641.4336 127.5891)
   (471.5000 649.7703 129.2473)
   (-3.500000 649.7703 129.2473)
   (-28.50000 647.6251 128.8206)))


(make-z-plane-x-axis
 '((471.5000 543.7776 363.3406)
   (486.0000 443.5862 296.3948)
   (494.5000 443.5862 296.3948)
   (494.5000 427.7884 285.8391)
   (498.5000 427.7884 285.8391)
   (498.5000 426.9569 285.2835)
   (521.0000 426.9569 285.2835)
   (525.1482 427.7062 285.7841)
   (527.6551 429.0679 286.6940)
   (529.7595 431.2624 288.1603)
   (530.5483 432.8029 289.1897)
   (531.0000 435.2715 290.8391)
   (531.0000 445.6649 297.7838)
   (603.6461 494.5779 330.4664)
   (603.6461 494.5779 330.4664)
   (605.8267 496.8768 332.0025)
   (606.6081 499.7901 333.9490)
   (606.0468 502.2012 335.5601)
   (604.7355 504.0253 336.7789)
   (601.6083 505.9147 338.0414)
   (528.5000 530.4742 354.4515)))

(dr:pline '((471.5 653.9957) (486.0 533.4966) (494.5 533.4966)
            (494.5 514.49677) (498.5 514.49677) (498.5 513.4967)
            (521.0 513.4967) (525.1482 514.3978) (527.6551 516.0356)
            (529.7595 518.67487) (530.5483 520.52765) (531.0 523.4966)
            (531.0 535.99664) (603.6461 594.8238) (603.6461 594.8238)
            (605.8267 597.5887) (606.6081 601.0924) (606.0468 603.99225)
            (604.7355 606.18604) (601.6083 608.45844) (528.5 637.99585))
          2)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(progn
(defparameter *tin*
  (open-tin-file "d:/home/_namatv/CFX/ugt5000_H2/ugt5000_H2.tin"))

(mnas-ansys/utils:surface-names-coeged-with-surface-in-family
 '("P_04")  *tin*
 :families-excluded
 '("KORP_04" "A_H/H_D001.8" "A_H/H_D004.0" "STOP" )
 :times 1 ))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
#+nil
'(
  initial-height
  height-ratio
  number-of-layers
  total-height
  
  )

(defun initial-height (height-ratio number-of-layers total-height)
  "@b(Описание:) функция @b(initial-height) возвращает высоту первого
слоя."
    (/ total-height
     (apply #'+
            (loop :for i :from 0 :below number-of-layers
                  :collect (expt height-ratio i)))))

(initial-height 1.2d0 5 15)  
                                2.0157

(defun height-ratio (initial-height  number-of-layers total-height)
  )

(defun number-of-layers (initial-height height-ratio  total-height)
  )

(defun total-height (initial-height height-ratio number-of-layers)
  "@b(Описание:) функция @b(total-height) возвращает высоту
призматических слоев."
  (* initial-height
     (apply #'+
            (loop :for i :from 0 :below number-of-layers
                  :collect (expt height-ratio i)))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(total-height 2.0 1.2 3)
(initial-height 1.2 3 7.28)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(ql:quickload :math)

(math/stat:variation-coefficient
 (loop :for i :in
       '(
         9.4	-0.9	-0.4	-12.5	-11.6
         5.2	19.3	-9.1	-9.4	-8.2
         0.5	-8.5	5.9	-3.9	-8.8
         -3.0	-6.9	-4.3	8.7	0.6
         -6.1	-0.2	11.2	28.9	4.4
         )
       :collect (+ i 100)))  ; => 0.099705264 (9.970527%)

(math/stat:variation-coefficient
 (loop :for i :in
       '(
         9.2	6.0	-14.7	-1.6	1.2
         -3.4	28.4	0.1	-6.6	3.2
         -11.7	8.7	1.2	-10.7	17.7
         -12.5	2.9	0.6	-14.6	1.4
         3.6	-6.3	5.4	-3.8	-3.7
         )
       :collect (+ i 100)))  ; => 0.098837815 (9.883781%)
"
Рисунок М.1 – Схема расположения термопар в одногорелочном отсеке КС ГТД ДА32 В2А32005801 вид по ходу газа

Таблица М.1 – Поле температур (t03) уходящих газов на выходе из КС с
ЖТ А32038002 и ГУ А32038004 по результатам испытаний в НИО 10.02.2017
со-гласно протоколу №994 на режиме 11

Таблица М.2 – Поле относительных температур уходящих газов на выходе
из КС с ЖТ А32038002 и ГУ А32038004 по результатам испытаний в НИО
10.02.2017 согласно протоколу №994 на режиме 11

Таблица М.3 – Поле температур уходящих газов на выходе из КС по
результа-там CFD-расчета за нечетной ЖТ

Таблица М.4 – Поле температур уходящих газов на выходе из КС по
результа-там CFD-расчета за четной ЖТ

Таблица М.5 – Поле температур уходящих газов на выходе из КС по
результа-там CFD-расчета осредненное по нечетной и четной ЖТ

Таблица М.6 – Поле относительных температур уходящих газов на выходе
из КС по результатам CFD-расчета осредненное по нечетной и четной ЖТ

Таблица М.7 – Поле разностей относительных температур уходящих газов
на выходе из КС с ЖТ А32038002 и ГУ А32038004 по результатам испытаний
в НИО 10.02.2017 согласно протоколу №994 режим 11 и относительных
темпе-ратур уходящих газов на выходе из КС по результатам CFD-расчета
осред-ненное по нечетной и четной ЖТ выраженное в процентах

Таблица М.8 – Поле разностей относительных температур уходящих газов
на выходе из КС с ЖТ А32038002 и ГУ А32038004 по результатам
CFD-расчета за нечетной и четной ЖТ выраженное в процентах
"
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(dia:open-tin-file)
(families (<tin>-surfaces dia:*tin*))


G3

B/GAS_1/D_07.000
C3/C_1_3/C_1_3_1/D_04.000
C3/C_1_3/C_1_3_2/D_08.000
C3/C_1_3/C_1_3_3/D_01.200
C3/C_2_3/C_2_3_1/D_04.000
GU/COOL_1/G3-M3/G3-M3_2/D_02.000
GU/COOL_1/HOLES/G3-M3/G3-M3_3/D_01.000
GU/COOL_1/HOLES/G3-M3/G3-M3_3/D_01.200
GU/COOL_1/HOLES/G3-M3/G3-M3_3/D_11.000
GU/COOL_1/RADIUS/G3-M3/G3-M3/G3-M3_4/D_02.000
GU/COOL_1/WALL/G3-M3/G3-M3_5/D_04.000
GU/COOL_2/HOLES/D_01.200
GU/COOL_2/PAZ/D_01.000
GU/COOL_2/WALL/D_02.000
GU/G1/HOLES/D_00.600
GU/G1/HOLES/D_02.500
GU/G1/HOLES/D_05.000
GU/G1/HOLES/D_07.000
GU/G1/WALL/D_00.000
GU/G1/WALL/D_01.000
GU/ZAV_1/IN/WALL/D_00.000
GU/ZAV_1/IN/WALL/D_02.000
GU/ZAV_1/IN/WALL/G3-M3/G3-M3_1/D_00.000
GU/ZAV_1/LOP/WALL/D_00.000
GU/ZAV_1/OUT/WALL/D_00.000
GU/ZAV_1/OUT/WALL/D_01.000
GU/ZAV_1/OUT/WALL/D_02.000


ic_geo_get_valid_namelen 
ic_geo_rename_family GU/ZAV_1/IN/WALL/G3-M0/D_00.000 GU/ZAV_1/IN/WALL/G3-M1000/D_00.000 0
ic_geo_rename_family GU/ZAV_1/IN/WALL/G3-M0/D_02.000 GU/ZAV_1/IN/WALL/G3-M1000/D_02.000 0
ic_geo_rename_family GU/ZAV_1/IN/WALL/G3-M0 GU/ZAV_1/IN/WALL/G3-M1000 1


B1/AIR_IN/D_00.000
B1/AIR_RL_OUT/N2/D_05.000
B1/AIR_SL_OUT/D_06.000



