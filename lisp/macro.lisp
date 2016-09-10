(defmacro add(num)
  (setq num (+ num 100))
  (print num))

(setq x 10)
(print x)
(add x)
