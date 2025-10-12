(defpackage #:mnas-ansys/cfx/pre/nodgui
  (:use #:cl)
  )

(in-package :mnas-ansys/cfx/pre/nodgui)

(defparameter *simulation* nil
  #+nil (make-instance '<simulation>)
  "Ссылка на объект смуляции.")
