(defun get-file (filename)
  (with-open-file (stream filename)
    (loop for line = (read-line stream nil)
          while line
          collect line)))

(defun product (a b)
  (loop for x in a append
        (mapcar (lambda (y)
                  (cons x y)
                  ) b)
        ))


(defun check-sum (list)
  (= (apply #'+ list) 2020))

; by removing pairs
; that are already too large we can do much better.
(defun sum-too-big (list)
  (> (apply #'+ list) 2020))

(defparameter *numbers* (mapcar #'parse-integer (get-file "1.txt")) )

(print (length *numbers*))

(defun solve-1 ()
  (apply #'* (car (remove-if-not #'check-sum
                                 (product *numbers*
                                          (mapcar #'list *numbers*))))))

(defun solve-2 ()
  (apply #'* (car (remove-if-not #'check-sum
                                 (product *numbers*
                                          (remove-if #'sum-too-big
                                                     (product *numbers*
                                                              (mapcar #'list *numbers*))))))))

(pprint (solve-1))
(pprint (solve-2))

