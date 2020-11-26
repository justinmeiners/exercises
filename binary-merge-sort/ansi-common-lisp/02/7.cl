; define a function that takes a list as an argument
; and returns true if one of its elements is a list
(defun has-listp (l)
  (if (null l) 
    nil
    (or (listp (car l))
              (has-listp (cdr l)))))

(print (has-listp (list 1 2 3 4)))

(print (has-listp (list 1 (list 1) 3 4)))
