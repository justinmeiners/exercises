(define (count-change amount)
    (cc amount 5))
(define (cc amount kinds-of-coins)
    (cond ((= amount 0) 1)
          ((or (< amount 0) (= kinds-of-coins 0)) 0)
            (else (+ (cc amount
                    (- kinds-of-coins 1))
                    (cc (- amount 
                        (first-denomination kinds-of-coins))
                        kinds-of-coins)))))

(define (first-denomination kinds-of-coins)
    (cond ((= kinds-of-coins 1) 1)
          ((= kinds-of-coins 2) 5)
          ((= kinds-of-coins 3) 10)
          ((= kinds-of-coins 4) 25)
          ((= kinds-of-coins 5) 50))) 



(display (count-change 11))

; (cc 11 5)
; (+ (cc 11 4) (cc -39 4))
; (+ (+ (cc 11 3) (cc -14 4)) 0)
; (+ (+ (+ (cc 11 2) (cc 1 3)) 0) 0)
; (+ (+ (+ (+ (cc 11 2) (cc 6 2)) (+ (cc 1 2) (cc -9 3) )) 0) 0)
; ... bleh ...


;  For 1 cent it takes n steps to find:
;  (cc 100 1)
;  (+ (cc 100 0) (cc 99 1))
;  (+ 0 (+ (cc 99 0) (cc 98 1)))
;  (+ 0 (+ 0 (+ (cc 98 0) (cc 97 1))))
;  etc

;  For 5 cent it takes n/5 steps to find:

;  (cc 100 1)
;  (+ (cc 100 0) (cc 95 1))
;  (+ 0 (+ (cc 90 0) (cc 90 1)))
;  (+ 0 (+ 0 (+ (cc 85 0) (cc 85 1))))
;  etc


; so the total is n * n/5 * n/10 * n/25 * n/50
; = n^5 / 62500








