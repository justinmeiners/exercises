(load "2_56.scm")

(define (augend e)
  (if (not (null? (cdddr e)))
    (cons '+ (cddr e))
    (caddr e)))


(define (multiplicand e)
  (if (not (null? (cdddr e)))
    (cons '* (cddr e))
    (caddr e)))


; 5.57
(display (derive '(* x y (+ x 3)) 'x))
(newline)
