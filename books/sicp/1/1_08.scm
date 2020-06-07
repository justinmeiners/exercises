; Excercise 1.8

(define (square x) (* x x))
(define (cube x) (* (square x) x))

(define (average x y) (/ (+ x y) 2))

(define (good-enough? guess x)
    (< (abs (- guess x)) 0.001))


(define (improve guess x)
    (average guess (/ x guess)))    


(define (sqrt-root-iter guess x)
    (if (good-enough? (square guess) x)
        guess
        (sqrt-root-iter (improve guess x) x)))


(define (improve-cube guess x)
   (/ (+ (/ x (square guess)) (* 2 guess)) 3))

    
(define (cube-root-iter guess x)
    (if (good-enough? (cube guess) x)
        guess
        (cube-root-iter (improve-cube guess x) x)))


(display (sqrt-root-iter 1 9))
(newline)
(display (cube-root-iter 1.5 8.0))



