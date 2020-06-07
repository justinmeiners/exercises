
(define (make-accumulator partial-sum)
  (lambda (term)
    (begin (set! partial-sum (+ partial-sum term))
           partial-sum)))

(define A (make-accumulator 5))

(display (A 10))
(newline)
(display (A 10))



