(load "2_69.scm")

(define lyric-pairs '((A 2) (GET 2) (SHA 3) (WAH 1) (BOOM 1) (JOB 2) (NA 16) (YIP 9)))
(define lyric-tree (generate-huffman-tree lyric-pairs))

(define lyrics '(GET A JOB
                     SHA NA NA NA NA NA NA NA NA
                     GET A JOB
                     SHA NA NA NA NA NA NA NA NA
                     WAH YIP YIP YIP YIP YIP YIP YIP YIP YIP
                     SHA BOOM))

(display lyric-tree)
(newline)

(display (encode lyrics lyric-tree))
(newline)
; - who many bits? - 
(display (length (encode lyrics lyric-tree)))

; - how many with fixed length? - 
; 8 symbols 
; 3 bits (2^3) to encode each symbol
; 36 characters in the lyrics
; 36 * 3 = 108 total bits

; compressed = 84 bits
