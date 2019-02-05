; EXCERCISE
; use find_if and find_if_not to implement
; quantifier functions all, none, not_all, and some,
; each taking a range and a predicate


(define (find-if ls p)
  (if (null? ls)
    #f
    (if (p (car ls))
      #t
      (find-if (cdr ls) p))))

; find_if_not applies the complement to the predicate
(define (find-if-not ls p)
  (find-if ls (lambda (x) (not (p x)))))


; all means -> none do not satisfy the predicate
(define (all ls p)
  (not (find-if-not ls p)))

(define (none ls p)
  (not (find-if ls p)))

(define (not-all ls p)
  (find-if-not ls p))

(define (some ls p)
  (find-if ls p))

; trure
(display (all '(2 4 6 8) even?))
(newline)

; false
(display (all '(2 4 6 7 8) even?))
(newline)

; true
(display (none '(2 4 6 8) odd?))
(newline)


; false
(display (none '(7 3 4 8) odd?))
(newline)

; true
(display (not-all '(7 3 4 8) odd?))
(newline)

; true
(display (some '(2 4 6 8) even?))
(newline)

; false
(display (some '(2 4 6 8) odd?))
(newline)












