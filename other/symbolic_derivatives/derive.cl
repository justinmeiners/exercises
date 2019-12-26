
(deftype math-expr ()
 `(or list number symbol))


; unary operations
(declaim (ftype (function (math-expr symbol) math-expr)
    derive
    sin-rule
    cos-rule
    log-rule
    exp-rule))

(defparameter unary-ops '((sin . sin-rule)
                          (cos . cos-rule)
                          (log . log-rule)
                          (exp . exp-rule)))


; binary operations
(declaim (ftype (function (math-expr math-expr symbol) math-expr)
        product-rule
        quotient-rule
        sum-rule
        diff-rule
        power-rule))

(defparameter binary-ops '((* . product-rule)
                           (/ . quotient-rule)
                           (+ . sum-rule)
                           (- . diff-rule)
                           (** . power-rule)))

(defun derivative (e x)
    (derive e x))


(defun derive (e x)
    (cond ((numberp e) 0) ; constant is zero
          ((symbolp e) 
             (if (eq e x) 
                 1
                 0))
          (t (let* ((op (car e))
                    (bin-rule (assoc op binary-ops))
                    (unary-rule (assoc op unary-ops)))
              (if bin-rule
               (funcall (cdr bin-rule) (cadr e) (caddr e) x)
               (funcall (cdr unary-rule) (cadr e) x))))))

; Simplifications/Helpers

(defun make-product (f g)
    (cond ((or (eq f 0) (eq g 0)) 0)
          ((eq f 1) g)
          ((eq g 1) f)
          ((and (numberp f) (numberp g)) (* f g))
          (t (list '* f g))))

(defun make-quotient (f g)
    (cond ((eq f 0) 0)
          ((eq g 1) f)
          ((and (numberp f) (numberp g)) (/ f g))
          (t (list '/ f g))))

(defun make-sum (f g)
    (cond ((eq f 0) g)
          ((eq g 0) f)
          ((and (numberp f) (numberp g)) (+ f g))
          (t (list '+ f g))))

(defun make-diff (f g)
    (cond ((eq f 0) g)
          ((eq g 0) f)
          ((and (numberp f) (numberp g)) (- f g))
          (t (list '- f g))))

(defun make-power (f g)
    (cond ((eq g 1) f)
          ((eq g 0) 1)
          ((and (numberp f) (numberp g)) (expt f g))
          (t (list '** f g))))

(defun make-cos (f)
 (cond ((eq f 0) 1)
  (t (list 'cos f))))

(defun make-sin (f)
 (cond ((eq f 0) 0)
  (t (list 'sin f))))

(defun make-log (f)
 (cond ((eq f 1) 0)
  (t (list 'log f))))

(defun make-exp (f)
 (cond ((eq f 0) 1)
  (t (list 'exp f))))


; Rules

(defun product-rule (f g var)
 (make-sum (make-product (derive f var) g)
  (make-product f (derive g var))))

(defun quotient-rule (f g var)
 (make-quotient
    (make-diff (make-product (derive f var) g)
               (make-product f (derive g var)))
    (make-product g 2)))

(defun sum-rule (f g var)
 (make-sum (derive f var) (derive g var)))

(defun diff-rule (f g var)
 (make-diff (derive f var) (derive g var)))

(defun power-rule (f g var)
 (make-product g 
  (make-power f (make-sum g -1))))

(defun sin-rule (f var)
 (make-product (list 'cos f) (derive f var)))

(defun cos-rule (f var)
 (make-product (make-product -1 (list 'sin f)) (derive f var)))

(defun exp-rule (f var)
 (make-product (make-exp f) (derive f var)))

(defun log-rule (f var)
 (make-product (make-quotient 1 f) (derive f var)))

(print (derive '(+ (* 2 (** x 3)) (* 8 (** x 2))) 'x))
(print (derivative '(+ (* 2 (** x 3)) (* 8 (** x 2))) 'x))

(print (derive '(cos x) 'x))
(print (derive '(log (** x 2)) 'x))

(print (derive '(sin (* 2 x)) 'x))
(print (derive '(/ (sin x) x) 'x))

 

(declaim (ftype (function (fixnum fixnum) fixnum) choose))

(defun choose (n k)
 (let ((x 1))
  (do ((i 1 (+ i 1)))
   ((> i k) x)
     (setf x (* x 
        (/ (- (+ n 1) i) i))))))


(declaim (ftype (function (symbol symbol fixnum) list) binomial))

(defun binomial (x y n)
 (cons '+ 
  (loop for k from 0 to n
   collect
   (list '* 
    (choose n k)
    (list '** 'x (- n k))
    (list '** 'y k)))))

