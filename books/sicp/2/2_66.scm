(load "2_63.scm")

(define (lookup key set) 
  (cond ((null? set) '())
        ((= key (entry set)) (entry set))
        ((< key (entry set))
         (lookup key (left-branch set)))
        ((> key (entry set))
         (lookup key (right-branch set)))))

(display (lookup 9 (test-tree)))
