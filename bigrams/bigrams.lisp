(defun read-token (stream pred)
    (let ((token '()))
        (do ((c (peek-char nil stream nil)
                (peek-char nil stream nil)))
            ((or (null c) (not (funcall pred c)))
                (if (null c)
                    token
                    (coerce (nreverse token) 'string)))
                (push (char-downcase (read-char stream) )
                      token))))

(defun next-token (stream)
    (read-token stream #'(lambda (c) (not (alphanumericp c))))
    (read-token stream #'alphanumericp))  

(defun make-bigram-index (stream)
    (defun add-next (list previous)
        (let ((next (next-token stream)))
            (if (null next)
                list
                (progn
                    (push (cons previous next) list)
                    (add-next list next)))))
    (add-next '() (next-token stream)))
        

(defun bigram< (a b)
    (if (string= (car a) (car b))
        (if (string< (cdr a) (cdr b))
            t
            nil)
        (if (string< (car a) (car b))
            t
            nil)))

(defun bigram-eq (a b)
    (and (string= (car a) (car b))
         (string= (cdr a) (cdr b))))
        

(defun merge-duplicates (ls)
    (let ((final))
        (progn
        (reduce #'(lambda (accum x)
                (if (bigram-eq (car accum) x)
                    (cons x (+ 1 (cdr accum)))
                    (progn
                        (push accum final)
                        (cons x 1))))
        (cdr ls)
        :initial-value (cons (car ls) 1))
        
         final)))
        
(defun count< (a b) (< (cdr a) (cdr b)))
           
(defparameter bigrams (make-bigram-index *standard-input*))  
(print (last (sort (merge-duplicates (sort bigrams #'bigram<)) #'count<) 100))


