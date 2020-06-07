(define (entry tree) (car tree))
(define (left-branch tree) (cadr tree))
(define (right-branch tree) (caddr tree)) 
(define (make-tree entry left right)
  (list entry left right))

(define (element-of-set? x set) 
  (cond ((null? set) false)
        ((= x (entry set)) true)
        ((< x (entry set))
         (element-of-set? x (left-branch set)))
        ((> x (entry set))
         (element-of-set? x (right-branch set)))))

(define (adjoin-set x set)
    (cond ((null? set) (make-tree x '() '()))
            ((= x (entry set)) set)
            ((< x (entry set))
             (make-tree (entry set)
                        (adjoin-set x (left-branch set))
                        (right-branch set)))
            ((> x (entry set))
    (make-tree (entry set) (left-branch set)
                        (adjoin-set x (right-branch set))))))

; in order LEFT MIDDLE RIGHT
(define (tree->list->1 tree)
  (if (null? tree) '()
    (append (tree->list->1 (left-branch tree))
            (cons (entry tree)
                  (tree->list->1
                    (right-branch tree))))))

(define (tree->list tree)
  (define (copy-to-list tree result-list)
    (if (null? tree)
      result-list
      (copy-to-list (left-branch tree)
                    (cons (entry tree)
                          (copy-to-list
                            (right-branch tree)
                            result-list)))))
  (copy-to-list tree '()))


(define (test-tree) 
  (make-tree 3 
             (make-tree 1 '() '()) 
             (make-tree 7 
                        (make-tree 5 '() '())
                        (make-tree 9 '() 
                                   (make-tree 11 '() '())))))

(define (test-tree-2) 
  (make-tree 5 
             (make-tree 3 (make-tree 1 '() '()) '()) 
             (make-tree 9
                        (make-tree 7 '() '())
                        (make-tree 11 '() '()))))
;
;(display (tree->list->1 tr))
;(newline)
;(display (tree->list->2 tr))


; Do the two procedues produce the same result for every tree? If not, how do the results differ? What do the two procedure produce for trees in 2.16?

; yes they prdouce the same result

; b) Do the two procedures have the same order of growth in the number of steps required to convert a balanced tree with n element sto a list? If not which one grows more slowly?

; no the first one is worse since the append requires a linear search to the end.

