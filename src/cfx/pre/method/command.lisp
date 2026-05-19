;;;; ./src/cfx/pre/method/command.lisp

(in-package :mnas-ansys/cfx/pre)

(defmethod command (number (simulation <simulation>))
  "@b(Описание:) метод @b(command) возвращает команду по ее номеру для
контейнера @b(container)."
  (nth number (<simulation>-commands simulation)))
