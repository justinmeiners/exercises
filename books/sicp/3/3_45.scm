
(define (transfer from-account to-account amount)
  ((from-account 'withdraw) amount)
  ((to-account 'deposit) amount))

; the sync mechanisms are separate
; withdraw and deposit could happen simulataneously because they are not in the same serialization set

; but that would actually be ok, since the amounts deposited and withdrawn are already known, so the two operations are independant

; from: - 10
; to: + 10

; same as

; to: + 10
; from: - 10


