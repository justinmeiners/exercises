
(define (no-more? ls) (null? ls))
(define (except-first-denomination ls) (cdr ls))

(define (first-denomination ls) (car ls))

(define (cc amount coin-list)
        (cond ((= amount 0) 1)
                ((or (< amount 0) (no-more? coin-list)) 0)
                (else (+ (cc amount
                            (except-first-denomination coin-list))
                         (cc (- amount
                             (first-denomination coin-list))
                            coin-list))
                )
        )) 



(define us-coins (list 50 25 10 5 1))
(define uk-coins (list 100 50 20 10 5 2 1))

(display (cc 100 us-coins))
(newline)
(display (cc 100 uk-coins))
