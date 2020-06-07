
(define (make-vec x y) (cons x y))

(define (xcor-vec vec) (car vec))
(define (ycor-vec vec) (cdr vec))

(define (add-vec a b)
  (make-vec (+ (xcor-vec a) (xcor-vec b))
            (+ (ycor-vec a) (ycor-vec b))))

(define (sub-vec a b)
  (make-vec (- (xcor-vec a) (xcor-vec b))
            (- (ycor-vec a) (ycor-vec b))))

(define (scale-vec a c)
  (make-vec (* (xcor-vec a) c)
            (* (ycor-vec a) c)))

;(display (add-vec (make-vec 1 0) (scale-vec (make-vec 1 1) 2)))






