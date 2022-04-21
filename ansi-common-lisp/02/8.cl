; takes a positive integer and prints that many dots

(defun dots (n)
  (format t ".")
  (if (> n 1)
    (dots (- n 1))))

(defun dots2 (n)
  (do ((i 0 (+ i 1)))
    ((= i n) 'done)
    (format t ".")))

(dots 10)
(format t "~%")
(dots2 10)
(format t "~%")

; takes a list and returns the number of times the symbol a occurs in it.

(defun occur (l x)
    (if (null l)
      0
        (if (= x (car l))
          (+ 1 (occur (cdr l) x))
          (+ 0 (occur (cdr l) x)))
        ))
    
(print (occur (list 1 1 2 1) 1))
(print (occur (list 1 1 2 1) 2))
(print (occur (list 1 1 2 1) 3))






