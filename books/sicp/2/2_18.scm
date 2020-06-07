

; I guess this doesn't work because the cdr must point to another cons pair
; in order for it to be recognized as a list. In this case I am pointer the
; car of the pair to the next cons, so it treats it as a nesting of lists.
; It looks like Ivan (my answer key) did the same thing :)


(define (rev ls)
    (if (null? (cdr ls))
        (car ls)
     (cons (rev (cdr ls)) (car ls))
    ))
        
(display (rev (list 1 4 9 16 25)))
(newline)


; the solution is to use list appending, instead of manual cons
; this works with either order

(define (rev2 ls)
    (if (null? (cdr ls))
        (list (car ls))
     (append (rev2 (cdr ls)) (list (car ls)))
    ))

(display (rev2 (list 1 4 9 16 25)))
 

