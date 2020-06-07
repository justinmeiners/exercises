(load "2_07.scm")

; since these represent values to a degree of accuracy
; any interval containing zero is essentially zero
(define (contains-zero? c) 
        (and (<= (lower-bound c) 0) (>= (upper-bound c) 0)))

(define (div-interval x y)
        (if (contains-zero? y)
            (error "interval divide by zero") 
            (mul-interval x 
                (make-interval (/ 1.0 (upper-bound y))
                               (/ 1.0 (lower-bound y)))
            )))


; this should fail because of divide by zero
(let ((i1 (make-interval 1 1))
      (i2 (make-interval -1 2)))
        (display-interval (div-interval i1 i2)))

