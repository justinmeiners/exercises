
(define (inc x) (+ x 1))
(define (dec x) (- x 1))

(define (add a b)
    (if (= a 0)
        b
        (inc (add (dec a) b))))

; (add 4 5)
; (+ 1 (add 3 5)
; (+ 1 (+ 1 (add 2 5)
; (+ 1 (+ 1 (+ 1 (add 1 5)
; (+ 1 (+ 1 (+ 1 (+ 1 (add 0 5)
; (+ 1 (+ 1 (+ 1 (+ 1 5))))
; (+ 1 (+ 1 (+ 1 6)))
; (+ 1 (+ 1 7))
; (+ 1 8)
; 9

; Recursive process


(define (add2 a b)
    (if (= a 0)
        b
        (+ (dec a) (inc b))))

; (add 4 5)
; (add 3 6)
; (add 2 7)
; (add 1 8)
; 9


; Linear iteration

