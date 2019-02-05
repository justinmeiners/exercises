
(define (double a) (+ a a))
(define (halve a) (/ a 2))

(define (mul a b) (mul-iter a b 0))

(define (mul-iter a b sum)
    (cond ((= b 0) sum)
          ((even? b) (mul-iter (double a) (halve b) sum))
          (else (mul-iter a (- b 1) (+ sum a)))
    )
)


(display (mul 1024 7))
(newline)
(display (mul 7 6))
(newline)
(display (mul 3 24))
