; this turned out to be a terrible way to implement this
; what I did is evidence of my set way of thinking
; the better way is incredibly simple

(define (make-account balance pass) 
  (define pass-list (list pass))

  (define (withdraw amount) 
    (if (>= balance amount)
      (begin (set! balance (- balance amount)) balance)
      "Insufficient funds")) 

  (define (deposit amount)
    (set! balance (+ balance amount))
    balance)

  (define (pass-complain amount) "Incorrect Password")

  (define (check-pass pass)
    (define (iter plist)
        (and (not (null? plist))
             (or (eq? (car plist) pass)
                 (iter (cdr plist)))))
    (iter pass-list))

  (define (add-pass new-pass) ; statey password list manipulation
    (set! pass-list (append pass-list (list new-pass))))

  (lambda (pass-entry m)
    (if (not (check-pass pass-entry))
      pass-complain
      (cond ((eq? m 'withdraw) withdraw)
            ((eq? m 'deposit) deposit)
            ((eq? m 'add-pass) add-pass) ; I had to add this here to access the local functions
            (else (error "Unknown request: MAKE-ACCOUNT"
                         m))))))

(define (make-joint account pass-entry new-pass)
  (begin
    ((account pass-entry 'add-pass) new-pass)
    account)) ; more procedural

(define hannah-acc (make-account 100 'secret))
(define justin-acc (make-joint hannah-acc 'secret 'bob))

(display ((hannah-acc 'secret 'deposit) 10))
(newline)
(display ((justin-acc 'bob 'withdraw) 5))











