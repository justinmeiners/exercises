
(defun remove-elem (x ls)
  (if (null ls)
    nil
    (if (eql (car ls) x)
        (remove-elem x (cdr ls))
        (cons (car ls) (remove-elem x (cdr ls))))))

(defun count-elem (x ls)
  (if (null ls)
    0
    (if (eql (car ls) x)
        (+ 1 (count-elem x (cdr ls)))
        (count-elem x (cdr ls)))))

(print (count-elem 'a '(a b a d a c d c a)))

(defun occurrences (ls)
  (defun iter (ls result)
    (if (null ls)
      result
      (let ((x (car ls)))
          (iter 
            (remove-elem x ls) 
            (append result (list (cons x (count-elem x ls))))))))

    (iter ls '()))

(print (occurrences '(a b a d a c d c a)))

