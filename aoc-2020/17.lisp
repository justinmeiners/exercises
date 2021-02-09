
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



(defun ref-to-index (N i) (+ i  N))
(defun index-to-ref (N i) (- i  N))

(defun grid-ref (array N coords)
  (let ((indicies (mapcar (lambda (x) (ref-to-index N x)) coords)))

    (if (every #'identity (mapcar (lambda (x max) (and (>= x 0) (< x max))) 
                                  indicies (array-dimensions array)))
        (apply #'aref (cons array indicies))
        #\.
        )))

(defun grid-set (array N coords x)
  (let ((indicies (mapcar (lambda (x) (ref-to-index N x))  coords)))
    (setf (apply #'aref (cons array indicies)) x)))


(defun cartesian-product (a b)
  (loop for x in a append
    (mapcar (lambda (tail)
              (append (if (consp x) x (list x)) 
                      (if (consp tail) tail (list tail)))) b)))

(defun shift (a b)
  (mapcar #'+ a b))

(defun iota (start N)
  (loop for i from start below (+ start N) collect i))


(defun find-neighbors (a N coords)
  (mapcar
    (lambda (offset)
      (grid-ref a N (shift coords offset)))
    (remove-if (lambda (c) (every #'zerop c))
            (reduce #'cartesian-product (make-list (length (array-dimensions a))
                                                   :initial-element (list -1 0 1))))))

(defun iterate (cycle N)
  (let* ((D (mapcar (lambda (x) (+ x 2)) (array-dimensions cycle)))
         (new-array (make-array D))
         (coords (reduce #'cartesian-product 
                    (mapcar (lambda (dim) (iota (- (+ N 1)) dim))
                            D)) ))

    (dolist (c coords)
      (let* ((neighbors (find-neighbors cycle N c))
             (active (count #\# neighbors)))

        (grid-set new-array (+ N 1) c
                  (if (char= #\# (grid-ref cycle N c))
                      (if (or (= active 2) (= active 3))
                          #\#
                          #\.
                          )

                      (if (= active 3)
                          #\#
                          #\.
                          )))
        ) 
      )
    new-array))


(defparameter *input* (get-file "17.txt"))
(defparameter *sample-input* (get-file "17_sample.txt"))


(defparameter *grid-3d*
  (make-array (list 1 8 8)
              :initial-contents 
              (list (mapcar (lambda (string) (coerce string 'list)) *input*))))

(defparameter *grid-4d*
  (make-array (list 1 1 8 8)
              :initial-contents 
              (list (list (mapcar (lambda (string) (coerce string 'list)) *input*)))))



(defparameter *grid-sample*
  (make-array (list 1 3 3)
              :initial-contents 
              (list (mapcar (lambda (string) (coerce string 'list)) *sample-input*))))


(defun solve-1 (g)
  (dotimes (i 6)
    (setf g (iterate g i)))
  (loop for i from 0 below (array-total-size g) sum
        (if (char= #\# (row-major-aref g i))
            1
            0
            )))
(pprint (solve-1 *grid-sample*))
(pprint (solve-1 *grid-3d*))

(pprint (solve-1 *grid-4d*))
