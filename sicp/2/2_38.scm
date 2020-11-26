

(define (fold-right op initial sequence) 
  (if (null? sequence)
      initial
      (op (car sequence)
          (fold-right op initial (cdr sequence)))))

(define (fold-left op initial sequence) 
  (define (iter result rest)
    (if (null? rest) result
            (iter (op result (car rest))
                  (cdr rest))))
        (iter initial sequence))

; fold left and right differ when commutativity matters

; 1 / (2 / 3) = 3/2
;(display (fold-right / 1 (list 1 2 3)))
;(newline)

; (1 / 2) / 3 = 1/6
;(display (fold-left / 1 (list 1 2 3)))
;(newline)

; (1 (2 (3 nil)))
;(display (fold-right list `() (list 1 2 3)))
;(newline)

; (((nil 1) 2) 3)
;(display (fold-left list `() (list 1 2 3)))
;(newline)
         

