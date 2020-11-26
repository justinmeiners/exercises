; 6

; If a is atom, is there a list l that makes :

(define a 'atom)

(define l '())

(print (null? (cons a l)))

; true?


; I don't think so...
; the only null list is the empty list
; and any list made from this cons
; must be nonempty
