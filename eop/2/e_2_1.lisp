
; EXERCISE
    ; implement a definition space predicate for addition on 32 bit signed integers.
    (defparameter *INT-MAX* 214783647)
(defparameter *INT-MIN* -2147483648)

    ; min <= a + b <= max
    ; min - b <= a <= max - b


    ; case 1.
    ; we know a >= min
    ; so if b >= 0
    ; then  min - b <= min <= b

    ; a <= max - b

    ; case 2
    ; we know a <= max
    ; so if b < 0
    ; then max <= max - b
    ; then min -b <= a


    (defun addable-definition-p (a b)
     (if (>= b 0)
      (<= a (- INT_MAX b))
      (> a (- INT_MIN b))))

