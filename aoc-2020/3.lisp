
(defun split-delimiterp (c) (or (char= c #\Space) (char= c #\,)))

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


(defparameter *input* (get-file "3.txt"))
(defparameter *height* (length *input*))
(defparameter *width* (length (car *input*)))

(defparameter *map* (make-array (list *height*
                                      *width*)
                                      :initial-contents (mapcar (lambda (x) (coerce x 'list)) *input*)
                                       ))

(defun cons+ (a b w)
  (list (mod (+ (car a) (car b)) w)
        (+ (cadr a) (cadr b))))

(defun count-trees (slope)
  (prog ((N 0)
         (p (list 0 0)))
        loop
        (setf p (cons+ p slope *width*))
        (when (< (cadr p ) *height*)
            (when (char= #\# (aref *map* (cadr p) (car p))) 
                (incf N))
            (go loop)
            )
        (return N)))


(defun solve-1 ()
  (count-trees '(3 1)))

(defun solve-2 ()
  (*
    (count-trees '(1 1))
    (count-trees '(3 1))
    (count-trees '(5 1))
    (count-trees '(7 1))
    (count-trees '(1 2))
    ))



(solve-1)
(solve-2)


