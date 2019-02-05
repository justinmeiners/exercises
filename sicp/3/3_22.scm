
(define (make-q)
    (let ((head-ptr '())
          (tail-ptr '()))

    (define (empty?) (null? head-ptr))

    (define (insert x)
        (let ((pair (cons x '())))
            (cond ((empty?) 
                    (set! head-ptr pair)
                    (set! tail-ptr pair))
                  (else 
                     (set-cdr! tail-ptr pair)
                     (set! tail-ptr pair)))))
                

    (define (get-head-ptr) head-ptr)
    (define (get-tail-ptr) tail-ptr)

    (define (print) (display head-ptr))

    (lambda (m)
        (cond ((eq? m 'head) get-head-ptr)
              ((eq? m 'tail) get-tail-ptr)
              ((eq? m 'empty) empty?)
              ((eq? m 'insert) insert)
              ((eq? m 'print) print)
              (else (error "unknwon command"))))))


(define q (make-q))

((q 'insert) 'a)
((q 'insert) 'b)
((q 'insert) 'c)

((q 'print))



