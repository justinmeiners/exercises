(use utils)

(define (monte-carlo trials experiment)
    (define (iter trials-remaining trials-passed)
        (cond ((= trials-remaining 0)
               (/ trials-passed trials))
            ((experiment)
                (iter (- trials-remaining 1) (+ trials-passed 1)))
            (else
                (iter (- trials-remaining 1) trials-passed))))
         (iter trials 0))

(define (random-in-range low high)
    (let ((rand-max 32767))
      (let ((integer (random rand-max))
            (range (- high low)))
          (+ low (* (/ integer rand-max) range)))))

(define (estimate-integral predicate trials x1 y1 x2 y2)
    (define (point-test)
        (let ((x (random-in-range x1 x2))
              (y (random-in-range y1 y2)))
            (predicate x y)))
    (* (- x2 x1) (- y2 y1) (monte-carlo trials point-test)))



;(define (point-in x y)
;    (and (>= y 0)
;         (<= y (* x x))))

;(display (estimate-integral point-in 5000 0 0 5 30))


; the random number generator in scheme is different, this is a test
;(do ((i 0 (+ i 1)))
;    ((= i 10) i)
;     (begin (display (random-in-range -1 1)) (newline)))

(define (in-unit-circle x y)
    (<= (+ (* x x) (* y y)) 1))

(display (estimate-integral in-unit-circle 50000 -1 -1 1 1))
    






