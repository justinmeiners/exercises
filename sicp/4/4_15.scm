
; the halting problem

; why can't you implement halts?
; is halts? analyzing the source code?
; Yes, wikipedia clarifies:

; " the halting problem is the problem of determining, from a description of an arbitrary computer program and an input, whether the program will finish running or continue to run forever."


(define (run-forever) (run-forever))

(define (try p)
    (if (halts? p p)
        (run-forever)
        'halted))
        

; consider (try try)

; halts? returns true
; then it runs forver...
; so halts? lied to us

; halts returns false
; then it returns the message halts...
; so halts? lied to us again


; so one cannot make a halting test

; https://en.wikipedia.org/wiki/Halting_problem



