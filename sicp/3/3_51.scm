(load "3_50.scm")

(define (show x)
    (display x)
    (newline)
   x)

; shows 0 - 10
; and returns (0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10)
(define x (stream-map show (stream-enumerate-interval 0 10)))

; 5
(display (stream-ref x 5))
(newline)

; 7
(display (stream-ref x 7))

