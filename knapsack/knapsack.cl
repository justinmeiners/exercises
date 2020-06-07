; PROBLEW
; W - maximum bag weight
; {m_1, m_2, ... m_n} = item weights
; {v_1, v_2, ... v_n} = item values

; want to choose a subset I so that
; sum m_i <= W
; and
; sum v_i is maximized
; In other words, if we choose another subset J
; then sum v_j <= sum v_i

(defvar items '((23 505) (26 352) (18 220) (32 354) (27 414) (29 498) (26 545) (30 473) (27 543)))

(defun knapsack (remaining items)
  (if (or (null items) (<= remaining 0))
    0
    (let* ((it (car items))
           (weight (car it))
           (val (cadr it)))
      (max
        (if (>= (- remaining weight) 0)
          (+ val (knapsack (- remaining weight) (cdr items)))
          0)
        (knapsack remaining (cdr items))))))

(print (knapsack 67 items))


