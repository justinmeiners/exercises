
(define (make-account balance pass) 
  (define (withdraw amount) 
    (if (>= balance amount)
      (begin (set! balance (- balance amount)) balance)
      "Insufficient funds")) 

  (define (deposit amount)
    (set! balance (+ balance amount))
    balance)

  (define (pass-complain amount) "Incorrect Password")

  (lambda (pass-entry m)
    (if (not (eq? pass-entry pass))
      pass-complain
      (cond ((eq? m 'withdraw) withdraw)
            ((eq? m 'deposit) deposit)
            (else (error "Unknown request: MAKE-ACCOUNT"
                         m))))))

(define (make-joint account old-pass new-pass)
  (lambda (pass-entry m)
    (if (eq? new-pass pass-entry)
      (account old-pass m)
      "Incorrect password")))

(define hannah-acc (make-account 100 'secret))
(define justin-acc (make-joint hannah-acc 'secret 'pickle))

(display ((hannah-acc 'secret 'deposit) 20))
(newline)
(display ((justin-acc 'pickle 'withdraw) 5))













