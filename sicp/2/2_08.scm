(load "2_07.scm")

(define (sub-interval x y)
  (add-interval x (make-interval (- (upper-bound y))
                                 (- (lower-bound y))
                                 )))

; Example:
; (5 +- 1) - (7 +-1) should be
; (-2 +- 2)
; (4, 6) + (-8, -6) = (-4, 0)

(display (sub-interval (make-interval 4 6) (make-interval 6 8)))
