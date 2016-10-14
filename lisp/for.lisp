(defvar i 1)

; loop
(print
  (loop
    (incf i 1)
    (if (> i 9) (return i))))

; loop-for
(terpri)
(loop for i from 10 to 15
      do (print i))

; do
(terpri)
(print
  (do ((x 0 (+ x 1))
       (y 5 (- y 1)))
      ((> x y) x)
      (format t "~% x = ~d y = ~d" x y)))

; dotimes
(terpri)
(dotimes (i 5)
  (print i))

; dolist
(terpri)
(dolist (i '(1 2 3))
  (print i))
