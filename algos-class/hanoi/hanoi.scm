; Created By: Justin Meiners (2018)
; Towers of Hanoi
; based on the description from
; Concrete Mathematics by Donald Knuth

(define (pole-make n)
  (define (build-list i)
    (if (> i n)
      '()
      (cons i (build-list (+ i 1)))))

  (define stack (build-list 1))

  (define (push x)
    (if (or (null? stack) (< x (car stack)))
      (set! stack (cons x stack))
      (error "you broke the rule")))

  (define (pop)
    (if (null? stack)
      (error "stack is empty")
      (let ((item (car stack)))
        (set! stack (cdr stack))
        item)))

  (define (print items)
    (if (null? items)
      (newline)
      (begin
        (display "-")
        (display (car items))
        (print (cdr items)))))

  (lambda (op)
    (cond ((eq? op 'push) push)
          ((eq? op 'pop) (pop))
          ((eq? op 'count) (length stack))
          ((eq? op 'print) (print stack)))))


(define disc-count 5)

(define a (pole-make disc-count))
(define b (pole-make 0))
(define c (pole-make 0))

(define (print-state)
  (display "a: ")
  (a 'print)
  (display "b: ")
  (b 'print)
  (display "c: ")
  (c 'print)
  (newline))

(define (move-discs n from extra to)
  (if (= n 0)
    'done
    (begin 
        (move-discs (- n 1) from to extra)
        (print-state)
        ((to 'push) (from 'pop))
        (move-discs (- n 1) extra from to))))

(move-discs disc-count a b c)
(display "final")
(newline)
(print-state)






