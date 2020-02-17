
; I didn't know there was a built in one, but good excercise!
;(defun merge-list (xs ys cmp)
;    (cond ((and (null xs) (null ys))
;            '())
;          ((or (null xs) (and (not (null ys)) (funcall cmp (car ys) (car xs))))
;             (cons (car ys) (merge-list xs (cdr ys) cmp)))
;          (t
;             (cons (car xs) (merge-list (cdr xs) ys cmp)))))

;(print (merge-list '(1 1 3 5 7 8) '(1 2 2 3) #'<))
;(print (merge 'list '(1 1 3 5 7 8) '(1 2 2 3) #'<))


(defun add-to-counter (counter carry op)
 (cond ((null counter)
        (cons carry counter))
  ((null (car counter))
   (cons carry (cdr counter)))
  (t
   (cons nil
    (add-to-counter (cdr counter) (funcall op carry (car counter)) op)))))


(defun reduce-counter (counter op)
 (labels
  ((advance (ls)
    (if (or (null ls) (not (null (car ls)))) ls
     (advance (cdr ls))))

   (final (ls result)
    (cond ((null ls) result)
     ((null (car ls))
      (final (cdr ls) result))
     (t 
      (final (cdr ls) (funcall op (car ls) result))))))

  (let ((start (advance counter)))
   (if (null start) '()
    (final (cdr start) (car start))))))


; Use case 1: Sort a list

(defparameter test-list-1 '(8 9 3 9 4 4 1 87 2 10 9 3 2 5 9))
(defparameter test-list-2 '(1 4 1 5 9 2 6 5 3 5))


(defun sort-list (ls cmp)
 (let ((c '())
       (merge-op (lambda (xs ys) (merge 'list xs ys cmp))))
  (dolist (x ls)
   (setf c (add-to-counter c (list x) merge-op))
   (print c))

  (reduce-counter c merge-op)))


; Use case 2: Find 2 smallest elements in list

; The car is the "best" element,
; and the cdr is a list of elements it has beaten

(defun combine-pairs (a b)
 (cons (car a) (cons (car b) (cdr a))))

(defun op-min-1-2 (a b cmp)
 (if (funcall cmp (car b) (car a))
  (combine-pairs b a)
  (combine-pairs a b)))

(defun min-list (ls cmp)
 (reduce 
  (lambda (a b)
   (if (funcall cmp a b) a b)) ls))

(defun min-1-2 (ls cmp)
 (let ((c '())
       (min-op (lambda (a b) (op-min-1-2 a b cmp))))
  (dolist (x ls)
   (setf c (add-to-counter c (list x) min-op))
   (print c))
  (let ((result (reduce-counter c min-op)))
   (cons (car result) (min-list (cdr result) cmp)))))


; Testing

(print (sort-list test-list-1 #'<))
(print (sort-list test-list-2 #'<))

(print (min-1-2 test-list-1 #'<))
(print (min-1-2 test-list-2 #'<))

