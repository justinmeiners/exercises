; 9
; what is

(define l '((kiwis mangoes lemons) and (more)))

(print (car (cdr (cdr (car l)))))

; (more)
; wrong :(
; lemons

(set! l '(() (eggs and (bacon)) (for) (breakfast)))

(print (car (cdr (car (cdr l)))))

; and

(set! l '(() () () (and (cofee)) please))

(print (car (cdr (cdr (cdr l)))))

; (and (coffee))

