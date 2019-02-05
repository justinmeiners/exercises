
; louis is making a mistake
; defines, lambda, ifs, etc all satisfy the form of an application:
; (operator arg0 arg1 .. argn)

; so they will be interepreted as such, and 
; (define x 3) will attempt to look up the define operator in the environment
