
(define (make-point x y) (cons x y))

(define (point-x p) (car p))
(define (point-y p) (cdr p))

(define (point-print p)
        (display "(")
        (display (point-x p))
        (display ", ")
        (display (point-y p))
        (display ")"))

(define (make-segment start end) (cons start end))

(define (segment-start seg) (car seg))
(define (segment-end seg) (cdr seg))

(define (segment-midpoint seg) 
        (make-point 
            (/ (+  (point-x (segment-start seg))
                   (point-x (segment-end seg))) 2)

            (/ (+  (point-y (segment-start seg))
                   (point-y (segment-end seg))) 2)
         ))

(define (segment-print s)
        (point-print (segment-start s))
        (display " ")
        (point-print (segment-end s)))


(point-print (segment-midpoint (make-segment (make-point 0 0) (make-point 2 5))))




            
