


(display (list 'a 'b 'c))
(newline)
; (a b c)

(display (list (list 'george)))
(newline)
; ((george))

(display (cdr '((x1 x2) (y1 y2))))
(newline)
; (y1 y2)
; I got this one wrong..
; correct: ((y1 y1))

(display (cadr '((x1 x2) (y1 y2))))
(newline)
; y1
; and this one wrong...
; correct (y1 y2)


(display (pair? (car '(a short list))))
(newline)
; false

(display (memq 'red '((red shoes) (blue socks))))
(newline)
; false

(display (memq 'red '(red shoes blue socks)))
; (red shoes blue socks)







