
(define (make-interval x y) (cons x y))

(define (lower-bound c) (car c))
(define (upper-bound c) (cdr c))

(define (display-interval c) 
        (display "(")
        (display (lower-bound c))
        (display ", ")
        (display (upper-bound c))
        (display ")"))

(define (width c) 
    (/ (- (lower-bound c) (upper-bound c)) 2) 
    )

(define (add-interval x y)
    (make-interval (+ (lower-bound x) (lower-bound y))
                   (+ (upper-bound x) (upper-bound y))))

   
(define (mul-interval x y)
    (let ((p1 (* (lower-bound x) (lower-bound y)))
          (p2 (* (lower-bound x) (upper-bound y)))
          (p3 (* (upper-bound x) (lower-bound y)))
          (p4 (* (upper-bound x) (upper-bound y))))
        (make-interval (min p1 p2 p3 p4)
                       (max p1 p2 p3 p4))))

(define (div-interval x y)
    (mul-interval x 
        (make-interval (/ 1.0 (upper-bound y))
                       (/ 1.0 (lower-bound y)))
    ))



