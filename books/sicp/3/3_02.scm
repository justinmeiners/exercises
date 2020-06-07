
(define (make-monitored f)
  (let ((count 0))
    (lambda (x)
      (if (eq? x 'how-many-calls)
        count
        (begin 
          (set! count (+ count 1))
          (f x))))))


(define s (make-monitored sqrt))

(display (s 100))
(newline)
(display (s 'how-many-calls))
(newline)
(display (s 20))
(newline)
(display (s 'how-many-calls))




