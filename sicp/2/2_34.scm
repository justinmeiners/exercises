
(define (accumulate op initial sequence)
    (if (null? sequence)
        initial
        (op (car sequence)
            (accumulate op initial (cdr sequence)))
    ))



(define (horner-eval x coeffs)
    (accumulate (lambda (coeff higher-terms) (+ (* x higher-terms) coeff))
            0
            coeffs))


(display (horner-eval 2 (list 1 3 0 5 0 1)))
