(declaim (optimize (speed 3) (safety 0) (space 0)))

(defun do-product (base length fn)
  (let ((digits (make-array length :initial-element 0)))
    (declare (type (simple-array fixnum *)))
    (prog ((total 0) (carry 0))
     (declare (type fixnum total carry base length))
      loop
      (funcall fn digits)
      (incf (aref digits 0))
      (setf carry 0)
      (setf sum 0)
      (dotimes (i length)
        (setf total (+ carry  (aref digits i)))
        (setf (aref digits i) (mod total base))
        (setf carry (floor total base)))

      (dotimes (i length)
        (if (not (= (aref digits i) 0))
            (go loop)
            nil))
      )))

(do-product 3 3 #'pprint)
