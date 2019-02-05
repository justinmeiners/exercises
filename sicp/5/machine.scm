

(define (make-stack)
  (let ((s '()))
    (define (push x)
      (set! s (cons x s)))
    (define (pop)
      (if (null? s)
          (error "empty stack")
          (let ((top (car s)))
            (set! s (cdr s))
            top)))
    (define (init)
      (set! s '())
      'done)
    (lambda (message)
      (cond ((eq? message 'push) push)
        ((eq? message 'pop) (pop))
        ((eq? message 'init') (init))
        (else (error "wtf"))))))

(define (stack-pop stack) (stack 'pop))
(define (stack-push stack x) ((stack 'push) x))

(define (make-register name)
  (let ((contents 'empty))
    (lambda (message)
      (cond ((eq? message 'get) contents)
        ((eq? message 'set) 
         (lambda (x) (set! contents x)))
        (else
          (error "what is this message?"))))))


(define (make-machine register-name ops program-text)
  (let ((machine (make-new-machine)))
    (for-each (lambda (reg-name))
              ((machine 'create-register)  reg-name)
              register-name)
    ((machine 'install-ops) ops)
    ((machine 'install-program)
     (assemble program-text machine))
    machine))

(define (set-register! machine register value))
(define (get-register machine register))
(define (start machine))

(define (make-new-machine)
  (let ((pc (make-register 'pc)))
    (flag (make-register 'flag))
    (stack (make-stack))
    (program '()))
  (let ((ops
          (list (list 'init-stack
                      (lambda () (stack 'init)))))
        (register-table
          (list (list 'pc pc) (list 'flag flag))))
    (define (create-register name)
      (if (assoc name register-table)
          (error "multiple")
          (set! register-table
            (cons (list name (make-register name))
                  register-table)))
      'created)
    (define (lookup-register name)
      (let ((val (assoc name register-table)))
        (if val
            (cadr val)
            (error "unknown"))))
    (define (execute)
      (let ((ins (pc 'get)))
        (if (null? ins)
            'done
            (begin
              ((execute-instruction (car ins))) (execute)))))
    (lambda (message)
      (cond ((eq? message 'start)
             (set-contents! pc program)
             (execute))
        ((eq? message 'install-program)
         (lambda (seq (set! program seq))))
        ((eq? message 'create-register) create-register)
        ((eq? message 'get-register) lookup-register)
        ((eq? message 'install-ops) (lambda (new-ops) (set! ops (append ops new-ops))))
        (else (error "weird mcachine"))))))


; Assembler 

(define (assemble program-text machine)
    (extract-labels program-text
        (lambda (ins labels)
            (update-ins! ins labels machine)
            ins)))


(define (extract-labels text receive)
  (if (null? text)
      (receive '() '())
      (extract-labels (cdr tex)
                      (lambda (ins labels)
                        (let ((next-ins (car text)))
                          (if (symbol? next-ins)
                              (receive ins
                                       (cons (make-label-entry next-ins ins) labels))
                              (receive 
                                (cons (make-instruction next-ins)
                                      ins))
                              labels))))))


; A GCD test

(define gcd-machine
  (make-machine 
    '(a b t)
    (list (list 'rem remainder) (list '= =))
    '(test-b
       (test (op =) (reg b) (const 0))
       (branch (label gc-done))
       (assign t (op rem) (reg a) (reg b))
       (assign a (reg b))
       (assign b (reg t))
       (goto (label test-b))
       gcd-done)))


; set inputs, run and display!
(set-register! gcd-machine 'a 206)
(set-register! gcd-machine 'b 40)
(start gcd-machine)
(display (get-register gcd-machine 'a))



