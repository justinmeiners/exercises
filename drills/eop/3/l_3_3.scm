; LEMMA

; function composition is associative
; (a (b c)) = ((a b) c)

; f: X -> Y
; g: Y -> Z
; h: Z -> W

; Proof
;   ((h o g) o f)(x)
; = h(g(f(x)))
; = h(g o f(x))
; = h o (g o f)
