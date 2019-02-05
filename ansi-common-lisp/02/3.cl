
(defun our-fourth (x)
    (car (cdr (cdr (cdr x)))))

(print (our-fourth (list 1 2 3 4)))

