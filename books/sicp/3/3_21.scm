
(define (head-ptr q) (car q))
(define (tail-ptr q) (cdr q))

(define (set-head-ptr! q x) (set-car! q x))
(define (set-tail-ptr! q x) (set-cdr! q x))


(define (empty-q? q) (null? (head-ptr q)))

(define (make-q) (cons '() '()))


(define (insert-q! q x)
    (let ((new-pair (cons x '())))
        (cond ((empty-q? q)
                (set-head-ptr! q new-pair)
                (set-tail-ptr! q new-pair)
                q)
              (else (set-cdr! (tail-ptr q) new-pair)
                    (set-tail-ptr! q new-pair)))))


           


; The queue is a cons with two pointers, one to the head, and the other to the tail
; [->, ->]
; [a, b, c]

; So the print function interprets it as a list in the car, and a tail in the cdr
; ((a b c) a b c)

(define (print-q q)
    (display (head-ptr q)))


(define q (make-q))

(insert-q! q 'a)
(insert-q! q 'b)


(display (insert-q! q 'c))
(newline)
(display (print-q q))
 

