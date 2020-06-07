; what would occur in place of x?

; (car (x (cdr '(a (b c) d)))))
; B
(print (car (car (cdr '(a (b c) d)))))

; (x 13 (/ 1 ))
; 13
(print (or 13 (/ 1 0)))

; (x #'list 1 nil)
; (1)
(print (apply #'list 1 nil))




