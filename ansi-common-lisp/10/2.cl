
(defmacro if1 (test a b)
  `(cond (,test ,a)
        (t ,b)))

; No
(if1 (< 10 5)
     (print "yes")
     (print "no"))

; YES
(if1 (> 10 5)
     (print "yes")
     (print "no"))


