(define (compose f g)
    (lambda (x) (f (g x))))

(define (repeated f n)
    (define (iter comp n)
        (if (= n 1) comp 
            (repeated (compose f comp) (- n 1))
        ))
    (iter f n))

(define (square x) (* x x))

(display ((repeated square 2) 5))
    


