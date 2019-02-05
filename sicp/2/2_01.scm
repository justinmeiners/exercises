(define (make-rat n d) 
    (let ((g (gcd n d)))
        (if (< d 0)
            (cons (/ (* -1 n) g) (/ (* -1 d) g))
            (cons (/ n g) (/ d g)))
     ))

(define (numer x) (car x))
(define (denom x) (cdr x))

(define (display-rat x)
        (newline)
        (display (numer x))
        (display "/")
        (display (denom x)))


(define (add-rat x y)
    (make-rat (+ (* (numer x) (denom y))
                 (* (numer y) (denom x)))
              (* (denom x) (denom y))))

(define (sub-rat x y)
    (make-rat (- (* (numer x) (denom y))
                 (* (numer y) (denom x)))
              (* (denom x) (denom y))))


(define (mul-rat x y)
    (make-rat (* (numer x) (numer y))
              (* (denom x) (denom y))))


(display-rat (add-rat (make-rat -1 -2) (make-rat -1 8)))





