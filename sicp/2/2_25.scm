

(let (
    (x (list 1 3 (list 5 7) 9))     
    (y (list (list 7)))             
    (z (list 1 (list 2 (list 3 (list 4 (list 5 (list 6 7)))))))
    )

    ; (1 3 (5 7) 9)
    (display x)
    (newline)
    (display (car (cdr (car (cdr (cdr x))))))
    (newline)

    ; ((7))
    (display y)
    (newline)
    (display (car (car y)))
    (newline)

    ; (1 (2 (3 (4 (5 (6 7))))))
    (display z)
    (newline) 
    (display (car (cdr (car (cdr (car (cdr (car (cdr (car (cdr (car (cdr z)))))))))))))
    (newline)
)



