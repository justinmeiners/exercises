
; Simpson's rule

(define (integral f a b n) 
    (define (sum term x next n mx)
        (if (= n mx) 
            0
            (+ (term x n mx) (sum term (next x) next (+ n 1) mx))
        ))

    (define (add-nudge x) (+ x (/ (- b a) n)))

    (define (simp-term x n mx) 
        (cond 
              ((or (= n 0) (= n mx)) (f x))
              ((= (remainder n 2) 0) (* 2 (f x)))
              (else (* 4 (f x)))
        ))

    (* (sum simp-term a add-nudge 0 (- n 1)) (/ (/ (- b a) n) 3))
)


(define (cube x) (* x x x))


(display (integral cube 0 1 100))
(newline)
(display (integral cube 0 1 1000)) 
(newline)
(display (integral cube 0 5 6000))
    
