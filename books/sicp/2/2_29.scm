
(define (make-mobile left right) (list left right))
(define (make-branch length structure) (list length structure))

(define (left-branch tree) (car tree))
(define (right-branch tree) (car (cdr tree)))

; Why do I need to (car (cdr...)) when for the rational number excercise I could just cdr?
; Because it is a (list ...) instead of a cons cell.
; Let's compare the two:

; cons: [length, structure]
; list: [length, _] -> [structure, nil]

(define (branch-length branch) (car branch))
(define (branch-structure branch) (car (cdr branch)))
(define (has-weight? branch) (not (pair? (branch-structure branch))))


(define (branch-weight branch)
    (if (has-weight? branch)
        (branch-structure branch)
        (total-weight (branch-structure branch))))

(define (total-weight mobile)
   (+ (branch-weight (left-branch mobile))
       (branch-weight (right-branch mobile))))


(define (torque mobile)
    (let ((l (left-branch mobile))
          (r (right-branch mobile)))
        (- (* (branch-weight l) (branch-length l)) 
           (* (branch-weight r) (branch-length r)))
    ))   

(define (balanced? mobile)
    (define (child-balanced? branch)
        (if (has-weight? branch) #t
        (balanced? (branch-structure branch))))


    (let ((l (left-branch mobile))
          (r (right-branch mobile)))
        (if (not (= (torque mobile) 0)) #f
            (and (child-balanced? l)
                 (child-balanced? r))
        )
    ))
     
        
; see image diagram

(define level-1 (make-mobile (make-branch 3 4) (make-branch 4 3)) )
(define level-2 (make-mobile (make-branch 3 level-1) (make-branch 3 7)))
(define level-3 (make-mobile (make-branch 2 level-2) (make-branch 2 14)))

(display (total-weight level-3))
(newline)
(display (torque level-1))
(display (balanced? level-1))
(newline)
(display (torque level-2))
(display (balanced? level-2))
(newline)
(display (torque level-3))
(display (balanced? level-3))
(newline)

