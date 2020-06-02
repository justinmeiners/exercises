

(defun part-create (id)
  (cons (cons id 1) nil))

(defun part-union (a b)
  (multiple-value-bind (small large)  (if (< (cdr (car a)) (cdr (car b)))
                                          (values a b)
                                          (values b a)
                                          )
    (rplacd small large)
    (rplacd (car large) (+ (cdar small) (cdar large)))
    large)
  )

(defun part-id (x)
  (if (null (cdr x))
      (car (car x))
      (part-id (cdr x))))

(defun npart-id (x)
  ; update the path once we reach root
  (let ((c (part-id x)))
    (rplacd x c)
    x
    ))

(defparameter bob (part-create 'bob))
(defparameter larry (part-create 'larry))
(defparameter john (part-create 'john))

(defparameter alice (part-create 'alice))
(defparameter sally (part-create 'sally))
(defparameter nicole (part-create 'nicole))


(part-union (part-union bob larry) john)
(part-union (part-union alice sally) nicole)

