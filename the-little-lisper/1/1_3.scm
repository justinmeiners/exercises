; 1.3 The list (all these problems) can be construced by
; (cons a (cons b (cons c d)))

; where

(define a 'all)
(define b 'these)
(define c 'problems)
(define d '())

(print (cons a (cons b (cons c d))))

; (all (these problems))
(print (cons a (cons (cons b (cons c d)) d)))

; (all (these) problems)
(print (cons a (cons (cons b d) (cons c d))))

; ((all these) problems)
(print (cons (cons a (cons b d)) (cons c d)))

; ((all these problems))
(print (cons (cons a (cons b (cons c d))) d)`)



