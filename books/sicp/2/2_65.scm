(load "2_64.scm")

(define (union-set set1 set2)
  (cond ((null? set1) set2)
        ((null? set2) set1)
        (else 
    (let ((x1 (car set1)) (x2 (car set2)))
      (cond ((> x1 x2)
             (cons x2 (union-set set1
                                 (cdr set2))))
            (else
             (cons x1 (union-set (cdr set1) set2))))))))

(define (intersection-set set1 set2)
  (if (or (null? set1) (null? set2))
    '()
    (let ((x1 (car set1)) (x2 (car set2)))
      (cond ((= x1 x2)
             (cons x1 (intersection-set (cdr set1)
                                        (cdr set2))))
            ((< x1 x2)
             (intersection-set (cdr set1) set2))
            ((> x1 x2)
             (intersection-set set1 (cdr set2)))))))

(define (union-tree t1 t2)
  (let ((l1 (tree->list t1))
        (l2 (tree->list t2)))
    (list->tree (union-set l1 l2))))

(define (intersection-tree t1 t2)
  (let ((l1 (tree->list t1))
        (l2 (tree->list t2)))
    (list->tree (intersection-set l1 l2))))

(display (union-tree (test-tree) (test-tree-2)))
(newline)
(display (intersection-tree (test-tree) (test-tree-2)))
(newline)
