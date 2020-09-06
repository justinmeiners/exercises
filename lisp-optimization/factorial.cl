(declaim (optimize (speed 3) (safety 0) (space 0))) 

(declaim (inline factorial))

(defun factorial (n)
  (prog ((p 1))
        (declare (type integer n p))
        loop
        (if (<= n 1)
            (return p))
        (setq p (* p n))
        (decf n)
        (go loop)))

;(factorial 10)


(declaim (notinline factorial))

; out of luck on this one.
; it cannot see that * will not overflow,
; and we have no control of that from the outside.
; a custom factorial would be required for better performance
(defun fast-factorial (n)
  (declare (type fixnum n))
  (declare (inline factorial))
  (factorial n))


