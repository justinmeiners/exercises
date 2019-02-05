; function composition f(g(x))
(define (compose f g)
    (lambda (x) (f (g x))))


(define (inc x) (+ x 1))
(define (square x) (* x x))

; book example
(display ((compose square inc) 6))




