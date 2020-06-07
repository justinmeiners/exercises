

; (while <predicate> <body>)
;
; => (let ((result 0)
 ;         (do-body (lambda () (begin <body>))))
;       (if <predicate>
;            (set! result (do-body))
;             result))
             

