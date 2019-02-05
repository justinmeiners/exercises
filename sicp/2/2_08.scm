(load "2_07.scm")

(define (sub-interval x y)
    (make-interval (- (lower-bound x) (lower-bound y))
                   (- (upper-bound x) (upper-bound y))))
 
