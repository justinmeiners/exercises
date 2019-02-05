(load "ring-matrix.scm")

; finds the shortest path between graph points

(define tropical-ring (ring-create min +inf.0 + 0.0))

(define nodes '(A B C D E F G))
(define distance (matrix-create (length nodes) (ring-add-identity tropical-ring)))

; FM2GP pg 149
(matrix-set distance 0 0 0.0)
(matrix-set distance 0 1 6.0)
(matrix-set distance 0 3 3.0)

(matrix-set distance 1 1 0.0)
(matrix-set distance 1 4 2.0)
(matrix-set distance 1 5 10.0)

(matrix-set distance 2 0 7.0)
(matrix-set distance 2 2 0.0)

(matrix-set distance 3 2 5.0)
(matrix-set distance 3 3 0.0)
(matrix-set distance 3 5 4.0)

(matrix-set distance 4 4 0.0)
(matrix-set distance 4 6 3.0)

(matrix-set distance 5 2 6.0)
(matrix-set distance 5 4 7.0)
(matrix-set distance 5 5 0.0)
(matrix-set distance 5 6 8.0)

(matrix-set distance 6 1 9.0)
(matrix-set distance 6 6 0.0)

; display
(do ((i 0 (+ i 1)))
  ((= i (- (matrix-size distance) 1)) i)
  (matrix-display distance)
  (set! distance (matrix-multiply distance distance tropical-ring))
  (newline))
  
