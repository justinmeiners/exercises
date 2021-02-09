
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

(defstruct policy (char) (min) (max))

(defun in-range (x min max)
  (and (>= x min)
       (<= x max)))

(defun check-policy-range (p str)
  (in-range (count (policy-char p) (coerce str 'list) :test #'char=)
            (policy-min p)
            (policy-max p)
            ))

(defun check-policy-pos (p str)
  (= 1 (count (policy-char p)
              (list (char str (decf (policy-min p)))
                    (char str (decf (policy-max p)))
                    ))))

(defun cleanup (str)
  (substitute-if #\space (lambda (c) (member c (coerce "-:" 'list) :test #'char=)) str))

(defun check-line (str checkp)
  (destructuring-bind (min max char pass)
    (split-string str)
    (funcall checkp (make-policy :char (coerce char 'character)
                                   :min (parse-integer min)
                                   :max (parse-integer max))
             pass)))

(defparameter *inputs* (mapcar #'cleanup (get-file "2.txt")))


(defun solve-1 ()
  (count-if (lambda (l) (check-line l #'check-policy-range)) *inputs*))

(defun solve-2 ()
  (count-if (lambda (l) (check-line l #'check-policy-pos)) *inputs*))


(pprint (solve-1))
(pprint (solve-2))



