
; https://en.wikipedia.org/wiki/Cycle_detection
; Floyd tortoise and hare
; I read about this in Elements of Programming, but forgot about it

(define (cycle? ls)
  (define (iter turtle hare)
    (cond ((or (null? turtle) (null? hare)) #f)
          ((null? (cdr hare)) #f)
          ((eq? turtle hare) #t)
          (else (iter (cdr turtle) (cddr hare)))))

  (and (not (or (null? ls) (null? (cdr ls))))
       (iter (cdr ls) (cddr ls))))

(define (append! x y) 
  (set-cdr! (last-pair x) y) x)

(define (last-pair x)
    (if (null? (cdr x)) 
      x 
      (last-pair (cdr x))))

(define w '(a b c d))

(display (cycle? w))
(append! w w)
(display (cycle? w))

