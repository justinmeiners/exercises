
(define a 'french)
(define l '(fries))

; what is?
(print (car (cons a l)))

; french

(set! a 'oranges)
(set! l '(apples and peaches))

; what is?
(print (cdr (cons a l)))

; (apples and peaches)

