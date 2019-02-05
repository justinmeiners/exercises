

(define (inc x) (+ 1 x))

(define (double f) 
    (lambda (x) (f (f x)))
    )

(display ((double inc) 2) )
(newline)


; prediction
; double = 2 apps
; (double double) 4 apps
; (double (double double)) 16 apps

(display (((double (double double)) inc) 5))
