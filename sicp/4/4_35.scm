
(define (an-integer-between low high)
    (require (<= low high))
    (amb low (an-integer-between (+ low 1) high)))

; the idea here is that either amb picks the current (low)
; or it chooses between [low + 1, high]
