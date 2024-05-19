(in-package :mnas-ansys/tin)

(defmethod read-object (lines n (point <prescribed-point>))
  "@b(Описание:) метод @b(read-object) возвращает два значения:
@begin(list)
 @item(объект типа <prescribed-point>;)
 @item(количество считанных строк.)
@end(list)
"
  (let ((params (mnas-string:split " " (elt lines n))))
    (setf (<point>-x point) (x-by-key (<object>-tag point) params))
    (setf (<point>-y point) (y-by-key (<object>-tag point) params))
    (setf (<point>-z point) (z-by-key (<object>-tag point) params))
    (setf (<ent>-family point) (by-key "family" params))
    (setf (<obj>-name  point) (by-key "name" params))
    (values point 1)))

(defmethod read-object (lines n (family <family>))
  "@b(Описание:) метод @b(read-object) возвращает два значения:
@begin(list)
 @item(объект типа <family>;)
 @item(количество считанных строк.)
@end(list)
"
  (let ((params (mnas-string:split " " (elt lines n))))
    (setf (<obj>-name             family) (by-key     "define_family" params))
    (setf (<family>-color         family) (int-by-key "color"         params))
    (setf (<family>-prism         family) (int-by-key "prism"         params))
    (setf (<family>-internal-wall family) (int-by-key "internal_wall" params))
    (setf (<family>-split-wall    family) (int-by-key "split_wall"    params))
    (setf (<family>-tetra-size    family) (x-by-key   "tetra_size"    params))
    (setf (<family>-height        family) (x-by-key   "height"        params))
    (setf (<family>-hratio        family) (x-by-key   "hratio"        params))
    (setf (<family>-nlay          family) (int-by-key "nlay"          params))
    (setf (<family>-ratio         family) (x-by-key   "ratio"         params))
    (setf (<family>-width         family) (x-by-key   "width"         params))
    (setf (<family>-min           family) (x-by-key   "min"           params))
    (setf (<family>-dev           family) (x-by-key   "dev"           params))
    (values family 1)))

(defmethod read-object (lines n (curve <curve>))
  "@b(Описание:) метод @b(read-object) возвращает два значения:
@begin(list)
 @item(объект типа <curve>;)
 @item(количество считанных строк.)
@end(list)
"
  (let ((params (mnas-string:split " " (elt lines n))))
    (setf (<ent>-family curve) (by-key "family" params))
    (setf (<tetra>-size curve) (by-key "tetra_size" params))
    (setf (<obj>-name  curve) (by-key "name" params))
    (setf (<curve>-vertex1 curve) (by-key "vertex1" params))
    (setf (<curve>-vertex2 curve) (by-key "vertex2" params))
    (values curve (- (position-if #'(lambda (el) (find el *defines* :test #'string=))
				  lines
				  :start (1+ n)
				  :key (lambda (el) (first (mnas-string:split " " el))))
		     n))))

(defmethod read-object (lines n (material-point <material-point>))
  "@b(Описание:) метод @b(read-object) возвращает два значения:
@begin(list)
 @item(объект типа <material-point>;)
 @item(количество считанных строк.)
@end(list)
"
  (let ((params (mnas-string:split " " (elt lines n))))
    (setf (<point>-x material-point) (x-by-key (<object>-tag material-point) params))
    (setf (<point>-y material-point) (y-by-key (<object>-tag material-point) params))
    (setf (<point>-z material-point) (z-by-key (<object>-tag material-point) params))
    (setf (<ent>-family material-point) (by-key "family" params))
    (setf (<obj>-name  material-point) (by-key "name" params))
    (values material-point 1)))

(defmethod read-object (lines n (coedge <coedge>))
  "@b(Описание:) метод @b(read-object) возвращает два значения:
@begin(list)
 @item(объект типа <coedge>;)
 @item(количество считанных строк.)
@end(list)
"
  (let ((params (mnas-string:split " " (elt lines n))))
    (setf (<coedge>-curve-type coedge) (nth 1  params))
    (ecase  (length params)
      (1 (setf (<coedge>-direction  coedge) t
               (<coedge>-name  coedge) ""))
      (2 (setf (<coedge>-direction  coedge) t
               (<coedge>-name  coedge) ""))
      (3 (setf (<coedge>-direction  coedge) t
               (<coedge>-name  coedge) (nth 2 params)))
      (4 (setf (<coedge>-direction  coedge) nil
               (<coedge>-name  coedge) (nth 3 params))))
    (values coedge 1)))

