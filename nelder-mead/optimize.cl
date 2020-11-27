


(defun vec+ (x y)
  (map 'vector #'+ x y))

(defun vec- (x y)
  (map 'vector #'- x y))

(defun vec-scale (a x)
  (map 'vector (lambda (y) (* y a)) x) )

(defun car< (a b)
  (< (car a) (car b)))

(defun centroid (simplex)
  (vec-scale (/ 1 (length simplex))
   (reduce #'vec+ simplex)))

(defun reflect-point (factor centroid worst)
    (vec+ centroid (vec-scale factor (vec- centroid worst))))

(defun expand-point (factor centroid reflect)
  (vec+ centroid (vec-scale factor (vec- reflect centroid))))

(defun contract-point (factor centroid worst) 
    (vec+ centroid (vec-scale factor (vec- worst centroid))))

(defun replace-lastn (simplex x)
  (setf (aref simplex (- (length simplex) 1)) x)
  simplex)

(defun shrink-simplex (factor simplex)
  (map 'vector (lambda (p)
                 (vec+ (aref simplex 0)
                       (vec-scale factor (vec- p (aref simplex 0))))
                 ) simplex))


(defun nelder-mead (f ftol iter reflect expand contract shrink simplex)
  (let* ((N (length simplex))
         (with-images (sort (map 'vector (lambda (p)
                                           (cons (funcall f p)
                                                 p
                                                 )
                                           ) simplex)
                            #'car<
                            ))
         (images (map 'vector #'car with-images))
         (ordered (map 'vector #'cdr with-images))

         (x0 (centroid (subseq ordered 0 (- N 1))))
         (xr (reflect-point reflect x0 (aref ordered (- N 1))))
         (fxr (funcall f xr)))

    (if (or (< (- (aref images (- N 1))
                  (aref images 0))
               ftol)
            (= iter 0)
            )
        (values (aref ordered 0) (aref images 0) iter)

        (nelder-mead f
                     ftol
                     (- iter 1)
                     reflect expand contract shrink
                     (cond ((and (<= (aref images 0) fxr)
                                 (< fxr (aref images (- N 2))))
                            (replace-lastn ordered xr))

                           ((< fxr (aref images 0))
                            (let* ((xe (expand-point expand x0 xr))
                                   (fxe (funcall f xe)))
                              (replace-lastn ordered (if (< fxe fxr)
                                                         xe
                                                         xr
                                                         ))
                              ))

                           (t (let* ((xc (contract-point contract x0 (aref ordered (- N 1))))
                                     (fxc (funcall f xc))
                                     )
                                (if (< fxc (aref images (- N 1)) )
                                    (replace-lastn ordered xc)
                                    (shrink-simplex shrink ordered)
                                    ))
                              )
                           )))))


(defun standard-simplex (p scale)
  (let* ((N (length p))
         (simplex (make-array (+ 1 N)
                              :initial-element nil
                              )))
    (setf (aref simplex 0) p)
    (loop for i from 1 to N do
          (let ((basis 
                  (make-array N
                              :initial-element 0.0
                              ) 
                  ))

            (setf (aref basis (- i 1)) scale)
            (setf (aref simplex i)
                  (vec+ p basis)

                  ))
          )

    simplex))

(defun himmelblau (x y)
  (+ (expt (+ (* x x) y -11.0) 2.0)
     (expt (+ x (* y y) -7.0) 2.0)
     ))

(defun rosenbrock (x y a b) 
  (+ (expt (- a x) 2.0)
     (* b (expt (- y (* x x)) 2.0))
     ))


(defun minimize (f initial-point &key (scale 1.0) (max-iterations -1))
  (nelder-mead f
               0.0001
               max-iterations
               1.0
               2.0 
               0.5
               0.5
               (standard-simplex initial-point scale)
               ))

(pprint (multiple-value-list (minimize 
                               (lambda (v) (himmelblau (aref v 0)
                                                       (aref v 1)
                                                       ))
                               #(0.0 0.0)
                               :max-iterations 1000
                               )))

(pprint (multiple-value-list (minimize (lambda (v)
                                         (rosenbrock
                                           (aref v 0)
                                           (aref v 1)
                                           1.0
                                           100.0
                                           )
                                         ) #(0.0 0.0))))
