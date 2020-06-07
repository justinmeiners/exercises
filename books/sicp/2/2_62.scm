(load "2_61.scm")

(define (union-set set1 set2)
  (cond ((null? set1) set2)
        ((null? set2) set1)
        (else 
    (let ((x1 (car set1)) (x2 (car set2)))
      (cond ((> x1 x2)
             (cons x2 (union-set set1
                                 (cdr set2))))
            (else
             (cons x1 (union-set (cdr set1) set2))))))))

(newline)
(display (union-set '(1 2 4 5 9) '(0 3 4 6 7)))

