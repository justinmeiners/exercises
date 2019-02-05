
; returns the sum of all non-nil elements

; a) 
; (defun summit (lst)
;  (remove nil lst)
;  (apply #'+ lst))

; removing is an expression, it doesn't modify the list

(defun summit (lst)
  (apply #'+ (remove nil lst)))

(print (summit (list 1 2 3 4)))


; b)
; (defun summit (lst)
;    (let ((x (car lst)))
;      (if (null x)
;        (summit (cdr lst))
;        (+ x (summit (cdr lst))))))


; it will never terminate
; the null case needs to end the execution

(defun summit2 (lst)
    (let ((x (car lst)))
      (if (null x)
        0
        (+ x (summit2 (cdr lst))))))

(print (summit2 (list 1 2 3 4)))


