
; invariant: a(b^n) = constant
; so to divide n/2, we need to square b or a
; to subtract n-1 w need to multiply a by b

(define (exp-fast b n) (exp-iter b n 1))

(define (exp-iter b n product)
    (cond ((= n 0) product):
            ; b^n = (b^2) n/2
          ( (even? n) (exp-iter (* b b) (/ n 2) product) )
            ; b^n = b * b^n-1
          ( else (exp-iter b (- n 1) (* product b)) )
    ))


(display (exp-fast 5 4))

(newline)

(display (exp-fast 5 3))

(newline)

(display (exp-fast 2 8))

(newline)

(display (exp-fast 7 21))







        
        
        


