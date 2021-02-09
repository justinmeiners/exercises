
(defun split-delimiterp (c) (or (char= c #\Space) (char= c #\,)))

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


; rule is a function that takes a number and says whether it's valid

(defun eval-rule (x rule)
  (cond ((numberp (car rule)) (and (>= x (nth 0 rule)) (<= x (nth 1 rule))) )
        ((eq (car rule) 'OR) (or (eval-rule x (nth 1 rule))
                                 (eval-rule x (nth 2 rule))))
        (t (error "invalid rule"))
        ))

(defparameter *default-rules*
  '(
    (DEPARTURE-LOCATION (or (32 69) (86 968)))
    (DEPARTURE-STATION (or (27 290) (301 952)))
    (DEPARTURE-PLATFORM (or (47 330) (347 956)))
    (DEPARTURE-TRACK (or (46 804) (826 956)))
    (DEPARTURE-DATE (or (25 302) (320 959)))
    (departure-time (or (29 885) (893 961)))
    (arrival-location (or (33 643) (649 963)))
    (arrival-station (or (29 135) (151 973)))
    (arrival-platform (or (50 648) (674 961)))
    (arrival-track (or (45 761) (767 971)))
    (class (or (46 703) (725 951)))
    (duration (or (47 244) (257 957)))
    (price (or (49 195) (209 956)))
    (route (or (44 368) (393 968)))
    (row (or (48 778) (797 954)))
    (seat (or (31 421) (427 964)))
    (train (or (42 229) (245 961)))
    (type (or (31 261) (281 964)))
    (wagon (or (36 428) (445 967)))
    (zone (or (30 906) (923 960)))
    ))


(defun valid-ticket (nums)
  (every (lambda (x) (some (lambda (rule)
                             (eval-rule x (nth 1 rule))
                             ) *default-rules*)
           )
         nums))

(defun ticket-errors (nums)
  (reduce #'+ (mapcar (lambda (x)
                        (if (some (lambda (rule)
                                    (eval-rule x (nth 1 rule))
                                    ) *default-rules*)
                            0
                            x)
                        )
                      nums)))


(defparameter *input* (get-file "16_tickets.txt"))
(defparameter *clean-tickets* (mapcar (lambda (nums) (mapcar #'parse-integer nums))
                                      (mapcar #'split-string *input*)))

(defun solve-1 ()
  (reduce #'+ (mapcar #'ticket-errors *clean-tickets*)))

(solve-1)

(defun best-rules (nums)
  (mapcar #'car (remove-if-not (lambda (rule)
                                 (every (lambda (x) 
                                          (eval-rule x (nth 1 rule))
                                          ) nums))

                               *default-rules*)))


(defun field-candidates (tickets)
  (let ((N (length (car tickets))))
    (loop for i from 0 below N collect
          (best-rules (mapcar (lambda (nums) (nth i nums)) tickets)))))

(defun lockin-decision (candidates final)
  (let ((i (position-if (lambda (best) (= (length best) 1)) candidates)))
    (if i
        (let ((off-the-table (car (nth i candidates)) ))
            (lockin-decision
              (mapcar (lambda (rules)
                        (remove off-the-table rules)
                        ) candidates)

              (cons (cons i off-the-table) final))

            )
        (sort final (lambda (a b ) (< (car a) (car b))))
        )))

(defun solve-2 ()
  (match-with-ticket
    (mapcar #'cdr (lockin-decision (field-candidates (remove-if-not #'valid-ticket *clean-tickets*)) '()))
    (car *clean-tickets*)
    ))

(defun match-with-ticket (fields ticket)
  (mapcar #'cons fields ticket))

(solve-2)

(defun this-product ()
  (* 59 67 151 107 167 179))

(this-product)



