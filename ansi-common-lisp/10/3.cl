
(defmacro random-choice (&rest exprs) 
  `(case (random ,(length exprs))
     ,@(let ((key -1))
         (mapcar #'(lambda (expr)
                     `(,(incf key) ,expr))
                 exprs))))

(print (macroexpand-1 '(random-choice (/ 1 0) (+ 1 2) (/ 1 0))))


;(defmacro nth-expr (n &rest expr)
;  `(eval (nth ,n (quote (list ,@expr)))))

(defmacro nth-expr (n &rest expr)
  `@(nth n expr))

(print (macroexpand-1 '(nth-expr 1 (/ 1 0) (+ 1 2) (/ 1 0))))

;(let ((n 2))
;  (print (nth-expr 1 (/ 1 0) (+ 1 2) (/ 1 0))))
