(defun enigma (x)
  (and (not (null x))
       (or (null (car x))
           (enigma (cdr x)))))

; returns true of the list contains nil
(print (enigma (list 1 2 nil 3 4 5)))

(defun mystery (x y)
  (if (null y)
    nil
    (if (eql (car y) x)
      0
      (let ((z (mystery x (cdr y))))
        (and z (+ z 1))))))

; returns the index of the item in the list
(print (mystery 10 (list 1 2 5 10)))
        
