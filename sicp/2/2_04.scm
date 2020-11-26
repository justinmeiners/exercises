
(define (cons2 x y)
    (lambda (m) (m x y))) ; evaluate the given procedure m given arguments x and y

(define (car2 z)
    (z (lambda (p q) p))) ; call the procedure with our lambda (return 1st item)

(define (cdr2 z)
    (z (lambda (p q) q))) ; call the procedure with our lambda (return 2nd item)


(display (car2 (cons2 3 5)))
(newline)
(display (cdr2 (cons2 10 15)))






