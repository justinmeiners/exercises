
; Arbitrary Dimension simplex subdivision
; From Hatcher's Algebraic Topology Pg. 119
; http://pi.math.cornell.edu/~hatcher/AT/ATpage.html

(defun add-vec (x y)
  (map 'vector (lambda (a b) (+ a b)) x y))

(defun scale-vec (s x)
  (map 'vector (lambda (a) (* s a)) x))

(defun calc-barycenter (simplex)
  (let ((N (length simplex)))
    (reduce #'add-vec
            (map 'vector (lambda (v) (scale-vec (float (/ 1 N)) v)) 
                 simplex))))

(defun simplex-subfaces (simplex)
  (labels ((helper (front back results)
                   (if (null back)
                     results
                     (helper (append front (list (car back)))
                             (cdr back)
                             (cons (append front (cdr back)) results)))))
        (reverse (helper '() simplex '()))))


(defun barycentric-subdivide (simplex)
  (if (null (cdr simplex))
    (list simplex)
    (let ((b (calc-barycenter simplex))
          (faces (simplex-subfaces simplex)))
      (mapcar (lambda (face) (cons b face)) 
              (apply #'append
                     (mapcar #'barycentric-subdivide faces))))))

(defun print-simplex (simplex)
    (loop for v in simplex do
        (format t "~{~a~^, ~}~%" (coerce v 'list))))


(defun print-complex (c)
    (loop for s in c do
        (print-simplex s)
        (format t "~%")))


(print-complex (barycentric-subdivide (list #(-1 0) #(1 0))))

(print-complex (barycentric-subdivide (list #(-1 0) #(0 1) #(1 0))))

(print-complex (barycentric-subdivide (list #(-1 0 0) #(0 1 0) #(1 0 0) #(0 0.5 1))))



