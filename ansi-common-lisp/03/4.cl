
; Why does this return nil? 
(print (member '(a) '((a) (b))))

; because we need to define equality or key access
(print (member '(a) '((a) (b)) :test #'equal))

