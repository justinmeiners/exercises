
(define (make-account balance) 
  (define (withdraw amount) 
    (if (>= balance amount)
      (begin (set! balance
               (- balance amount))
             balance)
      "Insufficient funds"))
  (define (deposit amount)
    (set! balance (+ balance amount)) balance)
  (let ((protected (make-serializer))) 
    (define (dispatch m)
      (cond ((eq? m 'withdraw) (protected withdraw)) 
            ((eq? m 'deposit) (protected deposit)) 
            ((eq? m 'balance)
             ((protected
                (lambda () balance)))) ; serialized
            (else
              (error "Unknown request: MAKE-ACCOUNT"
                     m))))
    dispatch))

; so the serializer calls a sequence of procedures, with in-order guarentee.
; so does a serialized balance getter do anything?

; this stops you from getting thr balance while a withdrawel or deposit is being made.
; but this shouldn't have that much affect since its atomic anyway




