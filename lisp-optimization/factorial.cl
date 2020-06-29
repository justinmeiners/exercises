(declaim (optimize (speed 3) (safety 0) (space 0))) 

(defun factorial (n)
  (prog ((p 1))
        (declare (type fixnum n p))
        loop
        (if (<= n 1)
            (return p))
        (setq p (* p n))
        (decf n)
        (go loop)))

(factorial 10)


;(defun dot (a b)
;  (declare (type (vector single-float) a b))
;  (reduce #'+ (map 'vector (lambda (a b) (+ a b)) a b)))


(defun dot (a b)
  (declare (type (simple-vector) a b))
  (let ((sum 0.0) (N (array-total-size a)))
        (declare (type fixnum N))
        (declare (type single-float sum))

        (dotimes (i N)
           (setq sum (+ sum (* (aref a i) (aref b i)))))
        sum))



(dot #(1.0 2.0 3.0) #(4.0 5.0 6.0))
