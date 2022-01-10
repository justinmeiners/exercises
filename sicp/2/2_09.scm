; Addition and subtraction

; [a, b] + [c, d] = [a + c, b + d]

; w1 = b - a
; w2 = d - c
; w3 = (b + d) - (a + c)
;    = (b - a) + (d - c) = w1 + w2


; [a, b] + -[c, d] = [a, b] + [-d, -c] = [a - d, b - c]

; w3 = (b - c) - (a - d)
;    = (b - a) - c + d 
;    = (b - a) + (d - c) = w1 + w2

; Multiplication

; [0, 1] * [2, 3] = [0, 3]

; w1 = 1, w2 = 1, w3 = 3

; however:

; [0, 1] * [0, 1 = [0, 1]]
; w1 = 1, w2 = 1, w3 = 1

; so w3 is not a function of w1 and w2
