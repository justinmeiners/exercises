
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



(defun parse-op (line)
  (let ((parts (split-string line)))
    (cons (intern (string-upcase (first parts)))
          (parse-integer (second parts))
          )))


(defparameter *input* (get-file "/Users/justin/repos/school/project-euler/advent/9.txt"))
(defparameter *program* (map 'vector #'parse-op *input*))


(defun eval-op (op state)
  ;(pprint op)
  (case  (car op)
    (ACC (list (+ (first state) (cdr op)) (+ 1 (second state))))
    (NOP (list (first state) (+ 1 (second state))))
    (JMP (list (first state) (+ (second state) (cdr op))))
    ))

(defun eval-program (program)
  (prog ((ran (make-array (length program) :initial-element nil))
         ;      (ACC PC)
         (state (list 0 0)))

        loop

        (if (or (>= (second state) (length program))
                (aref ran (second state)))

            (return (values (first state) 
                            (= (print (second state)) (length program))
                            )))

        (setf (aref ran (second state)) t)
        (setf state (eval-op (aref program (second state)) state))
        (go loop)
        
        ))

(defun swap-op (op)
  (case op
    (JMP 'NOP)
    (NOP 'JMP)
    (t op)))

(defun copy-cons (c)
  (cons (car c) (cdr c)))

(defun try-patches (program)
  (dotimes (i (length program))

    (let ((copy (map 'vector #'copy-cons program)))
      (setf (car (aref copy i)) 
            (swap-op (car (aref copy i))))

      (multiple-value-bind (acc terminate) (eval-program copy)
        ;(format t "trying: ~a. acc: ~a. result: ~a ~%" i acc terminate)
        (if terminate
            (return acc))))
    ))


(pprint (eval-program *program*))

(pprint (try-patches *program*))


