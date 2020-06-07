
(defmacro ntimes (n &rest expr)
  (let ((fname (gensym)))
    `(progn (defun ,fname (i)
              (if (< i 0) 
                nil
                (progn
                  ,@expr
                  (,fname (- i 1)))))
            (,fname ,n))))

(pprint (macroexpand-1 '(ntimes 10 (format t "hello world"))))
(ntimes 10 (format t "hello world"))

; now this time without defun

(defmacro ntimes-alt (n &rest expr)
  (let ((fname (gensym)))
    `(labels ((,fname (i)  
              (if (< i 0) 
                nil
                (progn
                  ,@expr
                  (,fname (- i 1))))))
            (,fname ,n))))

(pprint (macroexpand-1 '(ntimes-alt 10 (format t "hello world"))))
(ntimes-alt 10 (format t "hello world"))


