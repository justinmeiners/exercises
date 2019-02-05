; Show the following in box notation

; a) (a b (c d))
; [a, ->] [b, ^]
;         [c, ->], [d, nil]

; b) (a (b (c (d))))
; [a, ^]
; [b, ^]
; [c, ^]
; [d, nil]

; c) (((a b) c) d)
; [^, d]
; [^, c]
; [a, ->] [b, nil]

; d) (a (b . c) . d)
; [a, ->] [^, d]
;         [b, c]



