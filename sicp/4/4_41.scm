; Baker, Cooper, Fletcher, Miller, and Smith

; 5 floors. All on different floors.

; ~on(baker, 5)
; ~on(cooper, 1)
; ~on(fletcher, 5) ~on(fletcher 1)
; above(miller, cooper)
; ~adjacent(smith, fletcher)
; ~adjacent(fletcher, cooper)


; I did it!

; 1. smith
; 2. cooper
; 3. baker
; 4. fletcher
; 5. miller

(define (in? elem ls)
    (if (null? ls)
        #f
        (or (= (car ls) elem)
            (in? elem (cdr ls)))))
            
(define (distinct? ls)
    (if (null? ls)
        #f
        (and (not (in? (car ls) (cdr ls)))
            (distinc? (cdr ls)))))


(define (check-constraints baker cooper fletcher miller smith)
    (and 
         (distinct? (list baker cooper fletcher miller smith))
         (not (= baker 5))
         (not (= cooper 1))
         (not (= fletcher 5))
         (not (= fletcher 1))
         (> miller cooper)
         (> (abs (- smith fletcher 1)))
         (> (abs (- fletcher cooper 1)))))

