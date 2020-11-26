(load "2_12.scm")

(define (par1 r1 r2)
        (div-interval (mul-interval r1 r2)
                      (add-interval r1 r2)))

(define (par2 r1 r2)
        (let ((one (make-interval 1 1)))
             (div-interval
                one 
                (add-interval 
                    (div-interval one r1)
                    (div-interval one r2))
                )))

; the error's are propogated at each step
; so it is best to have as few operations as possible

(let ((r1 (make-interval 4 5))
      (r2 (make-interval 8 10)))
        (display (par1 r1 r2))
        (newline)
        (display (par2 r1 r2)))

                        
    
