; Recursive
(define (f n)
    (if (< n 3) 
        n
        (+ 
            (f (- n 1)) 
            (* 2 (f (- n 2))) 
            (* 3 (f (- n 3)))
        )
    ))


; Iterative
(define (f2 n)
    (define (f2-iter n a b c)
        (if (= n 0)
            (+ a (* 2 b) (* 3 c))
            (f2-iter (- n 1) (+ a (* 2 b) (* 3 c)) a b)))

    (if (< n 3)
        n
        (f2-iter (- n 3) 2 1 0)))



; Display procedure
(define (show-terms n counter)
    (if (> counter 0)
        (begin  
            (display (f n))
            (display " ")
            (display (f2 n))
            (newline)
            (show-terms (+ n 1) (- counter 1))
        )))
        
 
(show-terms 0 20)
    
    


             
            
       

    
    
    

        
          
