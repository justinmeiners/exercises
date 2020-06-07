
(define (fringe x)
    (cond ((null? x) '())
          ((pair? x) (append (fringe (car x)) (fringe (cdr x))))
          (else (list x))))


(define x (list (list 1 2) (list 3 4)))

(display (fringe x))
