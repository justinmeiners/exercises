
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


(defparameter *input* (get-file "19.txt"))
(defparameter *rule-input* (get-file "19_rules.txt"))

(defparameter *all-rules* (make-array 500 :initial-element nil))
(defparameter *all-rules-2* nil)

(defun build-rules () 
  (map nil (lambda (line) 
             (multiple-value-bind (index pattern)
               (parse-rule line) 
               (setf (aref *all-rules* index) pattern)
               ))
       *rule-input*)
  (setf *all-rules* (map 'vector #'identity (remove-if #'null *all-rules*)))
  (setf *all-rules-2* (map 'vector #'identity *all-rules*))
  (setf (aref *all-rules-2* 8) '(OR (42) (42 8)))
  (setf (aref *all-rules-2* 11) '(OR (42 31) (42 11 31)))
  )

(defun parse-parts (p)
  (let ((i (position '^ p)))
    (if i
        (list 'OR
              (subseq p 0 i)
              (subseq p  (+ i 1))
                     )
        
        p
        )
    ))


;(defun parse-parts (p)
;  (prog ((i 0))
;        loop
;        (if (eq (nth i p) '^)
;            (setf p (concatenate 'LIST
;                                (subseq p 0 (- i 1))
;                                 (list (list
;                                   'OR
;                                   (nth (- i 1) p)
;                                   (nth (+ i 1) p)
;                                   ))
;                                 (subseq p (+ i 2))
;                                 ))
;
;            (incf i)
;            )

;        (if (< i (length p))
;            (go loop))
;
;        (return p)
;        ))


(defun parse-rule (str)
  (let ((s-expr (read-from-string (concatenate 'string
                                                      "("
                                                      (substitute #\^ #\| (substitute #\space #\: str))
                                                      ")")))) 
    (values (car s-expr)
            (parse-parts (cdr s-expr)) 
            )))



(build-rules)


(defun eval-rule (str rule all-rules)
  (cond ((stringp rule) (if (char= (car str) (char rule 0))
                            (cdr str)
                            'FAIL
                            ))
        ((numberp rule) (eval-rule str (aref all-rules rule) all-rules))
        ((and (listp rule) (eq 'or (car rule))) 
         (let ((first (eval-rule str (nth 1 rule) all-rules))
               (second (eval-rule str (nth 2 rule) all-rules)))
           (if (eq 'FAIL first)
               second
               (if (eq 'FAIL second)
                   first
                   (if (= (random 2) 1) 
                       first
                       second
                       )))))
        ((listp rule)
         (prog ((s str)
                (l rule)
                (result nil))

               step
               (setf result (eval-rule s (car l) all-rules))

               (if (eq result 'FAIL)
                   (return result))

               (setf s result)
               (setf l (cdr l))

               (if (consp l)
                   (if (consp s)
                        (go step)
                        (return 'FAIL))
                   (return s))
              ))
        (t (error "unknown rule "))))

(defparameter *test-rules*
  #(
    (4 1 5)
    (or (2 3) (3 2))
    (or (4 4) (5 5))
    (or (4 5) (5 4))
    "a"
    "b"))

(defun solve-1 (all-rules inputs)
  (remove-if-not 
    (lambda (string)
      (not (eval-rule (coerce string 'list) (aref all-rules 0) all-rules))
      )
      inputs
    ))



(defun solve-2 (all-rules inputs)
  (remove-if-not 
    (lambda (string)
      ; use probablity!
      (some #'identity (loop for i from 1 to 500 collect
                             (not (eval-rule (coerce string 'list) (aref all-rules 0) all-rules))))
      )
      inputs
    ))

(pprint (eval-rule (coerce "ababbb" 'list) (aref *test-rules* 0) *test-rules*))


(pprint (length (solve-1 *all-rules* *input*)))

(pprint (length (solve-2 *all-rules-2* *input*)))


