; An excercise in tropical semirings for my Abstract Algebra course. 
; The applications came from Alexander Stepanov's book 
; [From Mathematics to Generic Programming](http://www.fm2gp.com/).

(define (ring-create add-op add-identity mult-op mult-identity)
  (cons (cons add-op add-identity) (cons mult-op mult-identity)))

(define (ring-add-op ring) (car (car ring)))
(define (ring-add-identity ring) (cdr (car ring)))
(define (ring-mult-op ring) (car (cdr ring)))
(define (ring-mult-identity ring) (cdr (cdr ring)))

; matrix operation
(define (matrix-create n x)
  (cons n (make-vector (* n n) x)))

(define (matrix-index m row col)
  (+ col (* row (car m))))

(define (matrix-size m) (car m))

(define (matrix-set m row col x)
  (vector-set! 
    (cdr m) 
    (matrix-index m row col)
    x))

(define (matrix-get m row col)
  (vector-ref
    (cdr m)
    (matrix-index m row col)))

(define (matrix-multiply m1 m2 ring)
  (define (dot row col i sum)
    (if (= i (matrix-size m1))
      sum
      (dot row col (+ i 1)
        ((ring-add-op ring) sum 
             ((ring-mult-op ring) (matrix-get m1 row i)
                      (matrix-get m2 i col))))))

  (let ((new (matrix-create (matrix-size m1) (ring-add-identity ring))))
    (do ((row 0 (+ row 1)))
      ((= row (matrix-size m1)) 'done)
      (do ((col 0 (+ col 1)))
        ((= col (matrix-size m1)) 'done)
        (matrix-set new row col (dot row col 0 (ring-add-identity ring)))))
    new))

(define (matrix-display m)
  (do ((row 0 (+ row 1)))
    ((= row (car m)) 'done)
    (do ((col 0 (+ col 1)))
      ((= col (car m)) 'done)
      (display (vector-ref (cdr m) (matrix-index m row col)))
      (display " "))  
    (newline)))

; find the index of an item in a list
(define (index-of item collec)
  (define (iter n l)
    (if (null? l)
      -1
      (if (eq? (car l) item)
        n
        (iter (+ n 1) (cdr l)))))
  (iter 0 collec))


