
(define (cycle? ls)
  (define (iter ls visited)
    (if (null? (cdr ls)) 
      #f
      (if (memq ls visited) 
        #t
        (iter (cdr ls) (cons ls visited)))))
  (iter (cdr ls) (list (car ls))))

(define (append! x y) 
  (set-cdr! (last-pair x) y) x)

(define (last-pair x)
    (if (null? (cdr x)) 
      x 
      (last-pair (cdr x))))

(define w '(a b c))

(display (cycle? w))
(append! w w)
(display (cycle? w))







