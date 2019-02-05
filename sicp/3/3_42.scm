
(define (make-account balance) 
  (define (withdraw amount) 
    (if (>= balance amount)
      (begin (set! balance (- balance amount)) balance)
      "Insufficient funds")) 
  (define (deposit amount)
    (set! balance (+ balance amount))
    balance)
  (let ((protected (make-serializer)))
    (let ((protected-withdraw (protected withdraw)) 
          (protected-deposit (protected deposit)))
      (define (dispatch m)
        (cond ((eq? m 'withdraw) protected-withdraw)
              ((eq? m 'deposit) protected-deposit)
              ((eq? m 'balance) balance)
              (else
                (error "Unknown request: MAKE-ACCOUNT"
                       m))))
      dispatch)))

; is there any difference?

; this reuses the same serialization set
; the other one before added a new procedure to the serilization set each call
; this one is probably better 



