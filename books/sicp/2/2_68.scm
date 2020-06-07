(load "2_67.scm")

(define (encode message tree) 
  (if (null? message)
      '()
      (append (encode-symbol (car message) tree)
              (encode (cdr message) tree))))

(define (in-list x ls)
  (and (not (null? ls))
       (or (eq? (car ls) x)
           (in-list x (cdr ls)))))

(define (encode-symbol symbol tree)
  (let ((left (left-branch tree))
        (right (right-branch tree)))
    (cond ((in-list symbol (symbols left)) 
           (if (leaf? left) (cons 0 '())
             (cons 0 (encode-symbol symbol left))))
          ((in-list symbol (symbols right))
           (if (leaf? right) (cons 1 '())
             (cons 1 (encode-symbol symbol right))))
          (else (error "symbol not in tree")))))

;(display (encode '(A D A B B C A) sample-tree))
;(newline)