(defmethod read-object (lines n (surface <surface>))
  "@b(Описание:) метод @b(read-object) возвращает два значения:
@begin(list)
 @item(объект типа <curve>;)
 @item(количество считанных строк.)
@end(list)
"
  (let ((params (mnas-string:split " " (elt lines n)))
        (end-position (position-if
                       #'(lambda (el) (find el *defines* :test #'string=))
		       lines
		       :start (1+ n)
		       :key (lambda (el) (first (mnas-string:split " " el))))))
    (setf (<obj>-name   surface) (by-key "name" params))
    (setf (<ent>-family surface) (by-key "family" params))
    (setf (<tetra>-size surface) (by-key "tetra_size" params))
    (let ((rez nil))
      (loop :for i :from (1+ n) :below (position-tin-in-objects lines :objects *defines* :start (1+ n))
            :do (when (string= "coedge" (key-tin-in-objects lines i))
                  (push (read-object lines i (make-instance '<coedge>)) rez)))
      (setf (<surface>-coedges surface) (nreverse rez)))
    (values surface (- end-position n))))

(defmethod read-object (lines n (solid <solid>))
  "@b(Описание:) метод @b(read-object) возвращает два значения:
@begin(list)
 @item(объект типа <solid>;)
 @item(количество считанных строк - одну строку.)
@end(list)
"
  (let ((params (mnas-string:split " " (elt lines n))))
    (setf (<obj>-name        solid) (by-key "name"   params))
    (setf (<ent>-family      solid) (by-key "family" params))
    (setf (<solid>-n-lumps   solid) (int-by-key "n_lumps" params))
    (setf (<solid>-n-sheets  solid) (int-by-key "n_sheets" params))
    (setf (<solid>-matlpoint solid) (by-key "matlpoint" params))
    (values solid 1)))

(defmethod read-object (lines n-start (tin <tin>))
  "@b(Описание:) метод @b(read-object) возвращает два значения:
@begin(list)
 @item(объект типа <family>;)
 @item(количество считанных строк.)
@end(list)
"
  (labels ((find-next-tltob (lines n)
	     (position-tin-in-objects lines :objects (mapcar #'first *tin-top-objects*) :start n)))
    (do ((ob-symol nil)
	 (object   nil)
	 (families  nil)
	 (n (find-next-tltob lines n-start) (find-next-tltob lines (1+ n))))
	((and (null n))
	 (setf (<tin>-families  tin) (nreverse families)
               )
         (init-curves tin)
	 (values tin 0))
      (setf ob-symol (second (find (key-tin-in-objects lines n) *tin-top-objects* :key #'first :test #'string=))
            object (read-object lines n (make-instance ob-symol)))
      (ecase ob-symol
	(<family>           (push object families))
        (<curve>            (add-obj-to-ht-by-name object (<tin>-curves   tin)))
       	(<surface>          (add-obj-to-ht-by-name object (<tin>-surfaces tin)))
        (<prescribed-point> (add-obj-to-ht-by-name object (<tin>-points   tin)))))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defmethod read-object (lines n (bspline <bspline>))
  (let ((params (mnas-string:split "," (elt lines (+ 1 n)))))
    (setf (<bspline>-n bspline) (int-by-pos 0 params))
    (setf (<bspline>-k bspline) (int-by-pos 1 params))
    (setf (<bspline>-i bspline) (int-by-pos 2 params))
;;;;
    (setf (<bspline>-knots bspline)
          (let ((s ""))
            (loop :for i :from (+ 2 n) :below (+ 2 n (<bspline>-knots-lines bspline))
                  :do
                     (setf s (concatenate 'string s "," (elt lines i))))
            (map 'vector #'read-from-string (mnas-string:split "," s))))
;;;;
    (loop :for i :from (+ 2 n (<bspline>-knots-lines bspline))
          :for j :from 0 :below (<bspline>-n bspline)
          :do
             (format t "~A~%" (elt lines i)))

;;    bspline
    ))

(defmethod <bspline>-knots-number ((bspline <bspline>))
  (+ (<bspline>-n bspline)
     (<bspline>-n bspline))
  )

(defmethod <bspline>-knots-lines ((bspline <bspline>))
  (ceiling  (<bspline>-knots-number bspline) 5))


