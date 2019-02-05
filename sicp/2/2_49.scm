(load "2_48.scm")

(define (segments-painter ls)
    (define (iter segs)
        (if (null? segs)
            '()
            (begin
                (display (start-segment (car segs)))
                (display "->")
                (display (end-segment (car segs))) 
                (display " ")
                (iter (cdr segs)))))
    (iter ls))

(define (draw-frame frame)
    (segments-painter 
        (list 
            (make-segment (make-vec 0 0) (make-vec 1 0))
            (make-segment (make-vec 1 0) (make-vec 1 1))
            (make-segment (make-vec 1 1) (make-vec 0 1))
            (make-segment (make-vec 0 1) (make-vec 0 0)) 
        )))

(define (draw-x frame)
    (segments-painter 
        (list 
            (make-segment (make-vec 0 0) (make-vec 1 1))
            (make-segment (make-vec 0 1) (make-vec 1 0))
        )))

(define (draw-diamond frame)
    (segments-painter 
        (list 
            (make-segment (make-vec 0.5 0) (make-vec 1 0.5))
            (make-segment (make-vec 1 0.5) (make-vec 0.5 1))
            (make-segment (make-vec 0.5 1) (make-vec 0 0.5))
            (make-segment (make-vec 0 0.5) (make-vec 0.5 0)) 
        )))

(draw-frame '())
(newline)
(draw-x '())
(newline)
(draw-diamond '())

