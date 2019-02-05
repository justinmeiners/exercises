(use srfi-1)

(define (enumerate-interval start end)
    (if (> start end)
        '()
        (cons start (enumerate-interval (+ 1 start) end))))

(define (flatmap proc seq)
    (fold-right append '() (map proc seq)))

(define empty-board '())

(define (adjoin-position row column positions)
    (cons (cons row column) positions)) ; append to front

(define (collides-row? position others)
    (cond ((null? others) #f)
           ((= (car position) (caar others)) #t)
           (else (collides-row? position (cdr others)))))

(define (collides-diagnol? position others)
    (cond ((null? others) #f)
           ((= (abs (/ 
                        (- (car position) (caar others))
                        (- (cdr position) (cdar others))))
                1) #t)
           (else (collides-diagnol? position (cdr others)))))


; I slightly modified this from the excercise
; k is unnecessary since the one to test is at the front
(define (safe? positions)
    (if (null? positions) 
        #t
        (not (or 
                (collides-row? (car positions) (cdr positions))
                (collides-diagnol? (car positions) (cdr positions))))))

(define (queens board-size) 
  (define (queen-cols k)
    (if (= k 0)
        (list empty-board) 
        (filter
            (lambda (positions) (safe? positions)) 
            (flatmap
                (lambda (rest-of-queens) (map (lambda (new-row)
                   (adjoin-position
                    new-row k rest-of-queens))
                 (enumerate-interval 1 board-size)))
          (queen-cols (- k 1))))))
  (queen-cols board-size))


; (display (safe? (list (cons 1 1) (cons -3 -2) (cons 2 3))))

(display (length (queens 8)))



