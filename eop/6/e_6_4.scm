; EXCERCISE

; State the postcondition for find_mismatch and explain why the final values of both iterators are returned


; either f0 = l0
; or f1 = l1
; or both are equal (the same)
; or source(f0) != source(f1)

; So the post condition
; is that f0=l0 or f1=l1 tells
; us there is no mismatch, although one may be a prefix of the other.

; Otherwise f0 and f1 are the first such iterators where source(f0) != source(f1)

; The function:

; find_mismatch f0 l0 f1 l1 r
  ; while (f0 != l0 && f1 != l1 && r(source(f0), source(f1))
  ;   ++f0;
;     ++f1;
;   return <f0, f1>;

; r must be some comparator


