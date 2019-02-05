
(define x 10)

(parallel-execute 
  (lambda () (set! x ((s (lambda () (* x x))))))
  (s (lambda () (set! x (+ x 1)))))


; + 1 = 11
; 11^2 = 121


; 10^2 = 100
; 110 + 1 = 101



