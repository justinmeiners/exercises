(define (map-tree func tree)
    (cond ((null? tree) (list))
          ((not (pair? tree)) (func tree))
          (else (cons (map-tree func (car tree))
                      (map-tree func (cdr tree))))
    ))

(display (map-tree (lambda (x) (* x x)) (list 1 (list 2 (list 3 4) 5) (list 6 7))))

 
