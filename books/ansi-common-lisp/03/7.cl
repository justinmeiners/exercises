
; Modify this program to user fewer cons cells
(defun compress (x) 
  (if (consp x)
    (compr (car x) 1 (cdr x)) x))

(defun compr (elt n 1st) 
  (if (null 1st)
    (list (n-elts elt n)) 
    (let ((next (car 1st)))
      (if (eql next elt)
        (compr elt (+ n 1) (cdr 1st)) 
        (cons (n-elts elt n)
            (compr next 1 (cdr 1st)))))))

(defun n-elts (elt n)
  (if (> n 1)
    ; instead of storing each pair as two conses and a list
    ; just use a cons pair
    (cons n elt)
    elt))


(print (compress '(1 1 1 0 1 0 0 0 0 1)))

