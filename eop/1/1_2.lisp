
; function
(defun sqr (x) (* x x))

; 2's complement value:
; -a_{n-1}2^{N} - (a_{0}1 + a_{1}2 .. a_{n}2^{n-2})
; S = 1 + 2 + 4 + ... 2^(n-2)
; 2S = 2 + 4 + 8 + ... 2^(n-1)
; S = 2^(n-1) - 1
; max value is 2147483647
; min value is 2^31 = 2147483648

; DEFINITION SPACE

; -46340 <= x <= 46340

; RESULT SPACE

; 0 <= x^2 <= 46340^2 = 214739600





