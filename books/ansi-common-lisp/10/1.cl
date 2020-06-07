
(let ((x 'a)
      (y 'b)
      (z '(c d)))

  ; ((C D) A Z)
    (print `(,z ,x z))
  ; (X B C D)
    (print `(x ,y ,@z)) 
  ; ((C D A) Z)
    (print `((,@z, x) z)))

