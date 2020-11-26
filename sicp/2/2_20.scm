
(define (same-parity alpha . numbs)
    (define (match? x) (= (modulo x 2) (modulo alpha 2)))

    (define (build-iter final ls)
        (cond ((null? ls) final)
              ((match? (car ls)) (build-iter (append final (list (car ls))) (cdr ls)))
              (else (build-iter final (cdr ls)))
        ))


    (build-iter (list alpha) numbs))


(display (same-parity 1 2 3 4 5 6 7))
(newline)
(display (same-parity 2 3 4 5 6 7 8))




