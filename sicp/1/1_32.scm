
; 1.32
(define (accumulate combiner null-value term a next b)
    (if (> a b)
        null-value
        (combiner 
            (term a) 
            (accumulate combiner null-value term (next a) next b)
        ))
    )


(define (sum term a next b)
    (accumulate + 0 term a next b))

(define (product term a next b)
    (accumulate * 1 term a next b))

(define (incr x) (+ 1 x))
(define (identity x) x)
(define (sqr x) (* x x))


(define (factorial n) 
    (product identity 1 incr n))


(display (sum sqr 1 incr 10))
(newline)
(display (factorial 8))
