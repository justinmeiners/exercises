
(define (head-ptr d) (car d))
(define (tail-ptr d) (cdr d))

(define (set-head-ptr! d x) (set-car! d x))
(define (set-tail-ptr! d x) (set-cdr! d x))


(define (empty-d? d) (null? (head-ptr d)))

(define (make-d) (cons '() '()))

(define (insert-head-d! d x)
    (let ((new-pair (cons x (head-ptr d))))
        (cond ((empty-d? d)
                (set-head-ptr! d new-pair)
                (set-tail-ptr! d new-pair)
                d)
              (else (set-head-ptr! d new-pair)))))

(define (insert-tail-d! d x)
    (let ((new-pair (cons x '())))
        (cond ((empty-d? d)
                (set-head-ptr! d new-pair)
                (set-tail-ptr! d new-pair)
                d)
              (else (set-cdr! (tail-ptr d) new-pair)
                    (set-tail-ptr! d new-pair))))) 

(define d (make-d))

(insert-tail-d! d 'c)
(insert-head-d! d 'b)
(insert-tail-d! d 'd)
(insert-head-d! d 'a)
(insert-tail-d! d 'e)

(display d)
 

