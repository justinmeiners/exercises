
(declaim (optimize (speed 3) (safety 2)))


(defun lookup (src indicies dest)
  (loop for i from 0 below (length indicies) do
        (setf
          (aref dest i)
          (aref src (aref indicies i)) )))


(defun iota-mod (buff start N m)
  (loop for i from 0 below N do
        (setf (aref buff i)
              (mod (+ start i) m))))

(defun find-destination (max current not-allowed)
  (prog ((min (apply #'min (set-difference '(1 2 3 4)
                            (map 'list #'identity not-allowed)))))

        loop
        (decf current)
        (if (< current min) (setf current max))

        (if (not (position current not-allowed))
            (return current)
            (go loop))))

(defun copy-subseq (src start end dest dest-start) 
  (prog ()
        loop
        (if (>= start end)
            (return nil))

        (setf (aref dest dest-start)
              (aref src start))

        (incf start)
        (incf dest-start)
        (go loop)
        ))

(defun copy-all-but (src end dest exclude)

  (prog ((start 0)
         (dest-start 0))

        loop
        (if (>= start end)
            (return nil))

        (when (not (position (aref src start) exclude))
          (setf (aref dest dest-start) (aref src start))
          (incf dest-start))

        (incf start)
        (go loop)
        ))

(defun play-round (start-cups current k)
  (prog ((cups (copy-seq start-cups))
         (N (length start-cups))
         (smaller-circle (make-array (- (length start-cups) 3)
                                   :initial-element 0
                                   :element-type 'fixnum))
         (next-three-indicies (make-array 3 :initial-element 0
                                           :element-type 'fixnum))
         (next-three (make-array 3 :initial-element 0
                                           :element-type 'fixnum))
         (current-val nil)
         (dest-val nil)
         (dest nil)
         )

        loop
        (setf current-val (elt cups current))
        (iota-mod next-three-indicies (+ current 1) 3 N)
        (lookup cups next-three-indicies next-three)
        (copy-all-but cups N smaller-circle next-three)

        (setf dest-val (find-destination N
                                           (elt cups current)
                                           next-three
                                           ))
        (setf dest (position dest-val smaller-circle) )
        ;(pprint cups)

        ;(pprint current-val)
        ;(pprint next-three)
        ;(pprint dest-val)

        (copy-subseq smaller-circle 0 (+ dest 1) cups 0) 
        (copy-subseq next-three 0 3 cups (+ dest 1)) 
        (copy-subseq smaller-circle (+ dest 1) (- N 3) cups (+ dest 1 3)) 

        (setf current (mod (+ 1 (position current-val cups)) N))

        (decf k)

        (if (> k 0)
            (go loop))
        (return cups)))

; part 1

(defparameter *test-input* #( 3 8 9 1 2 5 4 6 7))
(defparameter *input* #( 3 2 6 5 1 9 4 7 8))
 

(pprint (play-round *test-input* 0 10))
(pprint (play-round *test-input* 0 100))


(pprint (play-round *input* 0 100))

;p art 2



(defun remove-cup (val-to-next current)
  (let ((next (aref val-to-next current)))
    (setf (aref val-to-next current)
          (aref val-to-next next))

    (setf (aref val-to-next next)
          0)
    next))

(defun add-cup (val-to-next current to-add)
  (let ((next (aref val-to-next current)))
    (setf (aref val-to-next current) to-add)
    (setf (aref val-to-next to-add) next)
    ))

(defun ordered-list (val-to-next start k)
  (prog
    ((c start)
     (result nil))

    loop
    (push c result)
    (setf c (aref val-to-next c))

    (when (or (= c start) (= k 0))
        (return (reverse result))
        )
    (decf k)
    (go loop)
    ))

(defun play-2 (cups k)
  (prog  
    ((N (length cups))
     (current (aref cups 0))
     (dest 0)
     (val-to-next (make-array (+ (length cups) 1)
                                       :initial-element 0
                                       :element-type 'fixnum
                                       ))
     (three (make-array 3
                        :initial-element 0
                        :element-type 'fixnum
                        )))

         (loop for i from 0 below N do
               (setf (aref val-to-next (aref cups i)) 
                     (aref cups (mod (+ i 1) N))
                     ))

         ;(pprint val-to-next)

         loop
         (if (<= k 0)
             (return val-to-next))

         (dotimes (i 3)
           (setf (aref three i) (remove-cup val-to-next current)))

         (setf dest (find-destination N current three))
         (nreverse three)
         (dotimes (i 3)
                 (add-cup val-to-next dest (aref three i)))

         (setf current (aref val-to-next current))

         (decf k)
         (go loop)
         ))

(defparameter *test-input-2*
  (concatenate 'vector
               *test-input*
               (loop for i from 10 to 1000000 collect i)
               ))
 
(defparameter *input-2*
  (concatenate 'vector
               *input*
               (loop for i from 10 to 1000000 collect i)
               ))
 

(pprint (ordered-list (play-2 *test-input* 10) 1 -1))

(pprint (ordered-list (play-2 *input* 100) 1 -1))

(pprint (ordered-list (play-2 *input-2* 10000000) 1 5))



