(load "3_28.scm")

(define the-agenda (make-agenda))
(define inverter-delay 1)
(define and-gate-delay 3)
(define or-gate-delay 5)

(define input-1 (make-wire))
(define input-2 (make-wire))
(define sum (make-wire))
(define carry (make-wire))

(probe 'sum sum)
(probe 'carry carry)

(half-adder input-1 input-2 sum carry)

(set-signal! input-1 1)
(propogate)

(set-signal! input-2 1)
(propogate)


