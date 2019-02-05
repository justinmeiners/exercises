; Compiled with Chicken Scheme

; Example
; $ ./groups 
; enter the group order: 8
; Z_{8} 
; Z_{4} Z_{2} 
; Z_{2} Z_{2} Z_{2} 

(use srfi-1)
(use extras)

; Sieve of Eratosthenes
; I profiled it and it was much faster than
; the simpler implementation, howerver the 
; the rest of the code is pretty ineffecient
(define (prime-sieve count)
  (let ((marked (make-vector count #f)))
    (define (build-list index)
      (if (>= index count)
        '()
        (if (vector-ref marked index)
          (build-list (+ index 1))
          (cons (+ index 1) (build-list (+ index 1))))))
    (define (next-prime index)
      (if (>= index count)
        marked
        (begin
          (if (vector-ref marked index)
            'done
            (mark (+ index 1) (+ index index 1)))
          (next-prime (+ index 1)))))
    (define (mark stride index)
      (if (>= index count)
        'ok
        (begin
          (vector-set! marked index #t)
          (mark stride (+ index stride)))))
    (begin (next-prime 1) (build-list 1))))

(define (divide-prime n p)
  (define (iter m k)
    (if (= (modulo m p) 0)
      (iter (/ m p) (+ k 1))
      (cons m k)))
  (iter n 0))

(define (factor n prime-list)
  (if (null? prime-list)
    '()
    (let ((div-pair (divide-prime n (car prime-list))))
      (if (> (cdr div-pair) 0)
        (cons 
          (cons (car prime-list) (cdr div-pair))  
          (factor (car div-pair) (cdr prime-list)))
        (factor (car div-pair) (cdr prime-list))))))

(define (partition-n n)
  ; partition(n)
  ; (n) + part(0)
  ; (n - 1) + part(1)
  ; (n - 2) + part(2)
  ; ...
  ; (1) + part(n - 1) 
  (define (iter k)
    (if (= k n)
      '()
      (append
        (map 
          (lambda (tail) (cons (- n k) tail)) 
          (filter (lambda (tail) 
                    (or (null? tail)
                        (<= (car tail) (- n k)))) 
                  (partition-n k)))
        (iter (+ k 1)))))
  ; partition(0) = (null)
  (if (= n 0)
    (list '())
    (iter 0)))

(define (cartesian-product list-a list-b)
  (append-map 
    (lambda (a) (map (lambda (b) (append a b)) list-b)) list-a))

(define (combine-partitions factors)
  ; the way the combing works we need the elements in their own lists
  (define (wrap-list ls)
    (map (lambda (tail) (list tail)) ls))
  (if (null? (cdr factors))
    (wrap-list (partition-n (cdr (car factors))))
    (cartesian-product (wrap-list (partition-n (cdr (car factors))))
                       (combine-partitions (cdr factors)))))

(define (apply-powers prime-factor power-list)
  (if (null? power-list)
    '()
    (cons (expt prime-factor (car power-list))
          (apply-powers prime-factor (cdr power-list)))))

(define (build-groups n)
  ;  example combos ((1 1 1 1) (4)) 
  ;  example factors ((3 . n) (2 . m))  
  (define (iter-combos power-lists factors)
    (if (null? power-lists)
      '()
      (append (apply-powers (car (car factors)) (car power-lists))
              (iter-combos (cdr power-lists) (cdr factors)))))

  (define (iter-solutions solutions factors)
    (if (null? solutions)
      '()
      (cons (iter-combos (car solutions) factors)
            (iter-solutions (cdr solutions) factors))))

  (let* ((factors (factor n (prime-sieve n)))
         (solutions (combine-partitions factors)))
    (iter-solutions solutions factors)))

(define (input-loop)
  (define (display-group group)
    (map 
      (lambda (order)
        (display "Z_{") (display order) (display "} "))
      group))

  (begin
    (display "enter the group order: ")
    (map 
      (lambda (group) (display-group group) (newline))
      (build-groups (string->number (read-line))))
    (newline)
    (input-loop)))

(input-loop)

