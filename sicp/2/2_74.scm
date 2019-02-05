
(define (make-from-mag-angle mag a)
  (define (dispatch op)
    (cond ((eq? op 'real-part) (* mag (cos a)))
          ((eq? op 'imag-part) (* mag (sin a)))
          ((eq? op 'magnitude) mag)
          ((eq? op 'angle) a)
          (else (error "unknown op"))))
  dispatch)

(define (apply-generic op arg) (arg op))

(define pi 3.14159)

(let ((complex (make-from-mag-angle 1 (/ pi 4))))
    (display (apply-generic 'real-part complex))
    (newline)
    (display (apply-generic 'imag-part complex)))
 
