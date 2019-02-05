(load "get.scm")

(define (=number? a b) (eq? a b))
(define (variable? x) (symbol? x))

(define (same-variable? x y)  
  (and (variable? x) (variable? y) (eq? x y)))

(define (make-sum a b)
  (cond ((=number? a 0) b)
        ((=number? b 0) a)
        ((and (number? a) (number? b))
         (+ a b))
        (else (list '* a b))))

(define (make-product a b)
  (cond 
        ((or (=number? a 0) (=number? b 0)) 0)
        ((=number? a 1) b)
        ((=number? b 1) a)
        ((and (number? a) (number? b))
         (* a b))
        (else (list '* a b))))

(define (make-exponent b p)
  (cond 
        ((=number? b 0) 0)
        ((=number? p 0) 1)
        ((and (number? b) (number? p))
         (expt b p))
        (else (list '** b p))))


(define (deriv e var) 
  (cond ((number? e) 0)
        ((variable? e) 
         (if (same-variable? e var) 1 0)) 
        (else ((get 'deriv (operator e))
               (operands e) var)))) 

(define (operator exp) (car exp)) 
(define (operands exp) (cdr exp))


; a) numbers must be handled explicity because they are primitive, not tagged types. 

(define (install-sum-package)
    (define (addend e)
        (car e))

    (define (augend e)
        (car(cdr e)))

  (define (deriv-sum e var)
    (make-sum (deriv (addend e) var)
              (deriv (augend e) var)))

  (put 'deriv '+ deriv-sum))

(define (install-product-package)
  (define (multiplier e)
    (car e))

  (define (multiplicand e)
    (car (cdr e)))

  (define (deriv-product e var)
    (make-sum
      (make-product (multiplier e)
                    (deriv (multiplicand e) var))
      (make-product (deriv (multiplier e) var)
                    (multiplicand e))))
  (put 'deriv '* deriv-product))


; c) 

(define (install-exp-package)
  (define (base e) 
    (car e))

  (define (exponent e)
    (car (cdr e)))

  (define (deriv-exp e var)
    (make-product
      (make-product (exponent e)
                    (make-exponent 
                      (base e) 
                      (- (exponent e) 1)))
      (deriv (base e) var)))

  (put 'deriv '** deriv-exp))


(install-sum-package)
(install-product-package)
(install-exp-package)


(display (deriv '(* x b) 'x))
(newline)
(display (deriv '(* (* x y) (+ x 3)) 'x))
(newline)
(display (deriv '(* 2 (** x 3)) 'x))
(newline)




; d)
