(load "2_36.scm")

(define (dot-product a b)
    (accumulate + 0 (map * a b)))

(define (matrix-*-vector m v)
    (map (lambda (w) (dot-product v w)) m))

(define (transpose mat)
    (accumulate-n cons '() mat))

(define (matrix-*-matrix m n)
    (let ((cols (transpose n)))
        (map (lambda (x) (map (lambda (y) (dot-product x y)) cols)) m)))


(let ((matrix '((1 2 3 4) (4 5 6 6) (6 7 8 9))))
    (display (transpose matrix))
    (newline)
    (display (matrix-*-matrix matrix matrix)))


(let ((matrix '((1 0 0) (0 1 0) (0 0 1))))
    (newline)
    (display (matrix-*-vector matrix '(1 1 1))))


