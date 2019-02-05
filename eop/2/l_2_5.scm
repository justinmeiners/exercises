; LEMMA
; The distance from any point to an orbit to a point in a cylce of that orbit
; is always defined.

; PROOF
; suppose x in orb(f(a))
; and y is in a cycle of the orbit
;   let z be the connection point
;   then f^(k)(z) = z
;   then f^(n)(z) = y where n <= k
;   suppose x is in the cycle
;   then f^(m)(z) = x where m <= k
;       if m < n
;           then distance = n - m
;       otherwise if m > n
;           then distance = (k - m) + k
; suppose x is not in the cycle
;   then f^(j)(a) = z
;   and f^(l)(a) = x where l < j
;   then distance = (j - l) + n


; NOTES
; how can a distance not be defined?
; even an infinite sequence has a finite number of steps
; between each.

; because one may come after the other:
; 1, 2, 3, 4, 5 
; What is the distance from 4 to 2 ?
; not defined

; although as a side note, mathematically "distance" is a strange word to use here;
; metrics must be symmetric.

