

(define (avg-3 x1 x2 x3) (/ (+ x1 x2 x3) 3))

(define (smooth f)
    (define dx 0.001)
    (lambda (x) (avg-3 (f x) (f (- x dx)) (f (+ x dx))))
    )
     
(define (compose f g)
    (lambda (x) (f (g x))))

(define (repeated f n)
    (define (iter comp n)
        (if (= n 1) comp 
            (repeated (compose f comp) (- n 1))
        ))
    (iter f n))

(define (square x) (* x x))


(define (smooth-n f n)
    ((repeated smooth n) f))


(display ((smooth-n square 2) 3))

