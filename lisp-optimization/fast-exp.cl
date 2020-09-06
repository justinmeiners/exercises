
(declaim (optimize (speed 3) (space 0) (safety 0)))

(declaim (inline fast-exp))

(defun fast-exp (r x n op)
  (declare (type integer n))
  (declare (type function op))
  (prog ()
        loop
        (if (= n 0)
            (return r)) 

        (if (oddp n)
            (setf r (funcall op r x))
            )

        (setf x (funcall op x x))
        (setf n (the integer (floor n 2)))
        (go loop)
        ))

(declaim (notinline fast-exp))

(defun fast-integer-power (x N)
  (declare (type fixnum x N))
  (declare (inline fast-exp))
  
  (fast-exp x x (- N 1) (lambda (a b) (logand #xffffffff (* a b)))))
 
;(print (fast-integer-power 2 8))
