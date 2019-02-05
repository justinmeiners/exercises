; implement select 2_4


; Lets review first...
; select-k-n-ab
; select k from n where R(a, b)

(define (select-0-2 a b R)
  (if (R b a) b a))

(define (select-1-2 a b R)
  (if (R b a) a b))

(define (select-0-3 a b c R)
  (select-0-2 (select-0-2 a b R) c R))

(define (select-2-3 a b c R)
  (select-1-2 (select-1-2 a b R) c R))

; 3 cases we care about
; a <= b <= c (sorted)
; c <= a <= b
; a <= c <= b

(define (select-1-3-ab a b c R) 
  (if (not (R c b))
    b ; sorted 
    (select-1-2 a c R)))


(define (select-1-3 a b c R)
  (if (R b a)
    (select-1-3-ab b a c R)
    (select-1-3-ab a b c R)))

; ok I think I am ready

; 6 cases
; a <= b <= c <= d
; a <= c <= b <= d
; c <= a <= b <= d

; a <= c <= d <= b
; c <= d <= a <= b
; c <= a <= d <= b

(define (select-2-4-ab-cd a b c d R)
  (if (R b d)
    (select-1-2 b c R)
    (select-1-2 a d R)))

(define (select-2-4-ab a b c d R)
  (if (R c d)
    (select-2-4-ab-cd a b c d R)
    (select-2-4-ab-cd a b d c R)))

(define (select-2-4 a b c d R)
  (if (R a b)
    (select-2-4-ab a b c d R)
    (select-2-4-ab b a c d R)))


; we will use pairs with the cdr
; indicating the stability index
(define (<R a b)
  (< (car a) (car b)))

(define (gen-pairs n)
  (define (helper i tail)
      (if (= i n)
        tail
        (helper (+ i 1) (cons (cons 1 (- n i)) tail))))
  (helper 0 '()))


(display (select-0-2 (cons 2 0) (cons 2 1) <R))
(newline)
(display (select-1-2 (cons 2 0) (cons 2 1) <R))
(newline)
(display (select-1-3 (cons 1 0) (cons 2 1) (cons 3 2) <R))
(newline)
(display (select-1-3 (cons 1 0) (cons 1 1) (cons 1 2) <R))
(newline)
(display (select-1-3 (cons 1 0) (cons 2 1) (cons 3 2) <R))
(newline)
(display (apply select-2-4 (append (gen-pairs 4) (list <R) )))


