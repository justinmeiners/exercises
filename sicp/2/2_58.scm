
(define (=number? a b) (eq? a b))

(define (variable? x) (symbol? x))

(define (same-variable? x y)  
  (and (variable? x) (variable? y) (eq? x y)))

(define (sum? e) 
  (and (pair? e) (eq? (cadr e) '+)))

(define (exponent? e)
  (and (pair? e) (eq? (cadr e) '**)))

(define (addend e)
    (car e))

(define (augend e)
    (car (cdr (cdr e))))

(define (multiplier e)
    (car e))

(define (multiplicand e)
  (car (cdr (cdr e))))

(define (base e) 
    (car e))

(define (exponent e)
    (car (cdr (cdr e))))

(define (product? e)
  (and (pair? e) (eq? (cadr e) '*)))

(define (make-sum a b)
  (cond ((=number? a 0) b)
        ((=number? b 0) a)
        ((and (number? a) (number? b))
         (+ a b))
        (else (list a '+ b))))

(define (make-product a b)
  (cond 
        ((or (=number? a 0) (=number? b 0)) 0)
        ((=number? a 1) b)
        ((=number? b 1) a)
        ((and (number? a) (number? b))
         (* a b))
        (else (list a '* b))))

(define (make-exponent b p)
  (cond 
        ((=number? b 0) 0)
        ((=number? p 0) 1)
        ((and (number? b) (number? p))
         (expt b p))
        (else (list b '** p))))

(define (derive e var)
  (cond ((number? e) 0)
        ((variable? e) (if (same-variable? e var) 1 0))
        ((sum? e) (make-sum (derive (addend e) var)
                            (derive (augend e) var)))
        ((product? e)
         (make-sum
           (make-product (multiplier e)
                         (derive (multiplicand e) var))
           (make-product (derive (multiplier e) var)
                         (multiplicand e))))
        ((exponent? e)
         (make-product
           (make-product (exponent e)
                         (make-exponent 
                           (base e) 
                           (- (exponent e) 1)))
           (derive (base e) var)))
        (else
          (error "unknown expression"))))

(display (derive '(x + y) 'x))
(newline)
(display (derive '(x * y) 'x))
(newline)
(display (derive '((x * y) * (x + 3)) 'x))
(newline)
(display (derive '(2 * (x ** 3)) 'x))
(newline)


