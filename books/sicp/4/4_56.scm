
; a) names of all people who are supervised by Ben Bitdiddle, together with their addresses.

(and (supervisor ?name (Ben Bitdiddle))
     (address ?name ?place))

; b) all people whose salary is less than Ben, together with their salary and Ben's salary

(and (salary (Ben Bitdiddle) ?min-amount)
        (salary ?name ?amount)
        (lisp-value < ?amount ?min-amount))
    
; c) all people who are supervised by someone who is not in the computer division together with the supervisor's name and job.

(and (supervisor ?person ?supervisor)
     (not (job ?supervisor (computer . ?role)))
     (job ?supervisor ?job))

