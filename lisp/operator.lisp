(defvar a 100)
(defvar b 10)

; calculate
(print (+ a b))
(print (- a b))
(print (* a b))
(print (/ a b))
(print (mod a b))
(print (incf a b))
(print (decf a b))

; compare
(print (= a b))
(print (/= a b))
(print (> a b))
(print (>= a b))
(print (< a b))
(print (<= a b))
(print (max a b))
(print (min a b))

; logic
(defvar c nil)
(defvar d t)

(print (and c d))
(print (or c d))
(print (not c))
(print (not d))

; bitwise
(defvar i 4)
(defvar j 2)

(print (logand i j))
(print (logior i j))
(print (logxor i j))
(print (lognor i j))
(print (logeqv i j))
(print (lognot i))
