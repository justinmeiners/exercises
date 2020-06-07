; 8 true or false


(define l '((meatballs) and spaghetti))

(print (atom? (car l)))

; false
; list conttaining an item

(set! l '((meatballs)))
(print (null? (cdr l)))

; true

(set! l '(two meatballs))
(print (eq? (car l) (car (cdr l))))

; false

(set! l '(ball))
(define a 'meat)

(print (atom? (cons a l)))

; false


