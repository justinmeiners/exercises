(load "3_28.scm")

(define (ripple-carry-adder a-list b-list s-list c-in)
  (if (or (null? a-list) (null? b-list) (null? s-list))
    'ok
    (let ((new-c (make-wire)))
      (full-adder 
        (car a-list) ; add a
        (car b-list) ; to b
        c-in         ; input the previous carry
        (car s-list) ; output to s
        new-c)       ; to the new wire
      (ripple-carry-adder 
        (cdr a-list) 
        (cdr b-list) 
        (cdr s-list) 
        new-c))))

(define (build-wires n)
    (if (= n 0)
        '()
        (cons (make-wire) (build-wires (- n 1)))))

(define (binary-display name wire-list)
  (define (displayer wire)
    (add-action! wire
                 (lambda ()
                   (display name)
                   (display " ")
                   (display (current-time the-agenda))
                   (display " New-value = ")
                   (do ((w wire-list (cdr w)))
                     ((null? w) 'ok)
                     (display (get-signal (car w))))
                   (newline))))

  (define (iter wires)

    (if (null? wires)
      'ok
      (begin
        (displayer (car wires))
        (iter (cdr wires)))))
  (iter wire-list))

(define the-agenda (make-agenda))
(define inverter-delay 1)
(define and-gate-delay 3)
(define or-gate-delay 5)

(define a_s (build-wires 8))
(define b_s (build-wires 8))
(define s_s (build-wires 8))

(define c_in (make-wire))

(binary-display 'a a_s)
(binary-display 'b b_s)
(binary-display 'sum s_s)

(ripple-carry-adder a_s b_s s_s c_in)
(propogate)
(display "break\n")

(set-signal! (list-ref a_s 0) 1)
(set-signal! (list-ref a_s 1) 1)
(set-signal! (list-ref a_s 2) 1)
(set-signal! (list-ref a_s 3) 1)

(set-signal! (list-ref b_s 1) 1)
(propogate)




