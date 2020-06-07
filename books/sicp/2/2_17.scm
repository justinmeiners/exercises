(define (last-pair ls)
    (if (null? (cdr ls))
        ls
        (last-pair (cdr ls))
    ))


(display (last-pair (list 23 72 149 34)))
