;;;; ./src/cfx/post/method-mfr-gt.lisp

(in-package :mnas-ansys/cfx/post)

(defmethod print-object ((obj <mfr-gt>) s)
  (print-unreadable-object (obj s :type t)
    (format s "~S~%~S"
             (<mfr-gt>-name obj)
             (<mfr-gt>-tracts obj))))

(defmethod initialize-instance :after ((mfr-gt <mfr-gt>) &key tracts result)
  (setf (<result>-result mfr-gt) result)
  (setf (<mfr-gt>-tracts mfr-gt)
        (loop :for (designation x  monitor group description sign) :in tracts
              :collect
              (let ((mfr-gt-tract
                      (make-instance '<mfr-gt-tract>
                                     :designation designation
                                     :x           x
                                     :monitor     monitor
                                     :group       group
                                     :description description
                                     :sign        sign)))
                mfr-gt-tract))))

(defmethod mfr-by-tract ((mfr-gt-tract <mfr-gt-tract>) (mfr-gt <mfr-gt>))
  (* (<mfr-gt-tract>-sign mfr-gt-tract)
     (math/stat:average-value
      (mnas-ansys/cfx/file/mon:<mon>-data
       (gethash (<mfr-gt-tract>-monitor mfr-gt-tract)
                (mnas-ansys/cfx/file:<res>-mon
                 (<result>-result mfr-gt)))))))

(defmethod mass-flow-rate ((mfr-gt <mfr-gt>))
  (loop :for i :in (<mfr-gt>-tracts mfr-gt)
        :summing
        (mfr-by-tract i mfr-gt)))

(defmethod gropus ((mfr-gt <mfr-gt>))
  "Возвращает список групп."
  (remove-duplicates
   (loop :for i :in (<mfr-gt>-tracts mfr-gt)
         :collect (<mfr-gt-tract>-group i))
   :test #'equal))

(defmethod order-by-x ((mfr-gt <mfr-gt>))
  "Возвращает список трактов, отсортированный по координате X."
  (sort (<mfr-gt>-tracts mfr-gt)
        #'< :key #'<mfr-gt-tract>-x))

(defmethod mfr-by-group ((group string)  (mfr-gt <mfr-gt>))
  "Возвращает массовый расход через группу трактов @b(group) ЖТ."
  (loop :for i :in (<mfr-gt>-tracts mfr-gt)
        :when (string= group (<mfr-gt-tract>-group i))
          :summing (mfr-by-tract i mfr-gt)))

(defmethod mfr-by-group-relative ((group string)  (mfr-gt <mfr-gt>))
  "Возвращает относительный массовый расход через группу трактов @b(group) ЖТ."
  (/ (mfr-by-group group mfr-gt)
     (mass-flow-rate mfr-gt)))

(defmethod mfr-by-tract-relative ((mfr-gt-tract <mfr-gt-tract>) (mfr-gt <mfr-gt>))
  "Возвращает относительный массовый расход через тракт @b(mfr-gt-tract) ЖТ." 
  (/ (mfr-by-tract mfr-gt-tract mfr-gt)
     (mass-flow-rate mfr-gt)))

(defmethod mfr-table ((mfr-gt <mfr-gt>))
  "Возвращает таблицу с распределением массового расхода воздуха по
группам трактов ЖТ."
  (let ((rez (loop :for i :in (<mfr-gt>-tracts mfr-gt)
                   :collect
                   (list (<mfr-gt-tract>-designation i)
                         (<mfr-gt-tract>-x i)
                         #+nil (<mfr-gt-tract>-monitor i)
                         (<mfr-gt-tract>-group i)
                         (<mfr-gt-tract>-description i)
                         (mfr-by-tract i mfr-gt)
                         (* 100 (mfr-by-tract-relative i mfr-gt))))))
    (push (table-header mfr-gt)  rez)))

(defmethod table-header ((mfr-gt <mfr-gt>))
  (list "Об." "X, мм" "Наименование" "Группа" "G, кг/с" "G_R, %"))

(defmethod mfr-table-group ((mfr-gt <mfr-gt>))
  "Возвращает таблицу с распределением массового расхода воздуха по
группам трактов ЖТ."
  (let ((rez (loop :for i :in (gropus mfr-gt)
                   :collect
                   (list i
                         (mfr-by-group i mfr-gt)
                         (* 100
                            (mfr-by-group-relative i mfr-gt))))))
    (push (list "Група" "G, кг/с" "G_R, %")
          rez)))

(defmethod mfr-table-plot-data ((mfr-gt <mfr-gt>))
  "Возвращает таблицу с распределением массового расхода воздуха по
группам трактов ЖТ."
  (let ((rez (loop :for i :in (order-by-x  mfr-gt)
                   :collect
                   (list 
                    (<mfr-gt-tract>-x i)
                    (* 100 (mfr-by-tract-relative i mfr-gt))))))
    rez))

(defun cumulative-step (pairs)
  (let ((sorted (sort pairs #'< :key #'first))
        (result '())
        (sum 0))
    (dolist (pair sorted (nreverse result))
      (let ((x (first  pair))
            (y (second pair)))
        (push (list x sum) result)
        (incf sum y)
        (push (list x sum) result)))))
