(use srfi-1)

(define (enumerate-interval start end)
    (if (> start end)
        '()
        (cons start (enumerate-interval (+ 1 start) end))))

(define (flatmap proc seq)
    (fold-right append '() (map proc seq)))

(define (unique-trips n)
 (flatmap 
    (lambda (i) 
      (flatmap (lambda (j) 
             (map (lambda (k) (list i j k)) (enumerate-interval 1 n)))
           (enumerate-interval 1 n)))
        (enumerate-interval 1 n)))

(define (trips-which-total n s)
  (define (sum-to? trip)
    (= (apply + trip) s))
  (filter sum-to? (unique-trips n)))

(display (trips-which-total 3 4))
(newline)


