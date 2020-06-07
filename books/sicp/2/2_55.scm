(display (car ''abracadabra))

; quote is an operator
; what is happening is we are quoting a quote statement
; (car (quote (quote (abracadabra))))

; results in literally
; (car (quote abracadabra))

; and the car accesses the operator
; quote
