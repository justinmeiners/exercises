(load "2_46.scm")

(define (make-frame1 origin xp yp)
  (list origin xp yp))

(define (origin-frame1 frame) (car frame))
(define (xp-frame1 frame) (car (cdr frame)))
(define (yp-frame1 frame) (car (cdr (cdr frame))))

(define (make-frame origin xp yp)
  (cons origin (cons xp yp)))

(define (origin-frame frame) (car frame))
(define (xp-frame frame) (car (cdr frame)))
(define (yp-frame frame) (cdr (cdr frame)))

;(let ((test1 (make-frame1 (make-vec 0 0) (make-vec 1 0) (make-vec 0 1))))
;  (display (origin-frame1 test1))
;  (newline)
;  (display (xp-frame1 test1))
;  (newline)
;  (display (yp-frame1 test1)))

;(newline)
;(let ((test2 (make-frame2 (make-vec 0 0) (make-vec 1 0) (make-vec 0 1))))
;  (display (origin-frame2 test2))
;  (newline)
;  (display (xp-frame2 test2))
;  (newline)
;  (display (yp-frame2 test2)))


