(in-package :mnas-ansys/cfx/pre/nodgui)

(defun lb-test ()
  (nodgui:with-nodgui ()
    (nodgui:wm-title nodgui:*tk* "Mesh Dialog")
    (let* ((toplevel nodgui:*tk*)
           (frame3 (make-instance 'nodgui:frame :master toplevel))
           (mesh-listbox (make-instance 'nodgui:scrolled-listbox :master frame3)))

      (nodgui:grid frame3       0 0 :sticky :nsew)
      (nodgui:grid mesh-listbox 0 0 :sticky :nsew)

      (nodgui:grid-columnconfigure toplevel :all :weight  1)
      (nodgui:grid-rowconfigure    toplevel :all :weight  1)
      (nodgui:grid-columnconfigure frame3   :all :weight  1)
      (nodgui:grid-rowconfigure    frame3   :all :weight  1)
      )))

;; (lb-test)

;;(mnas-ansys/cfx/pre:<simulation>-meshes *simulation*)
