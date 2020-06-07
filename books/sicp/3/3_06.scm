
; really random :)
(define (rand-update x) (* (+ x 1) 2))
(define rand-init 0)

(define rand
    (let ((x rand-init))
        (lambda (dispatch)
            (cond ((eq? dispatch 'generate)
                     (set! x (rand-update x)))
                   ((eq? dispatch 'reset)
                    (set! x rand-init))
                   (else (error "unknown dispatch"))))))

(do ((i 0 (+ i 1)))
     ((= i 10) i)
      (begin
        (display (rand 'generate))
        (newline)))

(rand 'reset)

(do ((i 0 (+ i 1)))
     ((= i 10) i)
      (begin
        (display (rand 'generate))
        (newline)))
