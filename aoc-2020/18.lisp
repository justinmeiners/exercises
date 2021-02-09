
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



(defparameter *input* (get-file "/Users/justin/repos/school/project-euler/advent/18.txt"))
(defparameter *exprs* (mapcar #'read-from-string (mapcar (lambda (str)
                                               (concatenate 'string "(" str ")"))
                                             *input*)))

(defun eval-expr (expr)
  (let ((op nil))
    (cond ((numberp expr) expr)
          ((listp expr)
           (reduce (lambda (acc next)
                     (if op
                         (prog1 (funcall op (eval-expr acc) (eval-expr next))
                                (setf op nil)
                                )
                         (progn
                           (setf op next)
                           acc
                           )
                         ) 
                     ) expr)))))


(defun solve-1 () 
    (reduce #'+ (mapcar #'eval-expr *exprs*)))


(pprint (solve-1))

; (1 + (2 * 3) + (4 * (5 + 6))) 



(defun eval-expr-2 (expr)
  (cond ((numberp expr) expr)
        ((listp expr) (car (simplify-chain
                             (simplify-chain (mapcar #'eval-expr-2 expr) '+) '*)))
        (t expr)
        ))

(defun simplify-chain (chain allowed)

  (prog ((result '())
         (op nil)
         (l nil)
         (r nil))

        (setf l (car chain))
        (setf chain (cdr chain))

        loop

        (setf op (car chain))
        (setf chain (cdr chain))

        (setf r (car chain))
        (setf chain (cdr chain))

        (format t ":  ~a (~a) ~a ~%" l op r)

        (if (eq op allowed)
            (setf l (funcall op l r))

            (progn (push l result)
                   (push op result)
                   (setf l r)
                   ))

        (if (consp chain)
            (go loop))

        (push l result)
        (return (reverse result))
        ))


(defun solve-2 () 
    (reduce #'+ (mapcar #'eval-expr-2 *exprs*)))


(pprint (solve-2))


