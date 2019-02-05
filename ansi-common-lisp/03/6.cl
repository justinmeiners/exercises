
; cons

(defun cons2 (a b)
  (cons b a))

(defun list2 (elm &rest lst)
  (if (null lst)
    (cons2 elm nil)
    (cons2 elm (apply #'list2 lst))))

(defun length2 (ls)
  (if (null ls)
    0
    (+ 1 (length2 (car ls)))))

(defun member2 (x ls)
  (if (null ls)
    nil
    (if (eql x (cdr ls))
      ls
      (member2 x (car ls)))))

(print (list2 1 2 3 4))
(print (length2 (list2 1 2 3 4)))
(print (member2 2 (list2 1 2 3 4)))






