
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

(defun get-fields (line)
  (split-string line))


(defun cartesian-product (a b)
  (loop for x in a append
    (mapcar (lambda (tail)
              (append (if (consp x) x (list x)) 
                      (if (consp tail) tail (list tail)))) b)))

(defun shift (a b)
  (mapcar #'+ a b))

(defun iota (N)
  (loop for i from 0 below N collect i))





(defun grid-ref (a indicies)
  (if (every #'identity (mapcar (lambda (x max) (and (>= x 0) (< x max))) 
                                indicies (array-dimensions a)))
      (apply #'aref a indicies)
      #\.
      ))

(defun find-neighbors (a coords)
  (mapcar
    (lambda (offset)
      (grid-ref a (shift coords offset)))
    (remove-if (lambda (c) (every #'zerop c))
            (reduce #'cartesian-product (make-list (length (array-dimensions a))
                                                   :initial-element (list -1 0 1))))))


(defun iterate (cycle)
  (let* ((new-array (make-array (array-dimensions cycle)))
         (coords (reduce #'cartesian-product 
                    (mapcar #'iota (array-dimensions cycle))) ))

    (dolist (c coords)
      (let* ((neighbors (find-neighbors cycle c))
             (active (count #\# neighbors)))

        (setf (apply #'aref new-array c) 
              (cond ((and (>= active 4) (char= (grid-ref cycle c) #\#)) #\L) 
                    ((and (= active 0) (char= (grid-ref cycle c) #\L)) #\#)
                    (t (grid-ref cycle c)))
              )
        ))
    new-array))


(defparameter *input* (get-file "/Users/justin/repos/school/project-euler/advent/11.txt"))
(defparameter *grid-list* (mapcar (lambda (string) (coerce string 'list)) *input*))


(defparameter *grid*
  (make-array (list (length *grid-list*) (length (car *grid-list*)))
              :initial-contents *grid-list*))


(defun stabilize (grid)
  (prog ((state grid)
         (next-state nil)
         )

        loop
        (setf next-state (iterate state))
        (if (equalp next-state state)
            (return state))
        (setf state next-state)
        (go loop) 
        ) )

(defun solve-1 (stable)
  (loop for i from 0 below (array-total-size stable) sum
        (if (char= #\# (row-major-aref stable i))
            1
            0
            )))
(pprint (solve-1 (stabilize *grid*)))
