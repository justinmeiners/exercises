; Compiled with Chicken Scheme

; Example
; $ ./groups 
; enter the group order: 8
; Z_{8} 
; Z_{4} Z_{2} 
; Z_{2} Z_{2} Z_{2} 

(import srfi-1)
(import scheme (chicken io))

;(chicken io)

; Sieve of Eratosthenes
; I profiled it and it was much faster than
; the simpler implementation, howerver the 
; the rest of the code is pretty ineffecient

(: prime-sieve (number -> (list-of number)))

(define (prime-sieve count)
  (let ((marked (make-vector count #f)))

    (: build-list (number -> (list-of number)))
    (define (build-list index)
      (if (>= index count)
        '()
        (if (vector-ref marked index)
          (build-list (+ index 1))
          (cons (+ index 1) (build-list (+ index 1))))))

    (: next-prime (number -> null))

    (: mark (number number -> null))
    (define (next-prime index)
      (if (>= index count)
        marked
        (begin
          (if (vector-ref marked index)
            '()
            (mark (+ index 1) (+ index index 1)))
          (next-prime (+ index 1)))))

    (define (mark stride index)
      (if (>= index count)
        '()
        (begin
          (vector-set! marked index #t)
          (mark stride (+ index stride)))))

    (begin (next-prime 1) (build-list 1))))

(: divide-prime (number number --> (pair number number)))

(define (divide-prime n p)
  (define (iter m k)
    (if (= (modulo m p) 0)
      (iter (/ m p) (+ k 1))
      (cons m k)))
  (iter n 0))

(: factor (number (list-of number) --> (list-of number)))

(define (factor n prime-list)
  (if (null? prime-list)
    '()
    (let ((div-pair (divide-prime n (car prime-list))))
      (if (> (cdr div-pair) 0)
        (cons 
          (cons (car prime-list) (cdr div-pair))  
          (factor (car div-pair) (cdr prime-list)))
        (factor (car div-pair) (cdr prime-list))))))

(: partition-n (number --> (list-of (list-of number))))

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

(: cartesian-product (list list --> list))

(define (cartesian-product list-a list-b)
  (append-map 
    (lambda (a) (map (lambda (b) (append a b)) list-b)) list-a))

(: combine-partitions ((list-of number) -> list))

(define (combine-partitions factors)
  ; the way the combing works we need the elements in their own lists

  (: wrap-list (list --> (list-of list)))
  (define (wrap-list ls)
    (map (lambda (tail) (list tail)) ls))

  (if (null? (cdr factors))
    (wrap-list (partition-n (cdr (car factors))))
    (cartesian-product (wrap-list (partition-n (cdr (car factors))))
                       (combine-partitions (cdr factors)))))

(: apply-powers (number (list-of number) --> (list-of number)))

(define (apply-powers prime-factor power-list)
  (map (lambda (power) (expt prime-factor power)) power-list))

(: build-groups (number -> (list-of number)))

(define (build-groups n)
  ;  example combos ((1 1 1 1) (4)) 
  ;  example factors ((3 . n) (2 . m))  

  (define (build-combos power-lists factor-lists)
    (append-map (lambda (f p) 
                    (apply-powers (car f) p))
                factor-lists
                power-lists))

  (let* ((factors (factor n (prime-sieve n)))
         (solutions (combine-partitions factors)))
    (map (lambda (s)
           (build-combos s factors))
         solutions)))

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

