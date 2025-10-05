;;;; ./src/cfx/pre/web/app-simulation.lisp

(in-package #:mnas-ansys/cfx/pre/web)

(reblocks/app:defapp hw
  :prefix "/apps1/hw/"
  :routes ((page ("/" :name "hello-world")
             (make-hw-page))))
