(load "ring-matrix.scm")

; or and and are not functions, but compiler expanded
; so we need to wrap
(define (logical-or a b) (if (or (= a 1) (= b 1)) 1 0))
(define (logical-and a b) (if (and (= a 1) (= b 1)) 1 0))

(define adjacency-ring (ring-create logical-or 0 logical-and 1))

(define people '(DEREK JUSTIN JAMES GREG DON))
(define relation (matrix-create (length people) 0))

(define (make-friend from-name to-name)
  (let ((row (index-of from-name people))
        (col (index-of to-name people)))
  (matrix-set relation row col 1)
  (matrix-set relation col row 1)))
  
(define (friend-self people)
  (if (null? people)
    'done
    (begin
      (make-friend (car people) (car people))
      (friend-self (cdr people)))))

(friend-self people)
(make-friend 'JUSTIN 'DEREK)
(make-friend 'GREG 'DON)
(make-friend 'JUSTIN 'GREG)
(make-friend 'GREG 'JAMES)

(matrix-display relation)
(newline)
(matrix-display (matrix-multiply relation relation adjacency-ring))

