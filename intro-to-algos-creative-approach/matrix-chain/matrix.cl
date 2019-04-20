
; associate matrices
; in a way so that 
; multiplications are minimized

(defvar matrix-list '((A 100 20) (B 20 5) (C 5 60) (D 60 300) (E 300 100) (F 100 2)))
(defvar wiki-list '((A 10 30) (B 30 5) (C 5 60)))

; M x P  P x N => M x N

; a a a ...  a      b b b ... b
; a     P times     b    N times
; a                 b
; ... M times       ... P times
; a                 b

; M * P * n

(defun count-mults (left right)
  (let ((rows-1 (nth 1 (car left)))
        (rows-2 (nth 1 (car right)))
        (cols-2 (nth 2 (car (last right)))))
    (* rows-1 rows-2 cols-2)))
  
; A(l) is the minimal number of multiplications
; for the best association of a list l

; ((a b) (c d))
; rows((a,b)) * columns((a,b)) * columns((c,d))

; A(l) = min{ A(l(0, k-1)) + A(l(k, n)) }

(defun associate (matrices)
  (let ((n (length matrices)))
    (if (= n 1)
      0
      (loop for k from 1 to (- n 1) minimize
            (let ((left (subseq matrices 0 k))
                  (right (subseq matrices k)))
              (+ (count-mults left right)
                 (associate left)
                 (associate right)))))))

; (cost list)

(defun min-reduce (a b)
  (if (< (car b) (car a))
    b
    a))

(defun cons-associate (matrices)
  (let ((n (length matrices)))
    (if (= n 1)
      (list 0 (car matrices))
      (reduce #'min-reduce
                (loop for k from 1 to (- n 1) collect
                    (let* ((left (subseq matrices 0 k))
                           (right (subseq matrices k))
                           (assoc-left (cons-associate left))
                           (assoc-right (cons-associate right)))
                      (list (+ (count-mults left right)
                               (car assoc-left)
                               (car assoc-right))
                            (list (cadr assoc-left)
                                  (cadr assoc-right)))))))))


