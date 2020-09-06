(declaim (optimize (speed 3) (safety 0) (space 0))) 

(deftype vecN (N) `(simple-array single-float (,N) ))

(declaim (inline sum-array dot))

(declaim (ftype (function (array) real) sum-array))

(defun sum-array (array)
  (prog ((acc (aref array 0)) (i 1) (N (length array)))
      (declare (type fixnum i N))

      loop
      (if (>= i N)
          (return acc)
          )
      (setf acc (+ acc (aref array i)))
      (incf i)
      (go loop)
      ))

(defun dot (a b)
  (sum-array (map '(vecN *) 
                  (lambda (a b)
                    (declare (type single-float a b))
                    (+ a b)) 
                  a b)))


(deftype vec3 () '(vecN 3))


(defun dot3 (a b)
  (declare (type vec3 a b))
  (dot a b))

(defun fast-dot3 (a b)
  (declare (type vec3 a b))

  (let ((acc (the single-float 0.0)))
    (dotimes (i (length a))
      (declare (type fixnum i))
      (setf acc (the single-float (* acc (+ (aref a i)
                                            (aref b i)
                                            )

                                     )))

      )))


(defun fast-dot3-2 (a b)
  (declare (type vec3 a b))
  (+ (* (aref a 0) (aref b 0))
     (* (aref a 1) (aref b 1))
     (* (aref a 2) (aref b 2))
     ))
 
