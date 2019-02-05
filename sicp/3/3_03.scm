
(define (make-account balance pass) 
  (define (withdraw amount) 
    (if (>= balance amount)
      (begin (set! balance (- balance amount)) balance)
      "Insufficient funds")) 

  (define (deposit amount)
    (set! balance (+ balance amount))
    balance)

  (define (pass-complain amount) "Incorrect Password")

  (define (dispatch pass-entry m)
    (if (not (eq? pass-entry pass))
      pass-complain
      (cond ((eq? m 'withdraw) withdraw)
            ((eq? m 'deposit) deposit)
            (else (error "Unknown request: MAKE-ACCOUNT"
                         m)))))
  dispatch)

(define acc (make-account 100 'secret))

(display ((acc 'yolo 'deposit) 10))
(newline)
(display ((acc 'secret 'deposit) 10))
(newline)
(display ((acc 'secret 'withdraw) 10))
(newline)
(display ((acc 'dawg 'withdraw) 10))
(newline)












