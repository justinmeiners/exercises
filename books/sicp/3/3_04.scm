
(define (call-the-cops)
  "The coppers were called!")

(define (make-account balance attempts pass) 
  (define (withdraw amount) 
    (if (>= balance amount)
      (begin (set! balance (- balance amount)) balance)
      "Insufficient funds")) 

  (define (deposit amount)
    (set! balance (+ balance amount))
    balance)

  (define (pass-complain amount) 
    (begin (set! attempts (+ attempts 1))
           (if (> attempts 7)
             (call-the-cops)
             "Incorrect Password")))

  (define (dispatch pass-entry m)
    (if (not (eq? pass-entry pass))
      pass-complain
      (cond ((eq? m 'withdraw) withdraw)
            ((eq? m 'deposit) deposit)
            (else (error "Unknown request: MAKE-ACCOUNT"
                         m)))))
  dispatch)

(define acc (make-account 100 0 'secret))

(do ((i 0 (+ i 1)))
  ((= i 10) i)
  (begin
    (display ((acc 'yolo 'deposit) 5))
    (newline)))












