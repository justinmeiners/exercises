; Excercise 1.26

; By not using a square method, the expmod recursive calls is done twice, instead of one for each side of the square. Due to applicative order, scheme would evaluate the procedure and then square it, rather than the other way around.
