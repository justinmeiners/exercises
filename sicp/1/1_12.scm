; Excercise 1.12

(define (pascal col row)
    (cond ((< col 0) 0)
          ((> col row) 0)
          ((and (= col 0) (= row 0)) 1)
          (else (+ (pascal (- col 1) (- row 1)) (pascal col (- row 1))))
    ))



(define (print-pascal line line-count)
    (define (print-line col row count)
        (if (= count 0)
            (newline)  
            (begin 
                (display (pascal col row))
                (display " ")
                (print-line (+ col 1) row (- count 1)))))

    (if (= line-count 0)
        (newline)
        (begin 
            (print-line 0 line (+ 1 line))
            (print-pascal (+ line 1) (- line-count 1)))))

(print-pascal 0 20)








