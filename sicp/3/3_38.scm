

; Total $100

(define balanced 100)

; 1. Peter desposits $10

(set! balance (+ balance 10))

; 2. Peter withdraws $20

(set! balance (- balance 20))

; 3. Mary withdraws half

(set! balance (- balance (/ balance 2)))

; A) List all the different possible values for balance after these three transations have been completed, assuming that the banking system forces the three processes to run sequentionally in some order;

; 1. 
; + 10 = 110
; - 20 = 90
; / 2 = 45

; 2.
; / 2 = 50
; + 10 = 60
; - 20 - 40

; 3. 
; + 10 = 110
; / 2 = 55
; - 20 = 35

; 4. 
; - 20 = 80
; / 2 = 40
; + 10 = 50

; there are other orders of events, but only these possible outcomes


;B) this could get really hairy as in one process overwrites the other during a write.










