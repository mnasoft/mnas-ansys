;;;; ./src/cfx/pre/points.lisp

(in-package :mnas-ansys/cfx/pre)

(defun rotate-point-around-vector (point-3d point-1 point-2 teta)
  (let* ((rotate-teta (math/matr:rotate-around point-1 point-2  (math/coord:dtr teta)))
         (move-x-y-z (math/matr:move-xyz 0.0d0 0.0d0 0.0d0))
         (matrix-4x4 (math/matr:multiply move-x-y-z rotate-teta)))
    (math/matr:transform point-3d matrix-4x4)))

(defun mk-gt-cone-pnts (point-tcs pa-start pa-end)
  (apply
   #'append
   (loop :for (point tc) :in point-tcs
         :when tc
           :collect
           (loop :for (name teta) :in tc
                 :collect
                 `(,name
                   ,(rotate-point-around-vector
                     point
                     pa-end
                     pa-start
                     teta))))))

(defun move-rotate-point-around-vector (point-3d v point-1 point-2 teta)
  "@b(Описание:) функция @b(move-rotate-point-around-vector) смещает
точку @b(point-3d) в направлении вектора @b(v) и затем вращает
смещенную точку вокруг оси, проходящей через точки @b(point-1)
@b(point-2) на угол @b(teta) против часовой стрелки.

 @b(Пример использования:)
@begin[lang=lisp](code)
 (move-rotate-point-around-vector
  '(10.0   5.0 0.0)
  '( 0.0   5.0 0.0)
  '( 0.0   0.0 0.0)
  '(1000.0 0.0 0.0)
  45.0)
 => (10.0 7.071068 -7.071068)
@end(code)
"
  (let* ((rotate-teta (math/matr:rotate-around point-1 point-2 (math/coord:dtr teta)))
         (move-x-y-z (math/matr:move-v v))
         (matrix-4x4 (math/matr:multiply move-x-y-z rotate-teta)))
    (math/matr:transform point-3d matrix-4x4)))

(defun make-ic-point (pnt &optional (part "GEOM") (names "pnt"))
  (loop :for (name p) :in pnt :do
    (format t "ic_point {} ~A ~A {~{~8,3F~^,~}}; " part names p))
  (format t "~3%"))

(defun mk-t-f-points (p1
                      p2
                      &key
                        (axis-start '(0.0 0.0 0.0))
                        (axis-end   '(1000.0 0.0 0.0))
                        (h-start    100)
                        (teta-start 100)
                        (h-list    (math/core:split-range-at-center 0.0 1.0 10))
                        (teta-list (math/core:split-range -17.0 17.0 34)))
  (let ((d-p1-p2 (math/core:distance p1 p2)))
    (apply #'append
           (loop :for hight   :in h-list
                 :for hight-i :from h-start
                 :collect
                 (loop :for teta   :in   teta-list
                       :for teta-i :from teta-start
                       :collect 
                       (list (format nil "~A ~A" hight-i teta-i)
                             (move-rotate-point-around-vector
                              p1
                              (list 0.0d0 (* hight d-p1-p2) 0.0d0)
                              axis-start                         
                              axis-end
                              teta)))))))

