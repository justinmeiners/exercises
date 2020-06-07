
(define (accumulate op initial sequence)
    (if (null? sequence)
        initial
        (op (car sequence)
            (accumulate op initial (cdr sequence)))
    ))

(define (map2 p sequence)
    (accumulate (lambda (x y) (cons (p x) y)) (list) sequence))

(define (append2 s1 s2)
    (accumulate cons s2 s1))

(define (length2 s)
    (accumulate (lambda (x y) (+ 1 y)) 0 s))

(display (map2 (lambda (x) (+ x 1)) (list 1 2 3 4)))
(newline)
(display (append2 (list 1 2 3) (list 4 5 6)))
(newline)
(display (length2 (list 1 2 3 4 5)))
    
