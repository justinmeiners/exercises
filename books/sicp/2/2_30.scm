(define (square-tree tree)
    (cond ((null? tree) (list))
          ((not (pair? tree)) (* tree tree))
          (else (cons (square-tree (car tree))
                      (square-tree (cdr tree))))
    ))


(display (square-tree (list 1 (list 2 (list 3 4) 5) (list 6 7))))


            
            
