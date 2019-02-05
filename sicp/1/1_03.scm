(define (sq x) (* x x))

(define (largest-squares x y z)
  (cond ((and (< z x)  (< z y)) (+ (sq x) (sq y)))
        ((and (< y x)  (> y z)) (+ (sq x) (sq z)))
        (else (+ (sq y) (sq z)))
  ))

(display (largest-squares 3 4 5))
(newline)
(display (largest-squares 3 5 4))
(newline)
(display (largest-squares 4 5 3))
(newline)
(display (largest-squares 1 2 3))


    

