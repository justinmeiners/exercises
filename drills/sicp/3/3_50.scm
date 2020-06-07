
(define (stream-cons a b)
    (cons a (delay b)))

(define empty-stream '())

(define (stream-null? s) (null? s))

(define (stream-car s) (car s))

(define (stream-cdr s) (force (cdr s)))

(define (stream-ref s n)
  (if (= n 0)
    (stream-car s)
    (stream-ref (stream-cdr s) (- n 1))))

(define (stream-map proc s)
  (if (stream-null? s)
    empty-stream
    (stream-cons (proc (stream-car s))
                 (stream-map proc (stream-cdr s)))))

(define (stream-for-each proc s)
  (if (stream-null? s)
    'done
    (begin (proc (stream-car s))
           (stream-for-each proc (stream-cdr s)))))

(define (stream-enumerate-interval low high)
  (if (> low high)
    empty-stream
    (stream-cons low (stream-enumerate-interval (+ low 1) high))))

(define (stream-filter pred stream)
  (cond ((stream-null? stream) empty-stream)
        ((pred (stream-car stream))
         (stream-cons (stream-car stream)
                      (stream-filter pred (stream-cdr stream))))
        (else (stream-filter pred (stream-cdr stream)))))


;(define (stream-map proc . streams)
;  (if (stream-null? (car streams))
;    empty-stream
;    (stream-cons
        ; accumulate all the results with the proc
;        (apply proc (map car streams))
;        (apply stream-map
                ; put the proc as the first argument
                ; cdr over all the streams
;                (cons proc (map stream-cdr streams))))))


;(define test (stream-enumerate-interval 0 100))


;(define (print x) (display x) (display "\n"))

;(display (stream-for-each print (stream-filter even? test)))

;(stream-for-each print (stream-map + 
;                    (stream-enumerate-interval 1 3)
;                    (stream-enumerate-interval 4 6) 
;                    (stream-enumerate-interval  7 9)))



