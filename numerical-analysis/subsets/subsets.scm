; Created By: Justin Meiners (2018)

; base case: subsets of '() are '()

; assume we can find the the powerset for n items. P(n)
; then call the n+1 item x

; then the subsets including x are:
; P(n) union {A union {x} | A \in P(n)}

; In other words the powerset of P(n+1) includes all the subsets of P(n)
; in addition to all those same subsets with x inserted

; Therefore by induction we can find the powerset P(k) for any k

(define (subsets set)
  (if (null? set) '(())
    (append (map 
              (lambda (sub) (cons (car set) sub))
              (subsets (cdr set)))
            (subsets (cdr set)))))
