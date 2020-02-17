
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
(defparameter test-list-2 '#(1 4 1 5 9 2 6 5 3 5))


(defun tourn-sort (type seq cmp)
 (flet ((merge-op (xs ys) (merge type xs ys cmp)))
  (let ((counter 
         (reduce (lambda (c x)
                  (print c)
                  (add-to-counter c (list x) #'merge-op))
          seq :initial-value '())))
  (reduce-counter counter #'merge-op))))


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

(defun min-1-2 (seq cmp)
 (flet ((min-op (a b) (op-min-1-2 a b cmp)))
  (let* ((counter
          (reduce (lambda (c x)
                   (print c)
                   (add-to-counter c (list x) #'min-op))
           seq :initial-value '()))
         (result (reduce-counter counter #'min-op)))

   (cons (car result) (min-list (cdr result) cmp)))))


; Testing
(print (tourn-sort 'list test-list-1 #'<))
(print (tourn-sort 'vector test-list-2 #'<))
(print (tourn-sort 'string "this is a test of sorting" #'string<))


(print (min-1-2 test-list-1 #'<))
(print (min-1-2 test-list-2 #'<))
(print (min-1-2 "accbcd" #'char<))


