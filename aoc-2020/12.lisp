
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

(defparameter *input* (get-file "12.txt"))

(defun parse-line (str)
  (let ((cmd (subseq str 0 1))
        (num (parse-integer (subseq str 1)))
        )
    (cons (intern cmd) num)))

(defparameter *cmds* (mapcar #'parse-line *input*))

(defparameter *sample-cmds* (mapcar #'parse-line '("F10" "N3" "F7" "R90" "F11")))

(defun solve-1 (cmds)
  (reduce #'do-command
          cmds
          :initial-value (list (list 0 0) 0)
          ))

(defun solve-2 (cmds)
  (reduce #'do-command-2
          cmds
          :initial-value (list (list 0 0) (list 10 1))
          ))



(defun rotate (vec angle)
  (let* ((rad (* PI (/ angle 180.0)))
         (c (cos rad))
         (s (sin rad)))

    
    (list (round (+ (* (first vec) c) (* (second vec) (- s))))
          (round (+ (* (first vec) s) (* (second vec) c)))
          )))

(defun scale (scale vec)
  (mapcar (lambda (x) (* x scale)) vec))

(defun do-command-2 (state cmd)
  (let ((ship (first state))
        (waypoint (second state)))
    
    (case (car cmd) 
      (F
        (list (mapcar #'+
                      ship
                      (scale (cdr cmd) waypoint))
              waypoint))
      (L
        (list 
          ship
          (rotate waypoint (cdr cmd))
          waypoint))
      (R
        (list 
          ship
          (rotate waypoint (- (cdr cmd)))
          waypoint)) 

      (t 
        (list
           ship
           (mapcar #'+
                   (dir-delta (car cmd)
                              (cdr cmd))
                   waypoint)
           )))))

(defun do-command (state cmd)
  (let
    ((pos (first state))
     (angle (second state))
     )

    (case (car cmd)
      (F (list (mapcar #'+
                       (dir-delta (angle-dir angle)
                                  (cdr cmd))
                       pos)
               angle))

      (L (list pos
               (mod (+ angle (cdr cmd)) 360)))

      (R (list pos
               (mod (- angle (cdr cmd)) 360)))

      (t (list (mapcar #'+
                       (dir-delta (car cmd)
                                  (cdr cmd))
                       pos
                       )
               angle))
      )))


(defun angle-dir (angle)
  (case angle
    (0 'E)
    (90 'N)
    (180 'W)
    (270 'S)
    ))

(defun dir-delta (dir x)
  (case dir
    (N (list 0 x))
    (S (list 0 (- x)))
    (E (list x 0))
    (W (list (- x) 0))
    ))

(pprint (solve-1 *cmds*))
(pprint (solve-2 *cmds*))

(pprint (apply #'+ (mapcar #'abs (first (solve-2 *cmds*)))))
