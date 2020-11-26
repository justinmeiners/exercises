(load "2_68.scm")

(define (generate-huffman-tree pairs) 
  (successive-merge (make-leaf-set pairs)))

(define (successive-merge leaves)
  (if (null? (cdr leaves))
    (car leaves)
    (successive-merge 
      (adjoin-set
        ; the first two are always the smallest (the ones we want to merge)
        ; then we put it back into the set with the remaining elements
        (make-code-tree (car leaves) (cadr leaves))
                        (cdr (cdr leaves))))))

;(display sample-tree)
;(newline)
;(display (generate-huffman-tree '((C 1) (D 1) (B 2) (A 4))))


