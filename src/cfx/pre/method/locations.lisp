;;;; ./src/cfx/pre/method/locations.lisp

(in-package :mnas-ansys/cfx/pre)

(defmethod locations ((location null))
  "")

(defmethod locations ((location string))
  (format nil "~A" location))

(defmethod locations ((location sequence))
  (format nil "~{~A~^,~}" (coerce location 'list)))
