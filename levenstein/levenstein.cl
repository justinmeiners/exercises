
; levenstein distance
; is the number of changes required to change one word into another

; insertion
; deletion
; mutation (swap)

; we can match the front of a two ways
; change the first letter to match
; insert the one we want

; l(x:xs, y:ys)
; insert y x

; we always make the second one smaller

; aaaaab
; aaaaba
; 1 delete
; 1 insert
; or 
; 2 swaps
; in this case they are equal

; ababab
; bababa

; 1 delete
; 1 insert
; or lots of swaps
; in this case they are not


; suppose I know how to find knapsack for n-1 items
; then knapsack for n items
; k(n, w) = min( c + k(n-1, w+p), k(n-1, w))


; suppose I can find the levenstein distance
; to a string of length n-1

; BASE
; suppose b is the empty string -> delete everything
; suppose a is the empty string -> add everything
; suppose they are both empty -> done

; l(a, n) = 1 + min( l(insert a, n-1), l(delete a, n-1), l(replace a, n-1))


(defvar s1 '(a b a b a b a b))
(defvar s2 '(b a b a b a))

(defvar wiki-1 '(k i t t e n))
(defvar wiki-2 '(s i t t i n g))




; a b a b a b a b
; b a b a b a b 
; should be 2!
; b a b a b a

(defun levenstein (a b)
  (if (or (null a)  (null b))
      (max (length a) (length b))
      (min
        ; try a substition if necessary
        (+ (if (eq (car a) (car b))
            0
            1) (levenstein (cdr a) (cdr b)))

        ; deletion
        (+ 1 (levenstein (cdr a) b))
        ; addition
        (+ 1 (levenstein a (cdr b))))))

(print (levenstein wiki-1 wiki-2))

