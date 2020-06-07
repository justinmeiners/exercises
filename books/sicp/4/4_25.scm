(define (unless pred usual exception)
  (if pred exception usual))

(define (factorial n)
  (unless (= n 1)
    (* n (factorial (- n 1)))
    1))


; what happens when (factorial 5) in applicative-order?

; it will run forever
; since unless is a componound procedure,
; it must evaluate its arguments before evaluating the procedure
; so unless always evaluates the factorial
; and the base case never stops the recursion


(display (factorial 5))

; what happens when (factorial 5) in normal-order (lazy)?
; Yes it should work fine


