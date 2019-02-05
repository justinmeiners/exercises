(define (square-list items)
    (if (null? items)
        items
        (cons (* (car items) (car items)) (square-list (cdr items)))
        ))

(define (square-list2 items)
    (map (lambda (x) (* x x)) items))

(display (square-list (list 1 2 3 4)))
(newline)
(display (square-list2 (list 4 5 6 7)))
