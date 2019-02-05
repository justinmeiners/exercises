
; EXERCISE
; implement a definition space predicate for addition on 32 bit signed integers.


(define (addable a b)
  (define INT_MAX 214783647)
  (define INT_MIN -2147483648)

  (if (>= a 0)
    (<= b (- INT_MAX a))
    (> b (INT_MIN - a))))


; NOTES
; looks right to me! 
; https://stackoverflow.com/questions/6970802/test-whether-sum-of-two-integers-might-overflow
