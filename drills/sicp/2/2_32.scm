
(define (subsets s)
    (if (null? s)
        (list (list)) ; no more elements left. null set

        (let ((rest (subsets (cdr s)))) ; rest = subsets of S/{a}

            ; append the rest (subsets of S/{a})
            ; to the new subsets made by adding a
            (append rest (map (lambda (set) (cons (car s) set)) rest))
        )
    ))

; start with set containing null set [()]
; append 3 to it:
; [(3), ()]
; append 2 to all of them
; [(2, 3) (2), (3) ()]
; append 1 to all of them
; [(1, 2, 3), (1, 2), (1, 3), (1), (2, 3), (2), (3), ()]

(display (subsets (list 1 2 3)))


