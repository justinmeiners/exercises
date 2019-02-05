; Also in SICP 1.2.4
; https://mitpress.mit.edu/sites/default/files/sicp/full-text/book/book-Z-H-11.html#%_sec_1.2.4

; if n = 1
;    a
; if even
;   a^n = (a^2)^(n/2)
; if odd
;   a^n = a * (a^2)^((n-1)/2)

(define (power-assoc x n op)
      (cond ((= n 1) x)
                      ((= (modulo n 2) 0) 
                                   (power-assoc (op x x) (/ n 2) op)) 
                                (else 
                                              (op x (power-assoc (op x x) (/ (- n 1) 2) op)))))
  
; 2^16
(display (power-assoc 2 16 *))


; TODO implementation with an accumlator that doesn't keep state on the stack
