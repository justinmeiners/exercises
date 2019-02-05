
(define (conjunction-first exp)
    (car exp))

(define (conjustion-second exp)
    (car (cdr exp)))

(define (and? exp)
    (tagged-list? exp 'and))

(define (or? exp)
    (tagged-list? exp 'or))

; only evaluate the second if the first is true

((and? exp)
 (if (true? (eval (conjunction-first exp) env))
   (if (true? (eval (conjunction-second exp) env))
     true
     false)
   false))

; only evaluate the second if the first was false

((or? exp)
 (if (not (true? (eval (conjunction-first exp) env)))
   (if (not (true? (eval (conjunction-second exp) env)))
     false
     true)
   true))

; define them in terms of other

; exactly how I wrote them:

; (and <a> <b>) => (if <a> (if <b> true false) false)
; (or <a> <b>) => (if (not <a>) (if (not <b>) false true) true)


