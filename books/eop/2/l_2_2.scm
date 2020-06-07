; LEMMA
; an orbit does not contain both a terminal element and a cycle.


; PROOF
; Suppose the orbit has a terminal element.
; say f^(n)(x) is terminal.
; then f^(n+1)(x) is not defined.
; suppose the orbit has a cycle.
; then f^(m)(x) = x.
; if m > n, then this is beyond the terminal, and not defined.
; if m < n; then the cycle repeats before the terminal;

; NOTES

; transform: 
;   operation 
; ^ unary-function

; f^(n)(x) = x if n == 0
;          = f^(n-1)(f(x)) otherwise 


; orbit: Set of points in the sequence
; cycle: for some n f^n(x) = x
; terminal: x is not in the definition space for f(x)

; I was confused about the definition of terminal.
; the key is you can enter a terminal element, but you can't leave.

; ATTEMPT
; Suppose f^n(x) = x
; then since Codomain(f) = domain(f)
; x\in domain(f)
; so x is not terminal

; incorrect. Codomain and domain are simply the types
; the definition space is the set of valid values.

