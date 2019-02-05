
(defun showdots (ls)
  (if (null ls)
    (format t "NIL")
    (progn
        (format t "(~A . " (car ls))
        (showdots (cdr ls))
        (format t ") "))))
                
(showdots '(a b c))
  
