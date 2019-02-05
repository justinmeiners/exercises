(use srfi-1)

(define (enumerate-interval start end)
    (if (> start end)
        '()
        (cons start (enumerate-interval (+ 1 start) end))))

(define (flatmap proc seq)
    (fold-right append '() (map proc seq)))

(define (unique-pairs n)
 (flatmap 
    (lambda (i) 
      (map (lambda (j) (list i j))
           (enumerate-interval 1 (- i 1))))
        (enumerate-interval 1 n)))

(define (prime? n)
  (define (F n i) "helper"
    (cond ((< n (* i i)) #t)
          ((zero? (remainder n i)) #f)
          (else
           (F n (+ i 1)))))
 "primality test"
 (cond ((< n 2) #f)
     (else
      (F n 2))))

(define (prime-sum? pair)
  (prime? (+ (car pair) (cadr pair))))

(define (prime-sum-pairs n)
  (filter prime-sum? (unique-pairs n)))

(display (unique-pairs 4))
(newline)
(display (prime-sum-pairs 6))


