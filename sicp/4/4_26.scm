
; Ben:
; why not just implement unless as a special form?

; this would probably be faster
; the unless expression would simply be translated into an if
; at expand, or compile time


; I guess the bigger question is, should all lazy evaluation be addressed with special forms (macros)? It seems that provide a solution for most cases.


; (unless <predicate> <action> <exception>)
; => (if <predicate> <exception> <action>)
; this isn't a very compelling syntax...


; Alyssa:
; unless would be syntax and not a procedures

; one of the great things about scheme is that 
; procedures are first class functions, and can be passed to procedures such as 
; (map )

; this is not possible with unless, if it is part of the syntax.

; one could imagine some kind of procedure which uses a branching procedure to make a decision

; (test method cond) etc
