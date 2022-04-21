; Write a version of union that preserves the order of the elements in the original lists

(defun new-union (a b)
  (if (null b)
    a
    (if (member (car b) a)
      (new-union a (cdr b))
      (new-union (append a (list (car b))) (cdr b)))))

(print (new-union '(a b c) '(b a d)))





