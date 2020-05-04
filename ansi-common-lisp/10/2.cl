
(defmacro if1 (test a b)
  `(cond (,test ,a)
        (t ,b)))

(defmacro if1 (pred conseq alt)
   `(cond (,pred ,conseq)
          (t ,alt)))



; No
(if1 (< 10 5)
     (print "yes")
     (print "no"))

; YES
(if1 (> 10 5)
     (print "yes")
     (print "no"))


