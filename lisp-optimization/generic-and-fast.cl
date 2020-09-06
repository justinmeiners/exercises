; Can we make a generic function and then make specialized versions that are optimized?
; Open coding: https://stackoverflow.com/questions/20940426/what-does-it-mean-to-open-code-something-in-common-lisp

(declaim (optimize speed))

(declaim (inline reduce2))

(defun reduce2 (array op)
    (declare (type function op))

    (prog ((acc (aref array 0))
           (i 1)
           (N (length array)))

        (declare (type fixnum i N))

        loop
        (if (>= i N)
            (return acc))
        (incf i)
        (setf acc (funcall op acc (aref array i)))
        (go loop)
    ))

(defun max-integers (array)
    (declare (type (simple-array fixnum (*)) array))
    (reduce2 array #'>))

(defun sum-integers (array)
    (declare (type (simple-array fixnum (*)) array))
    (reduce2 array #'+))

(defun product-integers (array)
    (declare (type (simple-array fixnum (*)) array))
    (reduce2 array #'*))

