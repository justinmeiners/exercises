; 7

; Deterimine the value of

(define s 'x)
(define l 'y)

(print (cons s l))

; not valid in this book
; because l is not a list

(set! s '())
(set! l '())

(print (cons s l))

; (())

(set! s '())

; (print (car s))
; not allowed to take the car of an empty list

(set! l '(()))

(print (cdr l))

; ')


