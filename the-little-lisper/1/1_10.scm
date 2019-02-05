; 10

; get harry in

(define a '(apples in (harry has a backyard)))

(print (car (car (cdr (cdr a)))))

(define b '(apples and harry))

(print (car (cdr (cdr b))))

(define c '(((apples) and ((harry))) in his backyard))

(print (car (car (car (cdr (cdr (car  c)))))))


