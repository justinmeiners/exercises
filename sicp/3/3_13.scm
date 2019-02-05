
; [a, ->] [b, ->] [c, ->] (back to a)
(define (make-cycle x)
  (set-cdr! (last-pair x) x)
  x)

; it will have an infinite loop!
