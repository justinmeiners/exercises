(defun transform (subject &key (loops -1) (target -1))
  (prog ((v 1)
         (n 0))
        loop
        (if (or (= v target) (= n loops))
            (return (cons v n)))
        (setf v (mod (* v subject) 20201227))
        (incf n)
        (go loop)))

(defparameter *test-card-public* 5764801)
(defparameter *test-door-public* 17807724)

(assert (= 8 (cdr (transform 7 :target *test-card-public*))))
(assert (= 11 (cdr (transform 7 :target *test-door-public*))))
(assert (= 14897079 (car (transform *test-card-public* :loops 11))))

(defparameter *card-public* 16616892)
(defparameter *door-public* 14505727)

(pprint (car (transform *door-public* :loops (cdr (transform 7 :target *card-public*)))))


