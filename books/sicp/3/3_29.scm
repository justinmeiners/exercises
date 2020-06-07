(load "3_28.scm")


; or gate defined in terms of and and not

; I used a truth table to find this
;~(~P^~Q)

(define (or-gate2 a1 a2 output)
  (let ((a (make-wire))
        (b (make-wire))
        (c (make-wire)))
    (inverter a1 a)
    (inverter a2 b)
    (and-gate a b c)
    (inverter c output)
    'ok))

; delay = I + A + I = 2I + A
