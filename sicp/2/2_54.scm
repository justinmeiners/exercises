
(define (equal1 a b)
    (cond ((and (null? a) (null? b)) #t)
          ((and (not (null? a)) (not (null? b)))
            (let ((ca (car a))
                  (cb (car b)))
                (cond
                      ((and (pair? ca) (pair? cb)) (equal1 ca cb))
                      ((and (symbol? ca) (symbol? cb)) 
                        (and (eq? ca cb) (equal1 (cdr a) (cdr b))))
                      (else #f))))
                      (else #f)))


(display (equal1 '(this is a list) '(this is a list)))
(newline)
(display (equal1 '(this is a list) '(this (is a) list)))
