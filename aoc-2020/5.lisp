
(defun split-delimiterp (c) (or (char= c #\Space) (char= c #\:)))

(defun split-string (string &key (delimiterp #'split-delimiterp))
  (loop :for beg = (position-if-not delimiterp string)
        :then (position-if-not delimiterp string :start (1+ end))
        :for end = (and beg (position-if delimiterp string :start beg))
        :when beg :collect (subseq string beg end)
        :while end))

(defun get-file (filename)
  (with-open-file (stream filename)
    (loop for line = (read-line stream nil)
          while line
          collect line)))



(defparameter *input* (get-file "5.txt"))

(defun split (high range)
  (let ((mid (ceiling (- (cdr range) (car range)) 2)))
    (if high
        (cons (+ (car range) mid) (cdr range))
        (cons (car range) (+ (car range) mid))
        )))

(defun adjust (pos command)
  (case command
    (#\F (list
           (first pos)
           (split nil (second pos))
           ))
    (#\B (list
           (first pos)
           (split t (second pos))
           )) 
    (#\R (list
           (split t (first pos))
           (second pos)
           )) 
    (#\L (list
           (split nil (first pos))
           (second pos)
           )) ))

(defun search-done (range)
  (= 1 (- (cdr range) (car range))) )

(defun get-seat (pos)
  (assert (search-done (first pos)))
  (assert (search-done (second pos)))

  (cons (car (first pos))
        (car (second pos))))

(defun seat-id (seat)
  (+ (car seat) (* (cdr seat) 8)))

(defun eval-bsp (str)
  (get-seat (reduce #'adjust
                    (coerce str 'list)
                    :initial-value (list (cons 0 8) (cons 0 128))
                    )))

(defun solve-1 ()
  (apply #'max (mapcar #'seat-id (mapcar #'eval-bsp *input*))) )

(pprint (solve-1))


(defun solve-2 ()
  (let ((best '()))
    (reduce (lambda (previous next)
              (if (> (- next previous) 1)
                  (push (+ 1 previous) best)
                  )
              next
              )
            (sort (mapcar #'seat-id (mapcar #'eval-bsp *input*)) #'<))
    best))

(pprint (solve-2))


