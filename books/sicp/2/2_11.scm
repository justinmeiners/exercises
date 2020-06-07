(load "2_07.scm")

(define (mul-interval x y)
    (let ((xl (lower-bound x))
          (xu (upper-bound x))
          (yl (lower-bound y))
          (yu (upper-bound y)))

        ; cases are limited by the fact that lower < upper
        ; otherwise there would be more
        (cond ((and (>= xl 0) (>= xu 0) (>= yl 0) (>= yu 0)) ; case 1
                ; (+, +) * (+, +)
                ; (l * l, u * u)
                (make-interval (* xl yl) (* xu yu)))
              ((and (< xl 0) (< xu 0) (< yl 0) (< yu 0)) ; case 2
                ; (-, -) * (-, -)
                ; (u * u, l * l)
                (make-interval (* xu yu) (* xl yl)))
              ((and (>= xl 0) (>= xu 0) (< yl 0) (< yu 0)) ; case 3
                ; (+, +) * (-, -)
                ; (u * l, l * u) 
                (make-interval (* xu yl) (* xl yu)))
              ((and (< xl 0) (< xu 0) (>= yl 0) (>= yu 0)) ; case 4
                ; (-, -) * (+, +)
                ; (l * u, u * l)  
                (make-interval (* xl yu) (* xu yl)))
              ((and (>= xl 0) (>= xu 0) (< yl 0) (>= yu 0)) ; case 5
                ; (+, +) * (-, +)
                ; (u * l, l * u)
                (make-interval (* xu yl) (* xl yu)))
              ((and (>= xl 0) (>= xu 0) (< yl 0) (>= yu 0)) ; case 6
                ; (+, +) * (-, +)
                ; (u * l, l * u)
                (make-interval (* xu yl) (* xl yu)))
              ((and (< xl 0) (>= xu 0) (>= yl 0) (>= yu 0)) ; case 6
                ; (-, +) * (+, +)
                ; (l * u, u * l)
                (make-interval (* xl yu) (* xu yl)))
              ((and (< xl 0) (< xu 0) (< yl 0) (>= yu 0)) ; case 7
                ; (-, -) * (-, +)
                ; (l * u, u * l)
                (make-interval (* xl yu) (* xu yl)))
              ((and (< xl 0) (< xu 0) (< yl 0) (>= yu 0)) ; case 8
                ; (-, +) * (-, -)
                ; (u * l, l * u)
                (make-interval (* xu yl) (* xl yu)))
              ((and (< xl 0) (< xu 0) (< yl 0) (>= yu 0)) ; case 9
                ; (-, +) * (-, +)
                ; ?
                (let ((p1 (* xl yl))
                          (p2 (* xl yu))
                          (p3 (* xu yl))
                          (p4 (* xu yu)))
                        (make-interval (min p1 p2 p3 p4)
                                       (max p1 p2 p3 p4)))
                )
              (else (error "cases should be handles"))
            )))
 

(display-interval (mul-interval (make-interval -4 -2) (make-interval 0 1)))
(newline)

; this should fail since its a bad interval (else case)
(mul-interval (make-interval 5 -5) (make-interval 0 1))

