

(define (test-and-set! cell)
  (if (car cell) 
    #t
    (begin (set-car! cell true) false)))

; what can go wrong ?

; A     B
; A: (if (car cell) false
;       B: (if (car cell) false
; A: ((set-car! cell) true) ret fals
;       B: ((set-car! cell) true) ret false

; so they both simulatoensly return false and set the true bit

