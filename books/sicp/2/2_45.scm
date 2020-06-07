
(define (split first second) 
  (define (result painter n)
        (if (= n 0)
          painter
          (let ((smaller (result painter (- n 1))))
            (first painter (second smaller smaller)))))
  result)

  
(define right-split (split beside below))
(define up-split (split below beside))

