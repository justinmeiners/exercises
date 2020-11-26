
(define (count-pairs x)
  (if (not (pair? x))
    0
    (+ (count-pairs (car x))
       (count-pairs (cdr x))
       1)))

(define basic '(a b c))

(define a (cons basic basic))

(display (count-pairs a))
