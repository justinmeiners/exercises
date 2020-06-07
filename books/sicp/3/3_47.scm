
(define (make-semaphore n)
  (let ((count 0)
        (mutex (make-mutex)))
    (define dispatch (m)
      (cond ((eq? m 'acquire)
              (mutex 'acquire)
              (if (< count n)
                (begin (set! count (+ count 1))
                       (mutex 'release)
                       count)
                (begin
                  (mutex 'release)
                  (dispatch 'acquire))))
            ((eq? m 'release)
                (mutex 'acquire)
                (if (> count 0)
                  (begin
                    (set! count (- count 1))
                    (mutex 'release)
                    count)
                  (begin
                    (mutex 'release)
                    (display "over release"))))))))

