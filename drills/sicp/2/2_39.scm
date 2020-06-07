(load "2_38.scm")
(use srfi-1)

(define (rev sequence)
  (fold-right (lambda (x y) (append y (list x)) ) '() sequence))

(define (rev2 sequence)
  (fold-left (lambda (x y) (cons y x)) '() sequence))

(display (rev '(1 2 3 4)))
(newline)
(display (rev2 '(1 2 3 4)))

