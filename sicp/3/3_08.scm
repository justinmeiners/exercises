
; (+ (f 0) (f 1))

; turns 0 if the arguments to + are left to right
; but will return 1 if the arguments are evaluated from right to left


; (f1 0) + (f2 1) = 0
; and
; (f1 1) + (f2 0) = 1

(define previous '())
(define (f x)
  (if (null? previous)
    (begin
      (set! previous x)
      x)
    0))

 
; first expand with 0
; then expand with 1

;(display (+ (f 0) (f 1)))
(newline)
(display (+ (f 1) (f 0)))
