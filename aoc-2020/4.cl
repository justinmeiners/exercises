
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

(defun process (lines)
  (let ((records nil))
    (reduce (lambda (table line)
              (if (= (length line) 0)
                  (progn (push table records)
                         '())

                  (map nil (lambda (pair)
                            (cons pair table)) 
                       (get-fields line)
                       ) 
                  )
              
              
              )
            :initial-value '())
    
    
    ))


(defparameter *input* (get-file "4.txt"))

