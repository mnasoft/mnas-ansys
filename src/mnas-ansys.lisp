(defpackage :mnas-ansys
  (:use #:cl)
  (:documentation
   " Пакет предназначен для коммуницирования с различными подсистемами ANSYS:
@begin(list)
 @item(mnas-ansys/tin - манипулирования с данными в tin - файле;)
 @item(mnas-ansys/iс - построения команд подсистемы ANSYS ICEM CFD;)
 @item(mnas-ansys/ccl - построения команд на языке CCL подсистем ANSYS PRE, ANSYS POST;)
@end(list)"))

(in-package :mnas-ansys)
  
