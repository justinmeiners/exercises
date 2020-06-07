
; suppose the function pos+ takes a list and returns a list of each elements plus its position

; recursion
(defun pos+ (ls)
  (defun iter (ls i)
    (if (null ls)
      nil 
      (cons 
        (+ (car ls) i) 
        (iter (cdr ls) (+ i 1)))))
  (iter ls 0))

; iteration
       


(print (pos+ '(7 5 1 4)))


