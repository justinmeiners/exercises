
(define (product term a next b)
    (if (> a b) 
        1 
     (* (term a) (product term (next a) next b))
    ))

(define (product-iter term a next b)
    (define (iter a result)
        (if (> a b) 
            result 
        (iter (next a) (* result (term a))))
    )
    (iter a 1))


(define (incr x) (+ 1 x))
(define (identity x) x)

(define (factorial n) 
    (product-iter identity 1 incr n))


(display (factorial 0))
(newline)
(display (factorial 1))
(newline)
(display (factorial 3))
(newline)
(display (factorial 8))




