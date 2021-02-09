
(defun split-delimiterp (c) (or (char= c #\Space) (char= c #\:)))

(defun split-string (string &key (delimiterp #'split-delimiterp))
  (loop :for beg = (position-if-not delimiterp string)
        :then (position-if-not delimiterp string :start (1+ end))
        :for end = (and beg (position-if delimiterp string :start beg))
        :when beg :collect (subseq string beg end)
        :while end))

(defun get-file (filename)
  (with-open-file (stream filename)
    (loop for line = (read-line stream nil)
          while line
          collect line)))

(defun get-fields (line)
  (split-string line))

;(defparameter *input* (get-file "/Users/justin/repos/school/project-euler/advent/22.txt"))

(defparameter *deck-2*
  '(
    28
    50
    37
    20
    6
    42
    32
    47
    39
    22
    14
    7
    21
    17
    27
    8
    48
    11
    23
    12
    18
    35
    29
    33
    31
    )
  )

(defparameter *deck-1*
  '(
    45
    10
    43
    46
    25
    36
    16
    38
    30
    15
    26
    34
    9
    2
    44
    1
    4
    40
    5
    24
    49
    3
    41
    19
    13
    ))

(defun iota (N)
  (loop for i from 0 below N collect i))


(defun play (player-1 player-2)
  (prog ((deck-1 (mapcar #'identity player-1))
         (deck-2 (mapcar #'identity player-2))
         )

        draw
        (let ((top-1 (car deck-1))
              (top-2 (car deck-2))
              )
          (if (> top-1 top-2)
              (progn  (setf deck-2 (cdr deck-2))
                      (setf deck-1 (append (cdr deck-1) (list top-1 top-2))))

              (progn (setf deck-1 (cdr deck-1))
                     (setf deck-2 (append (cdr deck-2) (list top-2 top-1))) 
                     )))

        (if (and (not (null deck-1)) (not (null deck-2)))
            (go draw))

        (return (remove nil (if (null deck-1) deck-2 deck-1)))
        ))

(defun score-hand (hand)
  (reduce #'+ (mapcar (lambda (card position)
            (* card (- (length hand) position))
            ) hand (iota (length hand)))))





(pprint (score-hand (play '(9 2 6 3 1) '(5 8 4 7 10))))

(defun solve-1 ()
  (score-hand (play *deck-1* *deck-2*)))

(pprint (score-hand '(3 2 10 6 8 5 9 4 7 1)))

(pprint (solve-1))






(defun recursive-combat (hand-1 hand-2 played-hands)
  (cond ((null hand-1) (values 1 hand-2))
        ((null hand-2) (values 0 hand-1))
        ((find (list hand-1 hand-2) played-hands :test #'equalp) (values 0 hand-1))
        (t
         (case 
           (if (and (>= (length (cdr hand-1)) (car hand-1))
                    (>= (length (cdr hand-2)) (car hand-2)))
               (recursive-combat (subseq (cdr hand-1) 0 (car hand-1))
                                 (subseq (cdr hand-2) 0 (car hand-2))
                                 nil)  

               (if (> (car hand-1) (car hand-2)) 0 1)
               ) 
           (0 (recursive-combat
                (append (cdr hand-1) (list (car hand-1) (car hand-2)))
                (cdr hand-2)
                (cons (list hand-1 hand-2) played-hands)))
           (1 (recursive-combat 
                (cdr hand-1)
                (append (cdr hand-2) (list (car hand-2) (car hand-1)))
                (cons (list hand-1 hand-2) played-hands)))
           )
         )
        ))


(defun solve-2 (hand-1 hand-2)
  (multiple-value-bind (winner deck) (recursive-combat hand-1 hand-2 nil)
    (pprint deck)
    (score-hand deck)
    ))

(pprint (solve-2 '(9 2 6 3 1) '(5 8 4 7 10)))

(pprint (solve-2 '(43 19) '(2 29 14)))

(pprint (solve-2 *deck-1* *deck-2*))


