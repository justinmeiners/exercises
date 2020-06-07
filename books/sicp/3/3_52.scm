(load "3_50.scm")

(define sum 0)

(define (accum x)
    (set! sum (+ x sum)) sum)

(define seq (stream-map accum (stream-enumerate-interval 1 20)))

; sum should be 1
(display sum)
(newline)

;(define y (stream-filter even? seq))

; sum should be n(n+1)/2
; = 20 (21)/2 = 210 

;(display sum)
;(newline)

;(define z (stream-filter (lambda (x) (= (remainder x 5) 0)) seq))

;(display sum)
;(newline)

;(stream-ref y 7)

;(display sum)
;(newline)




