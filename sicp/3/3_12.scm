
(define (append! x y) 
  (set-cdr! (last-pair x) y) x)

(define (last-pair x)
    (if (null? (cdr x)) 
      x 
      (last-pair (cdr x))))

; x = [a, ->] [b, nil]
(define x (list 'a 'b))
; y = [c, ->] [d, nil]
(define y (list 'c 'd))
; z = [a, ->] [b, ->] [c, ->] [d, nil]
(define z (append x y))

(display z)
(newline)
(display (cdr x)) ; response: b
(newline)

(define w (append! x y))

(display w)
(newline)
(display (cdr x)) ; response: (b c d)
(newline)

