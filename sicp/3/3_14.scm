(define (mystery x)
  (define (loop x y)
    (if (null? x)
      y
      (let ((temp (cdr x)))
        (set-cdr! x y)
        (loop temp x))))
  (loop x '()))


(define v '(a b c d))

; looks like its doing a swap? lets see
(display (define w (mystery v)))
; it reverses the list by swapping elements!
