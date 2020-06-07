
(define (make-point x y) (cons x y))

(define (point-x p) (car p))
(define (point-y p) (cdr p))

(define (point-print p)
        (display "(")
        (display (point-x p))
        (display ", ")
        (display (point-y p))
        (display ")"))

(define (make-size w h) (make-point w h))
(define (size-w size) (point-x size))
(define (size-h size) (point-y size))


(define (make-rect origin size) (cons origin size))
(define (rect-origin rect) (car rect))
(define (rect-size rect) (cdr rect))


(define (rect-area rect) (* (size-w (rect-size rect)) (size-h (rect-size rect))))

(define (rect-perimeter rect) 
    (+ 
        (* (size-w (rect-size rect)) 2) 
        (* (size-h (rect-size rect)) 2)))




(display (rect-area (make-rect (make-point 0 0) (make-size 5 10))))
(newline)
(display (rect-perimeter (make-rect (make-point 0 0) (make-size 4 2))))


